# BẢNG ĐẶC TẢ CHỨC NĂNG

## Dự án: Magic English - Ứng dụng Học Tiếng Anh Thông Minh

---

## Tổng quan

Bảng đặc tả chức năng dưới đây mô tả chi tiết tất cả các chức năng trong dự án Magic English, bao gồm cả Backend (Spring Boot) và Frontend (Flutter Mobile).

---

## 1. MODULE XÁC THỰC (AUTHENTICATION)

| Mã chức năng | Tên chức năng           | Mô tả chi tiết                                                    | Actor                   | Điều kiện tiên quyết                   | Luồng xử lý chính                                                                                                                                     | Kết quả đầu ra                                         | API Endpoint                 |
| ------------ | ----------------------- | ----------------------------------------------------------------- | ----------------------- | -------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ | ---------------------------- |
| AUTH-01      | Đăng nhập               | Cho phép người dùng đăng nhập vào hệ thống bằng email và mật khẩu | Người dùng              | Có tài khoản đã đăng ký trong hệ thống | 1. Nhập email và mật khẩu<br>2. Hệ thống xác thực thông tin<br>3. Tạo JWT Access Token và Refresh Token<br>4. Lưu Refresh Token vào Cookie (HttpOnly) | Access Token, Thông tin user (id, email, name, avatar) | `POST /api/v1/auth/login`    |
| AUTH-02      | Đăng ký                 | Cho phép người dùng tạo tài khoản mới                             | Người dùng              | Email chưa tồn tại trong hệ thống      | 1. Nhập họ tên, email, mật khẩu<br>2. Kiểm tra email trùng lặp<br>3. Mã hóa mật khẩu bằng BCrypt<br>4. Lưu user vào database                          | Thông tin tài khoản mới (email, name)                  | `POST /api/v1/auth/register` |
| AUTH-03      | Đăng xuất               | Cho phép người dùng đăng xuất khỏi hệ thống                       | Người dùng đã đăng nhập | Đã đăng nhập thành công                | 1. Xóa Refresh Token trong database<br>2. Xóa Cookie refresh_token<br>3. Xóa token phía client (SharedPreferences)                                    | Thông báo đăng xuất thành công                         | `POST /api/v1/auth/logout`   |
| AUTH-04      | Làm mới Token           | Tự động refresh Access Token khi hết hạn                          | Hệ thống                | Có Refresh Token hợp lệ trong Cookie   | 1. Đọc Refresh Token từ Cookie<br>2. Xác thực Refresh Token<br>3. Tạo Access Token mới<br>4. Tạo Refresh Token mới                                    | Access Token mới, Refresh Token mới                    | `GET /api/v1/auth/refresh`   |
| AUTH-05      | Lấy thông tin tài khoản | Lấy thông tin chi tiết của người dùng hiện tại                    | Người dùng đã đăng nhập | Có Access Token hợp lệ                 | 1. Giải mã JWT Token<br>2. Lấy email từ SecurityContext<br>3. Query thông tin từ database                                                             | Thông tin user đầy đủ                                  | `GET /api/v1/auth/account`   |

---

## 2. MODULE QUẢN LÝ NGƯỜI DÙNG (USER MANAGEMENT)

| Mã chức năng | Tên chức năng              | Mô tả chi tiết                         | Actor                   | Điều kiện tiên quyết               | Luồng xử lý chính                                                                               | Kết quả đầu ra                                          | API Endpoint                |
| ------------ | -------------------------- | -------------------------------------- | ----------------------- | ---------------------------------- | ----------------------------------------------------------------------------------------------- | ------------------------------------------------------- | --------------------------- |
| USER-01      | Tạo người dùng mới         | Admin tạo tài khoản người dùng mới     | Admin                   | Có quyền Admin, Email chưa tồn tại | 1. Nhập thông tin user<br>2. Kiểm tra email trùng<br>3. Mã hóa mật khẩu<br>4. Lưu database      | Thông tin user mới                                      | `POST /api/v1/users`        |
| USER-02      | Xóa người dùng             | Admin xóa tài khoản người dùng         | Admin                   | Có quyền Admin, User tồn tại       | 1. Kiểm tra user tồn tại<br>2. Xóa user và dữ liệu liên quan                                    | Thông báo xóa thành công                                | `DELETE /api/v1/users/{id}` |
| USER-03      | Lấy thông tin user theo ID | Truy xuất thông tin người dùng theo ID | Admin/User              | User tồn tại trong hệ thống        | 1. Query user theo ID<br>2. Trả về thông tin                                                    | Thông tin user                                          | `GET /api/v1/users/{id}`    |
| USER-04      | Cập nhật thông tin user    | Người dùng cập nhật thông tin cá nhân  | Người dùng đã đăng nhập | Đã đăng nhập                       | 1. Nhận thông tin mới (name, avatar)<br>2. Cập nhật database<br>3. Trả về thông tin đã cập nhật | Thông tin user đã cập nhật (id, name, email, avatarUrl) | `PUT /api/v1/users`         |

---

## 3. MODULE HỌC TỪ VỰNG (VOCABULARY)

| Mã chức năng | Tên chức năng                 | Mô tả chi tiết                                                 | Actor                   | Điều kiện tiên quyết            | Luồng xử lý chính                                                                                                                                | Kết quả đầu ra                                                                        | API Endpoint                                 |
| ------------ | ----------------------------- | -------------------------------------------------------------- | ----------------------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------- | -------------------------------------------- |
| VOCAB-01     | Thêm từ vựng mới              | Thêm từ tiếng Anh mới và tự động làm giàu dữ liệu bằng AI      | Người dùng đã đăng nhập | Đã đăng nhập                    | 1. Nhập từ tiếng Anh<br>2. Gọi AI để lấy nghĩa, IPA, wordType, CEFR level, examples<br>3. Lấy audio URL từ Dictionary API<br>4. Lưu vào database | Thông tin từ vựng đầy đủ (word, meaning, ipa, wordType, cefrLevel, example, audioUrl) | `POST /api/v1/vocabulary`                    |
| VOCAB-02     | Lấy danh sách từ vựng         | Xem danh sách tất cả từ vựng đã học với phân trang và tìm kiếm | Người dùng đã đăng nhập | Đã đăng nhập                    | 1. Query từ vựng theo user<br>2. Áp dụng filter tìm kiếm<br>3. Phân trang kết quả                                                                | Danh sách từ vựng với metadata phân trang                                             | `GET /api/v1/vocabulary?search=&page=&size=` |
| VOCAB-03     | Xem trước từ vựng             | Xem thông tin từ vựng từ AI mà không lưu database              | Người dùng đã đăng nhập | Đã đăng nhập                    | 1. Nhập từ tiếng Anh<br>2. Gọi AI để lấy thông tin<br>3. Trả về kết quả (không lưu)                                                              | Thông tin từ vựng từ AI (preview)                                                     | `POST /api/v1/vocabulary/preview`            |
| VOCAB-04     | Thống kê từ vựng theo loại từ | Lấy phân bố từ vựng theo verb, noun, adjective, adverb         | Người dùng đã đăng nhập | Đã đăng nhập, Có từ vựng đã học | 1. Query thống kê từ database<br>2. Nhóm theo wordType<br>3. Đếm số lượng                                                                        | Map: {verb: 120, noun: 80, adjective: 60, adverb: 40}                                 | `GET /api/v1/vocabulary/breakdown`           |
| VOCAB-05     | Thống kê theo cấp độ CEFR     | Lấy phân bố từ vựng theo A1, A2, B1, B2, C1, C2                | Người dùng đã đăng nhập | Đã đăng nhập, Có từ vựng đã học | 1. Query thống kê từ database<br>2. Nhóm theo cefrLevel                                                                                          | Map: {A1: 30, A2: 50, B1: 90, B2: 70, C1: 20, C2: 10}                                 | `GET /api/v1/vocabulary/cefr-distribution`   |
| VOCAB-06     | Đếm tổng số từ vựng           | Lấy tổng số từ vựng đã học                                     | Người dùng đã đăng nhập | Đã đăng nhập                    | 1. Count từ vựng theo user_id                                                                                                                    | Số lượng từ vựng (Long)                                                               | `GET /api/v1/vocabulary/count`               |

---

## 4. MODULE KIỂM TRA NGỮ PHÁP (GRAMMAR CHECKER)

| Mã chức năng | Tên chức năng         | Mô tả chi tiết                                                     | Actor                   | Điều kiện tiên quyết                        | Luồng xử lý chính                                                                                                                                                                                       | Kết quả đầu ra                                                                                                         | API Endpoint                      |
| ------------ | --------------------- | ------------------------------------------------------------------ | ----------------------- | ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | --------------------------------- |
| GRAM-01      | Kiểm tra ngữ pháp     | Phân tích văn bản tiếng Anh, phát hiện và sửa lỗi ngữ pháp bằng AI | Người dùng đã đăng nhập | Đã đăng nhập                                | 1. Nhận văn bản đầu vào<br>2. Kiểm tra cache<br>3. Gọi AI phân tích lỗi (spelling, punctuation, grammar, clarity)<br>4. Parse response thành danh sách lỗi<br>5. Cache kết quả<br>6. Lưu DB bất đồng bộ | Score (0-100), correctedText, danh sách errors (errorType, errorText, correctedText, explanation tiếng Việt, position) | `POST /api/v1/grammar/check`      |
| GRAM-02      | Lấy lịch sử kiểm tra  | Xem lịch sử các lần kiểm tra ngữ pháp với phân trang               | Người dùng đã đăng nhập | Đã đăng nhập                                | 1. Query lịch sử theo user<br>2. Phân trang kết quả                                                                                                                                                     | Danh sách lịch sử kiểm tra với metadata                                                                                | `GET /api/v1/grammar?page=&size=` |
| GRAM-03      | Xem chi tiết kiểm tra | Xem chi tiết một lần kiểm tra ngữ pháp theo ID                     | Người dùng đã đăng nhập | Đã đăng nhập, Record tồn tại                | 1. Query theo ID<br>2. Kiểm tra ownership<br>3. Trả về chi tiết                                                                                                                                         | Chi tiết kiểm tra ngữ pháp                                                                                             | `GET /api/v1/grammar/{id}`        |
| GRAM-04      | Xóa lịch sử kiểm tra  | Xóa một record lịch sử kiểm tra                                    | Người dùng đã đăng nhập | Đã đăng nhập, Record tồn tại, Là chủ sở hữu | 1. Kiểm tra record tồn tại<br>2. Kiểm tra ownership<br>3. Xóa record                                                                                                                                    | HTTP 204 No Content                                                                                                    | `DELETE /api/v1/grammar/{id}`     |

---

## 5. MODULE LUYỆN THI TOEIC

| Mã chức năng | Tên chức năng       | Mô tả chi tiết                                            | Actor                   | Điều kiện tiên quyết              | Luồng xử lý chính                                                                                                                                 | Kết quả đầu ra                                   | API Endpoint                       |
| ------------ | ------------------- | --------------------------------------------------------- | ----------------------- | --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | ---------------------------------- |
| TOEIC-01     | Tạo đề thi TOEIC    | AI tạo đề thi TOEIC mới với các part Listening và Reading | Người dùng đã đăng nhập | Đã đăng nhập                      | 1. Nhận request (part, số câu hỏi, độ khó)<br>2. Gọi AI generate câu hỏi<br>3. Tạo audio cho Listening (Google TTS)<br>4. Lưu đề thi vào database | Đề thi TOEIC (testId, questions, audio URLs)     | `POST /api/v1/toeic/generate`      |
| TOEIC-02     | Lấy đề thi theo ID  | Xem chi tiết đề thi TOEIC đã tạo                          | Người dùng đã đăng nhập | Đã đăng nhập, Đề thi tồn tại      | 1. Query đề thi theo ID<br>2. Trả về chi tiết                                                                                                     | Chi tiết đề thi TOEIC                            | `GET /api/v1/toeic/tests/{testId}` |
| TOEIC-03     | Bắt đầu làm bài     | Bắt đầu một phiên làm bài thi mới                         | Người dùng đã đăng nhập | Đã đăng nhập, Đề thi tồn tại      | 1. Tạo record TestHistory<br>2. Lưu thời gian bắt đầu<br>3. Trả về session ID                                                                     | TestHistory (historyId, testId, startTime)       | `POST /api/v1/toeic/start`         |
| TOEIC-04     | Nộp bài thi         | Nộp bài thi và nhận kết quả                               | Người dùng đã đăng nhập | Đã đăng nhập, Có session đang làm | 1. Nhận danh sách câu trả lời<br>2. Chấm điểm tự động<br>3. Tính điểm TOEIC scale<br>4. Cập nhật TestHistory<br>5. Check achievements             | Kết quả (score, correct/total, detailed results) | `POST /api/v1/toeic/submit`        |
| TOEIC-05     | Xem lịch sử làm bài | Xem danh sách các bài thi đã làm                          | Người dùng đã đăng nhập | Đã đăng nhập                      | 1. Query TestHistory theo user<br>2. Sắp xếp theo thời gian                                                                                       | Danh sách lịch sử làm bài                        | `GET /api/v1/toeic/history`        |

---

## 6. MODULE LUYỆN THI IELTS

| Mã chức năng | Tên chức năng       | Mô tả chi tiết                                                                | Actor                   | Điều kiện tiên quyết              | Luồng xử lý chính                                                                                                        | Kết quả đầu ra                                      | API Endpoint                       |
| ------------ | ------------------- | ----------------------------------------------------------------------------- | ----------------------- | --------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------- | ---------------------------------- |
| IELTS-01     | Tạo đề thi IELTS    | AI tạo đề thi IELTS mới với 4 kỹ năng (Listening, Reading, Writing, Speaking) | Người dùng đã đăng nhập | Đã đăng nhập                      | 1. Nhận request (skill, số câu hỏi, chủ đề)<br>2. Gọi AI generate câu hỏi<br>3. Tạo audio nếu Listening<br>4. Lưu đề thi | Đề thi IELTS (testId, questions, audio URLs nếu có) | `POST /api/v1/ielts/generate`      |
| IELTS-02     | Lấy đề thi theo ID  | Xem chi tiết đề thi IELTS đã tạo                                              | Người dùng đã đăng nhập | Đã đăng nhập, Đề thi tồn tại      | 1. Query đề thi theo ID                                                                                                  | Chi tiết đề thi IELTS                               | `GET /api/v1/ielts/tests/{testId}` |
| IELTS-03     | Bắt đầu làm bài     | Bắt đầu một phiên làm bài thi IELTS mới                                       | Người dùng đã đăng nhập | Đã đăng nhập, Đề thi tồn tại      | 1. Tạo record TestHistory<br>2. Lưu thời gian bắt đầu                                                                    | TestHistory (historyId, testId, startTime)          | `POST /api/v1/ielts/start`         |
| IELTS-04     | Nộp bài thi         | Nộp bài thi IELTS và nhận kết quả                                             | Người dùng đã đăng nhập | Đã đăng nhập, Có session đang làm | 1. Nhận câu trả lời<br>2. Chấm điểm (AI chấm Writing/Speaking)<br>3. Tính band score<br>4. Cập nhật history              | Kết quả (band score, detailed feedback)             | `POST /api/v1/ielts/submit`        |
| IELTS-05     | Xem lịch sử làm bài | Xem danh sách các bài thi IELTS đã làm                                        | Người dùng đã đăng nhập | Đã đăng nhập                      | 1. Query TestHistory theo user                                                                                           | Danh sách lịch sử làm bài                           | `GET /api/v1/ielts/history`        |

---

## 7. MODULE THÀNH TÍCH (ACHIEVEMENT)

| Mã chức năng | Tên chức năng          | Mô tả chi tiết                                          | Actor                   | Điều kiện tiên quyết                | Luồng xử lý chính                                    | Kết quả đầu ra                                                     | API Endpoint                       |
| ------------ | ---------------------- | ------------------------------------------------------- | ----------------------- | ----------------------------------- | ---------------------------------------------------- | ------------------------------------------------------------------ | ---------------------------------- |
| ACH-01       | Lấy tất cả thành tích  | Xem danh sách tất cả các loại thành tích trong hệ thống | Người dùng đã đăng nhập | Đã đăng nhập                        | 1. Query tất cả Achievement                          | Danh sách Achievement (id, title, description, iconUrl, condition) | `GET /api/v1/achievements`         |
| ACH-02       | Lấy thành tích theo ID | Xem chi tiết một thành tích                             | Người dùng đã đăng nhập | Đã đăng nhập, Achievement tồn tại   | 1. Query Achievement theo ID                         | Chi tiết Achievement                                               | `GET /api/v1/achievements/{id}`    |
| ACH-03       | Tạo thành tích mới     | Admin tạo loại thành tích mới                           | Admin                   | Có quyền Admin                      | 1. Nhận thông tin achievement<br>2. Lưu vào database | Achievement mới                                                    | `POST /api/v1/achievements`        |
| ACH-04       | Cập nhật thành tích    | Admin cập nhật thông tin thành tích                     | Admin                   | Có quyền Admin, Achievement tồn tại | 1. Query achievement<br>2. Cập nhật thông tin        | Achievement đã cập nhật                                            | `PUT /api/v1/achievements/{id}`    |
| ACH-05       | Xóa thành tích         | Admin xóa loại thành tích                               | Admin                   | Có quyền Admin, Achievement tồn tại | 1. Xóa achievement                                   | HTTP 204 No Content                                                | `DELETE /api/v1/achievements/{id}` |

---

## 8. MODULE THÀNH TÍCH NGƯỜI DÙNG (USER ACHIEVEMENT)

| Mã chức năng | Tên chức năng                       | Mô tả chi tiết                                       | Actor                   | Điều kiện tiên quyết | Luồng xử lý chính                                                                                                                                 | Kết quả đầu ra                                                    | API Endpoint                             |
| ------------ | ----------------------------------- | ---------------------------------------------------- | ----------------------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | ---------------------------------------- |
| UACH-01      | Kiểm tra và cấp thành tích          | Trigger kiểm tra và tự động cấp thành tích mới       | Hệ thống/Client         | Đã đăng nhập         | 1. Nhận metricType và currentValue<br>2. So sánh với điều kiện từng achievement<br>3. Cấp achievement chưa có<br>4. Trả về danh sách mới đạt được | Danh sách Achievement mới đạt được                                | `POST /api/v1/user-achievements/check`   |
| UACH-02      | Lấy thành tích của user             | Xem danh sách thành tích đã đạt được                 | Người dùng đã đăng nhập | Đã đăng nhập         | 1. Query UserAchievement theo user_id                                                                                                             | Danh sách UserAchievement (với thông tin achievement và earnedAt) | `GET /api/v1/user-achievements`          |
| UACH-03      | Reset thành tích                    | Reset tất cả thành tích của user (testing)           | Người dùng đã đăng nhập | Đã đăng nhập         | 1. Xóa tất cả UserAchievement của user                                                                                                            | Thông báo reset thành công                                        | `DELETE /api/v1/user-achievements/reset` |
| UACH-04      | Lấy tất cả thành tích (with status) | Xem tất cả thành tích kèm trạng thái đã đạt/chưa đạt | Người dùng đã đăng nhập | Đã đăng nhập         | 1. Query tất cả Achievement<br>2. Đánh dấu đã đạt/chưa đạt                                                                                        | Danh sách Achievement                                             | `GET /api/v1/user-achievements/all`      |

---

## 9. MODULE THỐNG KÊ (STATISTICS)

| Mã chức năng | Tên chức năng      | Mô tả chi tiết                                      | Actor                   | Điều kiện tiên quyết | Luồng xử lý chính                                                                                                          | Kết quả đầu ra                                                            | API Endpoint                               |
| ------------ | ------------------ | --------------------------------------------------- | ----------------------- | -------------------- | -------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ------------------------------------------ |
| STAT-01      | Thống kê trang chủ | Lấy thống kê tổng hợp cho dashboard                 | Người dùng đã đăng nhập | Đã đăng nhập         | 1. Đếm từ học hôm nay<br>2. Đếm tổng từ<br>3. Tính streak ngày<br>4. Đếm grammar checks<br>5. Tính điểm grammar trung bình | Map: {wordsToday, totalWords, streakDays, grammarChecks, avgGrammarScore} | `GET /api/v1/vocabulary/home-stats`        |
| STAT-02      | Phân bố loại từ    | Thống kê từ vựng theo verb, noun, adjective, adverb | Người dùng đã đăng nhập | Đã đăng nhập         | 1. Group by wordType<br>2. Count mỗi nhóm                                                                                  | Map: {verb, noun, adjective, adverb, other}                               | `GET /api/v1/vocabulary/breakdown`         |
| STAT-03      | Phân bố CEFR       | Thống kê từ vựng theo cấp độ CEFR                   | Người dùng đã đăng nhập | Đã đăng nhập         | 1. Group by cefrLevel<br>2. Count mỗi cấp                                                                                  | Map: {A1, A2, B1, B2, C1, C2}                                             | `GET /api/v1/vocabulary/cefr-distribution` |
| STAT-04      | Tổng số từ vựng    | Đếm tổng số từ đã học                               | Người dùng đã đăng nhập | Đã đăng nhập         | 1. Count by user_id                                                                                                        | Long: totalCount                                                          | `GET /api/v1/vocabulary/count`             |

---

## 10. MODULE QUẢN LÝ FILE

| Mã chức năng | Tên chức năng | Mô tả chi tiết                       | Actor                   | Điều kiện tiên quyết                                 | Luồng xử lý chính                                                                                       | Kết quả đầu ra                          | API Endpoint                          |
| ------------ | ------------- | ------------------------------------ | ----------------------- | ---------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | --------------------------------------- | ------------------------------------- |
| FILE-01      | Upload file   | Upload file (ảnh đại diện, tài liệu) | Người dùng đã đăng nhập | Đã đăng nhập, File hợp lệ (pdf, jpg, png, doc, docx) | 1. Validate file extension<br>2. Tạo thư mục nếu chưa có<br>3. Lưu file với tên unique<br>4. Trả về URL | ResUploadFileDTO (fileName, uploadedAt) | `POST /api/v1/files`                  |
| FILE-02      | Download file | Tải file về máy                      | Người dùng đã đăng nhập | Đã đăng nhập, File tồn tại                           | 1. Kiểm tra file tồn tại<br>2. Đọc file<br>3. Trả về InputStreamResource                                | File binary data                        | `GET /api/v1/files?fileName=&folder=` |

---

## 11. MODULE PHÁT ÂM (PRONUNCIATION)

| Mã chức năng | Tên chức năng     | Mô tả chi tiết                                        | Actor                   | Điều kiện tiên quyết | Luồng xử lý chính                                                                                                                                    | Kết quả đầu ra                                                          | API Endpoint                         |
| ------------ | ----------------- | ----------------------------------------------------- | ----------------------- | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- | ------------------------------------ |
| PRON-01      | Phân tích phát âm | Phân tích và đánh giá phát âm dựa trên speech-to-text | Người dùng đã đăng nhập | Đã đăng nhập         | 1. Nhận expectedWord, transcribedText, IPA<br>2. So sánh transcribed với expected<br>3. Gọi AI phân tích chất lượng phát âm<br>4. Tính điểm và gợi ý | PronunciationFeedbackResponse (score, isCorrect, feedback, suggestions) | `POST /api/v1/pronunciation/analyze` |

---

## 12. MODULE AUDIO PROXY

| Mã chức năng | Tên chức năng | Mô tả chi tiết                                        | Actor      | Điều kiện tiên quyết | Luồng xử lý chính                                                      | Kết quả đầu ra          | API Endpoint              |
| ------------ | ------------- | ----------------------------------------------------- | ---------- | -------------------- | ---------------------------------------------------------------------- | ----------------------- | ------------------------- |
| AUDIO-01     | Proxy Audio   | Chuyển tiếp audio từ nguồn bên ngoài (Dictionary API) | Mobile App | Audio URL hợp lệ     | 1. Nhận audio URL<br>2. Fetch audio từ nguồn<br>3. Trả về audio stream | Audio binary data (MP3) | `GET /api/v1/audio-proxy` |

---

## BẢNG TỔNG HỢP CHỨC NĂNG THEO MODULE FRONTEND (FLUTTER)

| STT | Module Frontend | Service File                                       | Chức năng chính                             |
| --- | --------------- | -------------------------------------------------- | ------------------------------------------- |
| 1   | Authentication  | `auth_service.dart`                                | Đăng nhập, Đăng ký, Xử lý JWT Token         |
| 2   | Vocabulary      | `vocabulary_service.dart`                          | Thêm từ, Xem danh sách, Preview từ          |
| 3   | Grammar         | `grammar_service.dart`                             | Kiểm tra ngữ pháp, Xem lịch sử, Xóa lịch sử |
| 4   | TOEIC Practice  | `toeic_service.dart`                               | Generate đề, Làm bài, Submit, Xem lịch sử   |
| 5   | IELTS Practice  | `ielts_service.dart`                               | Generate đề, Làm bài, Submit, Xem lịch sử   |
| 6   | Achievement     | `achievement_service.dart`                         | Check achievements, Xem thành tích          |
| 7   | Progress/Stats  | `progress_service.dart`, `home_stats_service.dart` | Thống kê tiến độ, Dashboard stats           |
| 8   | User Profile    | `user_service.dart`                                | Cập nhật profile, Avatar                    |
| 9   | File Upload     | `file_service.dart`                                | Upload ảnh đại diện                         |
| 10  | News            | `news_service.dart`                                | Đọc tin tức tiếng Anh từ RSS                |
| 11  | Pronunciation   | `pronunciation_service.dart`                       | Luyện phát âm, Đánh giá phát âm             |

---

## BẢNG MA TRẬN PHÂN QUYỀN

| Chức năng           | Guest | User | Admin |
| ------------------- | ----- | ---- | ----- |
| Đăng ký             | ✅     | -    | -     |
| Đăng nhập           | ✅     | -    | -     |
| Xem/Thêm từ vựng    | ❌     | ✅    | ✅     |
| Kiểm tra ngữ pháp   | ❌     | ✅    | ✅     |
| Làm bài TOEIC/IELTS | ❌     | ✅    | ✅     |
| Xem thành tích      | ❌     | ✅    | ✅     |
| Xem thống kê        | ❌     | ✅    | ✅     |
| Quản lý Achievement | ❌     | ❌    | ✅     |
| Quản lý User        | ❌     | ❌    | ✅     |

---

## CHÚ THÍCH

- **Actor**: Đối tượng thực hiện chức năng
- **Điều kiện tiên quyết**: Các điều kiện cần thỏa mãn trước khi thực hiện
- **Luồng xử lý chính**: Các bước chính trong quy trình xử lý
- **API Endpoint**: Địa chỉ API tương ứng trên Backend
- **JWT**: JSON Web Token - cơ chế xác thực
- **CEFR**: Common European Framework of Reference - Khung tham chiếu ngôn ngữ châu Âu
- **AI**: Artificial Intelligence - Trí tuệ nhân tạo (OpenAI GPT)
