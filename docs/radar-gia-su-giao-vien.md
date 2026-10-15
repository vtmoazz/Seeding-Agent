# Radar nội dung: kết nối gia sư và giáo viên

Trạng thái: v0.2, 2026-10-15. Đã có quyết định ở mục 8; mục 6 và mục 9 còn chờ xác nhận trước khi tạo Routine.

## 1. Mục tiêu

Tìm chủ đề đang có nhu cầu thật ở hai phía:

- **Phụ huynh/học sinh** đang tìm gia sư, hỏi cách chọn, hỏi học phí, lo điểm số.
- **Gia sư và giáo viên** đang tìm lớp, tìm học viên, hỏi cách làm bài giảng, cách thu học phí, cách xây uy tín.

Radar chỉ đề xuất chủ đề và góc viết. Mọi bài vẫn đi theo `CLAUDE.md`: nháp, người duyệt, rồi mới đăng.

## 2. Phân công

| Bước | Ai làm | Ghi chú |
|---|---|---|
| Quét xu hướng, nhóm, từ khoá | Muse AI | Kết quả đặt vào một Google Doc "Radar" trong Drive |
| Đọc kết quả, lọc, chấm điểm | Claude (Boss) | Đọc qua connector Drive/Docs |
| Soạn bài, làm video | Claude + Reelcrew | Theo quy trình một bài |
| Duyệt, đăng | Người dùng, rồi `scripts/` | Không đổi |

Muse AI chưa có tài liệu kết nối (xem `CLAUDE.md`), nên kênh trao đổi tạm thời là Docs/Drive, không gọi API.

## 3. Trụ cột chủ đề

1. **Chọn gia sư**: tiêu chí, học thử, dấu hiệu cần đổi người, học phí hợp lý theo cấp học.
2. **Nghề gia sư/giáo viên**: tìm học viên đầu tiên, xây hồ sơ, thu học phí, xử lý phụ huynh khó.
3. **Công cụ và phương pháp**: bài giảng online, bảng trắng, đề kiểm tra, mẹo kèm từng môn.
4. **Mùa vụ**: đầu năm học, thi giữa kỳ/cuối kỳ, tuyển sinh lớp 10, thi tốt nghiệp THPT, hè.
5. **Câu chuyện kết nối**: trường hợp học viên tiến bộ (chỉ dùng khi có sự đồng ý và dữ liệu thật).

## 4. Chấm điểm chủ đề (Claude làm khi đọc kết quả Muse AI)

Mỗi chủ đề 0-5 điểm cho từng tiêu chí, tổng 20:

- **Cầu thật**: nhiều người hỏi cùng một vấn đề, trong 7 ngày gần nhất.
- **Hai phía**: giúp được cả bên tìm lẫn bên dạy.
- **Giá trị độc lập**: bỏ phần giới thiệu dịch vụ vẫn hữu ích.
- **Sản xuất được**: có thể thành bài hoặc video ngắn trong 1-2 ngày.

Từ 14 điểm trở lên mới tạo `content/<slug>/`. Dưới 14 thì ghi vào danh sách chờ.

Loại ngay: chủ đề liên quan trẻ vị thành niên ở mức cá nhân, tố cáo/tranh cãi cá nhân, bài kéo sang inbox, dữ liệu riêng tư (theo `docs/facebook-page-group-comment-agent-principles.md`). Không tự đăng comment trong group.

## 5. Đề xuất mật độ quét

Nguyên tắc: nhu cầu gia sư có mùa vụ và có giờ cao điểm, nên quét dày vào mùa cao điểm, thưa vào mùa thấp. Quét quá dày chỉ tạo trùng lặp và tốn quota.

| Loại quét | Mùa thường | Mùa cao điểm | Giờ chạy (UTC+7) |
|---|---|---|---|
| **Nhanh** (hashtag, nhóm chính, câu hỏi mới) | 1 lần/ngày | 2 lần/ngày | 07:00; thêm 20:30 vào mùa cao điểm |
| **Xu hướng** (chủ đề đang lên, đối thủ, tin giáo dục) | 2 lần/tuần (T2, T5) | 3 lần/tuần | 08:00 |
| **Sâu** (tổng hợp, chấm điểm lại, loại chủ đề cũ) | 1 lần/tuần (T2) | 1 lần/tuần | 09:00 |
| **Rà soát** (đối chiếu hiệu quả bài đã đăng, chỉnh từ khoá) | 1 lần/tháng | 2 lần/tháng | Tuần đầu tháng |

Lý do chọn giờ:
- 07:00: giáo viên và gia sư thường đăng và hỏi buổi sáng; kịp lên bài trong ngày.
- 20:30: phụ huynh hay hỏi tìm gia sư sau giờ cơm tối và sau khi xem bài vở của con.

**Mùa cao điểm** (đề xuất, cần bạn sửa theo thực tế): cuối tháng 8 đến giữa tháng 9, hai tuần trước thi giữa kỳ và cuối kỳ, tháng 5 đến đầu tháng 7 (tuyển sinh lớp 10, thi tốt nghiệp THPT), hai tuần trước Tết.

**Khởi động**: 2 tuần đầu chạy ở mức "mùa cao điểm" để lấy dữ liệu nền, rồi giảm theo số chủ đề đạt 14 điểm trở lên. Nếu một loại quét không ra chủ đề mới ba lần liên tiếp, giảm một bậc.

**Giới hạn đầu ra**: tối đa 3 chủ đề mới được đưa vào soạn bài mỗi ngày, tối đa 10 mỗi tuần, để người duyệt kịp đọc.

## 6. Cần bạn xác nhận (không đoán)

1. **Muse AI**: đang dùng gói nào, xuất kết quả được ra Google Docs/Drive theo lịch không, hay phải chạy thủ công? Nếu chỉ chạy thủ công thì lịch trên đổi thành "bạn chạy Muse AI, Claude đọc kết quả".
2. **Nguồn quét**: 3 Page và các group nào được phép theo dõi? Cần danh sách để đưa vào registry.
3. **Địa bàn và cấp học**: Đà Nẵng hay toàn quốc? Cấp nào (tiểu học, THCS, THPT, luyện thi, ngoại ngữ)?
4. **Mùa cao điểm** ở mục 5 có đúng với bạn không?
5. **Routine**: tạo bằng `create_trigger` (mỗi lần chạy mở một session). Bạn muốn giờ chạy cố định như bảng trên chứ?

## 7. Định dạng Doc "Radar" Muse AI trả về (đề xuất)

Mỗi dòng một chủ đề: `ngày | nguồn/nhóm | trụ cột | câu hỏi hoặc từ khoá gốc | số lần xuất hiện | link`. Claude đọc, chấm điểm theo mục 4, rồi ghi kết quả vào mục "Đã chọn / Danh sách chờ / Loại" cuối cùng cùng Doc.

## 8. Quyết định của người dùng (2026-10-15)

- **Nguồn quét**: tất cả Page và group đang quản lý (vẫn không tự đăng comment trong group).
- **Mật độ**: 3 lần/ngày, thay cho bảng ở mục 5. Đề xuất giờ: 07:00, 13:00, 20:30 (UTC+7). Mỗi lần là loại "Nhanh"; quét "Sâu" tuần một lần gộp vào lần 07:00 thứ Hai.
- **Địa bàn**: toàn quốc.
- **Phân khúc ưu tiên**: cao cấp, hoặc con học trường tư.
- **Muse AI**: gói cơ bản.
- **Bộ lọc giá (loại bỏ)**:
  - học phí dưới 150.000 đồng/buổi;
  - học phí dưới 1.000.000 đồng/tháng.
  Bài không nêu học phí thì không loại, chỉ giảm điểm "phân khúc" và ghi "chưa rõ giá".

Chấm điểm bổ sung (mục 4): thêm tiêu chí **Phân khúc** 0-5 (tín hiệu trường tư/quốc tế/song ngữ, học phí cao, yêu cầu gia sư chất lượng). Tổng thành 25, ngưỡng tạo bài là 18.

## 9. muse2api: chưa tích hợp, chờ xác nhận

Đã đọc https://github.com/www222fff/muse2api (v0.1, chính tác giả ghi "chưa chạy test, chưa thử với tài khoản thật"):

- Nó là cổng chuyển giao diện web muse.ai thành API kiểu OpenAI, chạy bằng Chromium và cookie đăng nhập (`hatch_sess`...) của tài khoản. Tác giả ghi chỉ để nghiên cứu và phải tuân thủ điều khoản của muse.ai.
- Nó chỉ trò chuyện/tạo ảnh/video, không tự quét Facebook. Dữ liệu Page/group phải do nguồn khác đưa vào.
- Cần một tiến trình chạy thường trực và cookie tài khoản; session cloud thì tạm thời. Cookie là thông tin đăng nhập, không được dán vào chat hay commit.
