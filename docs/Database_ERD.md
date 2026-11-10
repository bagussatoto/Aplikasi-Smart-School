# Database ERD for **Aplikasi Smart School**

> This document provides a concise Entity‑Relationship Diagram (ERD) and a textual description of each table in the `elearning` database.  It is written in Markdown with a Mermaid diagram so it can be rendered directly in supported editors (e.g., VS Code with Mermaid preview, Antigravity UI).

---

## Mermaid ER Diagram

```mermaid
erDiagram
    GURU {
        int id_guru PK
        varchar nip
        enum jeniskelamin
        varchar nama_guru
        varchar foto_guru
        varchar username
        varchar password
        varchar role
        varchar kelasmengajar
        varchar kelasmengajar2
        varchar kelasmengajar3
        varchar namamapel
    }
    KELAS {
        int id_kelas PK
        varchar nama_kelas
    }
    KEHADIRAN_GURU {
        int id_kehadiran PK
        varchar nama_guru
        varchar id_user
        varchar tanggalpresensi
        varchar stempel_presensi
        varchar out_presensi
        varchar jenis_presensi
        varchar status_presensi
        varchar waktu_presensi
    }
    KEHADIRAN_SISWA {
        int id_kehadiran PK
        varchar nama_siswa
        varchar id_user
        varchar tanggalpresensi
        varchar stempel_presensi
        varchar out_presensi
        varchar jenis_presensi
        varchar status_presensi
        varchar waktu_presensi
        varchar kelas
        varchar nomorabsen
    }
    KASUS {
        int id_kasus PK
        varchar nama_kasus
        varchar poin
        varchar siswa_id FK
    }
    LOG_LOGIN {
        int id PK
        varchar username
        varchar ipaddress
        varchar hak_akses
        timestamp tanggal
    }
    PENDAFTAR {
        int id_pendaftar PK
        varchar nis
        varchar nik
        varchar nisn
        varchar noinduk
        varchar nokk
        varchar nama_lengkap
        varchar tempatlahir
        varchar tanggallahir
        varchar jeniskelamin
        varchar agama
        varchar hobi
        varchar citacita
        varchar anakke
        varchar jumlahsaudara
        varchar jarakkesekolah
        varchar transportasi
        varchar kewarganegaraan
        varchar siswa_alamat
        varchar siswa_nohp
        varchar siswa_desakel
        varchar siswa_kecamatan
        varchar siswa_kabupaten
        varchar siswa_provinsi
        varchar siswa_kodepos
        varchar siswa_tinggal
        varchar siswa_kelas
        varchar siswa_nomorabsen
        varchar asal_sekolah
        varchar asal_noskhu
        varchar asal_noijazah
        varchar asal_nilaiun
        varchar asal_tanggal
        varchar asal_lamapendidikan
        ... (many additional columns omitted for brevity)
    }

    GURU ||--o{ KEHADIRAN_GURU : "records"
    KELAS ||--o{ KEHADIRAN_SISWA : "attendance"
    PENDAFTAR ||--o{ KEHADIRAN_SISWA : "student attendance"
    PENDAFTAR ||--o{ KASUS : "has cases"
    GURU ||--|| KELAS : "teaches"
    GURU ||--|| LOG_LOGIN : "login activity"
```
```

---

## Table Overview

| Table | Primary Key | Description |
|-------|-------------|-------------|
| **guru** | `id_guru` | Stores teacher data (NIP, name, credentials, assigned classes, subject). |
| **kelas** | `id_kelas` | List of classes (e.g., `7A`, `8B`). |
| **kehadiranguru** | `id_kehadiran` | Attendance records for teachers. Linked to `guru` via `nama_guru` (or `id_user`). |
| **kehadiransiswa** | `id_kehadiran` | Attendance records for students. Links to `pendaftar` (student) via `id_user` / `kelas` / `nomorabsen`. |
| **kasus** | `id_kasus` | Disciplinary cases. The column `siswa_id` references a student in `pendaftar`. |
| **log_login** | `id` | Audit log of login attempts, storing username, IP, role, and timestamp. |
| **pendaftar** | `id_pendaftar` | Core student profile (personal data, parental information, school history, etc.). |

---

## Relationship Notes

- **Teacher ↔ Attendance** – `kehadiranguru.id_user` (or `nama_guru`) references a teacher in `guru`. No explicit foreign‑key is defined in the dump, but the naming convention indicates this relationship.
- **Class ↔ Student Attendance** – `kehadiransiswa.kelas` corresponds to `kelas.nama_kelas`. The `nomorabsen` together with `kelas` uniquely identifies a student for a given day.
- **Student ↔ Cases** – `kasus.siswa_id` points to `pendaftar.id_pendaftar` (the student who committed the infraction).
- **Student ↔ Attendance** – `kehadiransiswa.id_user` stores the same identifier used for the student (usually the `id_pendaftar`).
- **Teacher ↔ Login Log** – `log_login.username` matches `guru.username` (or admin accounts). This helps trace who logged in.

> **Important:** The original SQL uses `MyISAM` for many tables, which does **not** enforce foreign‑key constraints. The diagram above reflects the **logical** relationships inferred from column names and typical application design.

---

## How to Visualise

If you open this file in a Markdown viewer that supports Mermaid (e.g., VS Code with the *Markdown Preview Enhanced* extension or Antigravity’s built‑in viewer), the diagram will render automatically. You can also copy the `erDiagram` block into any online Mermaid live editor to explore the layout.

---

*Generated by Antigravity – your AI coding assistant.*

