# HƯỚNG DẪN DEPLOY FLUTTER WEB MIỄN PHÍ

## Build Web đã hoàn tất!

**Thư mục output:** `build/web`

---

## CÁCH 1: VERCEL (Khuyến nghị - Dễ nhất)

### Bước 1: Cài đặt Vercel CLI

```bash
npm install -g vercel
```

### Bước 2: Deploy

```bash
cd t:\TryHard_IT_Project\Moblie\BTL\Frontend-Moblie\magic_enlish\build\web
vercel
```

### Bước 3: Làm theo hướng dẫn

- Đăng nhập tài khoản Vercel (đăng ký miễn phí tại vercel.com)
- Chọn project name
- Nhấn Enter để deploy

**Ưu điểm:**

- Deploy nhanh, đơn giản
- HTTPS miễn phí
- Custom domain miễn phí
- Auto deploy khi push code

---

## CÁCH 2: NETLIFY (Rất dễ)

### Cách A: Kéo thả (Drag & Drop)

1. Truy cập https://app.netlify.com/drop
2. Kéo thả thư mục `build/web` vào trang web
3. Done! Nhận link ngay lập tức

### Cách B: Dùng CLI

```bash
npm install -g netlify-cli
cd t:\TryHard_IT_Project\Moblie\BTL\Frontend-Moblie\magic_enlish\build\web
netlify deploy --prod
```

---

## CÁCH 3: GITHUB PAGES (Miễn phí vĩnh viễn)

### Bước 1: Tạo repository mới trên GitHub

- Tên repo: `magic-english-web` (hoặc tên bạn muốn)

### Bước 2: Push folder build/web lên GitHub

```bash
cd t:\TryHard_IT_Project\Moblie\BTL\Frontend-Moblie\magic_enlish\build\web
git init
git add .
git commit -m "Deploy Magic English Web"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/magic-english-web.git
git push -u origin main
```

### Bước 3: Bật GitHub Pages

1. Vào Settings > Pages
2. Source: Deploy from a branch
3. Branch: main, folder: / (root)
4. Save

**URL:** `https://YOUR_USERNAME.github.io/magic-english-web`

### Lưu ý cho GitHub Pages:

Nếu deploy vào subfolder (không phải root), cần sửa `index.html`:

```html
<!-- Đổi từ -->
<base href="/" />
<!-- Thành -->
<base href="/magic-english-web/" />
```

---

## CÁCH 4: FIREBASE HOSTING

### Bước 1: Cài Firebase CLI

```bash
npm install -g firebase-tools
firebase login
```

### Bước 2: Khởi tạo và Deploy

```bash
cd t:\TryHard_IT_Project\Moblie\BTL\Frontend-Moblie\magic_enlish
firebase init hosting
# Chọn: build/web làm public directory
# Configure as single-page app: Yes

firebase deploy
```

---

## SO SÁNH CÁC NỀN TẢNG

| Nền tảng         | Độ dễ      | HTTPS | Custom Domain | Bandwidth      |
| ---------------- | ---------- | ----- | ------------- | -------------- |
| **Vercel**       | ⭐⭐⭐⭐⭐ | ✅    | ✅ Miễn phí   | 100GB/tháng    |
| **Netlify**      | ⭐⭐⭐⭐⭐ | ✅    | ✅ Miễn phí   | 100GB/tháng    |
| **GitHub Pages** | ⭐⭐⭐⭐   | ✅    | ✅ Miễn phí   | Không giới hạn |
| **Firebase**     | ⭐⭐⭐     | ✅    | ✅ Miễn phí   | 10GB/tháng     |

---

## LƯU Ý QUAN TRỌNG

### 1. CORS với Backend Render

Backend của bạn trên Render cần cho phép CORS từ domain deploy:

```java
// SecurityConfig.java
@Bean
public CorsConfigurationSource corsConfigurationSource() {
    CorsConfiguration config = new CorsConfiguration();
    config.setAllowedOrigins(Arrays.asList(
        "http://localhost:3000",
        "https://your-app.vercel.app",      // Thêm domain Vercel
        "https://your-app.netlify.app"      // Thêm domain Netlify
    ));
    config.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
    config.setAllowCredentials(true);
    // ...
}
```

### 2. Biến môi trường

Đảm bảo `.env` file có Backend URL đúng:

```
Backend_URL=https://magic-english-final.onrender.com
```

### 3. Build lại nếu thay đổi URL

```bash
flutter build web --release
```

---

## KHUYẾN NGHỊ: DÙNG VERCEL

**Lý do:**

1. Deploy dễ nhất (chỉ 1 lệnh)
2. Auto HTTPS
3. Preview deployment cho mỗi commit
4. Analytics miễn phí
5. Tích hợp GitHub/GitLab

---

**Backend:** https://magic-english-final.onrender.com ✅ (Đã deploy)

**Chúc bạn deploy thành công!**
