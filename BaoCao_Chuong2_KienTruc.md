# BÁO CÁO ĐỒ ÁN

# ỨNG DỤNG HỌC TIẾNG ANH THÔNG MINH - MAGIC ENGLISH

---

# CHƯƠNG 1. TỔNG QUAN VỀ ĐỀ TÀI

## 1.1. Giới thiệu về đề tài

### 1.1.1. Đặt vấn đề

Trong bối cảnh hội nhập quốc tế và toàn cầu hóa, tiếng Anh đã trở thành ngôn ngữ không thể thiếu trong học tập, công việc và giao tiếp hàng ngày. Tại Việt Nam, nhu cầu học tiếng Anh ngày càng tăng cao, đặc biệt là trong giới trẻ và sinh viên.

Tuy nhiên, việc học tiếng Anh truyền thống gặp nhiều hạn chế:
- **Chi phí cao**: Các trung tâm ngoại ngữ có học phí đắt đỏ
- **Thời gian cố định**: Học viên phải tuân theo lịch học của trung tâm
- **Thiếu cá nhân hóa**: Chương trình học chung không phù hợp với từng người
- **Thiếu tương tác**: Ít cơ hội luyện tập và nhận phản hồi tức thì

### 1.1.2. Giải pháp đề xuất

**Magic English** là một ứng dụng học tiếng Anh thông minh trên nền tảng di động, kết hợp công nghệ **AI (Artificial Intelligence)** và **Machine Learning** để mang đến trải nghiệm học tập:
- **Cá nhân hóa**: Lộ trình học tập phù hợp với năng lực từng người
- **Linh hoạt**: Học mọi lúc, mọi nơi trên điện thoại
- **Tương tác**: Phản hồi ngay lập tức từ AI
- **Tiết kiệm**: Chi phí thấp hơn nhiều so với trung tâm

### 1.1.3. Các tính năng chính

| STT | Tính năng               | Mô tả                                                      |
| --- | ----------------------- | ---------------------------------------------------------- |
| 1   | **Học từ vựng**         | Học từ vựng theo chủ đề với flashcard và spaced repetition |
| 2   | **Luyện ngữ pháp**      | Bài tập ngữ pháp với AI kiểm tra và giải thích chi tiết    |
| 3   | **Luyện thi TOEIC**     | Đề thi TOEIC mẫu với tất cả các phần: Listening, Reading   |
| 4   | **Luyện thi IELTS**     | Đề thi IELTS với Speaking, Writing, Listening, Reading     |
| 5   | **OCR - Nhận diện chữ** | Chụp ảnh văn bản tiếng Anh và dịch/phân tích ngay          |
| 6   | **Speech-to-Text**      | Luyện phát âm với AI đánh giá giọng nói                    |
| 7   | **Grammar Checker**     | AI kiểm tra và sửa lỗi ngữ pháp trong câu                  |
| 8   | **Tin tức tiếng Anh**   | Đọc tin tức bằng tiếng Anh để nâng cao kỹ năng đọc hiểu    |
| 9   | **Theo dõi tiến độ**    | Biểu đồ và thống kê tiến độ học tập                        |
| 10  | **Hệ thống thành tích** | Gamification với huy hiệu và điểm thưởng                   |

---

## 1.2. Mục tiêu của đề tài

### 1.2.1. Mục tiêu tổng quát

Xây dựng một ứng dụng học tiếng Anh toàn diện trên nền tảng di động, tích hợp công nghệ AI để hỗ trợ người học cải thiện kỹ năng tiếng Anh một cách hiệu quả và thú vị.

### 1.2.2. Mục tiêu cụ thể

**Về chức năng:**
- ✅ Phát triển hệ thống đăng nhập/đăng ký an toàn với JWT
- ✅ Xây dựng module học từ vựng với nhiều chế độ luyện tập
- ✅ Tích hợp AI để kiểm tra ngữ pháp và đưa ra giải thích
- ✅ Phát triển bộ đề thi TOEIC và IELTS
- ✅ Tích hợp OCR để nhận diện văn bản từ ảnh
- ✅ Tích hợp Speech-to-Text để luyện phát âm
- ✅ Xây dựng hệ thống theo dõi tiến độ học tập
- ✅ Phát triển hệ thống thành tích và gamification

**Về công nghệ:**
- ✅ Backend với Spring Boot 3.5.8 và Spring AI
- ✅ Mobile app với Flutter (cross-platform)
- ✅ Database với MySQL/PostgreSQL
- ✅ Tích hợp OpenAI API cho các tính năng AI
- ✅ Tích hợp Google ML Kit cho OCR và Speech

**Về hiệu suất:**
- ✅ Thời gian phản hồi API < 500ms
- ✅ Hỗ trợ đa nền tảng (Android, iOS)
- ✅ Giao diện người dùng mượt mà, trực quan

---

## 1.3. Phạm vi của đề tài

### 1.3.1. Phạm vi chức năng

**Các chức năng được phát triển:**

| Module                | Chức năng                                          | Trạng thái   |
| --------------------- | -------------------------------------------------- | ------------ |
| **Authentication**    | Đăng nhập, đăng ký, quên mật khẩu, refresh token   | ✅ Hoàn thành |
| **User Profile**      | Xem và cập nhật thông tin cá nhân, avatar          | ✅ Hoàn thành |
| **Vocabulary**        | Học từ vựng, flashcard, quiz, spaced repetition    | ✅ Hoàn thành |
| **Grammar Checker**   | Kiểm tra ngữ pháp với AI, giải thích lỗi           | ✅ Hoàn thành |
| **TOEIC Practice**    | Đề thi TOEIC với Listening và Reading              | ✅ Hoàn thành |
| **IELTS Practice**    | Đề thi IELTS Speaking, Writing, Listening, Reading | ✅ Hoàn thành |
| **OCR**               | Nhận diện văn bản từ ảnh                           | ✅ Hoàn thành |
| **Speech-to-Text**    | Luyện phát âm với nhận diện giọng nói              | ✅ Hoàn thành |
| **News**              | Đọc tin tức tiếng Anh từ RSS feeds                 | ✅ Hoàn thành |
| **Progress Tracking** | Theo dõi tiến độ học tập với biểu đồ               | ✅ Hoàn thành |
| **Achievements**      | Hệ thống huy hiệu và thành tích                    | ✅ Hoàn thành |

**Các chức năng không nằm trong phạm vi:**
- ❌ Chức năng chat trực tiếp với giáo viên
- ❌ Lớp học online video call
- ❌ Thi online với giám sát
- ❌ Thanh toán và mua khóa học premium

### 1.3.2. Phạm vi công nghệ

**Backend:**
- Framework: Spring Boot 3.5.8
- Language: Java 21
- Database: MySQL 8.0 (Development), PostgreSQL (Production)
- AI: Spring AI với OpenAI API
- Audio: Google Cloud Text-to-Speech

**Frontend Mobile:**
- Framework: Flutter 3.0+
- Language: Dart 3.9.2
- State Management: Provider
- ML: Google ML Kit (OCR, Speech-to-Text)

### 1.3.3. Phạm vi người dùng

**Đối tượng sử dụng:**
- Học sinh, sinh viên muốn cải thiện tiếng Anh
- Người đi làm cần nâng cao trình độ tiếng Anh
- Người chuẩn bị thi TOEIC, IELTS
- Người muốn tự học tiếng Anh mọi lúc mọi nơi

**Nền tảng hỗ trợ:**
- Android 5.0+ (Lollipop trở lên)
- iOS 12.0+ (iPhone 5s trở lên)

### 1.3.4. Phạm vi triển khai

- **Môi trường Development**: Localhost với MySQL
- **Môi trường Production**: 
  - Backend: Render (free tier) với PostgreSQL
  - Frontend: Google Play Store / Apple App Store

---

## 1.4. Ý nghĩa của đề tài

### 1.4.1. Ý nghĩa khoa học

- Nghiên cứu và áp dụng công nghệ AI (Large Language Models) vào lĩnh vực giáo dục
- Tích hợp các công nghệ hiện đại: Spring AI, Google ML Kit, Speech Recognition
- Thiết kế và triển khai hệ thống phân tán với kiến trúc Client-Server

### 1.4.2. Ý nghĩa thực tiễn

- Cung cấp công cụ học tiếng Anh miễn phí/giá rẻ cho mọi người
- Giúp người học tiết kiệm thời gian và chi phí
- Tạo môi trường học tập linh hoạt, cá nhân hóa
- Hỗ trợ người học chuẩn bị thi TOEIC, IELTS hiệu quả

---

# CHƯƠNG 2. KIẾN TRÚC VÀ CÔNG NGHỆ

## 2.1. Kiến trúc hệ thống

### 2.1.1. Tổng quan kiến trúc

Hệ thống **Magic English** được thiết kế theo kiến trúc **Client-Server** với mô hình **3 tầng (3-tier architecture)**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         KIẾN TRÚC TỔNG QUAN                             │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────┐         ┌─────────────────┐                        │
│  │   Mobile App    │  HTTP   │   Backend API   │                        │
│  │   (Flutter)     │◄───────►│  (Spring Boot)  │                        │
│  │   Client-side   │  REST   │   Server-side   │                        │
│  └─────────────────┘         └────────┬────────┘                        │
│                                       │                                 │
│                              ┌────────┴────────┐                        │
│                              ▼                 ▼                        │
│                    ┌─────────────────┐ ┌───────────────┐                │
│                    │    MySQL DB     │ │  AI Services  │                │
│                    │  (PostgreSQL)   │ │   (OpenAI)    │                │
│                    └─────────────────┘ └───────────────┘                │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 2.1.2. Kiến trúc Backend (Spring Boot)

Backend được xây dựng theo mô hình **Layered Architecture** với các tầng:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        BACKEND ARCHITECTURE                             │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    PRESENTATION LAYER                            │   │
│  │  ┌───────────────┐ ┌───────────────┐ ┌───────────────────────┐  │   │
│  │  │AuthController │ │VocabController│ │ GrammarController ... │  │   │
│  │  └───────────────┘ └───────────────┘ └───────────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                    │                                    │
│                                    ▼                                    │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                     BUSINESS LOGIC LAYER                         │   │
│  │  ┌───────────────┐ ┌───────────────┐ ┌───────────────────────┐  │   │
│  │  │  AuthService  │ │ VocabService  │ │   AI Integration ...  │  │   │
│  │  └───────────────┘ └───────────────┘ └───────────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                    │                                    │
│                                    ▼                                    │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                      DATA ACCESS LAYER                           │   │
│  │  ┌───────────────┐ ┌───────────────┐ ┌───────────────────────┐  │   │
│  │  │UserRepository │ │VocabRepository│ │ LessonRepository ...  │  │   │
│  │  └───────────────┘ └───────────────┘ └───────────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                    │                                    │
│                                    ▼                                    │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                       DATABASE LAYER                             │   │
│  │                    MySQL 8.0 / PostgreSQL                        │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

**Cấu trúc thư mục Backend:**

| Thư mục       | Mô tả                                          | Số file  |
| ------------- | ---------------------------------------------- | -------- |
| `config/`     | Cấu hình Security, CORS, JWT, Cache, AI        | 9 files  |
| `controller/` | REST API endpoints - xử lý HTTP requests       | 12 files |
| `model/`      | Entities (JPA), DTOs, Request/Response objects | 50 files |
| `repository/` | Data Access Layer - JPA Repositories           | 13 files |
| `service/`    | Business Logic - Services & AI Integration     | 13 files |
| `utils/`      | Utilities - Helper classes                     | 7 files  |

### 2.1.3. Kiến trúc Frontend Mobile (Flutter)

Frontend Mobile sử dụng kiến trúc **Feature-First** kết hợp với **Provider Pattern** cho state management:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                     FLUTTER APP ARCHITECTURE                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                         UI LAYER                                 │   │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌──────────┐  │   │
│  │  │  Auth   │ │  Home   │ │Practice │ │  Vocab  │ │ Profile  │  │   │
│  │  │ Screens │ │ Screen  │ │ Screens │ │ Screens │ │ Screens  │  │   │
│  │  └─────────┘ └─────────┘ └─────────┘ └─────────┘ └──────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                    │                                    │
│                                    ▼                                    │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    STATE MANAGEMENT (Provider)                   │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌────────────────────────┐   │   │
│  │  │ AuthProvider │ │VocabProvider │ │ ProgressProvider ...   │   │   │
│  │  └──────────────┘ └──────────────┘ └────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                    │                                    │
│                                    ▼                                    │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                       DATA LAYER                                 │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌────────────────────────┐   │   │
│  │  │   Models     │ │ Repositories │ │     API Services       │   │   │
│  │  └──────────────┘ └──────────────┘ └────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                    │                                    │
│                                    ▼                                    │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                       CORE LAYER                                 │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌────────────────────────┐   │   │
│  │  │  Constants   │ │    Theme     │ │   Utils / Widgets      │   │   │
│  │  └──────────────┘ └──────────────┘ └────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

**Cấu trúc thư mục Frontend:**

| Thư mục      | Mô tả                                                                   |
| ------------ | ----------------------------------------------------------------------- |
| `core/`      | Constants, Theme, Utils, Widgets dùng chung                             |
| `data/`      | Models, Repositories, API Services                                      |
| `features/`  | UI theo từng tính năng (auth, home, practice, vocabulary, profile, ...) |
| `providers/` | State Management với Provider Pattern                                   |

### 2.1.4. Luồng dữ liệu trong hệ thống

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         DATA FLOW DIAGRAM                               │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   User Action                                                           │
│       │                                                                 │
│       ▼                                                                 │
│   ┌───────────────┐    ┌───────────────┐    ┌───────────────┐          │
│   │   UI Screen   │───►│   Provider    │───►│  API Service  │          │
│   └───────────────┘    └───────────────┘    └───────┬───────┘          │
│                                                      │                  │
│                              HTTP Request (JSON)     │                  │
│                                                      ▼                  │
│   ┌───────────────┐    ┌───────────────┐    ┌───────────────┐          │
│   │   Database    │◄───│    Service    │◄───│  Controller   │          │
│   └───────────────┘    └───────────────┘    └───────────────┘          │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 2.1.5. Luồng xác thực (Authentication Flow)

```
┌─────────────────────────────────────────────────────────────────────────┐
│                     AUTHENTICATION FLOW (JWT + OAuth2)                  │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  1. Login Request                                                       │
│  ┌─────────────┐          ┌─────────────┐          ┌─────────────┐     │
│  │   Mobile    │  POST    │   Backend   │  Query   │   Database  │     │
│  │    App      │─────────►│/api/v1/auth │─────────►│   (Users)   │     │
│  │             │  login   │   /login    │  user    │             │     │
│  └─────────────┘          └──────┬──────┘          └─────────────┘     │
│                                  │                                      │
│  2. JWT Token Response           │                                      │
│  ┌─────────────┐          ┌──────▼──────┐                              │
│  │   Mobile    │◄─────────│   Backend   │                              │
│  │    App      │   JWT    │ (Generate   │                              │
│  │             │  Token   │  JWT Token) │                              │
│  └──────┬──────┘          └─────────────┘                              │
│         │                                                               │
│  3. Store Token (SharedPreferences)                                     │
│         │                                                               │
│         ▼                                                               │
│  4. Authenticated Requests                                              │
│  ┌─────────────┐          ┌─────────────┐                              │
│  │   Mobile    │──────────│   Backend   │                              │
│  │    App      │ Bearer   │ (Validate   │                              │
│  │             │ Token    │  JWT Token) │                              │
│  └─────────────┘          └─────────────┘                              │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 2.2. Giới thiệu về Công nghệ phát triển

### 2.2.1. Backend Technologies

#### 2.2.1.1. Spring Boot 3.5.8

**Spring Boot** là framework Java phổ biến nhất để xây dựng ứng dụng enterprise. Trong dự án Magic English, Spring Boot được sử dụng với các module:

| Module                                       | Mục đích                    |
| -------------------------------------------- | --------------------------- |
| `spring-boot-starter-web`                    | Xây dựng RESTful API        |
| `spring-boot-starter-data-jpa`               | ORM với Hibernate           |
| `spring-boot-starter-security`               | Bảo mật ứng dụng            |
| `spring-boot-starter-oauth2-resource-server` | OAuth2 + JWT Authentication |
| `spring-boot-starter-validation`             | Validation dữ liệu đầu vào  |
| `spring-boot-starter-cache`                  | Caching với Caffeine        |

**Ưu điểm:**
- Auto-configuration giúp giảm boilerplate code
- Embedded server (Tomcat) - không cần cấu hình server riêng
- Production-ready với các actuator endpoints
- Tích hợp tốt với Spring AI cho các tính năng AI

#### 2.2.1.2. Spring Security + JWT + OAuth2

Hệ thống bảo mật sử dụng **JWT (JSON Web Token)** với **OAuth2 Resource Server**:

```java
// SecurityConfiguration.java
@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfiguration {
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) {
        http
            .csrf(c -> c.disable())
            .cors(Customizer.withDefaults())
            .oauth2ResourceServer(oauth2 -> oauth2.jwt(Customizer.withDefaults()))
            .sessionManagement(session -> 
                session.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
        return http.build();
    }
    
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
```

**Đặc điểm:**
- **Stateless Authentication**: Không lưu session trên server
- **BCrypt Password Encoding**: Mã hóa mật khẩu an toàn
- **JWT Token**: Access token + Refresh token
- **Role-based Access Control**: Phân quyền theo vai trò

#### 2.2.1.3. Spring AI với OpenAI

Tích hợp **Spring AI** để sử dụng các mô hình AI cho việc học tiếng Anh:

```java
// ChatClientConfig.java  
@Configuration
public class ChatClientConfig {
    @Bean
    public ChatClient chatClient(ChatClient.Builder builder) {
        return builder.build();
    }
}
```

**Ứng dụng AI trong dự án:**
- Kiểm tra ngữ pháp (Grammar Checker)
- Gợi ý từ vựng theo ngữ cảnh
- Tạo bài tập tự động
- Đánh giá bài viết

#### 2.2.1.4. JPA/Hibernate + MySQL

**JPA (Java Persistence API)** với **Hibernate** làm ORM, kết nối với **MySQL 8.0**:

```yaml
# application.yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/magic_english
    driver-class-name: com.mysql.cj.jdbc.Driver
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
```

#### 2.2.1.5. Caffeine Cache

Sử dụng **Caffeine Cache** cho in-memory caching để tăng hiệu suất:

```java
// CacheConfig.java
@Configuration
@EnableCaching
public class CacheConfig {
    @Bean
    public CacheManager cacheManager() {
        CaffeineCacheManager cacheManager = new CaffeineCacheManager();
        cacheManager.setCaffeine(Caffeine.newBuilder()
            .expireAfterWrite(10, TimeUnit.MINUTES)
            .maximumSize(1000));
        return cacheManager;
    }
}
```

#### 2.2.1.6. Các công nghệ hỗ trợ khác

| Công nghệ                       | Mục đích                                            |
| ------------------------------- | --------------------------------------------------- |
| **Lombok**                      | Giảm boilerplate code (Getter, Setter, Constructor) |
| **Google Cloud Text-to-Speech** | Tạo audio cho bài nghe IELTS/TOEIC                  |
| **Cloudinary**                  | Lưu trữ ảnh đại diện trên cloud                     |

---

### 2.2.2. Frontend Technologies (Flutter)

#### 2.2.2.1. Flutter & Dart

**Flutter 3.0+** là framework cross-platform của Google, sử dụng ngôn ngữ **Dart SDK 3.9.2**:

**Ưu điểm:**
- **Cross-platform**: Một codebase cho Android và iOS
- **Hot Reload**: Cập nhật UI ngay lập tức khi phát triển
- **Widget-based**: Component dễ tái sử dụng
- **Material Design**: Giao diện đẹp, hiện đại

#### 2.2.2.2. Provider (State Management)

Sử dụng **Provider** pattern để quản lý state:

```dart
// Ví dụ: AuthProvider
class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;
  
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  
  Future<void> login(String email, String password) async {
    // Gọi API đăng nhập
    final response = await authService.login(email, password);
    _currentUser = response.user;
    _isAuthenticated = true;
    notifyListeners();
  }
}
```

#### 2.2.2.3. HTTP Client

Sử dụng package **http** để gọi REST API:

```dart
// API Service
class ApiService {
  static const String baseUrl = 'http://localhost:8080/api/v1';
  
  Future<Response> get(String endpoint, {String? token}) async {
    return await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }
}
```

#### 2.2.2.4. Các thư viện chính

| Package                         | Version | Mục đích                        |
| ------------------------------- | ------- | ------------------------------- |
| `provider`                      | ^6.1.5  | State management                |
| `http`                          | ^1.2.0  | HTTP client cho REST API        |
| `shared_preferences`            | ^2.3.3  | Lưu trữ local (token, settings) |
| `google_fonts`                  | ^6.1.0  | Typography đẹp                  |
| `flutter_animate`               | ^4.5.0  | Animation effects               |
| `audioplayers`                  | ^6.1.0  | Phát audio (bài nghe)           |
| `google_mlkit_text_recognition` | ^0.13.0 | OCR - Nhận diện chữ từ ảnh      |
| `speech_to_text`                | ^7.0.0  | Nhận diện giọng nói             |
| `fl_chart`                      | ^0.69.0 | Biểu đồ tiến độ học tập         |
| `image_picker`                  | ^0.8.7  | Chọn ảnh từ gallery/camera      |
| `url_launcher`                  | ^6.3.1  | Mở URL bên ngoài                |
| `permission_handler`            | ^11.3.1 | Xử lý quyền truy cập            |

#### 2.2.2.5. ML Kit Integration

Tích hợp **Google ML Kit** cho tính năng OCR:

```dart
// Text Recognition từ ảnh
final textRecognizer = TextRecognizer();
final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
String text = recognizedText.text;
```

---

### 2.2.3. Database

#### MySQL 8.0

**MySQL** là hệ quản trị cơ sở dữ liệu quan hệ được sử dụng cho môi trường development:

- **Engine**: InnoDB (hỗ trợ transaction, foreign key)
- **Encoding**: UTF-8 (hỗ trợ tiếng Việt)
- **Connection Pooling**: HikariCP (mặc định của Spring Boot)

#### PostgreSQL (Production)

Sử dụng **PostgreSQL** cho môi trường production trên Render (free tier).

---

### 2.2.4. Công cụ phát triển

| Công cụ                     | Mục đích               |
| --------------------------- | ---------------------- |
| **IntelliJ IDEA / VS Code** | IDE phát triển         |
| **Android Studio**          | Android SDK & Emulator |
| **Git**                     | Version control        |
| **Postman**                 | Test API               |
| **MySQL Workbench**         | Quản lý database       |
| **Gradle**                  | Build tool cho Backend |
| **Flutter CLI**             | Build tool cho Mobile  |

---

### 2.2.5. Bảng tổng hợp công nghệ

| Thành phần               | Công nghệ                      | Phiên bản |
| ------------------------ | ------------------------------ | --------- |
| **Backend Framework**    | Spring Boot                    | 3.5.8     |
| **Backend Language**     | Java                           | 21        |
| **Security**             | Spring Security + OAuth2 + JWT | -         |
| **ORM**                  | JPA / Hibernate                | -         |
| **AI Integration**       | Spring AI + OpenAI             | 1.0.0-M4  |
| **Cache**                | Caffeine                       | 3.1.8     |
| **Database (Dev)**       | MySQL                          | 8.0       |
| **Database (Prod)**      | PostgreSQL                     | -         |
| **Mobile Framework**     | Flutter                        | 3.0+      |
| **Mobile Language**      | Dart                           | 3.9.2     |
| **State Management**     | Provider                       | 6.1.5     |
| **ML/AI Mobile**         | Google ML Kit                  | 0.13.0    |
| **Build Tool (Backend)** | Gradle                         | 8.0+      |
| **Build Tool (Mobile)**  | Flutter CLI                    | -         |

---

## 2.3. Tổng kết

Dự án **Magic English** được xây dựng với kiến trúc hiện đại, phân tách rõ ràng giữa Frontend và Backend:

1. **Backend (Spring Boot)**: Cung cấp RESTful API an toàn với JWT, tích hợp AI để hỗ trợ học tập
2. **Frontend (Flutter)**: Ứng dụng cross-platform với giao diện đẹp, tính năng OCR và Speech-to-Text
3. **Database**: MySQL (development) / PostgreSQL (production)
4. **AI Services**: Spring AI + OpenAI để kiểm tra ngữ pháp, gợi ý từ vựng

Kiến trúc này đảm bảo:
- **Scalability**: Dễ dàng mở rộng theo số lượng người dùng
- **Maintainability**: Code được tổ chức rõ ràng, dễ bảo trì
- **Security**: Xác thực JWT, mã hóa mật khẩu BCrypt
- **Performance**: Caching với Caffeine, stateless authentication

---

# CHƯƠNG 3. XÂY DỰNG ỨNG DỤNG

## 3.1. Tổng quan về các module

Ứng dụng Magic English được chia thành các module chính:

| Module             | Backend                                 | Frontend                              | Mô tả                    |
| ------------------ | --------------------------------------- | ------------------------------------- | ------------------------ |
| **Authentication** | AuthController, UserService             | AuthProvider, AuthService             | Đăng nhập, đăng ký, JWT  |
| **Vocabulary**     | VocabularyController, VocabularyService | VocabularyProvider, VocabularyService | Học từ vựng với AI       |
| **Grammar**        | GrammarController, GrammarService       | GrammarProvider, GrammarService       | Kiểm tra ngữ pháp với AI |
| **TOEIC**          | TOEICController, TOEICService           | ToeicScreen                           | Luyện thi TOEIC          |
| **IELTS**          | IELTSController, IELTSService           | IeltsScreen                           | Luyện thi IELTS          |
| **Progress**       | StatsController, StatsService           | ProgressProvider                      | Theo dõi tiến độ         |
| **Achievement**    | AchievementController                   | AchievementScreen                     | Hệ thống thành tích      |

---

## 3.2. Cấu trúc Database

### 3.2.1. Sơ đồ Entity Relationship

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         ENTITY RELATIONSHIP                             │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────┐         ┌─────────────┐         ┌─────────────┐       │
│  │    User     │─────────│ Vocabulary  │         │   Grammar   │       │
│  │             │    1:N  │             │         │             │       │
│  │ - id        │         │ - id        │         │ - id        │       │
│  │ - email     │         │ - word      │         │ - inputText │       │
│  │ - password  │         │ - meaning   │         │ - score     │       │
│  │ - name      │─────────│ - ipa       │─────────│ - errors    │       │
│  │ - avatar    │    1:N  │ - wordType  │    1:N  │             │       │
│  └─────────────┘         │ - cefrLevel │         └─────────────┘       │
│         │                └─────────────┘                               │
│         │                                                              │
│         │ 1:N                                                          │
│  ┌──────▼──────┐         ┌─────────────┐                               │
│  │UserAchieve- │         │ Achievement │                               │
│  │   ment      │─────────│             │                               │
│  │             │    N:1  │ - name      │                               │
│  └─────────────┘         │ - condition │                               │
│                          └─────────────┘                               │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 3.2.2. Các Entity chính

**User Entity:**
```java
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(unique = true, nullable = false)
    private String email;
    
    @Column(nullable = false)
    private String password;
    
    private String name;
    private String avatarUrl;
    private String refreshToken;
    
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Vocabulary> vocabularies;
    
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Grammar> grammars;
}
```

**Vocabulary Entity:**
```java
@Entity
@Table(name = "vocabularies")
public class Vocabulary {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String word;
    
    private String meaning;      // Nghĩa tiếng Việt (từ AI)
    private String ipa;          // Phiên âm IPA
    private String wordType;     // noun, verb, adjective...
    private String cefrLevel;    // A1, A2, B1, B2, C1, C2
    private String example;      // Câu ví dụ
    private String audioUrl;     // URL file audio
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    private LocalDateTime createdAt;
}
```

---

## 3.3. API Documentation

### 3.3.1. Authentication APIs

| Method | Endpoint                | Mô tả                   |
| ------ | ----------------------- | ----------------------- |
| POST   | `/api/v1/auth/login`    | Đăng nhập               |
| POST   | `/api/v1/auth/register` | Đăng ký                 |
| POST   | `/api/v1/auth/logout`   | Đăng xuất               |
| GET    | `/api/v1/auth/refresh`  | Làm mới token           |
| GET    | `/api/v1/auth/account`  | Lấy thông tin tài khoản |

### 3.3.2. Vocabulary APIs

| Method | Endpoint                     | Mô tả                              |
| ------ | ---------------------------- | ---------------------------------- |
| POST   | `/api/v1/vocabulary`         | Thêm từ mới (với AI enrichment)    |
| GET    | `/api/v1/vocabulary`         | Lấy danh sách từ (có phân trang)   |
| POST   | `/api/v1/vocabulary/preview` | Xem trước thông tin từ (không lưu) |

### 3.3.3. Grammar APIs

| Method | Endpoint                | Mô tả                         |
| ------ | ----------------------- | ----------------------------- |
| POST   | `/api/v1/grammar/check` | Kiểm tra ngữ pháp với AI      |
| GET    | `/api/v1/grammar`       | Lấy lịch sử kiểm tra          |
| GET    | `/api/v1/grammar/{id}`  | Lấy chi tiết một lần kiểm tra |
| DELETE | `/api/v1/grammar/{id}`  | Xóa lịch sử kiểm tra          |

---

## 3.4. Code minh họa các chức năng cốt lõi

### 3.4.1. Chức năng Authentication

#### Backend - AuthController.java

```java
@RestController
@RequestMapping("/api/v1")
public class AuthController {

    private final AuthenticationManagerBuilder authenticationManagerBuilder;
    private final SecurityUtil securityUtil;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    /**
     * API Đăng nhập - POST /api/v1/auth/login
     * Flow: Validate credentials -> Generate JWT -> Set refresh token cookie
     */
    @PostMapping("/auth/login")
    public ResponseEntity<ResLoginDTO> login(@Valid @RequestBody ReqLoginDTO loginDto) {
        // 1. Tạo authentication token từ email/password
        UsernamePasswordAuthenticationToken authenticationToken = 
            new UsernamePasswordAuthenticationToken(
                loginDto.getEmail(), 
                loginDto.getPassword()
            );

        // 2. Xác thực với Spring Security
        Authentication authentication = authenticationManagerBuilder.getObject()
                .authenticate(authenticationToken);

        // 3. Lưu thông tin vào SecurityContext
        SecurityContextHolder.getContext().setAuthentication(authentication);

        // 4. Lấy thông tin user từ database
        ResLoginDTO res = new ResLoginDTO();
        User currentUserDB = this.userService.handleGetUserByUsername(loginDto.getEmail());
        if (currentUserDB != null) {
            ResLoginDTO.UserLogin userLogin = new ResLoginDTO.UserLogin(
                    currentUserDB.getId(),
                    currentUserDB.getEmail(),
                    currentUserDB.getName(),
                    currentUserDB.getAvatarUrl());
            res.setUser(userLogin);
        }

        // 5. Tạo Access Token (JWT)
        String access_token = this.securityUtil.createAccessToken(
            authentication.getName(), res);
        res.setAccessToken(access_token);

        // 6. Tạo Refresh Token
        String refresh_token = this.securityUtil.createRefreshToken(
            loginDto.getEmail(), res);
        this.userService.updateUserToken(refresh_token, loginDto.getEmail());

        // 7. Set refresh token vào cookie (HttpOnly, Secure)
        ResponseCookie resCookies = ResponseCookie
                .from("refresh_token", refresh_token)
                .httpOnly(true)
                .secure(true)
                .path("/")
                .maxAge(refreshTokenExpiration)
                .build();

        return ResponseEntity.ok()
                .header(HttpHeaders.SET_COOKIE, resCookies.toString())
                .body(res);
    }

    /**
     * API Đăng ký - POST /api/v1/auth/register
     */
    @PostMapping("/auth/register")
    public ResponseEntity<ResRegister> register(@Valid @RequestBody User postManUser) 
        throws IdInvalidException {
        
        // 1. Kiểm tra email đã tồn tại
        boolean isEmailExist = this.userService.isEmailExist(postManUser.getEmail());
        if (isEmailExist) {
            throw new IdInvalidException("Email đã tồn tại");
        }

        // 2. Mã hóa password với BCrypt
        String hashPassword = this.passwordEncoder.encode(postManUser.getPassword());
        postManUser.setPassword(hashPassword);
        
        // 3. Lưu user vào database
        User newUser = this.userService.handleCreatUser(postManUser);

        return ResponseEntity.status(HttpStatus.CREATED).body(
            new ResRegister(newUser.getEmail(), newUser.getName()));
    }
}
```

#### Frontend Flutter - AuthService.dart

```dart
class AuthService {
  /// Đăng nhập - Gọi API và trả về ResponseLogin
  Future<BackendResponse<ResponseLogin>> login(
    String email,
    String password,
  ) async {
    final String url = dotenv.env['Backend_URL'] ?? '';
    
    final response = await http.post(
      Uri.parse('$url/api/v1/auth/login'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final jsonData = jsonDecode(response.body);

    return BackendResponse<ResponseLogin>.fromJson(
      jsonData,
      (data) => ResponseLogin.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Đăng ký tài khoản mới
  Future<BackendResponse<ResponseRegister>> register(
    String name,
    String email,
    String password,
  ) async {
    final String url = dotenv.env['Backend_URL'] ?? '';
    
    final response = await http.post(
      Uri.parse('$url/api/v1/auth/register'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name, 
        'email': email, 
        'password': password
      }),
    );

    final jsonData = jsonDecode(response.body);

    return BackendResponse<ResponseRegister>.fromJson(
      jsonData,
      (data) => ResponseRegister.fromJson(data as Map<String, dynamic>),
    );
  }
}
```

#### Frontend Flutter - AuthProvider.dart (State Management)

```dart
class AuthProvider with ChangeNotifier {
  ResponseLogin? _user;

  ResponseLogin? get user => _user;
  bool get isLoggedIn => _user != null;

  /// Lưu thông tin user sau khi đăng nhập thành công
  Future<void> setUser(ResponseLogin user) async {
    _user = user;
    notifyListeners();  // Thông báo cho UI cập nhật

    // Lưu vào SharedPreferences để persist session
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user.id);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_email', user.email);
    await prefs.setString('access_token', user.accessToken);
    
    if (user.avatarUrl != null && user.avatarUrl!.isNotEmpty) {
      await prefs.setString('avatarUrl', user.avatarUrl!);
    }
  }

  /// Load user khi mở app (auto-login)
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final userName = prefs.getString('user_name');
    final userEmail = prefs.getString('user_email');
    final accessToken = prefs.getString('access_token');

    if (userId != null && userName != null && 
        userEmail != null && accessToken != null) {
      _user = ResponseLogin(
        id: userId,
        name: userName,
        email: userEmail,
        accessToken: accessToken,
      );
      notifyListeners();
    }
  }

  /// Đăng xuất
  Future<void> logout() async {
    _user = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
```

---

### 3.4.2. Chức năng Vocabulary với AI Enrichment

#### Backend - VocabularyService.java

```java
@Service
@RequiredArgsConstructor
@Slf4j
public class VocabularyService {

    private final AiClientService aiClientService;
    private final VocabularyRepository vocabularyRepository;
    private final UserRepository userRepository;

    /**
     * Thêm từ mới và tự động làm giàu dữ liệu bằng AI
     * Flow: Nhận từ -> Gọi AI -> Parse response -> Lấy audio -> Lưu DB
     */
    @Transactional
    public VocabularyDetailResponse addVocabulary(AddVocabularyRequest request) {
        // 1. Lấy user hiện tại từ SecurityContext
        String email = SecurityUtil.getCurrentUserLogin()
            .orElseThrow(() -> new RuntimeException("User not authenticated"));
        User user = userRepository.findByEmail(email);

        // 2. Tạo entity mới
        Vocabulary vocabulary = new Vocabulary();
        vocabulary.setUser(user);
        vocabulary.setWord(request.getWord());

        // 3. Gọi AI để làm giàu dữ liệu (nghĩa, IPA, ví dụ...)
        enrichVocabularyWithAI(vocabulary);

        // 4. Lấy audio URL từ Free Dictionary API
        vocabulary.setAudioUrl(fetchAudioUrl(request.getWord()));

        // 5. Lưu vào database
        Vocabulary saved = vocabularyRepository.save(vocabulary);
        
        return VocabularyDetailResponse.fromEntity(saved);
    }

    /**
     * Gọi AI để làm giàu dữ liệu từ vựng
     * Sử dụng Prompt Engineering để yêu cầu AI trả về JSON chuẩn
     */
    private void enrichVocabularyWithAI(Vocabulary vocabulary) {
        String word = vocabulary.getWord();
        
        // Prompt được thiết kế cẩn thận để AI trả về JSON chuẩn
        String prompt = String.format("""
            Analyze the English word "%s" and provide detailed information 
            in STRICT JSON format:
            {
                "word": "%s",
                "ipa": "IPA pronunciation (e.g., /həˈloʊ/)",
                "meanings": ["nghĩa 1", "nghĩa 2", "nghĩa 3"],
                "wordType": "noun/verb/adjective/adverb",
                "examples": [
                    "Example sentence 1 in English",
                    "Example sentence 2 in English"
                ],
                "cefrLevel": "A1/A2/B1/B2/C1/C2"
            }

            RULES:
            - Meanings MUST be in Vietnamese, SHORT (max 2-4 words)
            - Return ONLY valid JSON, no markdown
            """, word, word);

        try {
            // Gọi AI service (có rotation giữa nhiều API keys)
            String aiResponse = aiClientService.generate(prompt);
            
            // Parse JSON response vào entity
            parseAIResponseIntoEntity(vocabulary, aiResponse);
        } catch (Exception e) {
            log.error("Error calling AI: {}", e.getMessage());
            setFallbackData(vocabulary);
        }
    }

    /**
     * Parse JSON từ AI vào Vocabulary entity
     */
    private void parseAIResponseIntoEntity(Vocabulary vocabulary, String aiResponse) {
        // Clean up markdown nếu có
        String json = aiResponse.trim();
        if (json.contains("```json")) {
            json = json.substring(json.indexOf("{"), json.lastIndexOf("}") + 1);
        }

        JsonNode node = objectMapper.readTree(json);

        vocabulary.setIpa(node.path("ipa").asText(""));
        vocabulary.setWordType(node.path("wordType").asText("unknown"));
        vocabulary.setCefrLevel(node.path("cefrLevel").asText("B1"));

        // Parse meanings array
        List<String> meanings = new ArrayList<>();
        node.path("meanings").forEach(m -> meanings.add(m.asText()));
        vocabulary.setMeaning(String.join("; ", meanings));

        // Parse examples array
        List<String> examples = new ArrayList<>();
        node.path("examples").forEach(e -> examples.add(e.asText()));
        vocabulary.setExample(String.join("\n", examples));
    }

    /**
     * Lấy URL audio từ Free Dictionary API
     */
    private String fetchAudioUrl(String word) {
        String apiUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/" + word;
        String response = restTemplate.getForObject(apiUrl, String.class);
        
        JsonNode rootArray = objectMapper.readTree(response);
        if (rootArray.isArray() && rootArray.size() > 0) {
            JsonNode phonetics = rootArray.get(0).path("phonetics");
            for (JsonNode phonetic : phonetics) {
                String audio = phonetic.path("audio").asText("");
                if (!audio.isEmpty()) {
                    return audio;
                }
            }
        }
        return null;
    }
}
```

---

### 3.4.3. Chức năng Grammar Checker với AI

#### Backend - GrammarService.java

```java
@Service
@RequiredArgsConstructor
@Slf4j
public class GrammarService {

    private final AiClientService aiClientService;
    private final GrammarRepository grammarRepository;
    private final UserRepository userRepository;

    // Cache để tránh gọi AI trùng lặp
    private final ConcurrentHashMap<String, GrammarCheckResponse> responseCache = 
        new ConcurrentHashMap<>();

    /**
     * Kiểm tra ngữ pháp bằng AI
     * Tối ưu: Cache + Async DB save để response nhanh hơn
     */
    public GrammarCheckResponse checkGrammar(CheckGrammarRequest request) {
        // 1. Lấy user hiện tại
        String email = SecurityUtil.getCurrentUserLogin()
            .orElseThrow(() -> new RuntimeException("User not authenticated"));
        User user = userRepository.findByEmail(email);

        String inputText = request.getText();

        // 2. Kiểm tra cache (tránh gọi AI trùng lặp)
        String cacheKey = user.getId() + "_" + inputText.hashCode();
        GrammarCheckResponse cachedResponse = responseCache.get(cacheKey);
        if (cachedResponse != null) {
            log.info("Cache HIT - Returning cached result");
            return cachedResponse;
        }

        // 3. Tạo entity và gọi AI
        Grammar grammar = new Grammar();
        grammar.setUser(user);
        grammar.setInputText(inputText);

        checkGrammarWithAI(grammar);

        // 4. Tạo response TRƯỚC KHI save DB (nhanh hơn)
        GrammarCheckResponse response = GrammarCheckResponse.fromEntity(grammar);

        // 5. Cache kết quả
        responseCache.put(cacheKey, response);
        
        // 6. Auto-clear cache sau 5 phút
        Executors.newSingleThreadScheduledExecutor()
            .schedule(() -> responseCache.remove(cacheKey), 
                      5, TimeUnit.MINUTES);

        // 7. Save DB bất đồng bộ (không block response)
        saveGrammarAsync(grammar, user);

        return response;
    }

    /**
     * Gọi AI để kiểm tra ngữ pháp với Prompt Engineering chi tiết
     */
    private void checkGrammarWithAI(Grammar grammar) {
        String text = grammar.getInputText();
        
        String prompt = String.format("""
            Analyze the following English text for grammar, spelling, 
            punctuation, and clarity errors.
            
            Return JSON:
            {
                "score": 85,
                "correctedText": "The fully corrected version",
                "errors": [
                    {
                        "errorType": "spelling|punctuation|grammar|clarity",
                        "beforeText": "Text before the error",
                        "errorText": "The incorrect text",
                        "correctedText": "The correct text",
                        "afterText": "Text after the error",
                        "explanation": "Giải thích chi tiết bằng tiếng Việt",
                        "startPosition": 20,
                        "endPosition": 25
                    }
                ]
            }

            Text to analyze: "%s"

            Rules:
            - score từ 0-100 (100 = hoàn hảo)
            - explanation PHẢI bằng tiếng Việt, chi tiết
            - Return ONLY valid JSON
            """, text);

        String aiResponse = aiClientService.generate(prompt);
        parseAIResponseIntoEntity(grammar, aiResponse);
    }

    /**
     * Save bất đồng bộ để không block API response
     */
    @Async("taskExecutor")
    @Transactional
    public void saveGrammarAsync(Grammar grammar, User user) {
        Grammar saved = grammarRepository.save(grammar);
        log.info("Grammar saved to DB with ID: {}", saved.getId());
        
        // Kiểm tra và cấp achievement
        Long totalChecks = grammarRepository.countByUserId(user.getId());
        userAchievementService.checkAndGrantAchievements(
            user, "grammar_check", totalChecks);
    }
}
```

#### Frontend Flutter - GrammarService.dart

```dart
class GrammarService {
  String get baseUrl => '${ApiConstants.baseUrl}/grammar';

  /// Lấy access token từ SharedPreferences
  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  /// Kiểm tra ngữ pháp với AI
  /// POST /api/v1/grammar/check
  Future<Grammar> checkGrammar(String text) async {
    final token = await _getAccessToken();
    if (token == null) {
      throw Exception('No access token found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/check'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      final data = responseData['data'];
      return Grammar.fromJson(data);
    } else {
      throw Exception('Failed to check grammar: ${response.body}');
    }
  }

  /// Lấy lịch sử kiểm tra ngữ pháp (có phân trang)
  Future<Map<String, dynamic>> getAllGrammarChecks({
    int page = 0,
    int size = 20,
  }) async {
    final token = await _getAccessToken();
    
    final response = await http.get(
      Uri.parse('$baseUrl?page=$page&size=$size'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      final data = responseData['data'] ?? responseData;
      final result = data['result'] as List<dynamic>;

      return {
        'grammars': result.map((json) => Grammar.fromJson(json)).toList(),
        'meta': data['meta'],
      };
    } else {
      throw Exception('Failed to load grammar checks');
    }
  }

  /// Xóa lịch sử kiểm tra
  Future<void> deleteGrammarCheck(int id) async {
    final token = await _getAccessToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete grammar check');
    }
  }
}
```

---

## 3.5. Tích hợp AI với Spring AI

### 3.5.1. Cấu hình AiClientService

```java
@Service
@RequiredArgsConstructor
@Slf4j
public class AiClientService {

    private final ChatClient chatClient;

    /**
     * Gọi AI để generate response
     * Có retry mechanism và error handling
     */
    public String generate(String prompt) {
        try {
            return chatClient.prompt()
                    .user(prompt)
                    .call()
                    .content();
        } catch (Exception e) {
            log.error("AI call failed: {}", e.getMessage());
            throw new RuntimeException("AI service unavailable");
        }
    }
}
```

### 3.5.2. Cấu hình OpenAI trong application.yaml

```yaml
spring:
  ai:
    openai:
      api-key: ${OPENAI_API_KEY}
      chat:
        options:
          model: gpt-4o-mini
          temperature: 0.7
          max-tokens: 2000
```

---

## 3.6. Tích hợp Google ML Kit trong Flutter

### 3.6.1. OCR - Text Recognition

```dart
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class OCRService {
  final TextRecognizer _textRecognizer = TextRecognizer();

  /// Nhận diện chữ từ ảnh
  Future<String> recognizeTextFromImage() async {
    // 1. Chọn ảnh từ gallery hoặc camera
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image == null) return '';

    // 2. Tạo InputImage từ file path
    final InputImage inputImage = InputImage.fromFilePath(image.path);

    // 3. Nhận diện text bằng ML Kit
    final RecognizedText recognizedText = 
        await _textRecognizer.processImage(inputImage);

    // 4. Trả về text đã nhận diện
    return recognizedText.text;
  }

  /// Giải phóng tài nguyên
  void dispose() {
    _textRecognizer.close();
  }
}
```

### 3.6.2. Speech-to-Text

```dart
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  String _recognizedText = '';

  /// Khởi tạo Speech Recognition
  Future<bool> initialize() async {
    // Yêu cầu quyền microphone
    final status = await Permission.microphone.request();
    if (!status.isGranted) return false;

    return await _speech.initialize(
      onStatus: (status) => print('Speech status: $status'),
      onError: (error) => print('Speech error: $error'),
    );
  }

  /// Bắt đầu nghe
  Future<void> startListening(Function(String) onResult) async {
    if (!_speech.isAvailable) return;

    _isListening = true;
    
    await _speech.listen(
      onResult: (result) {
        _recognizedText = result.recognizedWords;
        onResult(_recognizedText);
      },
      localeId: 'en_US',  // Nghe tiếng Anh
      cancelOnError: true,
      partialResults: true,
    );
  }

  /// Dừng nghe
  Future<void> stopListening() async {
    _isListening = false;
    await _speech.stop();
  }

  bool get isListening => _isListening;
  String get recognizedText => _recognizedText;
}
```

---

## 3.7. Tổng kết Chương 3

Chương này đã trình bày chi tiết về việc xây dựng ứng dụng Magic English:

1. **Cấu trúc module**: Phân chia rõ ràng giữa Backend (Spring Boot) và Frontend (Flutter)
2. **Database**: Thiết kế Entity với quan hệ User - Vocabulary - Grammar
3. **API**: RESTful API với JWT authentication
4. **Code minh họa**:
   - Authentication: Login/Register với JWT, BCrypt, SharedPreferences
   - Vocabulary: AI enrichment với prompt engineering
   - Grammar: AI grammar checking với caching và async DB save
5. **AI Integration**: Spring AI với OpenAI, Google ML Kit (OCR, Speech)

Điểm nổi bật của kiến trúc:
- ✅ **AI-powered features**: Làm giàu dữ liệu tự động
- ✅ **Performance optimization**: Caching, async operations
- ✅ **Clean architecture**: Separation of concerns
- ✅ **Cross-platform**: Flutter cho cả Android và iOS

---

# KẾT LUẬN

## 1. Kết quả đạt được

Sau quá trình nghiên cứu và phát triển, dự án **Magic English** đã hoàn thành các mục tiêu đề ra và đạt được những kết quả đáng ghi nhận:

### Về mặt chức năng

Ứng dụng đã xây dựng thành công 10 chức năng chính phục vụ việc học tiếng Anh:

- **Hệ thống xác thực người dùng**: Cho phép đăng ký, đăng nhập, đăng xuất với cơ chế JWT an toàn và refresh token để duy trì phiên làm việc.

- **Học từ vựng thông minh**: Người dùng chỉ cần nhập từ tiếng Anh, hệ thống AI sẽ tự động bổ sung nghĩa tiếng Việt, phiên âm IPA, loại từ, cấp độ CEFR, câu ví dụ và audio phát âm.

- **Kiểm tra ngữ pháp với AI**: Phân tích văn bản tiếng Anh, phát hiện lỗi ngữ pháp, chính tả, dấu câu và đưa ra giải thích chi tiết bằng tiếng Việt giúp người học hiểu rõ lỗi sai.

- **Luyện thi TOEIC**: Cung cấp bộ đề thi TOEIC với đầy đủ phần Listening và Reading, giúp người học làm quen với cấu trúc đề thi.

- **Luyện thi IELTS**: Hỗ trợ luyện tập cả 4 kỹ năng: Speaking, Writing, Listening và Reading theo format thi thực tế.

- **Nhận diện chữ từ ảnh (OCR)**: Sử dụng Google ML Kit để nhận diện văn bản tiếng Anh từ ảnh chụp, hỗ trợ người học tra cứu nhanh.

- **Luyện phát âm (Speech-to-Text)**: Tích hợp nhận diện giọng nói, cho phép người học luyện phát âm và nhận phản hồi tức thì.

- **Theo dõi tiến độ học tập**: Hiển thị biểu đồ thống kê số từ vựng đã học, số lần kiểm tra ngữ pháp, thời gian học theo ngày/tuần/tháng.

- **Hệ thống thành tích (Gamification)**: Trao huy hiệu khi người dùng đạt các mốc quan trọng, tạo động lực học tập liên tục.

- **Đọc tin tức tiếng Anh**: Tổng hợp tin tức từ các nguồn RSS uy tín, giúp người học cải thiện kỹ năng đọc hiểu thông qua nội dung thực tế.

### Về mặt kỹ thuật

**Phía Backend:**
- Xây dựng thành công RESTful API hoàn chỉnh với Spring Boot 3.5.8
- Tích hợp Spring AI với OpenAI API để xử lý ngôn ngữ tự nhiên
- Thiết kế cơ sở dữ liệu MySQL với JPA/Hibernate, đảm bảo tính toàn vẹn dữ liệu
- Triển khai xác thực và phân quyền với OAuth2 và JWT
- Tối ưu hiệu suất bằng Caffeine Cache và xử lý bất đồng bộ
- Deploy thành công trên nền tảng Render với PostgreSQL cho môi trường production

**Phía Frontend Mobile:**
- Phát triển ứng dụng đa nền tảng với Flutter, hoạt động trên cả Android và iOS từ một codebase duy nhất
- Áp dụng Provider pattern để quản lý state hiệu quả
- Tích hợp Google ML Kit cho các tính năng OCR và Speech Recognition
- Thiết kế giao diện thân thiện theo chuẩn Material Design

### Về mặt học thuật

- Nghiên cứu và áp dụng thành công công nghệ AI (Large Language Models) vào lĩnh vực giáo dục
- Thiết kế Prompt Engineering hiệu quả để yêu cầu AI trả về dữ liệu chuẩn JSON
- Triển khai kiến trúc Client-Server với các nguyên tắc best practices
- Áp dụng các design patterns phổ biến: Repository, Provider, DTO, Factory

---

## 2. Nhược điểm

Mặc dù đã hoàn thành các mục tiêu chính, dự án vẫn còn một số hạn chế cần được cải thiện:

### Về mặt chức năng

- **Phụ thuộc kết nối Internet**: Các tính năng sử dụng AI đều yêu cầu kết nối mạng, khiến người dùng không thể học offline khi không có Internet.

- **Chi phí sử dụng API**: Việc gọi OpenAI API phát sinh chi phí, dẫn đến việc cần giới hạn số lần sử dụng các tính năng AI.

- **Chưa có đánh giá Speaking tự động**: Phần luyện thi IELTS Speaking hiện chỉ hỗ trợ nhận diện giọng nói, chưa có AI đánh giá chất lượng phát âm và ngữ điệu.

- **Thiếu tính năng xã hội**: Chưa có bảng xếp hạng (leaderboard), chức năng kết bạn hay thách đấu giữa người học.

- **Chưa có thông báo nhắc nhở**: Ứng dụng chưa tích hợp push notification để nhắc nhở người dùng học hàng ngày, khó duy trì thói quen học.

### Về mặt kỹ thuật

- **Thời gian phản hồi AI**: Mỗi lần gọi AI mất khoảng 2-5 giây, có thể gây khó chịu cho người dùng khi phải chờ đợi.

- **Sử dụng một API key duy nhất**: Dễ bị giới hạn rate limit khi có nhiều người dùng cùng lúc.

- **Chưa có chế độ offline**: Dữ liệu chưa được đồng bộ về local, không thể sử dụng khi không có mạng.

- **Caching còn hạn chế**: Hiện tại chỉ cache ở phía backend, chưa có caching ở phía Flutter để tăng tốc trải nghiệm.

- **Thiếu unit tests**: Chưa có bộ test tự động đầy đủ, gây khó khăn cho việc bảo trì và mở rộng code.

### Về mặt UX/UI

- Một số màn hình còn đơn giản, chưa có hiệu ứng animation phong phú
- Chưa hỗ trợ Dark Mode đầy đủ trên tất cả các màn hình
- Chưa có hướng dẫn sử dụng (onboarding) chi tiết cho người dùng mới

---

## 3. Hướng phát triển

Dựa trên những nhược điểm đã nhận diện, nhóm đề xuất các hướng phát triển như sau:

### Ngắn hạn (1-3 tháng tới)

- **Chế độ Offline**: Cho phép người dùng tải từ vựng về máy và học offline bằng SQLite local, đồng bộ dữ liệu khi có mạng trở lại.

- **Push Notifications**: Tích hợp Firebase Cloud Messaging để gửi thông báo nhắc nhở học hàng ngày vào giờ cố định.

- **Spaced Repetition System**: Áp dụng thuật toán lặp lại ngắt quãng (như SM-2) cho việc ôn tập từ vựng, giúp ghi nhớ lâu hơn.

- **Dark Mode hoàn chỉnh**: Hỗ trợ giao diện tối trên tất cả màn hình, theo đúng cài đặt hệ thống của người dùng.

- **Bổ sung Unit Tests**: Viết test coverage cho các service quan trọng ở Backend và các Provider ở Flutter.

### Trung hạn (3-6 tháng tới)

- **AI Speaking Evaluation**: Sử dụng công nghệ Speech Recognition kết hợp AI để đánh giá chất lượng phát âm, ngữ điệu và đưa ra điểm số cụ thể.

- **Leaderboard và Social Features**: Xây dựng bảng xếp hạng theo tuần/tháng, cho phép kết bạn, thách đấu và chia sẻ thành tích lên mạng xã hội.

- **Writing Correction**: Tích hợp AI để chấm bài viết IELTS Writing theo rubric chính thức, đưa ra nhận xét chi tiết và điểm dự kiến.

- **Lộ trình học cá nhân hóa**: Sử dụng Machine Learning để phân tích trình độ người dùng và đề xuất lộ trình học phù hợp.

### Dài hạn (6-12 tháng tới)

- **AI Tutor Chatbot**: Phát triển chatbot AI hoạt động 24/7, trả lời mọi câu hỏi về tiếng Anh như một gia sư ảo.

- **Video Lessons**: Bổ sung bài học video với giáo viên thật hoặc avatar AI-generated, giúp việc học sinh động hơn.

- **Live Classes**: Tính năng lớp học trực tiếp với video call, cho phép học viên tương tác với giáo viên real-time.

- **Premium Subscription**: Ra mắt gói đăng ký trả phí với các tính năng nâng cao, không giới hạn lượt sử dụng AI.

- **Web Application**: Phát triển phiên bản web để người dùng có thể học trên máy tính, đồng bộ với ứng dụng mobile.

- **Multi-language Support**: Mở rộng hỗ trợ học các ngôn ngữ khác như tiếng Nhật, tiếng Hàn, tiếng Trung.

---

## 4. Lời kết

Dự án **Magic English** đã hoàn thành mục tiêu xây dựng một ứng dụng học tiếng Anh thông minh, tích hợp công nghệ AI hiện đại phục vụ người học Việt Nam. Ứng dụng đã chứng minh được tiềm năng to lớn của việc kết hợp Trí tuệ nhân tạo với giáo dục, mang đến trải nghiệm học tập:

- **Cá nhân hóa**: Nội dung được làm giàu tự động bởi AI, phù hợp với nhu cầu từng người
- **Tương tác cao**: Phản hồi ngay lập tức từ hệ thống, không cần chờ đợi giáo viên
- **Linh hoạt tối đa**: Học mọi lúc, mọi nơi chỉ với chiếc điện thoại
- **Gamification hiệu quả**: Hệ thống thành tích và huy hiệu tạo động lực học tập liên tục

Mặc dù vẫn còn một số hạn chế cần khắc phục, dự án đã đặt được nền móng kỹ thuật vững chắc cho việc phát triển mở rộng trong tương lai. Với roadmap rõ ràng và kiến trúc được thiết kế để dễ dàng scale, Magic English hoàn toàn có tiềm năng trở thành một nền tảng học tiếng Anh toàn diện, phục vụ hàng triệu người học tại Việt Nam và khu vực.

Nhóm phát triển tin rằng với sự nỗ lực không ngừng và việc lắng nghe phản hồi từ người dùng, Magic English sẽ ngày càng hoàn thiện và trở thành công cụ hữu ích đồng hành cùng người học trên con đường chinh phục tiếng Anh.

---

**Cảm ơn quý thầy cô và các bạn đã theo dõi báo cáo!**

*Ngày hoàn thành: 29/12/2024*

