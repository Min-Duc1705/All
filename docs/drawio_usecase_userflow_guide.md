# 📊 Hướng Dẫn Vẽ Use Case & User Flow bằng Draw.io

## Dự Án: Magic English - Ứng Dụng Học Tiếng Anh Thông Minh

---

## 📖 Mục Lục

1. [Tổng Quan Dự Án](#1-tổng-quan-dự-án)
2. [Use Case Diagram Tổng Quan](#2-use-case-diagram-tổng-quan)
3. [Use Case Chi Tiết Từng Chức Năng](#3-use-case-chi-tiết-từng-chức-năng)
4. [User Flow Diagrams](#4-user-flow-diagrams)
5. [Hướng Dẫn Sử Dụng Draw.io](#5-hướng-dẫn-sử-dụng-drawio)

---

## 1. Tổng Quan Dự Án

### 🎯 Actors (Tác nhân)

| Actor         | Mô tả                                 |
| ------------- | ------------------------------------- |
| **Guest**     | Người dùng chưa đăng nhập             |
| **Learner**   | Người học đã đăng nhập                |
| **AI System** | Hệ thống AI (Spring AI/OpenAI/Gemini) |

### 🏗️ Các Module Chức Năng Chính

```
Magic English
├── 🔐 Authentication (Đăng nhập/Đăng ký)
├── 📖 Vocabulary Management (Quản lý từ vựng)
├── 📝 Grammar Checker (Kiểm tra ngữ pháp)
├── 📚 TOEIC Practice (Luyện thi TOEIC)
├── 🎓 IELTS Practice (Luyện thi IELTS)
├── 🎤 Pronunciation (Luyện phát âm)
├── 🏆 Achievements (Thành tích)
├── 👤 Profile Management (Quản lý hồ sơ)
└── 📊 Progress Tracking (Theo dõi tiến độ)
```

---

## 2. Use Case Diagram Tổng Quan

### 📌 Cách vẽ trong Draw.io

1. **Mở Draw.io** → New Diagram → Blank Diagram
2. **Thêm Actor**:
   - Search "UML" trong shapes
   - Kéo thả **Actor** (hình người)
3. **Thêm Use Case**:
   - Vẽ **Ellipse** (hình elip)
   - Viết tên chức năng bên trong
4. **Thêm System Boundary**:
   - Vẽ **Rectangle** bao quanh các Use Case
   - Đặt tên hệ thống ở góc trên

### 🖼️ Sơ Đồ Use Case Tổng Quan

```
┌─────────────────────────────────────────────────────────────────┐
│                     MAGIC ENGLISH SYSTEM                         │
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐           │
│  │   Đăng ký    │  │  Đăng nhập   │  │ Đăng xuất    │           │
│  └──────────────┘  └──────────────┘  └──────────────┘           │
│          ↑                ↑                ↑                     │
│          │                │                │                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐           │
│  │ Quản lý      │  │ Kiểm tra     │  │ Luyện thi    │           │
│  │ Từ vựng      │  │ Ngữ pháp     │  │ TOEIC        │           │
│  └──────────────┘  └──────────────┘  └──────────────┘           │
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐           │
│  │ Luyện thi    │  │ Luyện        │  │ Xem          │           │
│  │ IELTS        │  │ Phát âm      │  │ Thành tích   │           │
│  └──────────────┘  └──────────────┘  └──────────────┘           │
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐                             │
│  │ Quản lý      │  │ Xem          │                             │
│  │ Hồ sơ        │  │ Tiến độ      │                             │
│  └──────────────┘  └──────────────┘                             │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
         │                    │                    │
         │                    │                    │
    🧑 Guest            🧑 Learner           🤖 AI System
```

### 📋 Bảng Tổng Hợp Use Cases

| ID   | Use Case          | Actor          | Mô tả                      |
| ---- | ----------------- | -------------- | -------------------------- |
| UC01 | Đăng ký           | Guest          | Tạo tài khoản mới          |
| UC02 | Đăng nhập         | Guest, Learner | Xác thực người dùng        |
| UC03 | Đăng xuất         | Learner        | Thoát khỏi hệ thống        |
| UC04 | Quản lý từ vựng   | Learner, AI    | Thêm/xem/xóa từ vựng       |
| UC05 | Kiểm tra ngữ pháp | Learner, AI    | Phân tích lỗi ngữ pháp     |
| UC06 | Luyện thi TOEIC   | Learner, AI    | Làm đề thi TOEIC           |
| UC07 | Luyện thi IELTS   | Learner, AI    | Làm đề thi IELTS           |
| UC08 | Luyện phát âm     | Learner, AI    | Đánh giá phát âm           |
| UC09 | Xem thành tích    | Learner        | Xem các huy hiệu đạt được  |
| UC10 | Quản lý hồ sơ     | Learner        | Cập nhật thông tin cá nhân |
| UC11 | Xem tiến độ       | Learner        | Xem thống kê học tập       |

---

## 3. Use Case Chi Tiết Từng Chức Năng

### 3.1 🔐 Authentication (UC01-UC03)

#### Use Case Description

| Thành phần        | Chi tiết                                                                                                  |
| ----------------- | --------------------------------------------------------------------------------------------------------- |
| **Use Case**      | Đăng nhập (UC02)                                                                                          |
| **Actor**         | Guest/Learner                                                                                             |
| **Precondition**  | Đã có tài khoản                                                                                           |
| **Main Flow**     | 1. Nhập email<br>2. Nhập mật khẩu<br>3. Nhấn đăng nhập<br>4. Hệ thống xác thực<br>5. Chuyển đến trang chủ |
| **Alternative**   | 3a. Quên mật khẩu                                                                                         |
| **Postcondition** | Đăng nhập thành công, nhận JWT token                                                                      |

#### Draw.io XML Code (Authentication Use Case)

```xml
<mxGraphModel>
  <root>
    <mxCell id="0"/>
    <mxCell id="1" parent="0"/>
    <!-- System Boundary -->
    <mxCell id="2" value="Authentication Module" style="swimlane;whiteSpace=wrap;html=1;" vertex="1" parent="1">
      <mxGeometry x="160" y="40" width="280" height="300" as="geometry"/>
    </mxCell>
    <!-- Use Cases -->
    <mxCell id="3" value="Đăng ký" style="ellipse;whiteSpace=wrap;html=1;" vertex="1" parent="2">
      <mxGeometry x="90" y="50" width="100" height="50" as="geometry"/>
    </mxCell>
    <mxCell id="4" value="Đăng nhập" style="ellipse;whiteSpace=wrap;html=1;" vertex="1" parent="2">
      <mxGeometry x="90" y="120" width="100" height="50" as="geometry"/>
    </mxCell>
    <mxCell id="5" value="Đăng xuất" style="ellipse;whiteSpace=wrap;html=1;" vertex="1" parent="2">
      <mxGeometry x="90" y="190" width="100" height="50" as="geometry"/>
    </mxCell>
    <mxCell id="6" value="Refresh Token" style="ellipse;whiteSpace=wrap;html=1;fillColor=#f8cecc;" vertex="1" parent="2">
      <mxGeometry x="90" y="250" width="100" height="40" as="geometry"/>
    </mxCell>
    <!-- Actor Guest -->
    <mxCell id="7" value="Guest" style="shape=umlActor;verticalLabelPosition=bottom;verticalAlign=top;" vertex="1" parent="1">
      <mxGeometry x="60" y="100" width="40" height="80" as="geometry"/>
    </mxCell>
    <!-- Actor Learner -->
    <mxCell id="8" value="Learner" style="shape=umlActor;verticalLabelPosition=bottom;verticalAlign=top;" vertex="1" parent="1">
      <mxGeometry x="60" y="220" width="40" height="80" as="geometry"/>
    </mxCell>
    <!-- Relationships -->
    <mxCell id="9" style="endArrow=none" edge="1" parent="1" source="7" target="3"/>
    <mxCell id="10" style="endArrow=none" edge="1" parent="1" source="7" target="4"/>
    <mxCell id="11" style="endArrow=none" edge="1" parent="1" source="8" target="4"/>
    <mxCell id="12" style="endArrow=none" edge="1" parent="1" source="8" target="5"/>
    <!-- Include relationship -->
    <mxCell id="13" value="&lt;&lt;include&gt;&gt;" style="dashed=1;endArrow=open" edge="1" parent="1" source="4" target="6"/>
  </root>
</mxGraphModel>
```

---

### 3.2 📖 Vocabulary Management (UC04)

#### Các Sub Use Cases

| Sub UC | Tên                 | Include/Extend        | Actor     |
| ------ | ------------------- | --------------------- | --------- |
| UC04.1 | Thêm từ mới         | Main                  | Learner   |
| UC04.2 | AI làm giàu dữ liệu | <<include>> từ UC04.1 | AI System |
| UC04.3 | Xem danh sách từ    | Main                  | Learner   |
| UC04.4 | Preview từ vựng     | <<extend>> từ UC04.1  | Learner   |
| UC04.5 | Tìm kiếm từ         | <<extend>> từ UC04.3  | Learner   |

#### Diagram Structure

```
         ┌──────────────────────────────────────────────┐
         │           Vocabulary Management              │
         │                                              │
         │   ┌─────────────┐     ┌─────────────┐       │
         │   │ Thêm từ mới │────→│ AI làm giàu │       │
         │   └─────────────┘     │    dữ liệu  │       │
         │         ↑             └─────────────┘       │
         │         │ <<extend>>        ↓               │
         │   ┌─────────────┐     ┌─────────────┐       │
         │   │ Preview từ  │     │   Lấy IPA,  │       │
         │   │   vựng      │     │   nghĩa,    │       │
         │   └─────────────┘     │   ví dụ     │       │
         │                       └─────────────┘       │
         │   ┌─────────────┐                           │
         │   │ Xem danh    │←── <<extend>> ─┐         │
         │   │ sách từ     │                │         │
         │   └─────────────┘          ┌─────────────┐ │
         │                            │ Tìm kiếm từ │ │
         │                            └─────────────┘ │
         └──────────────────────────────────────────────┘
              │                           │
         🧑 Learner                  🤖 AI System
```

---

### 3.3 📝 Grammar Checker (UC05)

#### Use Case Flow

```
Learner ──→ Nhập văn bản ──→ Kiểm tra ngữ pháp ──→ AI phân tích
                                    │
                                    ↓
                            ┌───────────────┐
                            │ Nhận kết quả: │
                            │ - Lỗi sai     │
                            │ - Gợi ý sửa   │
                            │ - Giải thích  │
                            └───────────────┘
```

| Use Case | Description          |
| -------- | -------------------- |
| UC05.1   | Kiểm tra ngữ pháp    |
| UC05.2   | Xem lịch sử kiểm tra |
| UC05.3   | Xem chi tiết kết quả |
| UC05.4   | Xóa lịch sử          |

---

### 3.4 📚 TOEIC Practice (UC06)

#### Complete Use Case Diagram

```
         ┌─────────────────────────────────────────────────────┐
         │                 TOEIC Practice Module               │
         │                                                     │
         │   ┌───────────────┐     ┌───────────────┐          │
         │   │ Tạo đề thi    │────→│ AI sinh đề   │          │
         │   │ (Generate)    │     │ tự động      │          │
         │   └───────────────┘     └───────────────┘          │
         │          │                                          │
         │          │ <<include>>                              │
         │          ↓                                          │
         │   ┌───────────────┐                                 │
         │   │ Chọn Section  │  Section: LISTENING/READING    │
         │   │ & Difficulty  │  Difficulty: EASY/MEDIUM/HARD  │
         │   └───────────────┘                                 │
         │          │                                          │
         │          ↓                                          │
         │   ┌───────────────┐                                 │
         │   │ Bắt đầu làm   │                                 │
         │   │ bài (Start)   │                                 │
         │   └───────────────┘                                 │
         │          │                                          │
         │          │ <<include>>                              │
         │          ↓                                          │
         │   ┌───────────────┐     ┌───────────────┐          │
         │   │ Nộp bài       │────→│ Xem kết quả   │          │
         │   │ (Submit)      │     │ & Giải thích  │          │
         │   └───────────────┘     └───────────────┘          │
         │                                │                    │
         │                                │ <<extend>>         │
         │                                ↓                    │
         │                         ┌───────────────┐          │
         │   ┌───────────────┐     │ Xem transcript│          │
         │   │ Xem lịch sử   │     │ (Listening)   │          │
         │   │ thi           │     └───────────────┘          │
         │   └───────────────┘                                 │
         │                                                     │
         └─────────────────────────────────────────────────────┘
              │                                    │
         🧑 Learner                           🤖 AI System
```

#### TOEIC Parts Breakdown

| Part   | Section   | Description                  |
| ------ | --------- | ---------------------------- |
| Part 1 | Listening | Photographs - Mô tả hình ảnh |
| Part 2 | Listening | Question-Response - Hỏi đáp  |
| Part 3 | Listening | Conversations - Hội thoại    |
| Part 4 | Listening | Talks - Bài nói              |
| Part 5 | Reading   | Incomplete Sentences         |
| Part 6 | Reading   | Text Completion              |
| Part 7 | Reading   | Reading Comprehension        |

---

### 3.5 🎓 IELTS Practice (UC07)

#### Sub Use Cases

```
         ┌────────────────────────────────────────────────────┐
         │                IELTS Practice Module                │
         │                                                     │
         │   ┌───────────────┐                                 │
         │   │ Chọn kỹ năng  │  Skills: READING/LISTENING/    │
         │   │ (Skill)       │         WRITING/SPEAKING       │
         │   └───────────────┘                                 │
         │          │                                          │
         │          ↓                                          │
         │   ┌───────────────┐     ┌───────────────┐          │
         │   │ Tạo đề thi    │────→│ AI sinh đề   │          │
         │   │ (Generate)    │     │ theo skill   │          │
         │   └───────────────┘     └───────────────┘          │
         │          │                                          │
         │          ↓                                          │
         │   ┌───────────────┐                                 │
         │   │ Làm bài       │                                 │
         │   │ (Start)       │                                 │
         │   └───────────────┘                                 │
         │          │                                          │
         │          ↓                                          │
         │   ┌───────────────┐     ┌───────────────┐          │
         │   │ Nộp bài       │────→│ Xem điểm     │          │
         │   │ (Submit)      │     │ Band Score   │          │
         │   └───────────────┘     └───────────────┘          │
         │                                                     │
         │   ┌───────────────┐                                 │
         │   │ Xem lịch sử   │                                 │
         │   │ thi           │                                 │
         │   └───────────────┘                                 │
         │                                                     │
         └────────────────────────────────────────────────────┘
```

---

### 3.6 🎤 Pronunciation (UC08)

```
         ┌─────────────────────────────────────────────────┐
         │            Pronunciation Assessment             │
         │                                                 │
         │   ┌───────────────┐                             │
         │   │ Chọn từ/câu   │                             │
         │   │ để luyện      │                             │
         │   └───────────────┘                             │
         │          │                                      │
         │          ↓                                      │
         │   ┌───────────────┐                             │
         │   │ Ghi âm phát   │                             │
         │   │ âm của user   │                             │
         │   └───────────────┘                             │
         │          │                                      │
         │          │ <<include>>                          │
         │          ↓                                      │
         │   ┌───────────────┐     ┌───────────────┐      │
         │   │ Phân tích     │────→│ AI so sánh   │      │
         │   │ phát âm       │     │ với chuẩn    │      │
         │   └───────────────┘     └───────────────┘      │
         │          │                                      │
         │          ↓                                      │
         │   ┌───────────────┐                             │
         │   │ Nhận feedback │                             │
         │   │ - Score       │                             │
         │   │ - Suggestions │                             │
         │   └───────────────┘                             │
         │                                                 │
         └─────────────────────────────────────────────────┘
```

---

### 3.7 🏆 Achievements & Profile (UC09-UC10)

```
         ┌──────────────────────────────────────────────────┐
         │              User Profile & Achievements          │
         │                                                   │
         │   ┌───────────────┐     ┌───────────────┐        │
         │   │ Xem thông tin │     │ Cập nhật      │        │
         │   │ cá nhân       │     │ thông tin     │        │
         │   └───────────────┘     └───────────────┘        │
         │                                                   │
         │   ┌───────────────┐     ┌───────────────┐        │
         │   │ Đổi avatar    │     │ Xem thành     │        │
         │   │               │     │ tích đạt được │        │
         │   └───────────────┘     └───────────────┘        │
         │                                                   │
         │   ┌───────────────┐     ┌───────────────┐        │
         │   │ Xem tiến độ   │     │ Xem thống kê  │        │
         │   │ học tập       │     │ vocabulary    │        │
         │   └───────────────┘     └───────────────┘        │
         │                                                   │
         └──────────────────────────────────────────────────┘
                              │
                         🧑 Learner
```

---

## 4. User Flow Diagrams

### 4.1 🔐 Authentication Flow

```
┌─────────┐     ┌─────────┐     ┌─────────┐     ┌─────────┐
│  Start  │────→│  Mở App │────→│ Có tài  │────→│ Đăng    │
│         │     │         │     │ khoản?  │ Có  │ nhập    │
└─────────┘     └─────────┘     └────┬────┘     └────┬────┘
                                     │ Không         │
                                     ↓               │
                               ┌─────────┐          │
                               │ Đăng ký │          │
                               │ mới     │          │
                               └────┬────┘          │
                                    │               │
                                    └───────────────┤
                                                    ↓
                               ┌─────────┐    ┌──────────┐
                               │ Thất    │←───│ Xác thực │
                               │ bại     │    │ thành    │
                               └────┬────┘    │ công?    │
                                    │         └────┬─────┘
                                    │              │ Có
                               ┌────↓────┐         ↓
                               │ Hiển thị│   ┌──────────┐
                               │ lỗi     │   │ Vào Home │
                               └─────────┘   │ Screen   │
                                             └──────────┘
```

### 4.2 📖 Vocabulary Learning Flow

```
┌─────────┐     ┌───────────┐     ┌───────────┐     ┌───────────┐
│  Home   │────→│ Vocabulary│────→│ Thêm từ   │────→│ Nhập từ  │
│ Screen  │     │  Screen   │     │ mới?      │ Có  │ tiếng Anh│
└─────────┘     └───────────┘     └─────┬─────┘     └─────┬─────┘
                                        │ Không           │
                                        ↓                 ↓
                                  ┌───────────┐    ┌───────────┐
                                  │ Xem danh  │    │ AI làm    │
                                  │ sách từ   │    │ giàu dữ   │
                                  └───────────┘    │ liệu      │
                                        │          └─────┬─────┘
                                        ↓                ↓
                                  ┌───────────┐    ┌───────────┐
                                  │ Tìm kiếm  │    │ Hiển thị  │
                                  │ từ vựng   │    │ preview   │
                                  └───────────┘    └─────┬─────┘
                                                         ↓
                                                   ┌───────────┐
                                                   │ Lưu từ    │
                                                   │ vào DB    │
                                                   └───────────┘
```

### 4.3 📚 TOEIC Practice Flow

```
┌─────────┐     ┌───────────┐     ┌───────────┐     ┌───────────┐
│Practice │────→│  Chọn     │────→│  Chọn     │────→│  Chọn     │
│ Screen  │     │  TOEIC    │     │  Section  │     │ Difficulty│
└─────────┘     └───────────┘     └───────────┘     └─────┬─────┘
                                                          │
                                                          ↓
┌───────────┐     ┌───────────┐     ┌───────────┐   ┌───────────┐
│ Xem kết   │←────│ Nộp bài   │←────│ Làm bài   │←──│ AI tạo    │
│ quả       │     │           │     │ thi       │   │ đề thi    │
└─────┬─────┘     └───────────┘     └───────────┘   └───────────┘
      │
      ↓
┌───────────┐     ┌───────────┐
│ Xem giải  │     │ Lưu lịch  │
│ thích     │────→│ sử thi    │
└───────────┘     └───────────┘
```

### 4.4 🎤 Pronunciation Practice Flow

```
┌─────────┐     ┌───────────┐     ┌───────────┐
│Practice │────→│ Chọn      │────→│ Xem từ/   │
│ Screen  │     │ Speaking  │     │ câu mẫu   │
└─────────┘     └───────────┘     └─────┬─────┘
                                        │
                                        ↓
                                  ┌───────────┐
                                  │ Nghe phát │
                                  │ âm chuẩn  │
                                  └─────┬─────┘
                                        │
                                        ↓
┌───────────┐     ┌───────────┐   ┌───────────┐
│ Nhận      │←────│ AI phân   │←──│ Ghi âm    │
│ feedback  │     │ tích      │   │ giọng nói │
└─────┬─────┘     └───────────┘   └───────────┘
      │
      ↓
┌───────────┐     ┌───────────┐
│ Xem điểm  │     │ Luyện tập │
│ & gợi ý   │────→│ lại       │
└───────────┘     └───────────┘
```

---

## 5. Hướng Dẫn Sử Dụng Draw.io

### 5.1 Cách Tạo Use Case Diagram

#### Bước 1: Mở Draw.io

1. Truy cập [draw.io](https://app.diagrams.net/)
2. Chọn **Create New Diagram**
3. Chọn **Blank Diagram** hoặc tìm template **UML Use Case**

#### Bước 2: Thêm Shapes cơ bản

| Element         | Shape trong Draw.io | Cách tìm             |
| --------------- | ------------------- | -------------------- |
| Actor           | Stick figure        | Search "UML" → Actor |
| Use Case        | Ellipse             | General → Ellipse    |
| System Boundary | Rectangle           | General → Rectangle  |
| Association     | Simple line         | Connector            |
| Include         | Dashed arrow        | Set style: dashed=1  |
| Extend          | Dashed arrow        | Set style: dashed=1  |

#### Bước 3: Tạo Quan Hệ

**Association (Kết nối Actor với Use Case):**

- Dùng đường thẳng đơn giản
- Không có mũi tên

**Include Relationship:**

```
Nguồn ----<<include>>----> Đích
```

- Style: `dashed=1;endArrow=open`
- Label: `<<include>>`

**Extend Relationship:**

```
Nguồn ----<<extend>>----> Đích
```

- Style: `dashed=1;endArrow=open`
- Label: `<<extend>>`

### 5.2 Cách Tạo User Flow Diagram

#### Sử dụng Flowchart Shapes

| Element       | Shape           | Ý nghĩa        |
| ------------- | --------------- | -------------- |
| Oval          | Ellipse         | Start/End      |
| Rectangle     | Rectangle       | Process        |
| Diamond       | Diamond/Rhombus | Decision       |
| Parallelogram | Parallelogram   | Input/Output   |
| Arrow         | Connector       | Flow direction |

#### Tips khi vẽ User Flow

1. **Bắt đầu từ điểm khởi đầu** (Oval "Start")
2. **Mỗi bước là một hình chữ nhật**
3. **Điểm quyết định dùng hình thoi**
4. **Kết thúc bằng Oval "End"**
5. **Mũi tên chỉ hướng đi**

### 5.3 Template XML Mẫu

#### Use Case Tổng Quan (Copy và Import)

```xml
<mxGraphModel dx="1038" dy="574" grid="1" gridSize="10" guides="1">
  <root>
    <mxCell id="0"/>
    <mxCell id="1" parent="0"/>

    <!-- System Boundary -->
    <mxCell id="system" value="Magic English System"
            style="swimlane;fontStyle=1;fontSize=14;startSize=30;"
            vertex="1" parent="1">
      <mxGeometry x="160" y="40" width="480" height="400" as="geometry"/>
    </mxCell>

    <!-- Use Cases Row 1 -->
    <mxCell id="uc1" value="Đăng ký"
            style="ellipse;whiteSpace=wrap;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;"
            vertex="1" parent="system">
      <mxGeometry x="30" y="50" width="120" height="50" as="geometry"/>
    </mxCell>

    <mxCell id="uc2" value="Đăng nhập"
            style="ellipse;whiteSpace=wrap;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;"
            vertex="1" parent="system">
      <mxGeometry x="170" y="50" width="120" height="50" as="geometry"/>
    </mxCell>

    <mxCell id="uc3" value="Quản lý Từ vựng"
            style="ellipse;whiteSpace=wrap;html=1;fillColor=#d5e8d4;strokeColor=#82b366;"
            vertex="1" parent="system">
      <mxGeometry x="30" y="120" width="120" height="50" as="geometry"/>
    </mxCell>

    <mxCell id="uc4" value="Kiểm tra Ngữ pháp"
            style="ellipse;whiteSpace=wrap;html=1;fillColor=#d5e8d4;strokeColor=#82b366;"
            vertex="1" parent="system">
      <mxGeometry x="170" y="120" width="120" height="50" as="geometry"/>
    </mxCell>

    <mxCell id="uc5" value="Luyện thi TOEIC"
            style="ellipse;whiteSpace=wrap;html=1;fillColor=#ffe6cc;strokeColor=#d79b00;"
            vertex="1" parent="system">
      <mxGeometry x="310" y="120" width="120" height="50" as="geometry"/>
    </mxCell>

    <mxCell id="uc6" value="Luyện thi IELTS"
            style="ellipse;whiteSpace=wrap;html=1;fillColor=#ffe6cc;strokeColor=#d79b00;"
            vertex="1" parent="system">
      <mxGeometry x="30" y="190" width="120" height="50" as="geometry"/>
    </mxCell>

    <mxCell id="uc7" value="Luyện Phát âm"
            style="ellipse;whiteSpace=wrap;html=1;fillColor=#e1d5e7;strokeColor=#9673a6;"
            vertex="1" parent="system">
      <mxGeometry x="170" y="190" width="120" height="50" as="geometry"/>
    </mxCell>

    <mxCell id="uc8" value="Xem Thành tích"
            style="ellipse;whiteSpace=wrap;html=1;fillColor=#f8cecc;strokeColor=#b85450;"
            vertex="1" parent="system">
      <mxGeometry x="310" y="190" width="120" height="50" as="geometry"/>
    </mxCell>

    <mxCell id="uc9" value="Quản lý Hồ sơ"
            style="ellipse;whiteSpace=wrap;html=1;fillColor=#f8cecc;strokeColor=#b85450;"
            vertex="1" parent="system">
      <mxGeometry x="30" y="260" width="120" height="50" as="geometry"/>
    </mxCell>

    <mxCell id="uc10" value="Xem Tiến độ"
            style="ellipse;whiteSpace=wrap;html=1;fillColor=#f8cecc;strokeColor=#b85450;"
            vertex="1" parent="system">
      <mxGeometry x="170" y="260" width="120" height="50" as="geometry"/>
    </mxCell>

    <!-- Actors -->
    <mxCell id="guest" value="Guest"
            style="shape=umlActor;verticalLabelPosition=bottom;verticalAlign=top;html=1;"
            vertex="1" parent="1">
      <mxGeometry x="60" y="80" width="40" height="80" as="geometry"/>
    </mxCell>

    <mxCell id="learner" value="Learner"
            style="shape=umlActor;verticalLabelPosition=bottom;verticalAlign=top;html=1;"
            vertex="1" parent="1">
      <mxGeometry x="60" y="220" width="40" height="80" as="geometry"/>
    </mxCell>

    <mxCell id="ai" value="AI System"
            style="shape=umlActor;verticalLabelPosition=bottom;verticalAlign=top;html=1;fillColor=#f5f5f5;strokeColor=#666666;fontColor=#333333;"
            vertex="1" parent="1">
      <mxGeometry x="700" y="180" width="40" height="80" as="geometry"/>
    </mxCell>

  </root>
</mxGraphModel>
```

### 5.4 Color Coding Scheme

Sử dụng màu sắc để phân loại các Use Cases:

| Category          | Color        | Hex Code |
| ----------------- | ------------ | -------- |
| Authentication    | Light Blue   | #dae8fc  |
| Learning Features | Light Green  | #d5e8d4  |
| Practice/Test     | Light Orange | #ffe6cc  |
| AI Features       | Light Purple | #e1d5e7  |
| User Management   | Light Red    | #f8cecc  |

### 5.5 Export và Chia sẻ

1. **Export PNG/SVG**: File → Export as → PNG/SVG
2. **Chia sẻ link**: File → Share → Create Link
3. **Nhúng vào tài liệu**: File → Embed → Copy HTML

---

## 📎 Tài Liệu Tham Khảo

- [Draw.io Documentation](https://www.diagrams.net/doc/)
- [UML Use Case Diagram Tutorial](https://www.visual-paradigm.com/guide/uml-unified-modeling-language/what-is-use-case-diagram/)
- [User Flow Best Practices](https://www.nngroup.com/articles/user-flows/)

---

> **Lưu ý**: Tất cả các diagram trong hướng dẫn này đều có thể vẽ trực tiếp trong Draw.io. Bạn có thể copy các XML code mẫu và import vào Draw.io để bắt đầu nhanh chóng.
