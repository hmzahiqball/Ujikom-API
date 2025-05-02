/*
 Navicat Premium Data Transfer

 Source Server         : putra
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3307
 Source Schema         : db_ujikompos

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 02/05/2025 15:30:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_customers
-- ----------------------------
DROP TABLE IF EXISTS `tb_customers`;
CREATE TABLE `tb_customers`  (
  `id_customers` int NOT NULL AUTO_INCREMENT,
  `nama_customers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `telp_customers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email_customers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alamat_customers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `tglLahir_customers` date NULL DEFAULT NULL,
  `gender_customers` enum('Laki-Laki','Perempuan') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status_customers` enum('aktif','non-aktif') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_customers`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_customers
-- ----------------------------
INSERT INTO `tb_customers` VALUES (1, 'Non-Member', '0', '-', '-', '0001-01-01', 'Laki-Laki', 'aktif', '2025-04-21 09:10:33', '2025-04-21 09:10:33', 0, NULL, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_detail_pembelian`) USING BTREE,
  INDEX `FK-detailPemToProduk`(`id_produk` ASC) USING BTREE,
  INDEX `FK-detailToPembelian`(`id_pembelian` ASC) USING BTREE,
  CONSTRAINT `FK-detailPemToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk` (`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-detailToPembelian` FOREIGN KEY (`id_pembelian`) REFERENCES `tb_pembelian` (`id_pembelian`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_detail_pembelian
-- ----------------------------
INSERT INTO `tb_detail_pembelian` VALUES (1, 1, 6, 1, 600000, 600000, '2025-05-02 10:38:35', '2025-05-02 10:38:35', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (2, 1, 7, 1, 300000, 300000, '2025-05-02 10:39:03', '2025-05-02 10:39:03', 0, NULL, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_detail_penjualan`) USING BTREE,
  INDEX `FK-detailToProduk`(`id_produk` ASC) USING BTREE,
  INDEX `FK-detailToPenjualan`(`id_penjualan` ASC) USING BTREE,
  CONSTRAINT `FK-detailToPenjualan` FOREIGN KEY (`id_penjualan`) REFERENCES `tb_penjualan` (`id_penjualan`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK-detailToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk` (`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_detail_penjualan
-- ----------------------------
INSERT INTO `tb_detail_penjualan` VALUES (1, 1, 1, 1, 13000000, 13000000, 0, '2025-04-25 15:31:15', '2025-04-25 15:31:15', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (2, 1, 2, 1, 8000000, 8000000, 0, '2025-04-25 15:31:15', '2025-04-25 15:31:15', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (3, 1, 3, 1, 10000000, 10000000, 0, '2025-04-25 15:31:15', '2025-04-25 15:31:15', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (4, 1, 4, 1, 20000000, 20000000, 0, '2025-04-25 15:31:15', '2025-04-25 15:31:15', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (5, 2, 4, 1, 20000000, 20000000, 0, '2025-04-25 15:33:19', '2025-04-25 15:33:19', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (6, 2, 3, 1, 10000000, 10000000, 0, '2025-04-25 15:33:19', '2025-04-25 15:33:19', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (7, 3, 6, 1, 800000, 800000, 0, '2025-04-25 15:35:07', '2025-04-25 15:35:07', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (8, 3, 7, 1, 475000, 475000, 5, '2025-04-25 15:35:07', '2025-04-25 15:35:07', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (9, 3, 5, 1, 600000, 600000, 0, '2025-04-25 15:35:07', '2025-04-25 15:35:07', 0, NULL, NULL);

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
  `status` enum('Approved','Pending','Rejected','Canceled') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_izin`) USING BTREE,
  INDEX `FK-izinTokaryawan`(`id_karyawan` ASC) USING BTREE,
  INDEX `FK-izinToJenisIzin`(`id_jenis_izin` ASC) USING BTREE,
  CONSTRAINT `FK-izinToJenisIzin` FOREIGN KEY (`id_jenis_izin`) REFERENCES `tb_kategori_izin` (`id_kategori_izin`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-izinTokaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan` (`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_izin_karyawan
-- ----------------------------
INSERT INTO `tb_izin_karyawan` VALUES (1, 2, 1, '2025-04-25', '2025-04-26', 'Approved', '2025-04-25 10:36:41', '2025-04-25 13:44:07', 0, NULL, NULL);
INSERT INTO `tb_izin_karyawan` VALUES (2, 1, 2, '2025-04-26', '2025-04-28', 'Canceled', '2025-04-25 14:51:08', '2025-04-25 14:58:54', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_karyawan
-- ----------------------------
DROP TABLE IF EXISTS `tb_karyawan`;
CREATE TABLE `tb_karyawan`  (
  `id_karyawan` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `posisi_karyawan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gaji_karyawan` int NULL DEFAULT NULL,
  `alamat_karyawan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `id_shifts` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_karyawan`) USING BTREE,
  INDEX `FK-karyawanToshifts`(`id_shifts` ASC) USING BTREE,
  INDEX `FK-karyawanTousers`(`id_user` ASC) USING BTREE,
  CONSTRAINT `FK-karyawanToshifts` FOREIGN KEY (`id_shifts`) REFERENCES `tb_shifts` (`id_shifts`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-karyawanTousers` FOREIGN KEY (`id_user`) REFERENCES `tb_users` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_karyawan
-- ----------------------------
INSERT INTO `tb_karyawan` VALUES (1, 1, 'Teknisi', 5000000, 'Jl. Mawar No. 123', 1, '2025-04-21 08:53:04', '2025-04-21 08:53:04', 0, NULL, NULL);
INSERT INTO `tb_karyawan` VALUES (2, 2, 'Owner', 90000000, 'Jl. Mawar No. 124', 1, '2025-04-21 08:53:59', '2025-04-21 08:53:59', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_kategori
-- ----------------------------
DROP TABLE IF EXISTS `tb_kategori`;
CREATE TABLE `tb_kategori`  (
  `id_kategori` int NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_kategori`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_kategori
-- ----------------------------
INSERT INTO `tb_kategori` VALUES (1, 'Elektronik', '2025-04-24 15:02:12', '2025-04-24 15:02:12', 0, NULL, NULL);
INSERT INTO `tb_kategori` VALUES (2, 'Furniture', '2025-04-24 15:02:34', '2025-04-24 15:02:34', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_kategori_izin
-- ----------------------------
DROP TABLE IF EXISTS `tb_kategori_izin`;
CREATE TABLE `tb_kategori_izin`  (
  `id_kategori_izin` int NOT NULL AUTO_INCREMENT,
  `nama_kategori_izin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_kategori_izin`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_kategori_izin
-- ----------------------------
INSERT INTO `tb_kategori_izin` VALUES (1, 'Sakit', '2025-04-25 10:35:49', '2025-04-25 13:31:52', 1, '2025-04-25 13:31:52', NULL);
INSERT INTO `tb_kategori_izin` VALUES (2, 'Izin Urusan Keluarga', '2025-04-25 13:30:58', '2025-04-25 13:30:58', 0, NULL, NULL);
INSERT INTO `tb_kategori_izin` VALUES (3, 'Izin Sakit', '2025-04-25 13:32:03', '2025-04-25 13:32:03', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_kategori_pengeluaran
-- ----------------------------
DROP TABLE IF EXISTS `tb_kategori_pengeluaran`;
CREATE TABLE `tb_kategori_pengeluaran`  (
  `id_kategori_pengeluaran` int NOT NULL AUTO_INCREMENT,
  `nama_kategori_pengeluaran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_kategori_pengeluaran`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
  `total_jam_kerja` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `total_overtime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_kehadiran`) USING BTREE,
  INDEX `FK-kehadiranTokaryawan`(`id_karyawan` ASC) USING BTREE,
  CONSTRAINT `FK-kehadiranTokaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan` (`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_kehadiran
-- ----------------------------
INSERT INTO `tb_kehadiran` VALUES (1, 2, '2025-04-24', '10:09:08', '15:09:06', '5j 00m', '0j 0m', '2025-04-24 10:09:08', '2025-04-24 15:09:51', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (3, 1, '2025-04-24', '15:10:03', '15:17:32', '0j 7m', '0j 0m', '2025-04-24 15:10:03', '2025-04-24 15:17:32', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (6, 2, '2025-04-25', '13:10:58', '14:20:46', '1j 9m', '0j 0m', '2025-04-25 13:10:58', '2025-04-25 14:20:46', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (7, 1, '2025-04-25', '14:20:51', '14:56:13', '0j 35m', '0j 0m', '2025-04-25 14:20:51', '2025-04-25 14:56:13', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (8, 1, '2025-04-25', '14:58:44', '15:02:31', '0j 3m', '0j 0m', '2025-04-25 14:58:44', '2025-04-25 15:02:31', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (9, 2, '2025-04-25', '15:02:36', '15:03:40', '0j 1m', '0j 0m', '2025-04-25 15:02:36', '2025-04-25 15:03:41', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (10, 1, '2025-04-25', '15:06:35', '15:09:12', '0j 2m', '0j 0m', '2025-04-25 15:06:35', '2025-04-25 15:09:12', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (11, 2, '2025-04-25', '15:09:17', '15:30:56', '0j 21m', '0j 0m', '2025-04-25 15:09:17', '2025-04-25 15:30:56', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (12, 1, '2025-04-25', '15:31:01', '15:31:20', '0j 0m', '0j 0m', '2025-04-25 15:31:01', '2025-04-25 15:31:20', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (13, 1, '2025-04-25', '15:31:24', '15:31:40', '0j 0m', '0j 0m', '2025-04-25 15:31:24', '2025-04-25 15:31:40', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (14, 2, '2025-04-25', '15:31:45', '15:33:04', '0j 1m', '0j 0m', '2025-04-25 15:31:45', '2025-04-25 15:33:04', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (15, 1, '2025-04-25', '15:33:09', '15:33:23', '0j 0m', '0j 0m', '2025-04-25 15:33:09', '2025-04-25 15:33:23', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (16, 2, '2025-04-25', '15:33:27', '15:33:37', '0j 0m', '0j 0m', '2025-04-25 15:33:27', '2025-04-25 15:33:37', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (17, 1, '2025-04-25', '15:33:49', '15:35:11', '0j 1m', '0j 0m', '2025-04-25 15:33:49', '2025-04-25 15:35:11', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (18, 2, '2025-04-25', '15:35:16', NULL, NULL, NULL, '2025-04-25 15:35:16', '2025-04-25 15:35:16', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (19, 2, '2025-05-02', '09:01:22', NULL, NULL, NULL, '2025-05-02 09:01:22', '2025-05-02 09:01:22', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (20, 2, '2025-05-02', '13:51:41', NULL, NULL, NULL, '2025-05-02 13:51:41', '2025-05-02 13:51:41', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_pembelian
-- ----------------------------
DROP TABLE IF EXISTS `tb_pembelian`;
CREATE TABLE `tb_pembelian`  (
  `id_pembelian` int NOT NULL AUTO_INCREMENT,
  `id_suppliers` int NULL DEFAULT NULL,
  `kode_pembelian` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `total_harga` decimal(15, 0) NULL DEFAULT NULL,
  `status_pembelian` enum('Success','Pending','Canceled') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tanggal_pembelian` datetime NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_pembelian`) USING BTREE,
  INDEX `FK-pembelianToSuppliers`(`id_suppliers` ASC) USING BTREE,
  CONSTRAINT `FK-pembelianToSuppliers` FOREIGN KEY (`id_suppliers`) REFERENCES `tb_suppliers` (`id_suppliers`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_pembelian
-- ----------------------------
INSERT INTO `tb_pembelian` VALUES (1, 1, 'SPL001-020525', 900000, 'Success', '2025-05-02 10:26:22', '2025-05-02 10:38:08', '2025-05-02 14:50:24', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_pengeluaran
-- ----------------------------
DROP TABLE IF EXISTS `tb_pengeluaran`;
CREATE TABLE `tb_pengeluaran`  (
  `id_pengeluaran` int NOT NULL AUTO_INCREMENT,
  `id_kategori_pengeluaran` int NULL DEFAULT NULL,
  `total_pengeluaran` decimal(15, 0) NULL DEFAULT NULL,
  `deskripsi_pengeluaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `tanggal` date NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_pengeluaran`) USING BTREE,
  INDEX `FK-pengeluaranToKategori`(`id_kategori_pengeluaran` ASC) USING BTREE,
  CONSTRAINT `FK-pengeluaranToKategori` FOREIGN KEY (`id_kategori_pengeluaran`) REFERENCES `tb_kategori_pengeluaran` (`id_kategori_pengeluaran`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
  `kode_penjualan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `total_harga` decimal(20, 0) NULL DEFAULT NULL,
  `total_bayar` decimal(20, 0) NULL DEFAULT NULL,
  `total_kembalian` decimal(20, 0) NULL DEFAULT NULL,
  `diskon_penjualan` int NULL DEFAULT NULL,
  `status_pembayaran` enum('Success','Pending','Canceled') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tanggal_penjualan` datetime NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_penjualan`) USING BTREE,
  INDEX `FK-penjualanToCustomers`(`id_customers` ASC) USING BTREE,
  INDEX `FK-penjualanToKaryawan`(`id_karyawan` ASC) USING BTREE,
  CONSTRAINT `FK-penjualanToCustomers` FOREIGN KEY (`id_customers`) REFERENCES `tb_customers` (`id_customers`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-penjualanToKaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan` (`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_penjualan
-- ----------------------------
INSERT INTO `tb_penjualan` VALUES (1, 1, 1, 'BDSNTS-20250425-0001', 51000000, 51000000, 0, 0, 'Success', '2025-03-14 08:31:15', '2025-04-25 15:31:15', '2025-05-02 09:50:45', 0, NULL, NULL);
INSERT INTO `tb_penjualan` VALUES (2, 1, 1, 'BDSNTS-20250425-0002', 30000000, 30000000, 0, 0, 'Success', '2025-04-25 08:33:19', '2025-04-25 15:33:19', '2025-04-25 15:33:19', 0, NULL, NULL);
INSERT INTO `tb_penjualan` VALUES (3, 1, 1, 'BDSNTS-20250425-0003', 1875000, 1875000, 0, 0, 'Success', '2025-05-02 08:35:07', '2025-04-25 15:35:07', '2025-05-02 09:41:23', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_produk
-- ----------------------------
DROP TABLE IF EXISTS `tb_produk`;
CREATE TABLE `tb_produk`  (
  `id_produk` int NOT NULL AUTO_INCREMENT,
  `id_kategori` int NULL DEFAULT NULL,
  `nama_produk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sku_produk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `barcode_produk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `deskripsi_produk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `harga_produk` decimal(15, 0) NULL DEFAULT NULL,
  `modal_produk` decimal(15, 0) NULL DEFAULT NULL,
  `diskon_produk` int NULL DEFAULT NULL,
  `stok_produk` int NULL DEFAULT NULL,
  `stok_minimum_produk` int NULL DEFAULT NULL,
  `status_produk` enum('Available','Kosong') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gambar_produk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_produk`) USING BTREE,
  INDEX `FK-produkToSubKategori`(`id_kategori` ASC) USING BTREE,
  CONSTRAINT `FK-produkToSubKategori` FOREIGN KEY (`id_kategori`) REFERENCES `tb_subkategori` (`id_subkategori`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_produk
-- ----------------------------
INSERT INTO `tb_produk` VALUES (1, 2, 'Laptop A', '001002LPTP', 'KAT001002LPTP877', 'Laptop Keren', 13000000, 10000000, 0, 9, 5, 'Available', '1745481861800.jpg', '2025-04-24 15:04:21', '2025-04-25 15:31:15', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (2, 1, 'Handphone A', '001001HNDPHN', 'KAT001001HNDPHN740', 'Handphone Keren', 8000000, 6000000, 0, 9, 5, 'Available', '1745481904587.png', '2025-04-24 15:05:04', '2025-04-25 15:31:15', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (3, 3, 'PC Gaming A', '001003PCGMNG', 'KAT001003PCGMNG384', 'PC Gaming Keren', 10000000, 8000000, 0, 8, 5, 'Available', '1745481938876.jpg', '2025-04-24 15:05:38', '2025-04-25 15:33:19', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (4, 4, 'Macbook A', '001004MCBK', 'KAT001004MCBK303', 'Macbook Keren', 20000000, 17000000, 0, 8, 5, 'Available', '1745482014573.jpg', '2025-04-24 15:06:54', '2025-04-25 15:33:19', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (5, 6, 'Kursi Gaming A', '002006KRSGMNG', 'KAT002006KRSGMNG730', 'Kursi Gaming Keren', 600000, 400000, 0, 9, 5, 'Available', '1745482061207.png', '2025-04-24 15:07:41', '2025-04-25 15:35:07', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (6, 5, 'Meja Gaming A', '002005MJGMNG', 'KAT002005MJGMNG685', 'Meja Gaming Keren', 800000, 600000, 0, 9, 5, 'Available', '1745482103266.png', '2025-04-24 15:08:23', '2025-04-25 15:35:07', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (7, 7, 'Rak A', '002007RK', 'KAT002007RK601', 'Rak Keren', 500000, 300000, 5, 9, 5, 'Available', '1745482141487.png', '2025-04-24 15:09:01', '2025-04-25 15:35:07', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_shifts
-- ----------------------------
DROP TABLE IF EXISTS `tb_shifts`;
CREATE TABLE `tb_shifts`  (
  `id_shifts` int NOT NULL AUTO_INCREMENT,
  `nama_shifts` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `start_time` time NULL DEFAULT NULL,
  `end_time` time NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_shifts`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_shifts
-- ----------------------------
INSERT INTO `tb_shifts` VALUES (1, 'Full-Time', '08:00:00', '16:00:00', '2025-04-17 15:57:01', '2025-04-17 15:57:01', 0, NULL, NULL);
INSERT INTO `tb_shifts` VALUES (2, 'Shift Malam', '18:00:00', '22:00:00', '2025-04-23 10:13:48', '2025-04-23 11:08:16', 1, '2025-04-23 11:08:16', NULL);
INSERT INTO `tb_shifts` VALUES (3, 'Shift Pagi', '08:00:00', '12:00:00', '2025-04-23 10:17:03', '2025-04-23 11:07:59', 1, '2025-04-23 11:07:59', NULL);

-- ----------------------------
-- Table structure for tb_stok_produk
-- ----------------------------
DROP TABLE IF EXISTS `tb_stok_produk`;
CREATE TABLE `tb_stok_produk`  (
  `id_laporan_stok` int NOT NULL AUTO_INCREMENT,
  `kode_laporan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `id_produk` int NULL DEFAULT NULL,
  `perubahan_stok` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alasan_perubahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_karyawan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_laporan_stok`) USING BTREE,
  INDEX `FK-stokToProduk`(`id_produk` ASC) USING BTREE,
  INDEX `FK-stokToUsers`(`nama_karyawan` ASC) USING BTREE,
  CONSTRAINT `FK-stokToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk` (`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_stok_produk
-- ----------------------------
INSERT INTO `tb_stok_produk` VALUES (1, 'BDSNTS-20250425-0003', 6, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-04-25 15:35:07', '2025-04-25 15:35:07', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (2, 'BDSNTS-20250425-0003', 7, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-04-25 15:35:07', '2025-04-25 15:35:07', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (3, 'BDSNTS-20250425-0003', 5, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-04-25 15:35:07', '2025-04-25 15:35:07', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_subkategori
-- ----------------------------
DROP TABLE IF EXISTS `tb_subkategori`;
CREATE TABLE `tb_subkategori`  (
  `id_subkategori` int NOT NULL AUTO_INCREMENT,
  `id_kategori` int NULL DEFAULT NULL,
  `nama_subkategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_subkategori`) USING BTREE,
  INDEX `FK-SubtoKategori`(`id_kategori` ASC) USING BTREE,
  CONSTRAINT `FK-SubtoKategori` FOREIGN KEY (`id_kategori`) REFERENCES `tb_kategori` (`id_kategori`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_subkategori
-- ----------------------------
INSERT INTO `tb_subkategori` VALUES (1, 1, 'Handphone', '2025-04-24 15:02:12', '2025-04-24 15:02:12', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (2, 1, 'Laptop', '2025-04-24 15:02:12', '2025-04-24 15:02:12', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (3, 1, 'PC', '2025-04-24 15:02:12', '2025-04-24 15:02:12', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (4, 1, 'Macbook', '2025-04-24 15:02:12', '2025-04-24 15:02:12', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (5, 2, 'Meja', '2025-04-24 15:02:34', '2025-04-24 15:02:34', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (6, 2, 'Kursi', '2025-04-24 15:02:34', '2025-04-24 15:02:34', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (7, 2, 'Rak', '2025-04-24 15:02:34', '2025-04-24 15:02:34', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_suppliers
-- ----------------------------
DROP TABLE IF EXISTS `tb_suppliers`;
CREATE TABLE `tb_suppliers`  (
  `id_suppliers` int NOT NULL AUTO_INCREMENT,
  `kode_suppliers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_suppliers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `contact_person` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `contact_suppliers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email_suppliers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alamat_suppliers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_suppliers`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_suppliers
-- ----------------------------
INSERT INTO `tb_suppliers` VALUES (1, 'SPL001', 'Supplier A', '1111', '11112', 'supplier.a@gmail.com', 'Kota A', '2025-04-21 11:15:04', '2025-05-02 11:24:42', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_users
-- ----------------------------
DROP TABLE IF EXISTS `tb_users`;
CREATE TABLE `tb_users`  (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `kode_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `contact_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `role_user` enum('admin','kasir') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status_user` enum('aktif','non-aktif') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gambar_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_user`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_users
-- ----------------------------
INSERT INTO `tb_users` VALUES (1, 'BDSNTS', 'Budi Santoso', '$2b$10$caX12QUpKy6KtI2LaAuo2OlPhRs8C8LwgcIBHMnp7gnwtMW65Hl4m', '08123456789', 'kasir', 'aktif', '1745200384655.jpg', '2025-04-21 08:53:04', '2025-04-21 08:53:04', 0, NULL, NULL);
INSERT INTO `tb_users` VALUES (2, 'PTRSYPRTM', 'Putra Suyapratama', '$2b$10$/YIR/z0VcIxqg1WXs6J6zuPWJzCoyALDMwDr27GaNVzoU0ejJR0Gm', '081210295730', 'admin', 'aktif', '1745200439821.jpg', '2025-04-21 08:53:59', '2025-04-21 08:53:59', 0, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
