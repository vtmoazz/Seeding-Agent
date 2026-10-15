# Quy trình radar -> duyệt -> đăng

```
Routine (lịch) -> Claude (Boss)
   radar (Muse AI/Grok, qua Docs/Drive) -> chủ đề
   -> soạn post.md + platforms.json -> Reelcrew làm video -> reelcrew check
   -> nháp Zernio -> trình người dùng -> "duyệt" -> approve.sh -> post_zernio.sh --schedule/--publish
```

## 1. Cấu hình environment (một lần)

Environment -> Edit:

- **Setup script**: dán nội dung `scripts/setup.sh`.
- **Network (Limited + Allow package managers)**, thêm: `zernio.com`, `mcp.zernio.com`, `reelcrew.io`,
  `api.elevenlabs.io`, `pixabay.com`, `agentkit.best`, `releases.agentkit.best` (tuỳ chọn), `api.telegram.org` (nếu dùng Telegram).
- **Secrets / biến môi trường** (không dán vào chat):
  `ZERNIO_API_KEY` (tạo ở zernio.com/dashboard/api-keys), `PIXABAY_API_KEY`, `ELEVENLABS_API_KEY` (nếu dùng).
- Connectors: Google Drive, Claude Docs (https://claude.ai/customize/connectors).

Cài đặt chỉ áp dụng cho session mới.

## 2. Reelcrew trên cloud

1. `reelcrew login --cloud` (xác nhận trên trình duyệt) rồi `reelcrew doctor`.
2. Key giọng đọc/ảnh: Reelcrew lưu bằng `reelcrew keys set <tên>`; kiểm tra bằng `reelcrew keys test`.
3. Trước khi trình duyệt luôn chạy `reelcrew check <video>` (hình đen, đứng hình, âm lượng, khoảng lặng, kích thước).

## 3. Zernio

Trên cloud dùng REST với `ZERNIO_API_KEY` (không cần trình duyệt). Không có `scheduledFor`/`publishNow` thì bài chỉ là nháp.
Tài liệu: https://zernio.com/agent-quickstart.md, https://zernio.com/llms.txt.

## 4. Telegram (tuỳ chọn, giai đoạn sau)

Cloud chỉ gửi thông báo ra được. Nút duyệt qua Telegram cần worker chạy thường trực trên máy khác. Giai đoạn đầu: duyệt bằng chat với Claude.

## 5. AgentKit (tuỳ chọn)

Không cần cho quy trình đăng bài. Cài `ak` và `ak kit init marketing --target claude-code --global` nếu muốn dùng kit.
