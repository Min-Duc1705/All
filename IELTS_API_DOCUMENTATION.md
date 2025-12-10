# IELTS Test System - API Documentation

## Overview

Hệ thống tạo đề thi IELTS tự động sử dụng AI (Gemini) và lưu lịch sử làm bài của user.

## Database Schema

Đã tạo 5 bảng trong `database_ielts_schema.sql`:

- `ielts_tests` - Bộ đề IELTS
- `ielts_questions` - Câu hỏi trong đề
- `ielts_answers` - Các đáp án
- `ielts_test_history` - Lịch sử làm bài
- `ielts_user_answers` - Câu trả lời của user

## API Endpoints

### 1. Generate IELTS Test

**POST** `/api/v1/ielts/generate`

Tạo bộ đề IELTS mới bằng AI. Nếu đã tồn tại đề với skill/level/difficulty giống nhau thì trả về đề cũ.

**Headers:**

```
Authorization: Bearer <access_token>
Content-Type: application/json
```

**Request Body:**

```json
{
  "skill": "Reading",
  "level": "General",
  "difficulty": "Easy"
}
```

**Parameters:**

- `skill`: Reading, Writing, Listening, Speaking
- `level`: General, Academic
- `difficulty`: Easy (10 câu), Medium (15 câu), Hard (20 câu)

**Response:** (201 Created)

```json
{
  "statusCode": 201,
  "message": "Generate IELTS test successfully",
  "data": {
    "id": 1,
    "skill": "Reading",
    "level": "General",
    "difficulty": "Easy",
    "title": "IELTS General Reading Test - Easy",
    "durationMinutes": 60,
    "totalQuestions": 10,
    "questions": [
      {
        "id": 1,
        "questionNumber": 1,
        "questionText": "What is the main idea of the passage?",
        "questionType": "multiple_choice",
        "passage": "Sample reading passage...",
        "audioUrl": null,
        "answers": [
          {
            "id": 1,
            "answerOption": "A",
            "answerText": "Answer A text",
            "isCorrect": null
          },
          {
            "id": 2,
            "answerOption": "B",
            "answerText": "Answer B text",
            "isCorrect": null
          },
          {
            "id": 3,
            "answerOption": "C",
            "answerText": "Answer C text",
            "isCorrect": null
          },
          {
            "id": 4,
            "answerOption": "D",
            "answerText": "Answer D text",
            "isCorrect": null
          }
        ]
      }
    ]
  }
}
```

**Note:** `isCorrect` không được trả về khi generate/fetch test (để tránh lộ đáp án).

---

### 2. Get Test by ID

**GET** `/api/v1/ielts/tests/{testId}`

Lấy thông tin chi tiết bộ đề theo ID.

**Headers:**

```
Authorization: Bearer <access_token>
```

**Response:** (200 OK)

```json
{
  "statusCode": 200,
  "message": "Fetch test successfully",
  "data": {
    "id": 1,
    "skill": "Reading",
    "level": "General",
    "difficulty": "Easy",
    "title": "IELTS General Reading Test - Easy",
    "durationMinutes": 60,
    "totalQuestions": 10,
    "questions": [...]
  }
}
```

---

### 3. Start Test Session

**POST** `/api/v1/ielts/start`

Bắt đầu làm bài test (tạo session trong `ielts_test_history`).

**Headers:**

```
Authorization: Bearer <access_token>
Content-Type: application/json
```

**Request Body:**

```json
{
  "testId": 1
}
```

**Response:** (201 Created)

```json
{
  "statusCode": 201,
  "message": "Start test successfully",
  "data": {
    "id": 1,
    "testId": 1,
    "testTitle": "IELTS General Reading Test - Easy",
    "skill": "Reading",
    "level": "General",
    "difficulty": "Easy",
    "startedAt": "2024-01-15T10:30:00Z",
    "completedAt": null,
    "score": null,
    "correctAnswers": 0,
    "totalAnswers": 10,
    "status": "in_progress",
    "timeSpentSeconds": null
  }
}
```

**Note:** Lưu `historyId` để submit test sau.

---

### 4. Submit Test

**POST** `/api/v1/ielts/submit`

Nộp bài và nhận kết quả chi tiết.

**Headers:**

```
Authorization: Bearer <access_token>
Content-Type: application/json
```

**Request Body:**

```json
{
  "historyId": 1,
  "timeSpentSeconds": 1800,
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

**Response:** (200 OK)

```json
{
  "statusCode": 200,
  "message": "Submit test successfully",
  "data": {
    "historyId": 1,
    "score": 7.5,
    "correctAnswers": 8,
    "totalQuestions": 10,
    "timeSpentSeconds": 1800,
    "questionResults": [
      {
        "questionId": 1,
        "questionNumber": 1,
        "questionText": "What is the main idea?",
        "userAnswer": "B",
        "correctAnswer": "B",
        "isCorrect": true
      },
      {
        "questionId": 2,
        "questionNumber": 2,
        "questionText": "Which statement is true?",
        "userAnswer": "C",
        "correctAnswer": "A",
        "isCorrect": false
      }
    ]
  }
}
```

**IELTS Band Score Calculation:**

- 90%+ → 9.0
- 82%+ → 8.5
- 75%+ → 8.0
- 67%+ → 7.5
- 60%+ → 7.0
- 52%+ → 6.5
- 45%+ → 6.0
- 37%+ → 5.5
- 30%+ → 5.0
- <30% → 4.0-4.5

---

### 5. Get Test History

**GET** `/api/v1/ielts/history`

Lấy lịch sử làm bài của user (sắp xếp mới nhất trước).

**Headers:**

```
Authorization: Bearer <access_token>
```

**Response:** (200 OK)

```json
{
  "statusCode": 200,
  "message": "Fetch test history successfully",
  "data": [
    {
      "id": 2,
      "testId": 1,
      "testTitle": "IELTS General Reading Test - Easy",
      "skill": "Reading",
      "level": "General",
      "difficulty": "Easy",
      "startedAt": "2024-01-15T10:30:00Z",
      "completedAt": "2024-01-15T11:00:00Z",
      "score": 7.5,
      "correctAnswers": 8,
      "totalAnswers": 10,
      "status": "completed",
      "timeSpentSeconds": 1800
    },
    {
      "id": 1,
      "testId": 1,
      "testTitle": "IELTS General Reading Test - Easy",
      "skill": "Reading",
      "level": "General",
      "difficulty": "Easy",
      "startedAt": "2024-01-14T09:00:00Z",
      "completedAt": "2024-01-14T09:25:00Z",
      "score": 6.5,
      "correctAnswers": 6,
      "totalAnswers": 10,
      "status": "completed",
      "timeSpentSeconds": 1500
    }
  ]
}
```

---

## Frontend Flow

### 1. User bấm Start button

```dart
// IELTS Practice Screen
_startTest(difficulty) {
  // 1. Generate test (hoặc lấy test có sẵn)
  final test = await ieltsService.generateTest(
    skill: _selectedSkill,
    level: _selectedLevel,
    difficulty: difficulty,
  );

  // 2. Start test session
  final history = await ieltsService.startTest(test.id);

  // 3. Navigate to test screen
  Navigator.push(IELTSTakeTestScreen(test, history));
}
```

### 2. User làm bài (giống Quiz Mode)

```dart
// IELTS Take Test Screen
- Hiển thị từng câu hỏi một
- User chọn đáp án
- Bấm Next để sang câu tiếp
- KHÔNG hiển thị đúng/sai ngay
- Phải làm hết mới được Submit
```

### 3. Submit và xem kết quả

```dart
// Submit khi làm xong
_submitTest() {
  final result = await ieltsService.submitTest(
    historyId: history.id,
    answers: _selectedAnswers,
    timeSpentSeconds: timeSpent,
  );

  // Navigate to result screen
  Navigator.push(IELTSResultScreen(result, test));
}
```

### 4. Xem chi tiết kết quả

```dart
// IELTS Result Screen
- Hiển thị Band Score (7.5)
- % đúng, thời gian
- Review từng câu: đáp án của user vs đáp án đúng
- Màu xanh (đúng), màu đỏ (sai)
```

---

## Testing Steps

### 1. Setup Database

```sql
-- Chạy file SQL để tạo bảng
SOURCE database_ielts_schema.sql;

-- Kiểm tra
SHOW TABLES LIKE 'ielts_%';
```

### 2. Test API với Postman/curl

#### A. Generate Test

```bash
curl -X POST http://localhost:8080/api/v1/ielts/generate \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "skill": "Reading",
    "level": "General",
    "difficulty": "Easy"
  }'
```

#### B. Start Test

```bash
curl -X POST http://localhost:8080/api/v1/ielts/start \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "testId": 1
  }'
```

#### C. Submit Test

```bash
curl -X POST http://localhost:8080/api/v1/ielts/submit \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "historyId": 1,
    "timeSpentSeconds": 1800,
    "answers": [
      {"questionId": 1, "selectedAnswerId": 2},
      {"questionId": 2, "selectedAnswerId": 5}
    ]
  }'
```

#### D. Get History

```bash
curl -X GET http://localhost:8080/api/v1/ielts/history \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### 3. Test Frontend

```bash
# Run Flutter app
flutter run

# Steps:
1. Login
2. Navigate to Practice → IELTS
3. Chọn skill (Reading), level (General)
4. Bấm Start ở một test card (Easy/Medium/Hard)
5. Đợi AI generate (loading dialog)
6. Làm bài: chọn đáp án từng câu
7. Bấm Next để sang câu tiếp
8. Bấm Submit Test khi làm xong
9. Xem kết quả: Band Score, % đúng, review từng câu
```

---

## Features

### ✅ Backend

- Spring Boot 3 + Spring AI
- Gemini AI tạo đề tự động
- Cache để tránh tạo đề trùng
- JWT authentication
- MySQL database
- REST API với validation

### ✅ Frontend

- Flutter với Material Design
- Quiz-like interface
- Progress tracking
- Timer
- Result visualization
- History tracking

### ✅ AI Features

- Tạo câu hỏi theo skill/level
- Tạo passage cho Reading
- Multiple choice questions
- Tự động tính IELTS Band Score

---

## Error Handling

### Backend

```java
// User not authenticated
throw new IdInvalidException("User not authenticated");

// Test not found
throw new IdInvalidException("Test not found with ID: " + testId);

// Test already completed
throw new IdInvalidException("Test is already completed");

// AI generation failed
throw new RuntimeException("Failed to generate test: " + e.getMessage());
```

### Frontend

```dart
try {
  final test = await ieltsService.generateTest(...);
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Failed to generate test: ${e.toString()}'),
      backgroundColor: Colors.red,
    ),
  );
}
```

---

## Performance Optimization

1. **AI Caching**: Tránh tạo đề trùng
2. **Lazy Loading**: Chỉ load câu hỏi khi cần
3. **Pagination**: History API hỗ trợ pagination
4. **Index**: Database có index trên skill, level, difficulty
5. **Connection Pool**: HikariCP với max 20 connections

---

## Security

1. **JWT Authentication**: Tất cả endpoints yêu cầu token
2. **User Isolation**: Chỉ xem history của chính mình
3. **Answer Protection**: Không trả `isCorrect` khi fetch test
4. **SQL Injection**: JPA/Hibernate prevent SQL injection
5. **XSS Protection**: Spring Security headers

---

## Future Enhancements

1. **Audio Support**: Upload audio cho Listening tests
2. **Writing Evaluation**: AI chấm bài Writing
3. **Speaking Record**: Record và chấm Speaking
4. **Adaptive Difficulty**: Tự động điều chỉnh độ khó
5. **Analytics**: Thống kê chi tiết progress
6. **Social Features**: So sánh với bạn bè
7. **Offline Mode**: Tải đề về làm offline

---

## Troubleshooting

### Problem: AI không generate được

**Solution:**

- Check API key trong `application.yaml`
- Check network connection
- Check Gemini API quota

### Problem: Test history không hiển thị

**Solution:**

- Check user authentication
- Check database connection
- Check SQL: `SELECT * FROM ielts_test_history WHERE user_id = ?`

### Problem: Submit test failed

**Solution:**

- Check tất cả câu đã được trả lời
- Check historyId còn status="in_progress"
- Check answerId hợp lệ

---

## Contact & Support

- Backend: Spring Boot 3.5.8, Java 21
- Frontend: Flutter 3.x
- AI: Google Gemini 2.5 Flash Lite
- Database: MySQL 8.0+

**Developed by:** Magic English Team  
**Documentation Version:** 1.0  
**Last Updated:** 2024-01-15
