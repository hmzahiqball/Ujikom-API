/*
 Navicat Premium Data Transfer

 Source Server         : putra
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3307
 Source Schema         : db_ujikomposs

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 25/07/2025 16:04:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for _prisma_migrations
-- ----------------------------
DROP TABLE IF EXISTS `_prisma_migrations`;
CREATE TABLE `_prisma_migrations`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) NULL DEFAULT NULL,
  `migration_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `rolled_back_at` datetime(3) NULL DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `applied_steps_count` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of _prisma_migrations
-- ----------------------------
INSERT INTO `_prisma_migrations` VALUES ('2c99b6f5-3611-4cb1-a72d-53b97aae70e0', 'dc033de7fd042f8019b97ecbaa7e5bb1585f91bd72fc525dd3caf63d6309d5f0', '2025-07-23 04:18:20.944', '20250723041819_add', NULL, NULL, '2025-07-23 04:18:19.391', 1);

-- ----------------------------
-- Table structure for tb_customers
-- ----------------------------
DROP TABLE IF EXISTS `tb_customers`;
CREATE TABLE `tb_customers`  (
  `id_customers` int NOT NULL AUTO_INCREMENT,
  `nama_customers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telp_customers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email_customers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `alamat_customers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `tglLahir_customers` date NULL DEFAULT NULL,
  `gender_customers` enum('Laki-Laki','Perempuan') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status_customers` enum('aktif','non-aktif') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_customers`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_customers
-- ----------------------------
INSERT INTO `tb_customers` VALUES (1, 'Non-Member', '0', '-', '-', '0001-01-01', 'Laki-Laki', 'aktif', '2025-07-23 06:43:45', '2025-07-23 06:43:45', 0, NULL, NULL);
INSERT INTO `tb_customers` VALUES (2, 'Nama Member', '087862384685', 'member@gmail.com', 'Jl, Mawar no 123', '2004-05-12', 'Laki-Laki', 'aktif', '2025-07-25 09:47:05', '2025-07-25 09:47:05', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_detail_pembelian
-- ----------------------------
DROP TABLE IF EXISTS `tb_detail_pembelian`;
CREATE TABLE `tb_detail_pembelian`  (
  `id_detail_pembelian` int NOT NULL AUTO_INCREMENT,
  `id_pembelian` int NULL DEFAULT NULL,
  `id_produk` int NULL DEFAULT NULL,
  `kuantitas` int NULL DEFAULT NULL,
  `harga` decimal(15, 0) NULL DEFAULT NULL,
  `subtotal` decimal(15, 0) NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_detail_pembelian`) USING BTREE,
  INDEX `FK-detailPemToProduk`(`id_produk` ASC) USING BTREE,
  INDEX `FK-detailToPembelian`(`id_pembelian` ASC) USING BTREE,
  CONSTRAINT `FK-detailPemToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk` (`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-detailToPembelian` FOREIGN KEY (`id_pembelian`) REFERENCES `tb_pembelian` (`id_pembelian`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_detail_pembelian
-- ----------------------------

-- ----------------------------
-- Table structure for tb_detail_penjualan
-- ----------------------------
DROP TABLE IF EXISTS `tb_detail_penjualan`;
CREATE TABLE `tb_detail_penjualan`  (
  `id_detail_penjualan` int NOT NULL AUTO_INCREMENT,
  `id_penjualan` int NULL DEFAULT NULL,
  `id_produk` int NULL DEFAULT NULL,
  `kuantitas` int NULL DEFAULT NULL,
  `harga` decimal(15, 0) NULL DEFAULT NULL,
  `subtotal` decimal(15, 0) NULL DEFAULT NULL,
  `diskon_produk` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_detail_penjualan`) USING BTREE,
  INDEX `FK-detailToPenjualan`(`id_penjualan` ASC) USING BTREE,
  INDEX `FK-detailToProduk`(`id_produk` ASC) USING BTREE,
  CONSTRAINT `FK-detailToPenjualan` FOREIGN KEY (`id_penjualan`) REFERENCES `tb_penjualan` (`id_penjualan`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK-detailToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk` (`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_detail_penjualan
-- ----------------------------

-- ----------------------------
-- Table structure for tb_izin_karyawan
-- ----------------------------
DROP TABLE IF EXISTS `tb_izin_karyawan`;
CREATE TABLE `tb_izin_karyawan`  (
  `id_izin` int NOT NULL AUTO_INCREMENT,
  `id_karyawan` int NULL DEFAULT NULL,
  `id_jenis_izin` int NULL DEFAULT NULL,
  `start_date` date NULL DEFAULT NULL,
  `end_date` date NULL DEFAULT NULL,
  `status` enum('Approved','Pending','Rejected','Canceled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_izin`) USING BTREE,
  INDEX `FK-izinToJenisIzin`(`id_jenis_izin` ASC) USING BTREE,
  INDEX `FK-izinTokaryawan`(`id_karyawan` ASC) USING BTREE,
  CONSTRAINT `FK-izinToJenisIzin` FOREIGN KEY (`id_jenis_izin`) REFERENCES `tb_kategori_izin` (`id_kategori_izin`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-izinTokaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan` (`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_izin_karyawan
-- ----------------------------

-- ----------------------------
-- Table structure for tb_karyawan
-- ----------------------------
DROP TABLE IF EXISTS `tb_karyawan`;
CREATE TABLE `tb_karyawan`  (
  `id_karyawan` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `posisi_karyawan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `gaji_karyawan` int NULL DEFAULT NULL,
  `alamat_karyawan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `id_shifts` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_karyawan`) USING BTREE,
  INDEX `FK-karyawanToshifts`(`id_shifts` ASC) USING BTREE,
  INDEX `FK-karyawanTousers`(`id_user` ASC) USING BTREE,
  CONSTRAINT `FK-karyawanToshifts` FOREIGN KEY (`id_shifts`) REFERENCES `tb_shifts` (`id_shifts`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-karyawanTousers` FOREIGN KEY (`id_user`) REFERENCES `tb_users` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_karyawan
-- ----------------------------
INSERT INTO `tb_karyawan` VALUES (1, 1, 'Barista', 5000000, 'Jl. Mawar No. 123', 1, '2025-07-23 06:43:45', '2025-07-23 06:43:45', 0, NULL, NULL);
INSERT INTO `tb_karyawan` VALUES (2, 2, 'Admin', 8000000, 'Jl. Mawar No. 123', 1, '2025-07-23 06:43:45', '2025-07-23 06:43:45', 0, NULL, NULL);
INSERT INTO `tb_karyawan` VALUES (3, 3, 'Barista', 3200000, 'Jl. Mawar no. 123', 2, '2025-07-23 13:46:33', '2025-07-23 13:46:33', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_kategori
-- ----------------------------
DROP TABLE IF EXISTS `tb_kategori`;
CREATE TABLE `tb_kategori`  (
  `id_kategori` int NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_kategori`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_kategori
-- ----------------------------

-- ----------------------------
-- Table structure for tb_kategori_izin
-- ----------------------------
DROP TABLE IF EXISTS `tb_kategori_izin`;
CREATE TABLE `tb_kategori_izin`  (
  `id_kategori_izin` int NOT NULL AUTO_INCREMENT,
  `nama_kategori_izin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_kategori_izin`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_kategori_izin
-- ----------------------------

-- ----------------------------
-- Table structure for tb_kategori_pengeluaran
-- ----------------------------
DROP TABLE IF EXISTS `tb_kategori_pengeluaran`;
CREATE TABLE `tb_kategori_pengeluaran`  (
  `id_kategori_pengeluaran` int NOT NULL AUTO_INCREMENT,
  `kode_kategori_pengeluaran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nama_kategori_pengeluaran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_kategori_pengeluaran`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_kategori_pengeluaran
-- ----------------------------

-- ----------------------------
-- Table structure for tb_kehadiran
-- ----------------------------
DROP TABLE IF EXISTS `tb_kehadiran`;
CREATE TABLE `tb_kehadiran`  (
  `id_kehadiran` int NOT NULL AUTO_INCREMENT,
  `id_karyawan` int NULL DEFAULT NULL,
  `tanggal_kehadiran` date NULL DEFAULT NULL,
  `clock_in` time NULL DEFAULT NULL,
  `clock_out` time NULL DEFAULT NULL,
  `total_jam_kerja` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `total_overtime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_kehadiran`) USING BTREE,
  INDEX `FK-kehadiranTokaryawan`(`id_karyawan` ASC) USING BTREE,
  CONSTRAINT `FK-kehadiranTokaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan` (`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_kehadiran
-- ----------------------------

-- ----------------------------
-- Table structure for tb_pembelian
-- ----------------------------
DROP TABLE IF EXISTS `tb_pembelian`;
CREATE TABLE `tb_pembelian`  (
  `id_pembelian` int NOT NULL AUTO_INCREMENT,
  `id_suppliers` int NULL DEFAULT NULL,
  `kode_pembelian` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `total_harga` decimal(15, 0) NULL DEFAULT NULL,
  `tanggal_pembelian` datetime NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_pembelian`) USING BTREE,
  INDEX `FK-pembelianToSuppliers`(`id_suppliers` ASC) USING BTREE,
  CONSTRAINT `FK-pembelianToSuppliers` FOREIGN KEY (`id_suppliers`) REFERENCES `tb_suppliers` (`id_suppliers`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_pembelian
-- ----------------------------

-- ----------------------------
-- Table structure for tb_pengeluaran
-- ----------------------------
DROP TABLE IF EXISTS `tb_pengeluaran`;
CREATE TABLE `tb_pengeluaran`  (
  `id_pengeluaran` int NOT NULL AUTO_INCREMENT,
  `id_kategori_pengeluaran` int NULL DEFAULT NULL,
  `kode_pengeluaran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `total_pengeluaran` decimal(15, 0) NULL DEFAULT NULL,
  `deskripsi_pengeluaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `tanggal` datetime NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_pengeluaran`) USING BTREE,
  INDEX `FK-pengeluaranToKategori`(`id_kategori_pengeluaran` ASC) USING BTREE,
  CONSTRAINT `FK-pengeluaranToKategori` FOREIGN KEY (`id_kategori_pengeluaran`) REFERENCES `tb_kategori_pengeluaran` (`id_kategori_pengeluaran`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_pengeluaran
-- ----------------------------

-- ----------------------------
-- Table structure for tb_penjualan
-- ----------------------------
DROP TABLE IF EXISTS `tb_penjualan`;
CREATE TABLE `tb_penjualan`  (
  `id_penjualan` int NOT NULL AUTO_INCREMENT,
  `id_customers` int NULL DEFAULT NULL,
  `id_karyawan` int NULL DEFAULT NULL,
  `id_promo` int NULL DEFAULT NULL,
  `kode_penjualan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `persen_pajak` int NULL DEFAULT NULL,
  `total_pajak` decimal(20, 0) NULL DEFAULT NULL,
  `total_harga` decimal(20, 0) NULL DEFAULT NULL,
  `total_bayar` decimal(20, 0) NULL DEFAULT NULL,
  `total_kembalian` decimal(20, 0) NULL DEFAULT NULL,
  `diskon_penjualan` int NULL DEFAULT NULL,
  `tipe_pembayaran` enum('Tunai','Kartu','QRIS','Lainnya') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status_pembayaran` enum('Success','Pending','Canceled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tanggal_penjualan` datetime NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_penjualan`) USING BTREE,
  INDEX `FK-penjualanToCustomers`(`id_customers` ASC) USING BTREE,
  INDEX `FK-penjualanToKaryawan`(`id_karyawan` ASC) USING BTREE,
  CONSTRAINT `FK-penjualanToCustomers` FOREIGN KEY (`id_customers`) REFERENCES `tb_customers` (`id_customers`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-penjualanToKaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan` (`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_penjualan
-- ----------------------------

-- ----------------------------
-- Table structure for tb_produk
-- ----------------------------
DROP TABLE IF EXISTS `tb_produk`;
CREATE TABLE `tb_produk`  (
  `id_produk` int NOT NULL AUTO_INCREMENT,
  `id_kategori` int NULL DEFAULT NULL,
  `nama_produk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sku_produk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `barcode_produk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `deskripsi_produk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `harga_produk` decimal(15, 0) NULL DEFAULT NULL,
  `modal_produk` decimal(15, 0) NULL DEFAULT NULL,
  `diskon_produk` int NULL DEFAULT NULL,
  `stok_produk` int NULL DEFAULT NULL,
  `stok_minimum_produk` int NULL DEFAULT NULL,
  `status_produk` enum('Available','Kosong') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `gambar_produk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_produk`) USING BTREE,
  INDEX `FK-produkToSubKategori`(`id_kategori` ASC) USING BTREE,
  CONSTRAINT `FK-produkToSubKategori` FOREIGN KEY (`id_kategori`) REFERENCES `tb_subkategori` (`id_subkategori`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_produk
-- ----------------------------

-- ----------------------------
-- Table structure for tb_promo
-- ----------------------------
DROP TABLE IF EXISTS `tb_promo`;
CREATE TABLE `tb_promo`  (
  `id_promo` int NOT NULL AUTO_INCREMENT,
  `nama_promo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `kode_promo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tipe_promo` enum('persen','nominal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `total_promo` bigint NULL DEFAULT NULL,
  `kuota_promo` int NULL DEFAULT NULL,
  `tanggal_mulai` date NULL DEFAULT NULL,
  `tanggal_akhir` date NULL DEFAULT NULL,
  `min_belanja` bigint NULL DEFAULT NULL,
  `status_promo` enum('aktif','nonaktif') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_promo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_promo
-- ----------------------------
INSERT INTO `tb_promo` VALUES (1, 'Promo Soft Opening', 'SOFTOPENING2025', 'nominal', 50000, 91, '2025-07-19', '2025-07-26', 10000, 'aktif', '2025-07-21 08:17:29', '2025-07-23 15:12:36');
INSERT INTO `tb_promo` VALUES (2, 'Promo Soft Opening', 'SOFTOPENING202520PERSEN', 'persen', 20, 50, '2025-07-21', '2025-07-27', 50000, 'aktif', '2025-07-21 08:20:17', '2025-07-21 08:20:17');
INSERT INTO `tb_promo` VALUES (3, 'Potongan 10 Ribu', 'POTONG10K', 'nominal', 10000, 1000, '2025-07-21', '2025-07-27', 0, 'nonaktif', '2025-07-23 15:17:57', '2025-07-23 15:32:11');

-- ----------------------------
-- Table structure for tb_settings
-- ----------------------------
DROP TABLE IF EXISTS `tb_settings`;
CREATE TABLE `tb_settings`  (
  `id_settings` int NOT NULL AUTO_INCREMENT,
  `key_settings` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_settings`) USING BTREE,
  UNIQUE INDEX `key_settings`(`key_settings` ASC) USING BTREE,
  UNIQUE INDEX `key_settings_2`(`key_settings` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_settings
-- ----------------------------
INSERT INTO `tb_settings` VALUES (2, 'tax', '11');

-- ----------------------------
-- Table structure for tb_shifts
-- ----------------------------
DROP TABLE IF EXISTS `tb_shifts`;
CREATE TABLE `tb_shifts`  (
  `id_shifts` int NOT NULL AUTO_INCREMENT,
  `nama_shifts` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `start_time` time NULL DEFAULT NULL,
  `end_time` time NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_shifts`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_shifts
-- ----------------------------
INSERT INTO `tb_shifts` VALUES (1, 'Full Time Shift', '08:00:00', '16:00:00', '2025-07-23 06:43:45', '2025-07-23 06:43:45', 0, NULL, NULL);
INSERT INTO `tb_shifts` VALUES (2, 'Shift Pagi', '08:00:00', '12:00:00', '2025-07-23 13:45:08', '2025-07-23 13:45:08', 0, NULL, NULL);
INSERT INTO `tb_shifts` VALUES (3, 'Shift Siang', '13:00:00', '16:00:00', '2025-07-23 13:45:25', '2025-07-23 13:45:25', 1, '2025-07-23 15:27:41', NULL);
INSERT INTO `tb_shifts` VALUES (4, 'Shift Sore', '16:00:00', '22:00:00', '2025-07-23 13:45:37', '2025-07-23 13:45:37', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_stok_produk
-- ----------------------------
DROP TABLE IF EXISTS `tb_stok_produk`;
CREATE TABLE `tb_stok_produk`  (
  `id_laporan_stok` int NOT NULL AUTO_INCREMENT,
  `kode_laporan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_produk` int NULL DEFAULT NULL,
  `perubahan_stok` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `alasan_perubahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nama_karyawan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_laporan_stok`) USING BTREE,
  INDEX `FK-stokToProduk`(`id_produk` ASC) USING BTREE,
  INDEX `FK-stokToUsers`(`nama_karyawan` ASC) USING BTREE,
  CONSTRAINT `FK-stokToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk` (`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_stok_produk
-- ----------------------------

-- ----------------------------
-- Table structure for tb_subkategori
-- ----------------------------
DROP TABLE IF EXISTS `tb_subkategori`;
CREATE TABLE `tb_subkategori`  (
  `id_subkategori` int NOT NULL AUTO_INCREMENT,
  `id_kategori` int NULL DEFAULT NULL,
  `nama_subkategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_subkategori`) USING BTREE,
  INDEX `FK-SubtoKategori`(`id_kategori` ASC) USING BTREE,
  CONSTRAINT `FK-SubtoKategori` FOREIGN KEY (`id_kategori`) REFERENCES `tb_kategori` (`id_kategori`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_subkategori
-- ----------------------------

-- ----------------------------
-- Table structure for tb_suppliers
-- ----------------------------
DROP TABLE IF EXISTS `tb_suppliers`;
CREATE TABLE `tb_suppliers`  (
  `id_suppliers` int NOT NULL AUTO_INCREMENT,
  `kode_suppliers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nama_suppliers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `contact_person` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `contact_suppliers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email_suppliers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `alamat_suppliers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_suppliers`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_suppliers
-- ----------------------------

-- ----------------------------
-- Table structure for tb_users
-- ----------------------------
DROP TABLE IF EXISTS `tb_users`;
CREATE TABLE `tb_users`  (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `kode_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nama_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `contact_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `role_user` enum('admin','kasir') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status_user` enum('aktif','non-aktif') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `gambar_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_user`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_users
-- ----------------------------
INSERT INTO `tb_users` VALUES (1, 'NMKSR', 'Nama Kasir', '$2b$10$caX12QUpKy6KtI2LaAuo2OlPhRs8C8LwgcIBHMnp7gnwtMW65Hl4m', '081234567890', 'kasir', 'aktif', '1745200384655.jpg', '2025-07-23 06:43:45', '2025-07-23 06:43:45', 0, NULL, NULL);
INSERT INTO `tb_users` VALUES (2, 'NMDMN', 'Nama Admin', '$2b$10$/YIR/z0VcIxqg1WXs6J6zuPWJzCoyALDMwDr27GaNVzoU0ejJR0Gm', '081278901234', 'admin', 'aktif', '1745200439821.jpg', '2025-07-23 06:43:45', '2025-07-23 06:43:45', 0, NULL, NULL);
INSERT INTO `tb_users` VALUES (3, 'NMBRST', 'Nama Barista', '$2b$10$ilncwtKZlg14nRsS4/REtepa49bEQe4YuCVcnT4uCVYaR728S9.mG', '081298765432', 'kasir', 'aktif', '1753253193148.jpg', '2025-07-23 13:46:33', '2025-07-23 13:46:33', 0, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
