# Today's Roadmap for Aplikasi Smart School

## Objective
Set up the development environment and resolve critical configuration issues so the application can run locally today.

## Status Summary
- **Environment Setup (Steps 1–4, 9):** Selesai terpasang di `D:\xampp` (XAMPP Portable PHP 5.6.40 + ionCube Loader v15.5.1 + MariaDB 10.1.37 + Apache 2.4.37).
- **Code & Configuration Fixes (Steps 5–8):** Selesai diterapkan di repositori.
- **Database Migration Script (Step 11):** Selesai dibuat dan dijalankan ke database `elearning` (seluruh 12 tabel menggunakan engine `InnoDB`).
- **Application Test (Step 10):** Endpoint `/` (`Beranda`) dan `/login` sudah terverifikasi HTTP `200 OK`; pengujian login & fitur di browser siap dilakukan user.

## Tasks (in order)
1. [x] **Install PHP 5.6**
   - Terpasang di `D:\xampp\php\php.exe` (PHP 5.6.40).
2. [x] **Install ionCube Loader for PHP 5.6**
   - `ioncube_loader_win_5.6.dll` (v15.5.1) terpasang di `D:\xampp\php\ext\` dan didaftarkan di `D:\xampp\php\php.ini`.
3. [x] **Install MySQL/MariaDB & Import Database**
   - MariaDB 10.1.37 (`D:\xampp\mysql`) siap; database `elearning` sudah dibuat dan di-import dari `db/bukuinduk.sql`.
4. [x] **Enable required PHP extensions**
   - Ekstensi `mysqli`, `mbstring`, `gd`, `openssl`, dan `ionCube Loader` aktif.
5. [x] **Set a writable session directory**
   - Dikonfigurasi di `application/config/config.php` menggunakan `sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'ci_sessions'`.
6. [x] **Generate and set an encryption key**
   - `$config['encryption_key']` (32 karakter) sudah diisi di `application/config/config.php`. *(Catatan: ganti dengan key baru untuk lingkungan produksi.)*
7. [x] **Fix PDF generator library path & API**
   - `application/libraries/Pdfgenerator.php` disesuaikan ke `APPPATH . 'third_party/dompdf/dompdf_config.inc.php'` menggunakan class `DOMPDF`.
8. [x] **Remove unused `log_helper`**
   - Entri `'log'` dihapus dari `$autoload['helper']` di `application/config/autoload.php`.
9. [x] **Verify web server configuration**
   - VirtualHost ditambahkan di `D:\xampp\apache\conf\extra\httpd-vhosts.conf` (`DocumentRoot` ke `D:/Project/git/Aplikasi-Smart-School`, `AllowOverride All`, `mod_rewrite` aktif) dan `httpd.exe -t` valid (`Syntax OK`).
10. [ ] **Test the application**
    - Jalankan Apache & MySQL via `D:\xampp\xampp-control.exe`, buka `http://localhost` di browser, uji login (`admin` / `admin`), cetak PDF, dan export Excel.
11. [x] **Convert tables to InnoDB & add indexes**
    - `db/migrations/001_convert_to_innodb.sql` sudah dijalankan ke database `elearning`; seluruh 12 tabel kini bertipe `InnoDB`.

## Notes
- Untuk menjalankan server secara mandiri di browser, buka `D:\xampp\xampp-control.exe` lalu klik **Start** pada **Apache** dan **MySQL**.
- Dokumentasi pendukung tersedia di `docs/Database_ERD.md` dan `readme.md`.
