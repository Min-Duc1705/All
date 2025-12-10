# Hướng dẫn chạy dự án Magic English bằng Docker

Tài liệu này hướng dẫn bạn cách chạy toàn bộ Backend (Server + Database) trên một máy tính mới mà không phải cài đặt Java, MySQL hay cấu hình môi trường phức tạp.

## 1. Yêu cầu duy nhất

Bạn chỉ cần cài đặt **Docker Desktop** trên máy tính muốn chạy dự án.

- Link tải: [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)
- Sau khi cài, hãy mở Docker Desktop lên.

## 2. Các bước chạy

### Bước 1: Copy dự án

Copy toàn bộ thư mục `magic-english` (chứa file `docker-compose.yml` và `Dockerfile` vừa tạo) sang máy tính kia.

### Bước 2: Chạy lệnh

1. Mở cửa sổ **Command Prompt (CMD)** hoặc **PowerShell** tại thư mục dự án đó.
2. Gõ lệnh sau và ấn Enter:
   ```bash
   docker-compose up --build -d
   ```
   _(Lần đầu chạy sẽ mất vài phút để tải MySQL, Java và build dự án)_

### Bước 3: Hoàn tất

- Sau khi lệnh chạy xong, server của bạn đã sẵn sàng.
- **API Server**: `http://localhost:8080`
- **Database**: Tự động chạy ngầm, bạn không cần quan tâm. Nếu cần kết nối thủ công thì dùng cổng `3307` (User: `root`, Pass: `123456`).

## 3. Các lệnh hữu ích khác

- **Tắt dự án**:
  ```bash
  docker-compose down
  ```
- **Xem log (để sửa lỗi)**:
  ```bash
  docker-compose logs -f
  ```

## 4. Lưu ý

- File bạn upload sẽ nằm trong thư mục `public` của dự án, dữ liệu database thì nằm trong Docker.
- Nếu bạn sửa code, hãy chạy lại lệnh ở Bước 2 để cập nhật thay đổi.
