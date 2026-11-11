# Today's Roadmap for Aplikasi Smart School

## Objective
Set up the development environment and resolve critical configuration issues so the application can run locally today.

## Status Summary
- **Code & Configuration Fixes (Steps 5–8):** Selesai diterapkan di repositori.
- **Database Migration Script (Step 11):** Skrip SQL sudah disiapkan di `db/migrations/001_convert_to_innodb.sql` (siap dijalankan setelah database `elearning` di-import).
- **Environment Setup & Testing (Steps 1–4, 9–10):** Menunggu instalasi PHP 5.6 + ionCube Loader + MySQL + Apache (mis. via XAMPP Portable PHP 5.6 atau hosting).

## Tasks (in order)
1. [ ] **Install PHP 5.6**
   - Gunakan XAMPP/Laragon versi PHP 5.6 atau Chocolatey (`choco install php --version=5.6.40`).
   - Verifikasi dengan `php -v`.
2. [ ] **Install ionCube Loader for PHP 5.6**
   - Download loader Windows VC11 yang sesuai (mis. `ioncube_loader_win_5.6.dll`) dari situs resmi ionCube.
   - Tambahkan `zend_extension` ke `php.ini` dan restart web server.
3. [ ] **Install MySQL/MariaDB & Import Database**
   - Buat database `elearning`.
   - Import dump awal: `mysql -u root -p elearning < db/bukuinduk.sql`.
4. [ ] **Enable required PHP extensions**
   - Pastikan `mysqli`, `mbstring`, `gd`, `openssl` aktif di `php.ini`.
5. [x] **Set a writable session directory**
   - Dikonfigurasi di `application/config/config.php` menggunakan `sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'ci_sessions'` agar otomatis valid dan portabel di Windows maupun Linux.
6. [x] **Generate and set an encryption key**
   - `$config['encryption_key']` (32 karakter) sudah diisi di `application/config/config.php`. *(Catatan: ganti dengan key baru untuk lingkungan produksi.)*
7. [x] **Fix PDF generator library path & API**
   - `application/libraries/Pdfgenerator.php` sudah disesuaikan ke `APPPATH . 'third_party/dompdf/dompdf_config.inc.php'` menggunakan class `DOMPDF` (`load_html`, `set_paper`, `render`, `stream`, `output`) dan `DOMPDF_ENABLE_REMOTE`.
8. [x] **Remove unused `log_helper`**
   - Entri `'log'` sudah dihapus dari `$autoload['helper']` di `application/config/autoload.php` (karena `application/helpers/log_helper.php` kosong 0 byte).
9. [ ] **Verify web server configuration**
   - Pastikan Apache/IIS berjalan dengan URL-Rewrite (`mod_rewrite`) aktif untuk `.htaccess`.
   - Pastikan aplikasi dapat diakses tanpa error 500.
10. [ ] **Test the application**
    - Buka halaman utama di browser.
    - Uji login dan fitur utama (termasuk cetak PDF / export Excel).
11. [x] **Prepare InnoDB migration script (`db/migrations/001_convert_to_innodb.sql`)**
    - Skrip konversi 7 tabel MyISAM ke InnoDB + penambahan index sudah dibuat; eksekusi ke MySQL dilakukan setelah Step 3 selesai.

## Notes
- Controller aplikasi terenkripsi **ionCube** (target PHP 5.6), sehingga **PHP 5.6 + ionCube Loader** wajib tersedia agar aplikasi bisa dijalankan.
- Dokumentasi pendukung tersedia di `docs/Database_ERD.md` dan `readme.md`.
