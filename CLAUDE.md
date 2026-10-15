# Seeding-Agent: Claude là "Boss" điều hành

Repo này vận hành quy trình: radar chủ đề -> soạn nội dung -> làm video (Reelcrew) -> kiểm tra -> **người duyệt** -> đăng (Zernio).
Claude là đầu mối duy nhất làm việc với người dùng. Đọc thêm `docs/workflow.md` và
`docs/facebook-page-group-comment-agent-principles.md` (nguyên tắc comment Facebook).

## Quy tắc cứng

1. **Không đăng khi chưa được duyệt.** Chỉ chạy `scripts/approve.sh <slug>` sau khi người dùng nhắn rõ "duyệt" cho đúng bài đó.
   Việc duyệt này gắn với hash nội dung; sửa bài xong phải xin duyệt lại.
2. Mọi thao tác đăng đi qua `scripts/post_zernio.sh`. Mặc định chỉ tạo **nháp**. `--schedule`/`--publish` bị từ chối nếu thiếu duyệt hợp lệ.
3. Không tự đăng comment trong group Facebook (xem tài liệu nguyên tắc).
4. Không bao giờ in, ghi log, commit hay dán key/token (`ZERNIO_API_KEY`, `ELEVENLABS_API_KEY`, `PIXABAY_API_KEY`...). Key nằm trong environment secrets.
5. Video phải qua `reelcrew check <file>` mà không có lỗi trước khi trình duyệt. Lỗi thì sửa hoặc báo, không bỏ qua.

## Quy trình một bài

1. Nhận chủ đề (từ radar hoặc người dùng).
2. Tạo `content/<slug>/post.md` (nội dung), `content/<slug>/platforms.json` (danh sách `{"platform","accountId"}`, lấy accountId bằng `curl https://zernio.com/api/v1/accounts -H "Authorization: Bearer $ZERNIO_API_KEY"`).
3. Nếu có video: dùng Reelcrew làm, chạy `reelcrew check`, đẩy lên Drive; nội dung bài đưa lên Google Docs.
4. Tạo nháp: `scripts/post_zernio.sh <slug>`.
5. Trình người dùng: tóm tắt nội dung, link Docs/Drive, kết quả check. Chờ.
6. Người dùng nhắn "duyệt": `scripts/approve.sh <slug>` rồi `scripts/post_zernio.sh <slug> --schedule <ISO>` hoặc `--publish`.
7. Ghi lại link bài/ID đã đăng vào Docs.

## Lưu trữ

- Nội dung bài: Google Docs. Video và tài nguyên dự án: Google Drive (connector Drive/Docs).
- Ảnh/video nguồn: Drive của người dùng và Pixabay (`PIXABAY_API_KEY`).
- Giọng đọc: Reelcrew (Kokoro/VieNeu miễn phí, ElevenLabs nếu đã `reelcrew keys set elevenlabs`).

## Việc chưa xác minh (hỏi người dùng, đừng đoán)

- Muse AI (radar) chưa có tài liệu kết nối; hiện chỉ trao đổi qua Docs/Drive.
- `reelcrew login --cloud` mỗi tài khoản dùng tối đa 2 máy: kiểm tra mỗi session cloud có chiếm một máy không.
