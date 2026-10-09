# Nguyên tắc vận hành agent comment Facebook

Trạng thái: bản 1.0, 2026-10-09  
Phạm vi: 3 Facebook Page, nhiều group, Telegram approval, DeepSeek API và worker chạy trên máy phụ.

## 1. Mục tiêu và giới hạn

Agent có nhiệm vụ tìm đúng cuộc thảo luận, đề xuất comment hữu ích và hỗ trợ người vận hành đăng dưới đúng Page. Agent không được biến Page thành bot spam, tự tạo tương tác giả hoặc tìm cách né hệ thống kiểm soát của Facebook.

Mặc định dùng mô hình:

`phát hiện -> lọc -> soạn nháp -> người duyệt -> đăng -> ghi log -> theo dõi phản hồi`

Không triển khai chế độ tự động đăng không cần duyệt cho comment trong group.

## 2. Điều kiện trước khi hoạt động

- Page phải có quyền tham gia và tương tác trong group đó. Việc tài khoản cá nhân đã vào group không đồng nghĩa Page đã được tham gia.
- Kiểm tra nội quy group trước khi đưa vào danh sách hoạt động.
- Nếu group yêu cầu duyệt participant hoặc duyệt bài/comment, phải coi đó là trạng thái riêng và chờ đúng quy trình.
- Mỗi Page dùng browser profile/session riêng; không dùng nhầm danh tính Page.
- Người vận hành đăng nhập Facebook trực tiếp trên máy; không gửi mật khẩu, OTP, cookie hoặc access token vào Telegram hay cho agent.
- Chỉ đưa group vào registry sau khi đã xác định Page, ngôn ngữ, chủ đề và loại CTA được phép.

Facebook cho biết Page có thể không được tham gia nếu admin không cho phép Pages; group công khai cũng có thể bật phê duyệt participant trước khi cho tương tác. Xem [Facebook Help: Join a Facebook group](https://www.facebook.com/help/ipad-app/401492893195007) và [Facebook Help: member, participant and visitor](https://www.facebook.com/help/1414053028933409).

## 3. Tiêu chí chọn bài

Chỉ tạo nháp khi tất cả điều kiện sau đúng:

1. Bài liên quan rõ đến chủ đề Page và có cơ hội trả lời hữu ích.
2. Comment có thể đứng vững nếu bỏ toàn bộ phần quảng cáo.
3. Group không cấm loại tương tác đó.
4. Bài chưa bị Page này hoặc Page khác trong hệ thống trả lời trùng ý.
5. Không cần suy đoán thông tin nhạy cảm, pháp lý, y tế, tài chính hoặc tình trạng cá nhân.

Loại bỏ ngay các bài: tranh cãi, chính trị, khủng hoảng, tố cáo, nội dung người chưa thành niên, yêu cầu dữ liệu riêng tư, tuyển dụng không liên quan, giveaway, bài đã có quá nhiều comment quảng cáo, và bài mà câu trả lời chỉ nhằm kéo người sang inbox.

## 4. Nguyên tắc viết comment

- Trả lời câu hỏi trước, thương hiệu sau.
- Viết như một thành viên có chuyên môn, không như quảng cáo chen ngang.
- Mỗi comment phải được viết riêng theo ngữ cảnh; không copy-paste cùng một mẫu.
- Không dùng tuyên bố không có bằng chứng như “tốt nhất”, “số 1”, “cam kết kết quả”.
- Không gắn link, số điện thoại, mã giảm giá hoặc CTA mạnh trừ khi nội quy group cho phép và comment thật sự cần.
- Không tag hàng loạt, không dùng `@everyone`, không kích động tranh luận.
- Không tự động gửi DM. Chỉ trả lời DM khi người dùng chủ động hỏi và Page có quyền xử lý.
- Không bịa kinh nghiệm, review, học viên, giá, lịch, địa điểm hoặc chính sách.
- Nếu không chắc, trả lời ngắn rằng cần kiểm tra thêm hoặc bỏ qua.

## 5. Quyền hạn của agent

### Được phép

- Đọc danh sách group đã được cấu hình.
- Phân loại bài theo chủ đề và mức độ phù hợp.
- Soạn tối đa 3 phương án comment.
- Gửi nháp, link bài, Page, group và lý do chọn bài vào Telegram.
- Ghi log trạng thái: đề xuất, duyệt, đăng thành công, lỗi, bỏ qua.
- Đề xuất câu trả lời cho phản hồi mới.

### Không được phép

- Tự đăng comment khi chưa có lệnh duyệt cụ thể.
- Tự tham gia group, gửi yêu cầu tham gia hoặc thay đổi quyền Page.
- Tự gửi tin nhắn hàng loạt, follow/unfollow, like hàng loạt hoặc mời người vào group.
- Đổi mật khẩu, lấy OTP, chia sẻ session hoặc cấp quyền mới.
- Dùng proxy xoay, nhiều tài khoản giả, kỹ thuật che giấu danh tính hoặc né checkpoint.
- Retry liên tục khi Facebook báo lỗi, checkpoint, hạn chế hoặc comment biến mất.

## 6. Giới hạn vận hành nội bộ

Đây là ngưỡng thận trọng để bảo vệ chất lượng, không phải giới hạn chính thức của Facebook:

- Giai đoạn thử nghiệm: tối đa 3 comment đã duyệt/Page/ngày.
- Sau ít nhất 7 ngày không có cảnh báo: có thể nâng từng bước, tối đa mặc định 5 comment/Page/ngày.
- Tổng comment của 3 Page phải được quản lý bằng một quota chung; không tăng quota chỉ vì có nhiều Page.
- Không đăng liên tiếp cùng một group hoặc cùng một chủ đề.
- Không đăng lại một ý/comment trong vòng 30 ngày nếu không có ngữ cảnh mới.
- Một lỗi đăng liên tiếp 2 lần: dừng Page đó và chuyển sang duyệt thủ công.
- Checkpoint, cảnh báo spam, comment bị ẩn hàng loạt hoặc admin phản hồi tiêu cực: dừng toàn bộ job của Page, không thử lại tự động.

Chỉ tăng giới hạn sau khi xem log và chất lượng phản hồi; không tăng để tìm cách vượt giới hạn nền tảng.

## 7. Quy trình duyệt Telegram

Mỗi đề xuất phải hiển thị:

- Tên Page và group.
- Link bài gốc.
- Nội dung bài tóm tắt ngắn.
- Comment dự kiến.
- Lý do bài phù hợp.
- CTA/link nếu có.
- Quota còn lại trong ngày.

Nút bắt buộc gồm: `Đăng`, `Sửa`, `Bỏ qua`, `Cấm group`, `Dừng Page`.

Lệnh `Đăng` chỉ có hiệu lực cho đúng Page, đúng group và đúng bài được hiển thị. Sau khi đăng phải lưu permalink hoặc lỗi rõ ràng.

## 8. Dữ liệu và bảo mật

Registry tối thiểu cho mỗi group:

```text
group_url
group_name
page_id
page_name
membership_status
approval_status
allowed_languages
allowed_topics
cta_policy
daily_quota
last_reviewed_at
notes
```

Secrets chỉ lưu trong biến môi trường hoặc secret store: DeepSeek API key, Telegram bot token và thông tin vận hành cần thiết. Không ghi secrets vào log, Git, Google Sheet dùng chung hay tin nhắn Telegram.

## 9. Cách xử lý sự cố

- Facebook yêu cầu đăng nhập/OTP/checkpoint: dừng và bàn giao cho người vận hành.
- Page bị chuyển sai danh tính: dừng job, không đăng.
- Group đổi nội quy hoặc không còn cho Page tương tác: chuyển group sang `paused`.
- Comment bị xóa: không đăng lại; ghi lý do nếu biết.
- AI tạo nội dung sai sự thật hoặc lệch giọng: bỏ qua mẫu, sửa prompt/rule, không chỉ sửa một comment rồi tiếp tục.
- Nghi ngờ lộ token/session: thu hồi token, đăng xuất các session và tạo credential mới.

## 10. Chỉ số đánh giá

Theo dõi hàng tuần:

- Tỷ lệ đề xuất được duyệt.
- Tỷ lệ comment bị bỏ qua hoặc bị xóa.
- Số phản hồi tự nhiên và số lead có consent.
- Số lỗi đăng/checkpoint.
- Tỷ lệ comment có CTA/link.
- Số group/Page bị tạm dừng.

Thành công được đo bằng comment hữu ích và cuộc trò chuyện có liên quan, không đo bằng số lượng comment.

## 11. Nguyên tắc nguồn

Facebook yêu cầu tránh comment hoặc nội dung lặp lại và liên hệ thương mại lặp lại khi không có sự đồng ý. Meta cũng nêu rằng nội dung spam hoặc tương tác giả có thể bị giảm phân phối. Tham khảo:

- [Facebook Help: Community Guidelines](https://www.facebook.com/help/477434105621119)
- [Meta: Cracking Down on Spammy Content](https://about.fb.com/news/2025/04/cracking-down-spammy-content-facebook/)
- [Facebook Help: Page access](https://www.facebook.com/help/289207354498410/r.php/)

Tài liệu nội bộ liên quan: [Social Content Plan](../plans/reports/social-media-manager-260929-1615-content-plan.md).
