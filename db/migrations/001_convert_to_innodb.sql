-- ============================================================================
-- Migration: 001_convert_to_innodb.sql
-- Database : elearning (Aplikasi Smart School)
-- Purpose  : Mengonversi seluruh tabel MyISAM ke InnoDB serta menambahkan
--            index pada kolom relasi & pencarian utama tanpa merusak data
--            existing atau controller yang terenkripsi ionCube.
-- ============================================================================

-- Pastikan dijalankan pada database yang sesuai:
-- USE elearning;

-- ----------------------------------------------------------------------------
-- 1. Konversi Engine MyISAM -> InnoDB (7 tabel)
--    (5 tabel lain: kehadiranguru, kehadiransiswa, kelas, rapor1, rapormapel
--     sudah menggunakan InnoDB di db/bukuinduk.sql)
-- ----------------------------------------------------------------------------
ALTER TABLE `guru` ENGINE=InnoDB;
ALTER TABLE `kasus` ENGINE=InnoDB;
ALTER TABLE `log_login` ENGINE=InnoDB;
ALTER TABLE `pendaftar` ENGINE=InnoDB;
ALTER TABLE `profil` ENGINE=InnoDB;
ALTER TABLE `surat` ENGINE=InnoDB;
ALTER TABLE `tbl_users` ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 2. Penambahan Index untuk Performa Query & Persiapan Relasi
--    Catatan: Gunakan sekali setelah import db/bukuinduk.sql.
-- ----------------------------------------------------------------------------
ALTER TABLE `guru`
  ADD INDEX `idx_guru_username` (`username`),
  ADD INDEX `idx_guru_nip` (`nip`);

ALTER TABLE `pendaftar`
  ADD INDEX `idx_pendaftar_nis` (`nis`),
  ADD INDEX `idx_pendaftar_nisn` (`nisn`),
  ADD INDEX `idx_pendaftar_username` (`username`),
  ADD INDEX `idx_pendaftar_kelas` (`siswa_kelas`);

ALTER TABLE `kasus`
  ADD INDEX `idx_kasus_siswa_id` (`siswa_id`);

ALTER TABLE `kehadiranguru`
  ADD INDEX `idx_kehadiranguru_user` (`id_user`),
  ADD INDEX `idx_kehadiranguru_tanggal` (`tanggalpresensi`);

ALTER TABLE `kehadiransiswa`
  ADD INDEX `idx_kehadiransiswa_user` (`id_user`),
  ADD INDEX `idx_kehadiransiswa_kelas` (`kelas`),
  ADD INDEX `idx_kehadiransiswa_tanggal` (`tanggalpresensi`);

ALTER TABLE `kelas`
  ADD INDEX `idx_kelas_nama` (`nama_kelas`);

ALTER TABLE `log_login`
  ADD INDEX `idx_log_login_username` (`username`),
  ADD INDEX `idx_log_login_tanggal` (`tanggal`);

ALTER TABLE `rapor1`
  ADD INDEX `idx_rapor1_user` (`id_user`),
  ADD INDEX `idx_rapor1_kelas` (`kelas`),
  ADD INDEX `idx_rapor1_mapel` (`mapel`);

ALTER TABLE `rapormapel`
  ADD INDEX `idx_rapormapel_kode` (`kode_mapel`);

ALTER TABLE `tbl_users`
  ADD INDEX `idx_tbl_users_username` (`username`);

-- ----------------------------------------------------------------------------
-- 3. (Opsional / Manual Review) Pemeriksaan Data Sebelum Foreign Key
--    JANGAN langsung mengaktifkan FOREIGN KEY sebelum memastikan:
--    a) Tidak ada data yatim (orphan rows). Di dump awal db/bukuinduk.sql,
--       contohnya rapor1 memiliki id_user=2 dan 5 yang tidak ada di pendaftar.
--    b) Tipe kolom cocok (mis. kasus.siswa_id dan kehadiransiswa.id_user
--       berbertipe varchar(100), sedangkan pendaftar.id_pendaftar int(16)).
--    c) Controller terenkripsi ionCube tidak mengirim nilai '' atau 0 saat insert.
-- ----------------------------------------------------------------------------

-- Cek orphan rapor1 -> pendaftar:
-- SELECT r.* FROM `rapor1` r
-- LEFT JOIN `pendaftar` p ON r.`id_user` = p.`id_pendaftar`
-- WHERE p.`id_pendaftar` IS NULL;

-- Cek orphan kasus -> pendaftar:
-- SELECT k.* FROM `kasus` k
-- LEFT JOIN `pendaftar` p ON CAST(k.`siswa_id` AS UNSIGNED) = p.`id_pendaftar`
-- WHERE p.`id_pendaftar` IS NULL;

-- Contoh penambahan FK setelah data bersih & tipe kolom disamakan:
-- ALTER TABLE `rapor1`
--   ADD CONSTRAINT `fk_rapor1_pendaftar`
--   FOREIGN KEY (`id_user`) REFERENCES `pendaftar` (`id_pendaftar`)
--   ON UPDATE CASCADE ON DELETE RESTRICT;
