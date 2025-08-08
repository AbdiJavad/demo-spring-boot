# Auto Setup: Java 17 + Maven (GitHub Codespaces + Windows)

این ریپو به‌صورت خودکار محیط توسعه‌ی **Java 17 + Maven** را در **GitHub Codespaces** آماده می‌کند
و اسکریپت نصب کامل برای ویندوز هم دارد.

## سریع‌ترین شروع در Codespaces
1) این ریپو را در گیت‌هاب بسازید و محتوای این ZIP را در آن آپلود کنید.
2) روی دکمه‌ی **Code → Create codespace on main** کلیک کنید.
3) صبر کنید devcontainer ساخته شود. سپس در ترمینال بنویسید:
   ```bash
   mvn -v
   ```
   اگر نسخه‌ها را دیدید یعنی نصب کامل شده.
4) برای اجرای یک پروژه‌ی Spring Boot موجود:
   ```bash
   mvn spring-boot:run
   ```

## اجرای اسکریپت نصب روی ویندوز (Local)
- فایل `scripts\install_all.bat` را با **Run as administrator** اجرا کنید.
- این اسکریپت در صورت دردسترس بودن از `winget` استفاده می‌کند؛ اگر نبود، راهنمای نصب دستی می‌دهد.

## اجرای اسکریپت نصب روی لینوکس/مک
```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

## پوشه‌ها
- `.devcontainer/` تنظیمات کامل Codespaces
- `.vscode/` تسک‌ها و اکستنشن‌های لازم
- `scripts/` اسکریپت‌های نصب
- `.github/workflows/ci.yml` بیلد Maven در GitHub Actions

> نکته: اگر پروژه Spring Boot ندارید، یک بار دیگر بپرسید تا برایتان اسکلت آماده هم اضافه کنم.

---
## نمونه پروژه Spring Boot آماده
پوشه `demo-spring-boot/` شامل یک REST API ساده با H2 است. اجرا:

```bash
cd demo-spring-boot
mvn spring-boot:run
```
کنسول H2: http://localhost:8080/h2-console  (JDBC: `jdbc:h2:mem:testdb`)

برای PostgreSQL:
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=postgres
```
