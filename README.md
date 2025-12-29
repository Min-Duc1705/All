# Magic English - Ứng dụng học tiếng Anh

Ứng dụng học tiếng Anh toàn diện với AI, hỗ trợ luyện thi TOEIC, IELTS, học từ vựng, kiểm tra ngữ pháp và theo dõi tiến độ học tập.

## 🏗️ Cấu trúc thư mục dự án

```
BTL/
├── Backend/                          # Backend Spring Boot
│   └── magic-english/
│       └── src/main/java/vn/project/magic_english/
│           ├── MagicEnglishApplication.java    # Entry point
│           ├── config/                          # Cấu hình (Security, CORS, AI...)
│           ├── controller/                      # REST API Controllers
│           ├── model/                           # Entity models (User, TOEIC, IELTS...)
│           ├── repository/                      # JPA Repositories
│           ├── service/                         # Business logic services
│           └── utils/                           # Utilities (Security, Error handling)
│
├── Frontend-Moblie/                  # Flutter Mobile App
│   └── magic_enlish/
│       └── lib/
│           ├── main.dart                        # Entry point
│           ├── core/                            # Core utilities
│           │   ├── constants/                   # App constants
│           │   ├── theme/                       # Theme configuration
│           │   ├── utils/                       # Helper utilities
│           │   └── widgets/                     # Reusable widgets
│           ├── data/                            # Data layer
│           │   ├── models/                      # Data models
│           │   ├── repositories/                # Data repositories
│           │   └── services/                    # API services
│           ├── features/                        # Feature modules
│           │   ├── auth/                        # Authentication (Login, Register)
│           │   ├── grammar_checker/             # AI Grammar checking
│           │   ├── home/                        # Home dashboard
│           │   ├── news/                        # English news
│           │   ├── onboarding/                  # Onboarding screens
│           │   ├── practice/                    # TOEIC & IELTS practice
│           │   ├── profile/                     # User profile & settings
│           │   ├── progress/                    # Learning progress tracking
│           │   └── vocabulary/                  # Vocabulary learning
│           └── providers/                       # State management providers
│
├── Frontend-Web/                     # Web Frontend (nếu có)
│
├── docs/                             # Tài liệu dự án
│
└── README.md                         # File này
```

## 🚀 Tính năng chính

- **Luyện thi TOEIC**: Part 1-7, Listening & Reading với AI tạo đề
- **Luyện thi IELTS**: Writing Task 1 & 2, đánh giá bằng AI
- **Học từ vựng**: Flashcards, phát âm, ví dụ
- **Kiểm tra ngữ pháp**: AI phân tích và sửa lỗi
- **Theo dõi tiến độ**: Biểu đồ, thống kê học tập
- **Tin tức tiếng Anh**: Đọc tin để cải thiện kỹ năng

## 🛠️ Công nghệ sử dụng

### Backend

- Java 17 + Spring Boot 3
- Spring Security + JWT
- Spring Data JPA + PostgreSQL
- Gemini AI API (text generation)
- Cloudinary (media storage)

### Frontend Mobile

- Flutter 3.x + Dart
- Provider (state management)
- Dio + HTTP (API calls)
- AudioPlayers (audio playback)
- Cached Network Image

## 📦 Cài đặt

### Backend

```bash
cd Backend/magic-english
./mvnw spring-boot:run
```

### Frontend Mobile

```bash
cd Frontend-Moblie/magic_enlish
flutter pub get
flutter run
```

### Build APK

```bash
flutter build apk --release
copy build\app\outputs\flutter-apk\app-release.apk MagicEnglish.apk
```

## 👥 Tác giả

- **Nhóm dự án**: TryHard IT

## 📄 License

MIT License
