# Hướng dẫn xem Sơ đồ (ERD, Use Case, User Flow)

Các file tài liệu (`ERD.md`, `Use_Cases.md`, `User_Flow.md`) trong thư mục này sử dụng cú pháp **Mermaid** để vẽ biểu đồ tự động. Dưới đây là cách để bạn xem các biểu đồ này dưới dạng hình ảnh.

## Cách 1: Xem trực tiếp trong VS Code (Khuyên dùng)

VS Code hỗ trợ xem trước file Markdown rất tốt.

1. Mở file `.md` bạn muốn xem (ví dụ: `ERD.md`).
2. Nhấn tổ hợp phím `Ctrl + Shift + V` (hoặc click vào biểu tượng **Open Preview to the Side** ở góc trên bên phải cửa sổ soạn thảo).
3. Biểu đồ sẽ được hiển thị ngay lập tức.
   - _Lưu ý: Nếu biểu đồ không hiện ra, bạn có thể cần cài đặt thêm Extension "Markdown Preview Mermaid Support" trong VS Code._

## Cách 2: Sử dụng trang web Mermaid Live Editor

Nếu bạn muốn chỉnh sửa nhanh hoặc tải ảnh về máy:

1. Mở file `.md` và copy toàn bộ nội dung trong khối code (phần nằm giữa các dấu ba dấu phẩy ngược \`\`\`mermaid ... \`\`\`).
2. Truy cập trang web: [https://mermaid.live/](https://mermaid.live/)
3. Dán code vào khung bên trái.
4. Biểu đồ sẽ hiện ra ở khung bên phải. Bạn có thể tải về dưới dạng ảnh PNG hoặc SVG.

## Giải thích các file

- **ERD.md**: Sơ đồ thực thể - quan hệ (Cấu trúc Database).
- **Use_Cases.md**: Sơ đồ Use Case (Chức năng hệ thống).
- **User_Flow.md**: Sơ đồ luồng đi của người dùng (User Flow/Sequence Diagram).
