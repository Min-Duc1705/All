# CHƯƠNG 1. TỔNG QUAN VỀ ĐỀ TÀI

---

## 1.1. Giới thiệu về đề tài

Trong bối cảnh hội nhập quốc tế và toàn cầu hóa, tiếng Anh đã trở thành ngôn ngữ không thể thiếu trong học tập, công việc và giao tiếp hàng ngày. Tại Việt Nam, nhu cầu học tiếng Anh ngày càng tăng cao, đặc biệt là trong giới trẻ và sinh viên.

Tuy nhiên, việc tự học tiếng Anh truyền thống gặp nhiều khó khăn và hạn chế:

+ **Quản lý từ vựng rời rạc**: Người học ghi chép từ mới vào sổ tay, file Excel, hoặc các ứng dụng flashcard khác nhau. Quá trình lưu trữ (phải tự gõ nghĩa, phiên âm IPA, câu ví dụ) rất tốn thời gian và thủ công. Dữ liệu bị phân tán ở nhiều nơi, khó ôn tập và dễ quên.

+ **Thiếu phản hồi tức thì về viết lách**: Khi luyện viết, người học không chắc chắn câu mình viết đã đúng ngữ pháp và tự nhiên hay chưa. Việc chờ đợi giáo viên chữa bài hoặc sử dụng các công cụ chấm điểm chuyên nghiệp có thể tốn kém và chậm trễ, làm giảm sự tự tin và tần suất luyện tập.

+ **Khó theo dõi tiến độ và mất động lực**: Người học phải dùng nhiều ứng dụng khác nhau để học từ, hẹn giờ, ghi chú. Không có một bức tranh tổng thể về nỗ lực của bản thân, không biết mình đã học được bao nhiêu từ, dẫn đến cảm giác nản chí và dễ bỏ cuộc.

+ **Thiếu công cụ luyện thi TOEIC/IELTS**: Người chuẩn bị thi TOEIC/IELTS phải mua sách đề thi hoặc đăng ký các dịch vụ trả phí với chi phí cao, đề thi hạn chế.

+ **Không có phản hồi về phát âm**: Luyện phát âm không có người hướng dẫn, không biết mình phát âm đúng hay sai, thiếu feedback để cải thiện.

Xuất phát từ những vấn đề trên, nhóm đã quyết định xây dựng ứng dụng **"Magic English"** - một ứng dụng học tiếng Anh thông minh trên nền tảng di động, tích hợp công nghệ **AI (Artificial Intelligence)** để giải quyết các khó khăn mà người tự học tiếng Anh thường gặp phải.

Ứng dụng hợp nhất các chức năng quan trọng nhất vào một nơi duy nhất (all-in-one):
- Lưu trữ và quản lý từ vựng thông minh với AI tự động làm giàu dữ liệu
- Kiểm tra ngữ pháp và chấm điểm viết lách tức thì
- Theo dõi tiến độ học tập với gamification (streak, achievements)
- Luyện thi TOEIC/IELTS với AI tạo đề
- Luyện phát âm với Speech-to-Text
- Nhận diện văn bản từ ảnh (OCR)

---

## 1.2. Mục tiêu của đề tài

Đề tài hướng đến các mục tiêu cụ thể sau:

+ Xây dựng ứng dụng di động đa nền tảng (Android, iOS) hỗ trợ người dùng tự học tiếng Anh hiệu quả.

+ Tích hợp AI để tự động hóa việc tra cứu và làm giàu dữ liệu từ vựng (nghĩa, phiên âm IPA, loại từ, câu ví dụ, cấp độ CEFR, audio phát âm).

+ Phát triển tính năng kiểm tra ngữ pháp thông minh, đưa ra điểm số, phân tích lỗi và gợi ý cải thiện bằng tiếng Việt giúp người học dễ hiểu.

+ Xây dựng hệ thống theo dõi tiến độ với biểu đồ trực quan và streak ngày học liên tục, tạo động lực học tập.

+ Phát triển hệ thống gamification với huy hiệu và thành tích để khuyến khích người dùng duy trì thói quen học.

+ Xây dựng module luyện thi TOEIC với đề thi được AI tạo tự động, bao gồm phần Listening và Reading.

+ Xây dựng module luyện thi IELTS với 4 kỹ năng (Listening, Reading, Writing, Speaking).

+ Tích hợp Speech-to-Text để hỗ trợ luyện phát âm, đánh giá độ chính xác phát âm của người dùng.

+ Tích hợp OCR (Optical Character Recognition) để nhận diện văn bản tiếng Anh từ ảnh chụp.

+ Cung cấp module đọc tin tức tiếng Anh giúp người dùng cải thiện kỹ năng đọc hiểu.

---

## 1.3. Phạm vi của đề tài

### 1.3.1. Đối tượng sử dụng

+ Học sinh, sinh viên muốn cải thiện vốn từ vựng và kỹ năng viết tiếng Anh
+ Người đi làm cần nâng cao trình độ tiếng Anh cho công việc
+ Người chuẩn bị thi TOEIC, IELTS
+ Người muốn tự học tiếng Anh mọi lúc mọi nơi

### 1.3.2. Phạm vi triển khai

+ Ứng dụng di động hoạt động trên nền tảng Android 5.0+ và iOS 12.0+
+ Backend API được triển khai trên cloud (Render)
+ Database sử dụng MySQL (Development) và PostgreSQL (Production)

### 1.3.3. Các chức năng của hệ thống

**Nhóm chức năng cốt lõi:**
+ Đăng ký, đăng nhập, quản lý tài khoản người dùng
+ Thêm và quản lý từ vựng với AI tự động làm giàu dữ liệu
+ Kiểm tra ngữ pháp với AI, hiển thị điểm số và giải thích lỗi
+ Theo dõi tiến độ học tập với biểu đồ và thống kê
+ Hệ thống thành tích và huy hiệu (gamification)

**Nhóm chức năng mở rộng:**
+ Luyện thi TOEIC (Part Listening và Reading)
+ Luyện thi IELTS (4 kỹ năng)
+ Luyện phát âm với Speech-to-Text
+ Nhận diện văn bản từ ảnh (OCR)
+ Đọc tin tức tiếng Anh từ RSS

### 1.3.4. Các chức năng không nằm trong phạm vi

+ Chức năng chat trực tiếp với giáo viên
+ Lớp học online video call
+ Thi online với giám sát proctoring
+ Thanh toán và mua khóa học premium
+ Chế độ offline (yêu cầu kết nối Internet)

---

## 1.4. Phân chia nhiệm vụ

| Thành viên       | Nhiệm vụ được giao                                                                                                                                                                 |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Nguyễn Văn A** | - Thiết kế và xây dựng Backend API với Spring Boot<br>- Tích hợp Spring AI với OpenAI API<br>- Xây dựng module Vocabulary, Grammar Checker<br>- Thiết kế Database và Entity        |
| **Nguyễn Văn B** | - Phát triển Frontend Mobile với Flutter<br>- Xây dựng UI/UX cho các màn hình<br>- Tích hợp Google ML Kit (OCR, Speech-to-Text)<br>- Xây dựng module Stats & Streaks, Achievements |
| **Cả nhóm**      | - Viết báo cáo đồ án<br>- Kiểm thử và sửa lỗi<br>- Triển khai ứng dụng                                                                                                             |

---
