# MAGIC ENGLISH - API DOCUMENTATION

**Version:** 1.0.0  
**Framework:** Spring Boot 3.5.8  
**Java:** 21

**RESTful API Documentation cho Ứng Dụng Học Tiếng Anh Thông Minh**

---

## MỤC LỤC

| STT | Nội dung             | Trang |
| :-: | -------------------- | :---: |
|  1  | Tổng Quan            |   2   |
|  2  | Thông Tin Kết Nối    |   2   |
|  3  | Authentication API   |   3   |
|  4  | User Management API  |   5   |
|  5  | Vocabulary API       |   6   |
|  6  | Grammar API          |   8   |
|  7  | IELTS Test API       |  10   |
|  8  | TOEIC Test API       |  13   |
|  9  | Achievement API      |  16   |
| 10  | Statistics API       |  18   |
| 11  | File Management API  |  21   |
| 12  | Pronunciation API    |  22   |
| 13  | Audio/TTS API        |  23   |
| 14  | Mã Lỗi (Error Codes) |  24   |

---

## 1. TỔNG QUAN

### Mô tả

Magic English API là một RESTful API được xây dựng trên nền tảng **Spring Boot 3.5.8**, cung cấp các dịch vụ backend cho ứng dụng học tiếng Anh thông minh tích hợp **AI**.

### Công nghệ sử dụng

| Công nghệ       | Phiên bản | Mô tả              |
| --------------- | --------- | ------------------ |
| Spring Boot     | 3.5.8     | Framework chính    |
| Spring Security | 6.x       | Bảo mật & JWT      |
| Spring AI       | 1.x       | Tích hợp AI/OpenAI |
| MySQL           | 8.0       | Database           |
| JPA/Hibernate   | -         | ORM                |

### Định dạng Response tiêu chuẩn

> **⚠️ Lưu ý quan trọng:** Tất cả API response đều được bọc tự động bởi `FormatRestResponse` (ResponseBodyAdvice)

**Response Structure (RestResponse\<T\>):**

```json
{
    "statusCode": 200,
    "error": null,
    "message": "CALL API SUCCESS",
    "data": { ... }
}
```

| Field        | Type         | Mô tả                                                     |
| ------------ | ------------ | --------------------------------------------------------- |
| `statusCode` | Integer      | HTTP status code (200, 201, 400, 401, ...)                |
| `error`      | String       | Thông báo lỗi (null nếu thành công)                       |
| `message`    | String/Array | Message từ @ApiMessage annotation hoặc "CALL API SUCCESS" |
| `data`       | Object/Array | Dữ liệu response thực tế                                  |

**Ví dụ Response thành công:**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "fetch account",
  "data": {
    "user": {
      "id": 1,
      "email": "user@example.com",
      "name": "Nguyen Van A"
    }
  }
}
```

**Ngoại lệ không bọc response:**

- Response dạng `String` hoặc `Resource` (file download)
- Swagger/OpenAPI endpoints (`/v3/api-docs`, `/swagger-ui`)
- Response có status >= 400 (errors trả về trực tiếp)

---

## 2. THÔNG TIN KẾT NỐI

| Thuộc tính         | Giá trị                        |
| ------------------ | ------------------------------ |
| **Base URL**       | `http://localhost:8080/api/v1` |
| **Content-Type**   | `application/json`             |
| **Authentication** | Bearer Token (JWT)             |

### Headers bắt buộc cho các API yêu cầu xác thực:

```http
Authorization: Bearer <access_token>
Content-Type: application/json
```

---

## 3. AUTHENTICATION API

Các API liên quan đến xác thực và quản lý phiên đăng nhập.

### 1.1 Đăng nhập (Login)

| Thuộc tính      | Giá trị                             |
| --------------- | ----------------------------------- |
| **Endpoint**    | `POST /api/v1/auth/login`           |
| **Auth**        | ❌ Không yêu cầu                    |
| **Description** | Xác thực người dùng và trả về token |

**Request Body:**

```json
{
  "Email": "user@example.com",
  "password": "password123"
}
```

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": 1,
      "email": "user@example.com",
      "name": "Nguyen Van A",
      "avatarUrl": "https://example.com/avatar.jpg"
    }
  }
}
```

---

### 1.2 Đăng ký (Register)

| Thuộc tính      | Giá trị                      |
| --------------- | ---------------------------- |
| **Endpoint**    | `POST /api/v1/auth/register` |
| **Auth**        | ❌ Không yêu cầu             |
| **Description** | Tạo tài khoản người dùng mới |

**Request Body:**

```json
{
  "name": "Nguyen Van A",
  "email": "user@example.com",
  "password": "password123"
}
```

**Response (201 Created):**

```json
{
  "statusCode": 201,
  "error": null,
  "message": "Register a new user",
  "data": {
    "email": "user@example.com",
    "name": "Nguyen Van A"
  }
}
```

---

### 1.3 Lấy thông tin tài khoản

| Thuộc tính      | Giá trị                                |
| --------------- | -------------------------------------- |
| **Endpoint**    | `GET /api/v1/auth/account`             |
| **Auth**        | ✅ Yêu cầu Bearer Token                |
| **Description** | Lấy thông tin tài khoản đang đăng nhập |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "fetch account",
  "data": {
    "user": {
      "id": 1,
      "email": "user@example.com",
      "name": "Nguyen Van A"
    }
  }
}
```

---

### 1.4 Làm mới Token

| Thuộc tính      | Giá trị                               |
| --------------- | ------------------------------------- |
| **Endpoint**    | `GET /api/v1/auth/refresh`            |
| **Auth**        | ✅ Yêu cầu Refresh Token trong Cookie |
| **Description** | Tạo access token mới từ refresh token |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "Get User by refresh token",
  "data": {
    "access_token": "new_access_token...",
    "refresh_token": "new_refresh_token...",
    "user": {
      "id": 1,
      "email": "user@example.com",
      "name": "Nguyen Van A"
    }
  }
}
```

---

### 1.5 Đăng xuất (Logout)

| Thuộc tính      | Giá trị                        |
| --------------- | ------------------------------ |
| **Endpoint**    | `POST /api/v1/auth/logout`     |
| **Auth**        | ✅ Yêu cầu Bearer Token        |
| **Description** | Đăng xuất và xóa refresh token |

**Response (200 OK):** Empty body

---

## 4. USER MANAGEMENT API

Quản lý thông tin người dùng.

### 2.1 Tạo người dùng mới

| Thuộc tính      | Giá trị                    |
| --------------- | -------------------------- |
| **Endpoint**    | `POST /api/v1/users`       |
| **Auth**        | ✅ Yêu cầu Bearer Token    |
| **Description** | Tạo người dùng mới (Admin) |

**Request Body:**

```json
{
  "name": "Nguyen Van A",
  "email": "user@example.com",
  "password": "password123"
}
```

---

### 2.2 Lấy thông tin người dùng theo ID

| Thuộc tính      | Giá trị                     |
| --------------- | --------------------------- |
| **Endpoint**    | `GET /api/v1/users/{id}`    |
| **Auth**        | ✅ Yêu cầu Bearer Token     |
| **Description** | Lấy chi tiết thông tin user |

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| id | Long | ✅ | ID của user |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "fetch user by id",
  "data": {
    "id": 1,
    "name": "Nguyen Van A",
    "email": "user@example.com",
    "avatarUrl": "https://example.com/avatar.jpg",
    "createdAt": "2024-01-01T00:00:00Z",
    "updatedAt": "2024-01-02T00:00:00Z"
  }
}
```

---

### 2.3 Cập nhật người dùng

| Thuộc tính      | Giá trị                 |
| --------------- | ----------------------- |
| **Endpoint**    | `PUT /api/v1/users`     |
| **Auth**        | ✅ Yêu cầu Bearer Token |
| **Description** | Cập nhật thông tin user |

**Request Body:**

```json
{
  "id": 1,
  "name": "Nguyen Van B",
  "avatarUrl": "https://example.com/new-avatar.jpg"
}
```

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "Update a user",
  "data": {
    "id": 1,
    "name": "Nguyen Van B",
    "email": "user@example.com",
    "avatarUrl": "https://example.com/new-avatar.jpg"
  }
}
```

---

### 2.4 Xóa người dùng

| Thuộc tính      | Giá trị                     |
| --------------- | --------------------------- |
| **Endpoint**    | `DELETE /api/v1/users/{id}` |
| **Auth**        | ✅ Yêu cầu Bearer Token     |
| **Description** | Xóa user theo ID            |

**Response (200 OK):** Empty body

---

## 5. VOCABULARY API

Quản lý từ vựng với tính năng AI enrichment.

### 3.1 Thêm từ vựng mới

| Thuộc tính      | Giá trị                                       |
| --------------- | --------------------------------------------- |
| **Endpoint**    | `POST /api/v1/vocabulary`                     |
| **Auth**        | ✅ Yêu cầu Bearer Token                       |
| **Description** | Thêm từ mới, tự động làm giàu dữ liệu bằng AI |

**Request Body:**

```json
{
  "word": "achievement"
}
```

**Response (201 Created):**

```json
{
  "statusCode": 201,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": {
    "id": 1,
    "word": "achievement",
    "ipa": "/əˈtʃiːvmənt/",
    "audioUrl": "https://api.voicerss.org/...",
    "meaning": "Thành tựu, thành tích",
    "wordType": "noun",
    "examples": [
      "His greatest achievement was winning the gold medal.",
      "The bridge is a remarkable feat of engineering achievement."
    ],
    "cefrLevel": "B1",
    "createdAt": "2024-01-01T00:00:00Z",
    "updatedAt": "2024-01-01T00:00:00Z"
  }
}
```

---

### 3.2 Lấy danh sách từ vựng

| Thuộc tính      | Giá trị                                          |
| --------------- | ------------------------------------------------ |
| **Endpoint**    | `GET /api/v1/vocabulary`                         |
| **Auth**        | ✅ Yêu cầu Bearer Token                          |
| **Description** | Lấy danh sách từ vựng với phân trang và tìm kiếm |

**Query Parameters:**
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| search | String | ❌ | - | Từ khóa tìm kiếm |
| page | Integer | ❌ | 0 | Số trang (bắt đầu từ 0) |
| size | Integer | ❌ | 10 | Số phần tử mỗi trang |

**Example:** `GET /api/v1/vocabulary?search=achieve&page=0&size=10`

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": {
    "meta": {
      "page": 0,
      "pageSize": 10,
      "pages": 5,
      "total": 48
    },
    "result": [
      {
        "id": 1,
        "word": "achievement",
        "ipa": "/əˈtʃiːvmənt/",
        "meaning": "Thành tựu, thành tích",
        "wordType": "noun",
        "cefrLevel": "B1"
      }
    ]
  }
}
```

---

### 3.3 Xem trước từ vựng (Preview)

| Thuộc tính      | Giá trị                                               |
| --------------- | ----------------------------------------------------- |
| **Endpoint**    | `POST /api/v1/vocabulary/preview`                     |
| **Auth**        | ✅ Yêu cầu Bearer Token                               |
| **Description** | Xem trước thông tin từ vựng mà không lưu vào database |

**Request Body:**

```json
{
  "word": "vocabulary"
}
```

---

## 6. GRAMMAR API

Kiểm tra và sửa lỗi ngữ pháp bằng AI.

### 4.1 Kiểm tra ngữ pháp

| Thuộc tính      | Giá trị                               |
| --------------- | ------------------------------------- |
| **Endpoint**    | `POST /api/v1/grammar/check`          |
| **Auth**        | ✅ Yêu cầu Bearer Token               |
| **Description** | Phân tích và sửa lỗi ngữ pháp bằng AI |

**Request Body:**

```json
{
  "text": "She don't like to swimming in the sea."
}
```

**Response (201 Created):**

```json
{
  "statusCode": 201,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": {
    "id": 1,
    "inputText": "She don't like to swimming in the sea.",
    "correctedText": "She doesn't like swimming in the sea.",
    "score": 65,
    "errors": [
      {
        "id": 1,
        "errorType": "VERB_AGREEMENT",
        "beforeText": "She ",
        "errorText": "don't",
        "correctedText": "doesn't",
        "afterText": " like",
        "explanation": "Use 'doesn't' with third person singular subjects",
        "startPosition": 4,
        "endPosition": 9
      },
      {
        "id": 2,
        "errorType": "GERUND",
        "beforeText": "like to ",
        "errorText": "swimming",
        "correctedText": "swim",
        "afterText": " in",
        "explanation": "Use bare infinitive after 'like to'",
        "startPosition": 18,
        "endPosition": 26
      }
    ],
    "createdAt": "2024-01-01T00:00:00Z"
  }
}
```

---

### 4.2 Lấy lịch sử kiểm tra ngữ pháp

| Thuộc tính      | Giá trị                                 |
| --------------- | --------------------------------------- |
| **Endpoint**    | `GET /api/v1/grammar`                   |
| **Auth**        | ✅ Yêu cầu Bearer Token                 |
| **Description** | Lấy danh sách các lần kiểm tra ngữ pháp |

**Query Parameters:**
| Parameter | Type | Required | Default |
|-----------|------|----------|---------|
| page | Integer | ❌ | 0 |
| size | Integer | ❌ | 20 |

**Response (200 OK):**

```json
{
    "statusCode": 200,
    "error": null,
    "message": "CALL API SUCCESS",
    "data": {
        "meta": {
            "page": 0,
            "pageSize": 20,
            "pages": 3,
            "total": 45
        },
        "result": [
            {
                "id": 1,
                "inputText": "She don't like swimming.",
                "correctedText": "She doesn't like swimming.",
                "score": 75,
                "errors": [...],
                "createdAt": "2024-01-01T10:00:00Z"
            },
            {
                "id": 2,
                "inputText": "He go to school yesterday.",
                "correctedText": "He went to school yesterday.",
                "score": 80,
                "errors": [...],
                "createdAt": "2024-01-02T09:30:00Z"
            }
        ]
    }
}
```

---

### 4.3 Lấy chi tiết kiểm tra ngữ pháp

| Thuộc tính      | Giá trị                                |
| --------------- | -------------------------------------- |
| **Endpoint**    | `GET /api/v1/grammar/{id}`             |
| **Auth**        | ✅ Yêu cầu Bearer Token                |
| **Description** | Lấy chi tiết một lần kiểm tra ngữ pháp |

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| id | Long | ✅ | ID của bản ghi kiểm tra ngữ pháp |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": {
    "id": 1,
    "inputText": "She don't like to swimming in the sea.",
    "correctedText": "She doesn't like swimming in the sea.",
    "score": 65,
    "errors": [
      {
        "id": 1,
        "errorType": "VERB_AGREEMENT",
        "beforeText": "She ",
        "errorText": "don't",
        "correctedText": "doesn't",
        "afterText": " like",
        "explanation": "Use 'doesn't' with third person singular subjects",
        "startPosition": 4,
        "endPosition": 9
      }
    ],
    "createdAt": "2024-01-01T00:00:00Z"
  }
}
```

---

### 4.4 Xóa bản ghi kiểm tra ngữ pháp

| Thuộc tính      | Giá trị                       |
| --------------- | ----------------------------- |
| **Endpoint**    | `DELETE /api/v1/grammar/{id}` |
| **Auth**        | ✅ Yêu cầu Bearer Token       |
| **Description** | Xóa bản ghi kiểm tra ngữ pháp |

**Response (204 No Content)**

---

## 7. IELTS TEST API

Tạo và quản lý bài thi IELTS với AI.

### 5.1 Tạo bài thi IELTS mới

| Thuộc tính      | Giá trị                       |
| --------------- | ----------------------------- |
| **Endpoint**    | `POST /api/v1/ielts/generate` |
| **Auth**        | ✅ Yêu cầu Bearer Token       |
| **Description** | Tạo bài thi IELTS mới bằng AI |

**Request Body:**

```json
{
  "skill": "Reading",
  "level": "Academic",
  "difficulty": "Medium"
}
```

| Field      | Allowed Values                        |
| ---------- | ------------------------------------- |
| skill      | Reading, Writing, Listening, Speaking |
| level      | General, Academic                     |
| difficulty | Easy, Medium, Hard                    |

**Response (201 Created):**

```json
{
  "statusCode": 201,
  "error": null,
  "message": "Generate IELTS test successfully",
  "data": {
    "id": 1,
    "skill": "Reading",
    "level": "Academic",
    "difficulty": "Medium",
    "title": "The Impact of Climate Change on Marine Ecosystems",
    "durationMinutes": 20,
    "totalQuestions": 13,
    "questions": [
      {
        "id": 1,
        "questionNumber": 1,
        "passage": "Climate change is affecting marine ecosystems worldwide...",
        "questionText": "What is the main topic of the passage?",
        "answers": [
          {
            "id": 1,
            "answerText": "The effects of pollution",
            "isCorrect": false
          },
          {
            "id": 2,
            "answerText": "Climate change and marine life",
            "isCorrect": true
          }
        ]
      }
    ]
  }
}
```

---

### 5.2 Lấy bài thi theo ID

| Thuộc tính      | Giá trị                            |
| --------------- | ---------------------------------- |
| **Endpoint**    | `GET /api/v1/ielts/tests/{testId}` |
| **Auth**        | ✅ Yêu cầu Bearer Token            |
| **Description** | Lấy chi tiết bài thi theo ID       |

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| testId | Long | ✅ | ID của bài thi IELTS |

**Response (200 OK):**

```json
{
    "statusCode": 200,
    "error": null,
    "message": "Fetch test successfully",
    "data": {
        "id": 1,
        "skill": "Reading",
        "level": "Academic",
        "difficulty": "Medium",
        "title": "The Impact of Climate Change",
        "durationMinutes": 20,
        "totalQuestions": 13,
        "questions": [...]
    }
}
```

---

### 5.3 Bắt đầu làm bài thi

| Thuộc tính      | Giá trị                       |
| --------------- | ----------------------------- |
| **Endpoint**    | `POST /api/v1/ielts/start`    |
| **Auth**        | ✅ Yêu cầu Bearer Token       |
| **Description** | Bắt đầu một phiên làm bài thi |

**Request Body:**

```json
{
  "testId": 1
}
```

**Response (201 Created):**

```json
{
  "statusCode": 201,
  "error": null,
  "message": "Start test successfully",
  "data": {
    "historyId": 1,
    "testId": 1,
    "userId": 1,
    "startedAt": "2024-01-01T10:00:00Z",
    "status": "IN_PROGRESS"
  }
}
```

---

### 5.4 Nộp bài thi

| Thuộc tính      | Giá trị                     |
| --------------- | --------------------------- |
| **Endpoint**    | `POST /api/v1/ielts/submit` |
| **Auth**        | ✅ Yêu cầu Bearer Token     |
| **Description** | Nộp bài thi và nhận kết quả |

**Request Body:**

```json
{
  "historyId": 1,
  "answers": [
    {
      "questionId": 1,
      "selectedAnswerId": 2
    },
    {
      "questionId": 2,
      "selectedAnswerId": 5
    }
  ]
}
```

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "Submit test successfully",
  "data": {
    "historyId": 1,
    "score": 7.5,
    "totalCorrect": 10,
    "totalQuestions": 13,
    "completedAt": "2024-01-01T10:18:30Z",
    "questionResults": [
      {
        "questionId": 1,
        "isCorrect": true,
        "userAnswerId": 2,
        "correctAnswerId": 2
      }
    ]
  }
}
```

---

### 5.5 Lấy lịch sử làm bài

| Thuộc tính      | Giá trị                        |
| --------------- | ------------------------------ |
| **Endpoint**    | `GET /api/v1/ielts/history`    |
| **Auth**        | ✅ Yêu cầu Bearer Token        |
| **Description** | Lấy lịch sử các bài thi đã làm |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "Fetch test history successfully",
  "data": [
    {
      "historyId": 1,
      "testId": 1,
      "skill": "Reading",
      "score": 7.5,
      "startedAt": "2024-01-01T10:00:00Z",
      "completedAt": "2024-01-01T10:18:30Z"
    }
  ]
}
```

````

---

## 8. TOEIC TEST API

Tạo và quản lý bài thi TOEIC với AI.

### 6.1 Tạo bài thi TOEIC mới

| Thuộc tính      | Giá trị                       |
| --------------- | ----------------------------- |
| **Endpoint**    | `POST /api/v1/toeic/generate` |
| **Auth**        | ✅ Yêu cầu Bearer Token       |
| **Description** | Tạo bài thi TOEIC mới bằng AI |

**Request Body:**

```json
{
  "section": "Part 5",
  "difficulty": "Medium"
}
````

| Field      | Allowed Values                                                             |
| ---------- | -------------------------------------------------------------------------- |
| section    | Listening, Reading, Part 1, Part 2, Part 3, Part 4, Part 5, Part 6, Part 7 |
| difficulty | Easy, Medium, Hard                                                         |

**Response (201 Created):**

```json
{
  "statusCode": 201,
  "error": null,
  "message": "Generate TOEIC test successfully",
  "data": {
    "id": 1,
    "section": "Reading",
    "part": "Part 5",
    "difficulty": "Medium",
    "title": "Incomplete Sentences",
    "durationMinutes": 15,
    "totalQuestions": 10,
    "questions": [
      {
        "id": 1,
        "questionNumber": 1,
        "questionText": "The manager _____ the report before the meeting.",
        "audioUrl": null,
        "answers": [
          { "id": 1, "answerText": "review", "isCorrect": false },
          { "id": 2, "answerText": "reviews", "isCorrect": false },
          { "id": 3, "answerText": "reviewed", "isCorrect": true },
          { "id": 4, "answerText": "reviewing", "isCorrect": false }
        ]
      }
    ]
  }
}
```

---

### 6.2 Lấy bài thi theo ID

| Thuộc tính      | Giá trị                            |
| --------------- | ---------------------------------- |
| **Endpoint**    | `GET /api/v1/toeic/tests/{testId}` |
| **Auth**        | ✅ Yêu cầu Bearer Token            |
| **Description** | Lấy chi tiết bài thi TOEIC theo ID |

**Path Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| testId | Long | ✅ | ID của bài thi TOEIC |

**Response (200 OK):**

```json
{
    "statusCode": 200,
    "error": null,
    "message": "Fetch test successfully",
    "data": {
        "id": 1,
        "section": "Reading",
        "part": "Part 5",
        "difficulty": "Medium",
        "title": "Incomplete Sentences",
        "durationMinutes": 15,
        "totalQuestions": 10,
        "questions": [...]
    }
}
```

---

### 6.3 Bắt đầu làm bài thi

| Thuộc tính      | Giá trị                       |
| --------------- | ----------------------------- |
| **Endpoint**    | `POST /api/v1/toeic/start`    |
| **Auth**        | ✅ Yêu cầu Bearer Token       |
| **Description** | Bắt đầu một phiên làm bài thi |

**Request Body:**

```json
{
  "testId": 1
}
```

**Response (201 Created):**

```json
{
  "statusCode": 201,
  "error": null,
  "message": "Start test successfully",
  "data": {
    "historyId": 1,
    "testId": 1,
    "userId": 1,
    "startedAt": "2024-01-01T10:00:00Z",
    "status": "IN_PROGRESS"
  }
}
```

---

### 6.4 Nộp bài thi

| Thuộc tính      | Giá trị                     |
| --------------- | --------------------------- |
| **Endpoint**    | `POST /api/v1/toeic/submit` |
| **Auth**        | ✅ Yêu cầu Bearer Token     |
| **Description** | Nộp bài thi và nhận kết quả |

**Request Body:**

```json
{
  "historyId": 1,
  "answers": [
    { "questionId": 1, "selectedAnswerId": 3 },
    { "questionId": 2, "selectedAnswerId": 5 }
  ]
}
```

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "Submit test successfully",
  "data": {
    "historyId": 1,
    "score": 850,
    "totalCorrect": 8,
    "totalQuestions": 10,
    "completedAt": "2024-01-01T10:15:00Z",
    "questionResults": [
      {
        "questionId": 1,
        "isCorrect": true,
        "userAnswerId": 3,
        "correctAnswerId": 3
      }
    ]
  }
}
```

---

### 6.5 Lấy lịch sử làm bài

| Thuộc tính      | Giá trị                        |
| --------------- | ------------------------------ |
| **Endpoint**    | `GET /api/v1/toeic/history`    |
| **Auth**        | ✅ Yêu cầu Bearer Token        |
| **Description** | Lấy lịch sử các bài thi đã làm |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "Fetch test history successfully",
  "data": [
    {
      "historyId": 1,
      "testId": 1,
      "section": "Reading",
      "part": "Part 5",
      "score": 850,
      "startedAt": "2024-01-01T10:00:00Z",
      "completedAt": "2024-01-01T10:15:00Z"
    }
  ]
}
```

---

## 9. ACHIEVEMENT API

Quản lý hệ thống thành tích.

### 7.1 Lấy tất cả thành tích

| Thuộc tính      | Giá trị                                        |
| --------------- | ---------------------------------------------- |
| **Endpoint**    | `GET /api/v1/achievements`                     |
| **Auth**        | ✅ Yêu cầu Bearer Token                        |
| **Description** | Lấy danh sách tất cả thành tích trong hệ thống |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": [
    {
      "id": 1,
      "title": "First Steps",
      "description": "Learn your first 10 words",
      "iconUrl": "https://example.com/badge1.png",
      "metricType": "VOCABULARY",
      "targetValue": 10
    }
  ]
}
```

---

### 7.2 Kiểm tra và cấp thành tích

| Thuộc tính      | Giá trị                                         |
| --------------- | ----------------------------------------------- |
| **Endpoint**    | `POST /api/v1/user-achievements/check`          |
| **Auth**        | ✅ Yêu cầu Bearer Token                         |
| **Description** | Kiểm tra và cấp thành tích mới dựa trên tiến độ |

**Request Body:**

```json
{
  "metricType": "VOCABULARY",
  "currentValue": 50
}
```

| metricType     | Mô tả                    |
| -------------- | ------------------------ |
| VOCABULARY     | Số từ vựng đã học        |
| GRAMMAR_CHECKS | Số lần kiểm tra ngữ pháp |
| IELTS_TESTS    | Số bài thi IELTS đã làm  |
| TOEIC_TESTS    | Số bài thi TOEIC đã làm  |
| STREAK_DAYS    | Số ngày học liên tiếp    |

**Response (200 OK):** Danh sách thành tích vừa đạt được

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": [
    {
      "id": 2,
      "title": "Word Master",
      "description": "Learn 50 words",
      "iconUrl": "https://example.com/badge2.png"
    }
  ]
}
```

---

### 7.3 Lấy thành tích của người dùng

| Thuộc tính      | Giá trị                              |
| --------------- | ------------------------------------ |
| **Endpoint**    | `GET /api/v1/user-achievements`      |
| **Auth**        | ✅ Yêu cầu Bearer Token              |
| **Description** | Lấy danh sách thành tích đã đạt được |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": [
    {
      "id": 1,
      "achievement": {
        "id": 1,
        "title": "First Steps",
        "description": "Learn your first 10 words",
        "iconUrl": "https://example.com/badge1.png"
      },
      "unlockedAt": "2024-01-01T10:00:00Z"
    }
  ]
}
```

---

### 7.4 Reset thành tích (Testing)

| Thuộc tính      | Giá trị                                       |
| --------------- | --------------------------------------------- |
| **Endpoint**    | `DELETE /api/v1/user-achievements/reset`      |
| **Auth**        | ✅ Yêu cầu Bearer Token                       |
| **Description** | Xóa tất cả thành tích của user (dùng để test) |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": "Achievements reset successfully for user: Nguyen Van A"
}
```

---

## 10. STATISTICS API

Thống kê dữ liệu học tập.

### 8.1 Thống kê từ vựng theo loại từ

| Thuộc tính      | Giá trị                            |
| --------------- | ---------------------------------- |
| **Endpoint**    | `GET /api/v1/vocabulary/breakdown` |
| **Auth**        | ✅ Yêu cầu Bearer Token            |
| **Description** | Phân loại từ vựng theo loại từ     |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": {
    "noun": 120,
    "verb": 80,
    "adjective": 60,
    "adverb": 40,
    "other": 10
  }
}
```

---

### 8.2 Phân bố CEFR

| Thuộc tính      | Giá trị                                    |
| --------------- | ------------------------------------------ |
| **Endpoint**    | `GET /api/v1/vocabulary/cefr-distribution` |
| **Auth**        | ✅ Yêu cầu Bearer Token                    |
| **Description** | Phân bố từ vựng theo cấp độ CEFR           |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": {
    "A1": 30,
    "A2": 50,
    "B1": 90,
    "B2": 70,
    "C1": 20,
    "C2": 10
  }
}
```

---

### 8.3 Tổng số từ vựng

| Thuộc tính   | Giá trị                        |
| ------------ | ------------------------------ |
| **Endpoint** | `GET /api/v1/vocabulary/count` |
| **Auth**     | ✅ Yêu cầu Bearer Token        |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": 270
}
```

---

### 8.4 Thống kê trang chủ

| Thuộc tính      | Giá trị                             |
| --------------- | ----------------------------------- |
| **Endpoint**    | `GET /api/v1/vocabulary/home-stats` |
| **Auth**        | ✅ Yêu cầu Bearer Token             |
| **Description** | Thống kê tổng hợp cho dashboard     |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": {
    "wordsToday": 5,
    "totalWords": 270,
    "streakDays": 7,
    "grammarChecks": 15,
    "avgGrammarScore": 85
  }
}
```

---

### 8.5 Thống kê từ vựng theo ngày

| Thuộc tính   | Giá trị                              |
| ------------ | ------------------------------------ |
| **Endpoint** | `GET /api/v1/stats/daily-vocabulary` |
| **Auth**     | ✅ Yêu cầu Bearer Token              |

**Query Parameters:**
| Parameter | Type | Default |
|-----------|------|---------|
| days | Integer | 7 |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": [
    { "date": "2024-12-23", "count": 3 },
    { "date": "2024-12-24", "count": 5 },
    { "date": "2024-12-25", "count": 0 }
  ]
}
```

---

### 8.6 Thống kê kiểm tra ngữ pháp theo ngày

| Thuộc tính      | Giá trị                                  |
| --------------- | ---------------------------------------- |
| **Endpoint**    | `GET /api/v1/stats/daily-grammar-checks` |
| **Auth**        | ✅ Yêu cầu Bearer Token                  |
| **Description** | Số lần kiểm tra ngữ pháp theo từng ngày  |

**Query Parameters:**
| Parameter | Type | Default |
|-----------|------|---------|
| days | Integer | 7 |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": [
    { "date": "2024-12-23", "count": 2 },
    { "date": "2024-12-24", "count": 5 },
    { "date": "2024-12-25", "count": 0 }
  ]
}
```

---

### 8.7 Điểm ngữ pháp theo ngày

| Thuộc tính   | Giá trị                                  |
| ------------ | ---------------------------------------- |
| **Endpoint** | `GET /api/v1/stats/daily-grammar-scores` |
| **Auth**     | ✅ Yêu cầu Bearer Token                  |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": [
    { "date": "2024-12-23", "avgScore": 85 },
    { "date": "2024-12-24", "avgScore": 78 }
  ]
}
```

---

### 8.8 Hoạt động theo ngày

| Thuộc tính      | Giá trị                                       |
| --------------- | --------------------------------------------- |
| **Endpoint**    | `GET /api/v1/stats/daily-activity`            |
| **Auth**        | ✅ Yêu cầu Bearer Token                       |
| **Description** | Kiểm tra hoạt động học tập theo ngày (streak) |

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": [
    { "date": "2024-12-23", "hasActivity": true },
    { "date": "2024-12-24", "hasActivity": true },
    { "date": "2024-12-25", "hasActivity": false }
  ]
}
```

---

## 11. FILE MANAGEMENT API

Upload và download files.

### 9.1 Upload file

| Thuộc tính       | Giá trị                     |
| ---------------- | --------------------------- |
| **Endpoint**     | `POST /api/v1/files`        |
| **Auth**         | ✅ Yêu cầu Bearer Token     |
| **Content-Type** | `multipart/form-data`       |
| **Description**  | Upload file (ảnh, document) |

**Form Data:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| file | File | ✅ | File cần upload |
| folder | String | ✅ | Thư mục lưu trữ |

**Allowed Extensions:** `pdf, jpg, jpeg, png, doc, docx`

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": {
    "fileName": "avatar_1704067200.jpg",
    "uploadedAt": "2024-01-01T10:00:00Z"
  }
}
```

---

### 9.2 Download file

| Thuộc tính      | Giá trị                 |
| --------------- | ----------------------- |
| **Endpoint**    | `GET /api/v1/files`     |
| **Auth**        | ✅ Yêu cầu Bearer Token |
| **Description** | Tải file xuống          |

**Query Parameters:**
| Parameter | Type | Required |
|-----------|------|----------|
| fileName | String | ✅ |
| folder | String | ✅ |

**Example:** `GET /api/v1/files?fileName=avatar.jpg&folder=users`

**Response:** Binary file data

---

## 12. PRONUNCIATION API

Phân tích và đánh giá phát âm.

### 10.1 Phân tích phát âm

| Thuộc tính      | Giá trị                                  |
| --------------- | ---------------------------------------- |
| **Endpoint**    | `POST /api/v1/pronunciation/analyze`     |
| **Auth**        | ✅ Yêu cầu Bearer Token                  |
| **Description** | Đánh giá phát âm dựa trên speech-to-text |

**Request Body:**

```json
{
  "expectedWord": "achievement",
  "transcribedText": "achievment",
  "ipa": "/əˈtʃiːvmənt/"
}
```

**Response (200 OK):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "CALL API SUCCESS",
  "data": {
    "score": 75,
    "isCorrect": false,
    "expectedWord": "achievement",
    "transcribedWord": "achievment",
    "feedback": "Missing 'e' sound in the middle. Try pronouncing each syllable: a-CHIEVE-ment",
    "suggestions": [
      "Focus on the 'ieev' sound",
      "Practice breaking the word into syllables"
    ]
  }
}
```

---

## 13. AUDIO/TTS API

Proxy audio và Text-to-Speech.

### 11.1 Proxy Audio

| Thuộc tính      | Giá trị                                        |
| --------------- | ---------------------------------------------- |
| **Endpoint**    | `GET /api/audio/proxy`                         |
| **Auth**        | ❌ Không yêu cầu                               |
| **Description** | Proxy audio từ external URLs (giải quyết CORS) |

**Query Parameters:**
| Parameter | Type | Required |
|-----------|------|----------|
| url | String | ✅ |

**Response:** Audio stream (audio/mpeg)

---

### 11.2 Text-to-Speech

| Thuộc tính      | Giá trị                             |
| --------------- | ----------------------------------- |
| **Endpoint**    | `GET /api/audio/tts`                |
| **Auth**        | ❌ Không yêu cầu                    |
| **Description** | Tạo audio từ text bằng VoiceRSS API |

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| text | String | ✅ | Văn bản cần đọc |

**Example:** `GET /api/audio/tts?text=Hello%20World`

**Multi-voice Support:**

- Sử dụng `Man:` hoặc `Male:` để đổi sang giọng nam
- Sử dụng `Woman:` hoặc `Female:` để đổi sang giọng nữ

**Response:** Audio stream (audio/mpeg)

---

### 11.3 Test Audio

| Thuộc tính      | Giá trị                        |
| --------------- | ------------------------------ |
| **Endpoint**    | `GET /api/audio/test`          |
| **Auth**        | ❌ Không yêu cầu               |
| **Description** | Kiểm tra audio proxy hoạt động |

---

## 14. MÃ LỖI (ERROR CODES)

### HTTP Status Codes

| Code | Status                | Mô tả                |
| ---- | --------------------- | -------------------- |
| 200  | OK                    | Thành công           |
| 201  | Created               | Tạo thành công       |
| 204  | No Content            | Xóa thành công       |
| 400  | Bad Request           | Request không hợp lệ |
| 401  | Unauthorized          | Chưa xác thực        |
| 403  | Forbidden             | Không có quyền       |
| 404  | Not Found             | Không tìm thấy       |
| 422  | Unprocessable Entity  | Validation error     |
| 500  | Internal Server Error | Lỗi server           |

### Error Response Format

```json
{
  "statusCode": 400,
  "message": "Validation failed",
  "data": null,
  "error": {
    "type": "ValidationError",
    "details": [{ "field": "email", "message": "Email không được để trống" }]
  }
}
```

### Common Errors

| Error                | Mô tả           | Giải pháp                     |
| -------------------- | --------------- | ----------------------------- |
| `IdInvalidException` | ID không hợp lệ | Kiểm tra ID tồn tại           |
| `StorageException`   | Lỗi upload file | Kiểm tra file extension, size |
| `Token expired`      | Token hết hạn   | Sử dụng refresh token         |

---

## 15. GHI CHÚ

### Pagination Response

Các API có phân trang sử dụng format:

```json
{
    "meta": {
        "page": 0,
        "pageSize": 10,
        "totalPages": 5,
        "totalElements": 48
    },
    "result": [...]
}
```

### Date/Time Format

Tất cả timestamp sử dụng **ISO 8601** format: `2024-01-01T10:00:00Z`

---

<div align="center">

## 📞 Liên Hệ

**Magic English Team**

📧 Email: support@magicenglish.vn

📱 Version: 1.0.0

📅 Cập nhật: January 2025

---

**Made with ❤️ by Magic English Team**

</div>
