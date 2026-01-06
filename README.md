<div align="center">

# 🌟 MAGIC ENGLISH - Ứng Dụng Học Tiếng Anh Thông Minh

<img src="https://img.shields.io/badge/Spring%20Boot-3.5.8-brightgreen?style=for-the-badge&logo=spring&logoColor=white" alt="Spring Boot">
<img src="https://img.shields.io/badge/Flutter-3.0+-blue?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
<img src="https://img.shields.io/badge/Java-21-orange?style=for-the-badge&logo=openjdk&logoColor=white" alt="Java">
<img src="https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL">
<img src="https://img.shields.io/badge/AI-Spring%20AI-purple?style=for-the-badge&logo=openai&logoColor=white" alt="AI">

### 🚀 Nền tảng học tiếng Anh hiện đại với công nghệ AI

[Tính năng](#-tính-năng-chính) •
[Cấu trúc](#-cấu-trúc-dự-án) •
[Cài đặt](#-hướng-dẫn-cài-đặt) •
[Đóng góp](#-quy-tắc-commit) •
[Thành viên](#-team-members--responsibilities)

</div>

---

## 📖 Giới Thiệu Dự Án

**Magic English** là một ứng dụng học tiếng Anh thông minh, kết hợp công nghệ **AI** và **Machine Learning** để mang đến trải nghiệm học tập cá nhân hóa và hiệu quả.

### 🎯 Mục Tiêu

- ✨ Cung cấp trải nghiệm học tiếng Anh **tương tác** và **sinh động**
- 🤖 Ứng dụng **AI** để phân tích và đánh giá khả năng học viên
- 📱 Giao diện **thân thiện**, dễ sử dụng trên mobile
- 🎓 Cá nhân hóa lộ trình học tập theo **năng lực từng người**
- 🏆 Hệ thống **thành tích** và **động lực** học tập

### 💡 Công Nghệ Sử Dụng

<div align="center">

| Backend           | Frontend         | Database       | AI/ML            |
| ----------------- | ---------------- | -------------- | ---------------- |
| Spring Boot 3.5.8 | Flutter 3.0+     | MySQL 8.0      | Spring AI        |
| Spring Security   | Dart             | JPA/Hibernate  | OpenAI API       |
| OAuth2            | Provider Pattern | Caffeine Cache | Text Recognition |
| RESTful API       | Material Design  | -              | Google ML Kit    |

</div>

---

## 🏗️ Cấu Trúc Dự Án

```
BTL_final/
│
├── 📂 Backend/                                    # 🔧 Backend - Spring Boot API
│   ├── 📂 src/main/java/vn/nhomx/magic_english/
│   │   ├── 📁 config/                             # ⚙️ Cấu hình (Security, CORS, Cache)
│   │   ├── 📁 controller/                         # 🎮 REST Controllers
│   │   ├── 📁 model/                              # 📊 Entities & DTOs
│   │   ├── 📁 repository/                         # 💾 JPA Repositories
│   │   ├── 📁 service/                            # 💼 Business Logic & AI
│   │   ├── 📁 utils/                              # 🛠️ Helper classes
│   │   └── 📄 MagicEnglishApplication.java        # 🚀 Main Entry Point
│   │
│   ├── 📂 src/main/resources/
│   │   └── 📄 application.yaml                    # ⚙️ Cấu hình ứng dụng
│   │
│   ├── � build.gradle                            # � Dependencies
│   ├── � Dockerfile                              # � Docker config
│   └── 📄 docker-compose.yml                      # � Docker compose
│
├── 📂 Mobile/magic_english/                       # 📱 Mobile App - Flutter
│   ├── 📂 lib/
│   │   ├── 📄 main.dart                           # 🚀 App Entry Point
│   │   │
│   │   ├── 📁 core/                               # 🎯 Core functionality
│   │   │   ├── constants/                         # 📌 App constants
│   │   │   ├── theme/                             # 🎨 App themes
│   │   │   ├── utils/                             # 🛠️ Utilities
│   │   │   └── widgets/                           # 🧩 Shared widgets
│   │   │
│   │   ├── 📁 data/                               # 💾 Data Layer
│   │   │   ├── models/                            # 📊 Data models
│   │   │   ├── repositories/                      # 🔄 Repositories
│   │   │   └── services/                          # 🌐 API services
│   │   │
│   │   ├── 📁 features/                           # 🎯 Feature Modules
│   │   │   ├── auth/                              # 🔐 Authentication
│   │   │   ├── home/                              # 🏠 Home screen
│   │   │   ├── vocabulary/                        # � Vocabulary
│   │   │   ├── grammar_checker/                   # ✍️ Grammar checker
│   │   │   ├── practice/                          # 📝 Practice (IELTS, TOEIC)
│   │   │   ├── progress/                          # 📊 Progress tracking
│   │   │   ├── profile/                           # 👤 User profile
│   │   │   ├── news/                              # 📰 News
│   │   │   └── onboarding/                        # � Onboarding
│   │   │
│   │   └── 📁 providers/                          # � State Management
│   │
│   ├── 📂 android/                                # 🤖 Android config
│   ├── 📂 ios/                                    # 🍎 iOS config
│   └── 📄 pubspec.yaml                            # 📦 Flutter dependencies
│
├── � Web/                                        # 🌐 Web (future)
│
└── 📄 README.md                                   # 📖 Documentation
```

---

## 📋 Nhiệm Vụ Các Thư Mục

### 🔧 Backend (Spring Boot)

| Thư mục         | Mô tả             | Trách nhiệm                                          |
| --------------- | ----------------- | ---------------------------------------------------- |
| **config/**     | Cấu hình hệ thống | Security, CORS, JWT, Cache, OpenAI integration       |
| **controller/** | API Endpoints     | Nhận requests, validate, gọi services, trả responses |
| **model/**      | Data Models       | Entities (JPA), DTOs, Request/Response objects       |
| **repository/** | Database Access   | JPA Repositories, Custom queries                     |
| **service/**    | Business Logic    | Core logic, AI integration, data processing          |
| **utils/**      | Tiện ích          | Validators, formatters, helpers, constants           |

### 📱 Frontend Mobile (Flutter)

| Thư mục        | Mô tả            | Trách nhiệm                             |
| -------------- | ---------------- | --------------------------------------- |
| **core/**      | Core App         | Constants, themes, utilities, widgets   |
| **data/**      | Data Layer       | Models, repositories, API services      |
| **features/**  | Features         | UI screens, widgets theo từng chức năng |
| **providers/** | State Management | Quản lý state với Provider pattern      |

---

## 🚀 Hướng Dẫn Cài Đặt

### 📋 Yêu Cầu Hệ Thống

- ☕ **Java JDK 21+**
- 🐘 **MySQL 8.0+**
- 📱 **Flutter SDK 3.0+**
- 🔧 **Gradle 8.0+**
- 🎯 **Android Studio** hoặc **VS Code**

### 🔧 Cài Đặt Backend

```bash
# 1. Di chuyển vào thư mục backend
cd Backend

# 2. Cấu hình database trong application.yaml
# Sửa username, password, database name

# 3. Build project
gradlew clean build

# 4. Chạy ứng dụng
gradlew bootRun
```

Backend sẽ chạy tại: `http://localhost:8080`

### 📱 Cài Đặt Mobile App

```bash
# 1. Di chuyển vào thư mục mobile
cd Mobile/magic_english

# 2. Cài đặt dependencies
flutter pub get

# 3. Chạy app (Android)
flutter run

# 4. Build APK
flutter build apk --release
```

---

## 🎨 Quy Tắc Commit

### 📝 Format Commit Message

```
[<prefix>] <type>(<scope>): <message>
```

### 🏷️ Prefixes

| Prefix  | Ý nghĩa                 | Ví dụ                                        |
| ------- | ----------------------- | -------------------------------------------- |
| `[BE]`  | Backend changes         | `[BE] feat(auth): add JWT authentication`    |
| `[FE]`  | Frontend/Mobile changes | `[FE] fix(login): fix validation error`      |
| `[DB]`  | Database changes        | `[DB] update: add user_progress table`       |
| `[DOC]` | Documentation           | `[DOC] update: improve README structure`     |
| `[ALL]` | Ảnh hưởng cả BE và FE   | `[ALL] refactor: update API response format` |

### 📦 Types

| Type       | Mô tả             | Khi nào dùng                   |
| ---------- | ----------------- | ------------------------------ |
| `feat`     | Tính năng mới     | Thêm feature, API mới          |
| `fix`      | Sửa bug           | Fix lỗi, bug                   |
| `refactor` | Tái cấu trúc code | Cải thiện code không đổi logic |
| `style`    | Style code        | Format, indent, whitespace     |
| `docs`     | Documentation     | Cập nhật README, comments      |
| `test`     | Testing           | Thêm/sửa tests                 |
| `perf`     | Performance       | Cải thiện hiệu suất            |
| `chore`    | Maintenance       | Update dependencies, configs   |
| `build`    | Build system      | Gradle, pubspec changes        |

### ✨ Ví Dụ Commits Chuẩn

```bash
# Backend
[BE] feat(auth): implement OAuth2 login with Google
[BE] fix(lesson): resolve null pointer in getLessonById
[BE] refactor(service): optimize AI prompt generation

# Frontend
[FE] feat(login): add biometric authentication
[FE] fix(ui): correct alignment on lesson cards
[FE] style(home): update color scheme to match design
```

---

<div align="center">

## 🎯 Team Members & Responsibilities

<br/>

| 👤 Thành Viên              | 🎯 Vai Trò        | 🆔 Mã Sinh Viên |
| -------------------------- | ----------------- | --------------- |
| **Lê Minh Đức**            | 👑 Leader         | `2251172287`    |
| **Nguyễn Thị Thanh Huyền** | 👤 Thành viên     | `2251172379`    |
| **Ngô Thị Thùy**           | 👤 Thành viên     | `2251172517`    |

</div>

---

## 📞 Liên Hệ & Đóng Góp

<div align="center">

### 📚 Tài Liệu Tham Khảo

- 📖 [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- 📱 [Flutter Documentation](https://flutter.dev/docs)
- 🤖 [Spring AI Documentation](https://docs.spring.io/spring-ai/reference/)
- 🎨 [Material Design Guidelines](https://material.io/design)

---

### ⭐ Nếu thấy dự án hữu ích, hãy cho chúng tôi một Star nhé!

**Made with ❤️ by Magic English Team**

</div>
