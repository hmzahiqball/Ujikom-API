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

 Date: 06/05/2025 15:59:53
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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_customers
-- ----------------------------
INSERT INTO `tb_customers` VALUES (1, 'Non-Member', '0', '-', '-', '0001-01-01', 'Laki-Laki', 'aktif', '2025-04-21 09:10:33', '2025-04-21 09:10:33', 0, NULL, NULL);
INSERT INTO `tb_customers` VALUES (2, 'Putra Suyapratama', '081234567890', 'member@gmail.com', 'Jl. Mawar No. 123, Kecamatan Disana, Jakarta, 12345', '2000-05-28', 'Laki-Laki', 'aktif', '2025-05-06 12:06:47', '2025-05-06 12:06:47', 0, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_detail_pembelian
-- ----------------------------
INSERT INTO `tb_detail_pembelian` VALUES (1, 1, 1, 10, 149000, 1490000, '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (2, 1, 2, 10, 80000, 800000, '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (3, 1, 3, 10, 120000, 1200000, '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (4, 1, 4, 10, 139000, 1390000, '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (5, 1, 5, 10, 139000, 1390000, '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (6, 1, 6, 10, 79000, 790000, '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (7, 2, 7, 10, 119000, 1190000, '2025-05-06 14:09:40', '2025-05-06 14:09:40', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (8, 2, 8, 10, 169000, 1690000, '2025-05-06 14:09:40', '2025-05-06 14:09:40', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (9, 2, 9, 10, 89000, 890000, '2025-05-06 14:09:40', '2025-05-06 14:09:40', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (10, 2, 10, 10, 179000, 1790000, '2025-05-06 14:09:40', '2025-05-06 14:09:40', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (11, 3, 11, 10, 49000, 490000, '2025-05-06 14:09:55', '2025-05-06 14:09:55', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (12, 3, 12, 10, 39000, 390000, '2025-05-06 14:09:55', '2025-05-06 14:09:55', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (13, 4, 13, 10, 149000, 1490000, '2025-05-06 14:10:09', '2025-05-06 14:10:09', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (14, 4, 14, 10, 129000, 1290000, '2025-05-06 14:10:09', '2025-05-06 14:10:09', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (15, 5, 16, 10, 110000, 1100000, '2025-05-06 14:10:32', '2025-05-06 14:10:32', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (16, 5, 17, 10, 89000, 890000, '2025-05-06 14:10:32', '2025-05-06 14:10:32', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (17, 6, 18, 10, 89000, 890000, '2025-05-06 14:10:51', '2025-05-06 14:10:51', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (18, 6, 19, 10, 89000, 890000, '2025-05-06 14:10:51', '2025-05-06 14:10:51', 0, NULL, NULL);
INSERT INTO `tb_detail_pembelian` VALUES (19, 6, 20, 10, 39000, 390000, '2025-05-06 14:10:51', '2025-05-06 14:10:51', 0, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_detail_penjualan
-- ----------------------------
INSERT INTO `tb_detail_penjualan` VALUES (1, 1, 1, 1, 399000, 399000, 0, '2025-05-06 14:26:36', '2025-05-06 14:26:36', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (2, 1, 2, 1, 120000, 120000, 0, '2025-05-06 14:26:36', '2025-05-06 14:26:36', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (3, 1, 3, 1, 499000, 499000, 0, '2025-05-06 14:26:36', '2025-05-06 14:26:36', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (4, 1, 4, 1, 359000, 359000, 0, '2025-05-06 14:26:36', '2025-05-06 14:26:36', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (5, 2, 5, 1, 359000, 359000, 0, '2025-05-06 14:26:48', '2025-05-06 14:26:48', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (6, 2, 6, 1, 149000, 149000, 0, '2025-05-06 14:26:48', '2025-05-06 14:26:48', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (7, 2, 7, 1, 349000, 349000, 0, '2025-05-06 14:26:48', '2025-05-06 14:26:48', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (8, 2, 8, 1, 499000, 499000, 0, '2025-05-06 14:26:48', '2025-05-06 14:26:48', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (9, 3, 9, 1, 169000, 169000, 0, '2025-05-06 14:26:59', '2025-05-06 14:26:59', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (10, 3, 10, 1, 339000, 339000, 0, '2025-05-06 14:26:59', '2025-05-06 14:26:59', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (11, 3, 11, 1, 99000, 99000, 0, '2025-05-06 14:26:59', '2025-05-06 14:26:59', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (12, 3, 12, 1, 89000, 89000, 0, '2025-05-06 14:26:59', '2025-05-06 14:26:59', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (13, 4, 13, 1, 379000, 379000, 0, '2025-05-06 14:27:17', '2025-05-06 14:27:17', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (14, 4, 14, 1, 339000, 339000, 0, '2025-05-06 14:27:17', '2025-05-06 14:27:17', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (15, 4, 15, 1, 249000, 249000, 0, '2025-05-06 14:27:17', '2025-05-06 14:27:17', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (16, 4, 16, 1, 239000, 239000, 0, '2025-05-06 14:27:17', '2025-05-06 14:27:17', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (17, 5, 17, 1, 239000, 239000, 0, '2025-05-06 14:27:28', '2025-05-06 14:27:28', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (18, 5, 18, 1, 199000, 199000, 0, '2025-05-06 14:27:28', '2025-05-06 14:27:28', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (19, 5, 19, 1, 119200, 119200, 20, '2025-05-06 14:27:28', '2025-05-06 14:27:28', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (20, 5, 20, 1, 35400, 35400, 40, '2025-05-06 14:27:28', '2025-05-06 14:27:28', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (21, 6, 1, 1, 399000, 399000, 0, '2025-05-06 14:27:56', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (22, 6, 5, 1, 359000, 359000, 0, '2025-05-06 14:27:56', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (23, 6, 9, 1, 169000, 169000, 0, '2025-05-06 14:27:56', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (24, 6, 13, 1, 379000, 379000, 0, '2025-05-06 14:27:56', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (25, 6, 17, 1, 239000, 239000, 0, '2025-05-06 14:27:56', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (26, 7, 2, 1, 120000, 120000, 0, '2025-05-06 14:28:10', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (27, 7, 6, 1, 149000, 149000, 0, '2025-05-06 14:28:10', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (28, 7, 10, 1, 339000, 339000, 0, '2025-05-06 14:28:10', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (29, 7, 14, 1, 339000, 339000, 0, '2025-05-06 14:28:10', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (30, 7, 18, 1, 199000, 199000, 0, '2025-05-06 14:28:10', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (31, 8, 3, 1, 499000, 499000, 0, '2025-05-06 14:28:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (32, 8, 7, 1, 349000, 349000, 0, '2025-05-06 14:28:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (33, 8, 11, 1, 99000, 99000, 0, '2025-05-06 14:28:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (34, 8, 15, 1, 249000, 249000, 0, '2025-05-06 14:28:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (35, 8, 19, 1, 119200, 119200, 20, '2025-05-06 14:28:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (36, 9, 4, 1, 359000, 359000, 0, '2025-05-06 14:28:39', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (37, 9, 8, 1, 499000, 499000, 0, '2025-05-06 14:28:39', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (38, 9, 12, 1, 89000, 89000, 0, '2025-05-06 14:28:39', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (39, 9, 16, 1, 239000, 239000, 0, '2025-05-06 14:28:39', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_detail_penjualan` VALUES (40, 9, 20, 1, 35400, 35400, 40, '2025-05-06 14:28:39', '2025-05-06 14:28:39', 0, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_izin_karyawan
-- ----------------------------
INSERT INTO `tb_izin_karyawan` VALUES (1, 1, 1, '2025-05-08', '2025-05-11', 'Pending', '2025-05-06 14:29:02', '2025-05-06 14:29:02', 0, NULL, NULL);

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
INSERT INTO `tb_karyawan` VALUES (1, 1, 'Teknisi', 5000000, 'Jl. Mawar No. 123', 2, '2025-04-21 08:53:04', '2025-05-06 12:02:51', 0, NULL, NULL);
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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_kategori
-- ----------------------------
INSERT INTO `tb_kategori` VALUES (1, 'Atasan Pria', '2025-05-06 11:35:20', '2025-05-06 11:35:20', 0, NULL, NULL);
INSERT INTO `tb_kategori` VALUES (2, 'Bawahan Pria', '2025-05-06 11:35:51', '2025-05-06 11:35:51', 0, NULL, NULL);
INSERT INTO `tb_kategori` VALUES (3, 'Pakaian Dalam Pria', '2025-05-06 11:36:21', '2025-05-06 11:36:21', 0, NULL, NULL);
INSERT INTO `tb_kategori` VALUES (4, 'Atasan Wanita', '2025-05-06 11:37:08', '2025-05-06 11:37:08', 0, NULL, NULL);
INSERT INTO `tb_kategori` VALUES (5, 'Bawahan Wanita', '2025-05-06 11:37:39', '2025-05-06 11:37:39', 0, NULL, NULL);
INSERT INTO `tb_kategori` VALUES (6, 'Dress', '2025-05-06 11:38:11', '2025-05-06 11:38:11', 0, NULL, NULL);
INSERT INTO `tb_kategori` VALUES (7, 'Pakaian Dalam Wanita', '2025-05-06 11:38:37', '2025-05-06 11:40:53', 1, '2025-05-06 11:40:53', NULL);
INSERT INTO `tb_kategori` VALUES (8, 'Aksesoris', '2025-05-06 11:39:20', '2025-05-06 11:39:20', 0, NULL, NULL);

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
INSERT INTO `tb_kategori_izin` VALUES (1, 'Izin Urusan Keluarga', '2025-05-06 12:10:50', '2025-05-06 12:10:50', 0, NULL, NULL);
INSERT INTO `tb_kategori_izin` VALUES (2, 'Izin Sakit', '2025-05-06 12:12:01', '2025-05-06 12:12:01', 0, NULL, NULL);
INSERT INTO `tb_kategori_izin` VALUES (3, 'Izin Malas', '2025-05-06 12:12:09', '2025-05-06 12:12:13', 1, '2025-05-06 12:12:13', NULL);

-- ----------------------------
-- Table structure for tb_kategori_pengeluaran
-- ----------------------------
DROP TABLE IF EXISTS `tb_kategori_pengeluaran`;
CREATE TABLE `tb_kategori_pengeluaran`  (
  `id_kategori_pengeluaran` int NOT NULL AUTO_INCREMENT,
  `kode_kategori_pengeluaran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_kategori_pengeluaran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_kategori_pengeluaran`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_kategori_pengeluaran
-- ----------------------------
INSERT INTO `tb_kategori_pengeluaran` VALUES (1, 'KPL001', 'Pembelian Produk ke Supplier', '2025-05-06 13:45:45', '2025-05-06 13:46:35', 0, NULL, NULL);
INSERT INTO `tb_kategori_pengeluaran` VALUES (2, 'KPL002', 'Gaji & Tunjangan', '2025-05-06 13:45:52', '2025-05-06 13:46:40', 0, NULL, NULL);
INSERT INTO `tb_kategori_pengeluaran` VALUES (3, 'KPL003', 'Operasional Toko', '2025-05-06 13:45:56', '2025-05-06 13:46:43', 0, NULL, NULL);
INSERT INTO `tb_kategori_pengeluaran` VALUES (4, 'KPL004', 'Sewa & Perawatan', '2025-05-06 13:45:59', '2025-05-06 13:46:46', 0, NULL, NULL);
INSERT INTO `tb_kategori_pengeluaran` VALUES (5, 'KPL005', 'Peralatan & Inventaris', '2025-05-06 13:46:03', '2025-05-06 13:46:48', 0, NULL, NULL);
INSERT INTO `tb_kategori_pengeluaran` VALUES (6, 'KPL006', 'Promosi & Iklan', '2025-05-06 13:46:07', '2025-05-06 13:46:50', 0, NULL, NULL);
INSERT INTO `tb_kategori_pengeluaran` VALUES (7, 'KPL007', 'Transportasi & Pengiriman', '2025-05-06 13:46:12', '2025-05-06 13:46:52', 0, NULL, NULL);
INSERT INTO `tb_kategori_pengeluaran` VALUES (8, 'KPL008', 'Pajak & Perizinan', '2025-05-06 13:46:15', '2025-05-06 13:46:54', 0, NULL, NULL);
INSERT INTO `tb_kategori_pengeluaran` VALUES (9, 'KPL009', 'Biaya Keuangan', '2025-05-06 13:46:20', '2025-05-06 13:46:56', 0, NULL, NULL);
INSERT INTO `tb_kategori_pengeluaran` VALUES (10, 'KPL010', 'Biaya Lain-lain', '2025-05-06 13:46:28', '2025-05-06 13:47:01', 0, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_kehadiran
-- ----------------------------
INSERT INTO `tb_kehadiran` VALUES (1, 2, '2025-05-06', '11:33:53', '14:21:32', '2j 47m', '0j 0m', '2025-05-06 11:33:53', '2025-05-06 14:21:32', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (2, 1, '2025-05-06', '14:21:39', '14:29:06', '0j 7m', '2j 29m', '2025-05-06 14:21:39', '2025-05-06 14:29:06', 0, NULL, NULL);
INSERT INTO `tb_kehadiran` VALUES (3, 2, '2025-05-06', '14:29:10', NULL, NULL, NULL, '2025-05-06 14:29:10', '2025-05-06 14:29:10', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_pembelian
-- ----------------------------
DROP TABLE IF EXISTS `tb_pembelian`;
CREATE TABLE `tb_pembelian`  (
  `id_pembelian` int NOT NULL AUTO_INCREMENT,
  `id_suppliers` int NULL DEFAULT NULL,
  `kode_pembelian` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `total_harga` decimal(15, 0) NULL DEFAULT NULL,
  `tanggal_pembelian` datetime NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_pembelian`) USING BTREE,
  INDEX `FK-pembelianToSuppliers`(`id_suppliers` ASC) USING BTREE,
  CONSTRAINT `FK-pembelianToSuppliers` FOREIGN KEY (`id_suppliers`) REFERENCES `tb_suppliers` (`id_suppliers`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_pembelian
-- ----------------------------
INSERT INTO `tb_pembelian` VALUES (1, 1, 'SPL003-060125', 7060000, '2025-01-06 14:09:03', '2025-01-06 14:09:03', '2025-05-06 14:26:14', 0, NULL, NULL);
INSERT INTO `tb_pembelian` VALUES (2, 2, 'SPL002-060225', 5560000, '2025-02-06 14:09:39', '2025-02-06 14:09:39', '2025-05-06 14:26:11', 0, NULL, NULL);
INSERT INTO `tb_pembelian` VALUES (3, 3, 'SPL003-060325', 880000, '2025-03-06 14:09:54', '2025-03-06 14:09:54', '2025-05-06 14:26:09', 0, NULL, NULL);
INSERT INTO `tb_pembelian` VALUES (4, 4, 'SPL004-060425', 2780000, '2025-04-06 14:10:08', '2025-04-06 14:10:08', '2025-05-06 14:26:06', 0, NULL, NULL);
INSERT INTO `tb_pembelian` VALUES (5, 5, 'SPL005-060525', 1990000, '2025-05-06 14:10:30', '2025-05-06 14:10:30', '2025-05-06 14:10:30', 0, NULL, NULL);
INSERT INTO `tb_pembelian` VALUES (6, 7, 'SPL007-060625', 2170000, '2025-06-06 14:10:50', '2025-06-06 14:10:50', '2025-05-06 14:26:03', 0, NULL, NULL);

-- ----------------------------
-- Table structure for tb_pengeluaran
-- ----------------------------
DROP TABLE IF EXISTS `tb_pengeluaran`;
CREATE TABLE `tb_pengeluaran`  (
  `id_pengeluaran` int NOT NULL AUTO_INCREMENT,
  `id_kategori_pengeluaran` int NULL DEFAULT NULL,
  `kode_pengeluaran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `total_pengeluaran` decimal(15, 0) NULL DEFAULT NULL,
  `deskripsi_pengeluaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `tanggal` datetime NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_pengeluaran`) USING BTREE,
  INDEX `FK-pengeluaranToKategori`(`id_kategori_pengeluaran` ASC) USING BTREE,
  CONSTRAINT `FK-pengeluaranToKategori` FOREIGN KEY (`id_kategori_pengeluaran`) REFERENCES `tb_kategori_pengeluaran` (`id_kategori_pengeluaran`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_pengeluaran
-- ----------------------------
INSERT INTO `tb_pengeluaran` VALUES (1, 1, 'KPL001-060525', 7060000, 'Pembelian Produk Kemeja Hitam, Kaos Hitam, Polo Shirt Hitam, Hoodie Hitam, Sweater Hitam, Jaket Hitam ke AP Production pada 2025-05-06 14:09:03', '2025-01-06 14:09:03', '2025-01-06 14:09:03', '2025-01-06 14:09:03', 0, NULL, NULL);
INSERT INTO `tb_pengeluaran` VALUES (2, 1, 'KPL001-060525', 5560000, 'Pembelian Produk Celana Panjang Hitam, Celana Jeans, Celana Pendek, Jogger Pants ke BP Production pada 2025-05-06 14:09:39', '2025-02-06 14:09:39', '2025-02-06 14:09:39', '2025-02-06 14:09:39', 0, NULL, NULL);
INSERT INTO `tb_pengeluaran` VALUES (3, 1, 'KPL001-060525', 880000, 'Pembelian Produk Boxer, Kaos Dalam ke PDP Production pada 2025-05-06 14:09:54', '2025-03-06 14:09:54', '2025-03-06 14:09:54', '2025-03-06 14:09:54', 0, NULL, NULL);
INSERT INTO `tb_pengeluaran` VALUES (4, 1, 'KPL001-060525', 2780000, 'Pembelian Produk Blouse Biru, Kemeja Pink ke AW Production pada 2025-05-06 14:10:08', '2025-04-06 14:10:08', '2025-04-06 14:10:08', '2025-04-06 14:10:08', 0, NULL, NULL);
INSERT INTO `tb_pengeluaran` VALUES (5, 1, 'KPL001-060525', 1990000, 'Pembelian Produk Legging Hitam, Celana Cutbray ke BW Production pada 2025-05-06 14:10:30', '2025-05-06 14:10:30', '2025-05-06 14:10:32', '2025-05-06 14:10:32', 0, NULL, NULL);
INSERT INTO `tb_pengeluaran` VALUES (6, 1, 'KPL001-060525', 2170000, 'Pembelian Produk Topi MLB, Ikat Pinggang Kulit, Dasi ke A Production pada 2025-05-06 14:10:50', '2025-06-06 14:10:50', '2025-06-06 14:10:50', '2025-06-06 14:10:50', 0, NULL, NULL);
INSERT INTO `tb_pengeluaran` VALUES (7, 5, 'KPL005-060525', 1500000, 'Beli TV', '2025-05-06 15:22:12', '2025-05-06 15:22:12', '2025-05-06 15:22:12', 0, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_penjualan
-- ----------------------------
INSERT INTO `tb_penjualan` VALUES (1, 1, 1, 'BDSNTS-20250106-0001', 1377000, 1400000, 23000, 0, 'Success', '2025-01-06 14:26:36', '2025-01-06 14:26:36', '2025-05-06 14:31:53', 0, NULL, NULL);
INSERT INTO `tb_penjualan` VALUES (2, 1, 1, 'BDSNTS-20250206-0002', 1356000, 1400000, 44000, 0, 'Success', '2025-02-06 14:26:48', '2025-02-06 14:26:48', '2025-05-06 14:31:58', 0, NULL, NULL);
INSERT INTO `tb_penjualan` VALUES (3, 1, 1, 'BDSNTS-20250306-0003', 696000, 700000, 4000, 0, 'Success', '2025-03-06 14:26:59', '2025-03-06 14:26:59', '2025-05-06 14:32:33', 0, NULL, NULL);
INSERT INTO `tb_penjualan` VALUES (4, 1, 1, 'BDSNTS-20250306-0004', 1206000, 1250000, 44000, 0, 'Success', '2025-03-06 14:27:17', '2025-03-06 14:27:17', '2025-05-06 14:32:06', 0, NULL, NULL);
INSERT INTO `tb_penjualan` VALUES (5, 1, 1, 'BDSNTS-20250406-0005', 592600, 600000, 7400, 0, 'Success', '2025-04-06 14:27:28', '2025-04-06 14:27:28', '2025-05-06 14:32:37', 0, NULL, NULL);
INSERT INTO `tb_penjualan` VALUES (6, 2, 1, 'BDSNTS-20250406-0006', 1545000, 1600000, 55000, 0, 'Success', '2025-04-06 14:27:56', '2025-04-06 14:27:56', '2025-05-06 14:32:29', 0, NULL, NULL);
INSERT INTO `tb_penjualan` VALUES (7, 2, 1, 'BDSNTS-20250506-0007', 1146000, 1200000, 54000, 0, 'Success', '2025-05-06 14:28:10', '0000-00-00 00:00:00', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_penjualan` VALUES (8, 2, 1, 'BDSNTS-20250506-0008', 1315200, 1350000, 34800, 0, 'Success', '2025-05-06 14:28:24', '2025-05-06 14:28:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_penjualan` VALUES (9, 1, 1, 'BDSNTS-20250606-0009', 1221400, 1250000, 28600, 0, 'Success', '2025-06-06 14:28:39', '2025-06-06 14:28:39', '2025-05-06 14:32:42', 0, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_produk
-- ----------------------------
INSERT INTO `tb_produk` VALUES (1, 1, 'Kemeja Hitam', '001001KMJHTM', 'KAT001001KMJHTM509', 'Kemeja Hitam Bagus', 399000, 149000, 0, 108, 20, 'Available', '1746506530702.png', '2025-05-06 11:42:10', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (2, 2, 'Kaos Hitam', '001002KSHTM', 'KAT001002KSHTM384', 'Kaos Hitam Bagus', 120000, 80000, 0, 108, 20, 'Available', '1746506580840.png', '2025-05-06 11:43:00', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (3, 3, 'Polo Shirt Hitam', '001003PLSHRTHTM', 'KAT001003PLSHRTHTM880', 'Polo Shirt Hitam Bagus', 499000, 120000, 0, 108, 20, 'Available', '1746506642932.png', '2025-05-06 11:44:02', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (4, 4, 'Hoodie Hitam', '001004HDHTM', 'KAT001004HDHTM123', 'Hoodie Hitam Bagus', 359000, 139000, 0, 108, 20, 'Available', '1746506693812.png', '2025-05-06 11:44:53', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (5, 5, 'Sweater Hitam', '001005SWTRHTM', 'KAT001005SWTRHTM390', 'Sweater Hitam Bagus', 359000, 139000, 0, 108, 20, 'Available', '1746506744578.png', '2025-05-06 11:45:44', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (6, 6, 'Jaket Hitam', '001006JKTHTM', 'KAT001006JKTHTM280', 'Jaket Hitam Bagus', 149000, 79000, 0, 108, 20, 'Available', '1746506788035.png', '2025-05-06 11:46:28', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (7, 7, 'Celana Panjang Hitam', '002007CLNPNJNGHTM', 'KAT002007CLNPNJNGHTM227', 'Celana Panjang Hitam Bagus', 349000, 119000, 0, 108, 20, 'Available', '1746506844060.png', '2025-05-06 11:47:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (8, 8, 'Celana Jeans', '002008CLNJNS', 'KAT002008CLNJNS492', 'Celana Jeans Bagus', 499000, 169000, 0, 108, 20, 'Available', '1746506913041.png', '2025-05-06 11:48:33', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (9, 9, 'Celana Pendek', '002009CLNPNDK', 'KAT002009CLNPNDK110', 'Celana Pendek Bagus', 169000, 89000, 0, 108, 20, 'Available', '1746506950313.png', '2025-05-06 11:49:10', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (10, 10, 'Jogger Pants', '002010JGGRPNTS', 'KAT002010JGGRPNTS538', 'Jogger Pants Bagus', 339000, 179000, 0, 108, 20, 'Available', '1746506989310.png', '2025-05-06 11:49:49', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (11, 11, 'Boxer', '003011BXR', 'KAT003011BXR780', 'Boxer Bagus', 99000, 49000, 0, 108, 20, 'Available', '1746507125958.png', '2025-05-06 11:52:05', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (12, 13, 'Kaos Dalam', '003013KSDLM', 'KAT003013KSDLM497', 'Kaos Dalam Bagus', 89000, 39000, 0, 108, 20, 'Available', '1746507171225.png', '2025-05-06 11:52:51', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (13, 14, 'Blouse Biru', '004014BLSBR', 'KAT004014BLSBR815', 'Blouse Biru Bagus', 379000, 149000, 0, 108, 20, 'Available', '1746507260761.png', '2025-05-06 11:54:20', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (14, 15, 'Kemeja Pink', '004015KMJPNK', 'KAT004015KMJPNK786', 'Kemeja Pink Lucu', 339000, 129000, 0, 108, 20, 'Available', '1746507314605.png', '2025-05-06 11:55:14', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (15, 19, 'Rok Hitam', '005019RKHTM', 'KAT005019RKHTM177', 'Rok Hitam Bagus', 249000, 119000, 0, 98, 20, 'Available', '1746507360035.png', '2025-05-06 11:56:00', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (16, 20, 'Legging Hitam', '005020LGGNGHTM', 'KAT005020LGGNGHTM289', 'Legging Hitam Bagus', 239000, 110000, 0, 108, 20, 'Available', '1746507402212.png', '2025-05-06 11:56:42', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (17, 21, 'Celana Cutbray', '005021CLNCTBRY', 'KAT005021CLNCTBRY760', 'Celana Cutbray Bagus', 239000, 89000, 0, 108, 20, 'Available', '1746507471386.png', '2025-05-06 11:57:51', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (18, 29, 'Topi MLB', '008029TPMLB', 'KAT008029TPMLB223', 'Topi MLB Bagus', 199000, 89000, 0, 108, 20, 'Available', '1746507533391.png', '2025-05-06 11:58:53', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (19, 30, 'Ikat Pinggang Kulit', '008030KTPNGGNGKLT', 'KAT008030KTPNGGNGKLT969', 'Ikat Pinggang Kulit Keren', 149000, 89000, 20, 108, 20, 'Available', '1746507593959.png', '2025-05-06 11:59:53', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_produk` VALUES (20, 31, 'Dasi', '008031DS', 'KAT008031DS866', 'Dasi Bagus', 59000, 39000, 40, 108, 20, 'Available', '1746507636942.png', '2025-05-06 12:00:36', '2025-05-06 14:28:39', 0, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_shifts
-- ----------------------------
INSERT INTO `tb_shifts` VALUES (1, 'Full Time', '08:00:00', '16:00:00', '2025-05-06 12:01:44', '2025-05-06 12:01:44', 0, NULL, NULL);
INSERT INTO `tb_shifts` VALUES (2, 'Shift Pagi', '08:00:00', '12:00:00', '2025-05-06 12:02:35', '2025-05-06 12:02:35', 0, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_stok_produk
-- ----------------------------
INSERT INTO `tb_stok_produk` VALUES (1, 'SPL003-060525', 1, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (2, 'SPL003-060525', 2, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (3, 'SPL003-060525', 4, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (4, 'SPL003-060525', 3, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (5, 'SPL003-060525', 5, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (6, 'SPL003-060525', 6, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:04', '2025-05-06 14:09:04', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (7, 'SPL002-060525', 7, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:40', '2025-05-06 14:09:40', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (8, 'SPL002-060525', 8, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:40', '2025-05-06 14:09:40', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (9, 'SPL002-060525', 9, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:40', '2025-05-06 14:09:40', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (10, 'SPL002-060525', 10, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:40', '2025-05-06 14:09:40', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (11, 'SPL003-060525', 11, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:55', '2025-05-06 14:09:55', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (12, 'SPL003-060525', 12, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:09:55', '2025-05-06 14:09:55', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (13, 'SPL004-060525', 13, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:10:09', '2025-05-06 14:10:09', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (14, 'SPL004-060525', 14, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:10:09', '2025-05-06 14:10:09', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (15, 'SPL005-060525', 16, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:10:32', '2025-05-06 14:10:32', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (16, 'SPL005-060525', 17, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:10:32', '2025-05-06 14:10:32', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (17, 'SPL007-060525', 18, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:10:51', '2025-05-06 14:10:51', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (18, 'SPL007-060525', 19, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:10:51', '2025-05-06 14:10:51', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (19, 'SPL007-060525', 20, '+ 10', 'Pembelian Produk Dari Supplier', 'Putra Suyapratama', '2025-05-06 14:10:51', '2025-05-06 14:10:51', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (20, 'BDSNTS-20250506-0001', 1, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:36', '2025-05-06 14:26:36', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (21, 'BDSNTS-20250506-0001', 2, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:36', '2025-05-06 14:26:36', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (22, 'BDSNTS-20250506-0001', 3, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:36', '2025-05-06 14:26:36', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (23, 'BDSNTS-20250506-0001', 4, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:36', '2025-05-06 14:26:36', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (24, 'BDSNTS-20250506-0002', 5, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:48', '2025-05-06 14:26:48', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (25, 'BDSNTS-20250506-0002', 6, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:48', '2025-05-06 14:26:48', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (26, 'BDSNTS-20250506-0002', 7, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:48', '2025-05-06 14:26:48', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (27, 'BDSNTS-20250506-0002', 8, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:48', '2025-05-06 14:26:48', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (28, 'BDSNTS-20250506-0003', 9, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:59', '2025-05-06 14:26:59', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (29, 'BDSNTS-20250506-0003', 10, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:59', '2025-05-06 14:26:59', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (30, 'BDSNTS-20250506-0003', 11, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:59', '2025-05-06 14:26:59', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (31, 'BDSNTS-20250506-0003', 12, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:26:59', '2025-05-06 14:26:59', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (32, 'BDSNTS-20250506-0004', 13, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:17', '2025-05-06 14:27:17', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (33, 'BDSNTS-20250506-0004', 14, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:17', '2025-05-06 14:27:17', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (34, 'BDSNTS-20250506-0004', 15, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:17', '2025-05-06 14:27:17', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (35, 'BDSNTS-20250506-0004', 16, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:17', '2025-05-06 14:27:17', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (36, 'BDSNTS-20250506-0005', 17, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:28', '2025-05-06 14:27:28', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (37, 'BDSNTS-20250506-0005', 18, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:28', '2025-05-06 14:27:28', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (38, 'BDSNTS-20250506-0005', 19, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:28', '2025-05-06 14:27:28', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (39, 'BDSNTS-20250506-0005', 20, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:28', '2025-05-06 14:27:28', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (40, 'BDSNTS-20250506-0006', 1, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:56', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (41, 'BDSNTS-20250506-0006', 5, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:56', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (42, 'BDSNTS-20250506-0006', 9, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:56', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (43, 'BDSNTS-20250506-0006', 13, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:56', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (44, 'BDSNTS-20250506-0006', 17, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:27:56', '2025-05-06 14:27:56', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (45, 'BDSNTS-20250506-0007', 2, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:10', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (46, 'BDSNTS-20250506-0007', 6, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:10', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (47, 'BDSNTS-20250506-0007', 10, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:10', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (48, 'BDSNTS-20250506-0007', 14, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:10', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (49, 'BDSNTS-20250506-0007', 18, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:10', '2025-05-06 14:28:10', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (50, 'BDSNTS-20250506-0008', 3, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (51, 'BDSNTS-20250506-0008', 7, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (52, 'BDSNTS-20250506-0008', 11, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (53, 'BDSNTS-20250506-0008', 15, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (54, 'BDSNTS-20250506-0008', 19, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:24', '2025-05-06 14:28:24', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (55, 'BDSNTS-20250506-0009', 4, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:39', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (56, 'BDSNTS-20250506-0009', 8, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:39', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (57, 'BDSNTS-20250506-0009', 12, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:39', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (58, 'BDSNTS-20250506-0009', 16, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:39', '2025-05-06 14:28:39', 0, NULL, NULL);
INSERT INTO `tb_stok_produk` VALUES (59, 'BDSNTS-20250506-0009', 20, '-1', 'Penjualan Produk', 'Budi Santoso', '2025-05-06 14:28:39', '2025-05-06 14:28:39', 0, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_subkategori
-- ----------------------------
INSERT INTO `tb_subkategori` VALUES (1, 1, 'Kemeja', '2025-05-06 11:35:20', '2025-05-06 11:35:20', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (2, 1, 'Kaos', '2025-05-06 11:35:20', '2025-05-06 11:35:20', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (3, 1, 'Polo Shirt', '2025-05-06 11:35:20', '2025-05-06 11:35:20', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (4, 1, 'Hoodie', '2025-05-06 11:35:20', '2025-05-06 11:35:20', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (5, 1, 'Sweater', '2025-05-06 11:35:20', '2025-05-06 11:35:20', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (6, 1, 'Jaket', '2025-05-06 11:35:20', '2025-05-06 11:35:20', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (7, 2, 'Celana Panjang', '2025-05-06 11:35:52', '2025-05-06 11:35:52', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (8, 2, 'Jeans', '2025-05-06 11:35:52', '2025-05-06 11:35:52', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (9, 2, 'Celana Pendek', '2025-05-06 11:35:52', '2025-05-06 11:35:52', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (10, 2, 'Jogger Pants', '2025-05-06 11:35:52', '2025-05-06 11:35:52', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (11, 3, 'Boxer', '2025-05-06 11:36:21', '2025-05-06 11:36:21', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (12, 3, 'Brief', '2025-05-06 11:36:21', '2025-05-06 11:36:21', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (13, 3, 'Kaos Dalam', '2025-05-06 11:36:21', '2025-05-06 11:36:21', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (14, 4, 'Blouse', '2025-05-06 11:37:08', '2025-05-06 11:37:08', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (15, 4, 'Kemeja Wanita', '2025-05-06 11:37:08', '2025-05-06 11:37:08', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (16, 4, 'Crop Top', '2025-05-06 11:37:08', '2025-05-06 11:37:08', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (17, 4, 'Tank Top', '2025-05-06 11:37:08', '2025-05-06 11:37:08', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (18, 4, 'Kaos Wanita', '2025-05-06 11:37:08', '2025-05-06 11:37:08', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (19, 5, 'Rok', '2025-05-06 11:37:39', '2025-05-06 11:37:39', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (20, 5, 'Legging', '2025-05-06 11:37:39', '2025-05-06 11:37:39', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (21, 5, 'Celana Panjang Wanita', '2025-05-06 11:37:39', '2025-05-06 11:37:39', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (22, 5, 'Jeans Wanita', '2025-05-06 11:37:39', '2025-05-06 11:37:39', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (23, 6, 'Mini Dress', '2025-05-06 11:38:11', '2025-05-06 11:38:11', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (24, 6, 'Maxy Dress', '2025-05-06 11:38:11', '2025-05-06 11:38:11', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (25, 6, 'Minicon', '2025-05-06 11:38:11', '2025-05-06 11:38:11', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (26, 7, 'Bra', '2025-05-06 11:38:37', '2025-05-06 11:38:37', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (27, 7, 'Celana Dalam Wanita', '2025-05-06 11:38:37', '2025-05-06 11:38:37', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (28, 7, 'Lingerie', '2025-05-06 11:38:37', '2025-05-06 11:38:37', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (29, 8, 'Topi', '2025-05-06 11:39:20', '2025-05-06 11:39:20', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (30, 8, 'Ikat Pinggang', '2025-05-06 11:39:20', '2025-05-06 11:39:20', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (31, 8, 'Dasi', '2025-05-06 11:39:20', '2025-05-06 11:39:20', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (32, 8, 'Hijab', '2025-05-06 11:39:20', '2025-05-06 11:39:20', 0, NULL, NULL);
INSERT INTO `tb_subkategori` VALUES (33, 8, 'Scarf', '2025-05-06 11:39:20', '2025-05-06 11:39:20', 0, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_suppliers
-- ----------------------------
INSERT INTO `tb_suppliers` VALUES (1, 'SPL003', 'AP Production', '081234567890', '081234567890', 'supplier@gmail.com', 'Jl. Mawar No. 123, Kecamatan Disana, Jakarta, 12345', '2025-05-06 12:04:13', '2025-05-06 12:04:13', 0, NULL, NULL);
INSERT INTO `tb_suppliers` VALUES (2, 'SPL002', 'BP Production', '081234567890', '081234567890', 'supplier@gmail.com', 'Jl. Mawar No. 123, Kecamatan Disana, Jakarta, 12345', '2025-05-06 12:04:30', '2025-05-06 12:04:30', 0, NULL, NULL);
INSERT INTO `tb_suppliers` VALUES (3, 'SPL003', 'PDP Production', '081234567890', '081234567890', 'supplier@gmail.com', 'Jl. Mawar No. 123, Kecamatan Disana, Jakarta, 12345', '2025-05-06 12:04:55', '2025-05-06 12:04:55', 0, NULL, NULL);
INSERT INTO `tb_suppliers` VALUES (4, 'SPL004', 'AW Production', '081234567890', '081234567890', 'supplier@gmail.com', 'Jl. Mawar No. 123, Kecamatan Disana, Jakarta, 12345', '2025-05-06 12:05:10', '2025-05-06 12:05:10', 0, NULL, NULL);
INSERT INTO `tb_suppliers` VALUES (5, 'SPL005', 'BW Production', '081234567890', '081234567890', 'supplier@gmail.com', 'Jl. Mawar No. 123, Kecamatan Disana, Jakarta, 12345', '2025-05-06 12:05:24', '2025-05-06 12:05:24', 0, NULL, NULL);
INSERT INTO `tb_suppliers` VALUES (6, 'SPL006', 'D Production', '081234567890', '081234567890', 'supplier@gmail.com', 'Jl. Mawar No. 123, Kecamatan Disana, Jakarta, 12345', '2025-05-06 12:05:40', '2025-05-06 12:05:40', 0, NULL, NULL);
INSERT INTO `tb_suppliers` VALUES (7, 'SPL007', 'A Production', '081234567890', '081234567890', 'supplier@gmail.com', 'Jl. Mawar No. 123, Kecamatan Disana, Jakarta, 12345', '2025-05-06 12:06:00', '2025-05-06 12:06:00', 0, NULL, NULL);

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
