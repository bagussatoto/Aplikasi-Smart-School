# Aplikasi Smart School

Sistem Informasi Manajemen Sekolah berbasis web yang dibangun menggunakan **CodeIgniter 3** (PHP & MySQL) untuk mengelola administrasi akademik, buku induk, presensi, bimbingan konseling (BK), dan e-raport secara terpadu.

<p align="center">
  <img src="https://user-images.githubusercontent.com/28720491/127005728-c0211ba0-0648-4fd6-94b7-2bd49aafe2e0.png" alt="Preview Aplikasi Smart School" width="640" />
</p>

---

## Fitur Utama

- **Multi-Level User** — Dukungan hak akses terpisah untuk Admin, Guru, Bimbingan Konseling (BK), dan Siswa/Pengguna.
- **Kelembagaan & Master Data** — Pengelolaan data pokok sekolah, guru, siswa, dan kelas.
- **Buku Induk Siswa** — Pencatatan dan pengelolaan data induk siswa terpusat.
- **Presensi Guru & Siswa** — Pencatatan kehadiran harian untuk guru dan peserta didik.
- **Manajemen BK** — Pencatatan kasus dan pelanggaran siswa.
- **E-Raport** — Pengelolaan laporan hasil belajar siswa.
- **Import / Export & Cetak Dokumen** — Dukungan import/export format Excel (`PHPExcel`) serta pembuatan laporan PDF (`DOMPDF`, `TCPDF`, `FPDF`).

---

## Kebutuhan Sistem

| Komponen | Spesifikasi |
| :--- | :--- |
| **PHP** | **PHP 5.6** (wajib sesuai target enkripsi ionCube pada controller) |
| **Ekstensi PHP** | `ionCube Loader` (VC11 x86-64 untuk Windows), `mysqli`, `mbstring`, `gd`, `openssl` |
| **Database** | MySQL / MariaDB |
| **Web Server** | Apache (dengan `mod_rewrite` aktif) atau web server lain yang mendukung URL rewrite |

> **Catatan:** Sebagian besar file controller di `application/controllers/` terproteksi menggunakan **ionCube Encoder** (target PHP 5.6), sehingga ekstensi **ionCube Loader** harus aktif agar aplikasi dapat dijalankan.

---

## Panduan Instalasi

1. **Salin atau clone repositori** ke direktori web server (misalnya `htdocs/` atau `public_html/`):
   ```bash
   git clone https://github.com/bagussatoto/Aplikasi-Smart-School.git
   ```
2. **Buat database & import skema**:
   - Buat database baru bernama `elearning` di MySQL/MariaDB.
   - Import file dump SQL dari `db/bukuinduk.sql`:
     ```bash
     mysql -u root -p elearning < db/bukuinduk.sql
     ```
3. **Konfigurasi koneksi database**:
   - Buka `application/config/database.php` dan sesuaikan `hostname`, `username`, `password`, serta `database` (`elearning`).
4. **Verifikasi konfigurasi aplikasi**:
   - Periksa `application/config/config.php` (`base_url`, `encryption_key`, dan `sess_save_path`).
   - Pastikan Apache `mod_rewrite` aktif agar routing di `.htaccess` berjalan tanpa `index.php`.
5. **Jalankan di browser**:
   - Akses URL aplikasi melalui browser (default controller: `beranda`).

---

## Struktur Direktori Ringkas

```text
Aplikasi-Smart-School/
├── application/
│   ├── config/          # Konfigurasi aplikasi, database, autoload, dan routing
│   ├── controllers/     # Controller per peran (admin, bk, guru, pengguna, user)
│   ├── libraries/       # Wrapper library (Pdfgenerator, Dompdf_gen, Tcpdf_gen, Excel)
│   ├── models/          # Model akses database
│   ├── third_party/     # Library pihak ketiga (dompdf, tcpdf, fpdf, PHPExcel)
│   └── views/           # Template tampilan HTML/PHP
├── db/
│   └── bukuinduk.sql    # Dump skema dan data awal database elearning
├── docs/
│   ├── Database_ERD.md  # Diagram ERD dan ringkasan tabel inti database
│   └── Today_Roadmap.md # Roadmap setup lingkungan dan perbaikan konfigurasi
├── git-hooks/           # Template Git post-commit hook
├── scripts/             # Utilitas otomasi (auto_push.ps1)
├── system/              # Core framework CodeIgniter 3
├── .htaccess            # Aturan URL rewrite Apache
└── index.php            # Entry point aplikasi
```

---

## Dokumentasi Terkait

- [Database ERD](docs/Database_ERD.md) — Relasi logis tabel inti pada database `elearning`.
- [Roadmap Setup & Perbaikan](docs/Today_Roadmap.md) — Langkah instalasi lokal dan daftar perbaikan konfigurasi.

---

## Lisensi

Proyek ini dibangun di atas framework CodeIgniter 3 yang menggunakan **MIT License**. Lihat [license.txt](license.txt) untuk detail lengkap.
