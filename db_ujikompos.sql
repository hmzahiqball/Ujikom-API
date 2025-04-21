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

 Date: 21/04/2025 09:41:52
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
  PRIMARY KEY (`id_customers`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_customers
-- ----------------------------
INSERT INTO `tb_customers` VALUES (1, 'Non-Member', '0', '-', '-', '0001-01-01', 'Laki-Laki', 'aktif', '2025-04-21 09:10:33', '2025-04-21 09:10:33');

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
  PRIMARY KEY (`id_detail_pembelian`) USING BTREE,
  INDEX `FK-detailPemToProduk`(`id_produk` ASC) USING BTREE,
  INDEX `FK-detailToPembelian`(`id_pembelian` ASC) USING BTREE,
  CONSTRAINT `FK-detailPemToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk` (`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-detailToPembelian` FOREIGN KEY (`id_pembelian`) REFERENCES `tb_pembelian` (`id_pembelian`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_detail_penjualan`) USING BTREE,
  INDEX `FK-detailToProduk`(`id_produk` ASC) USING BTREE,
  INDEX `FK-detailToPenjualan`(`id_penjualan` ASC) USING BTREE,
  CONSTRAINT `FK-detailToPenjualan` FOREIGN KEY (`id_penjualan`) REFERENCES `tb_penjualan` (`id_penjualan`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK-detailToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk` (`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_detail_penjualan
-- ----------------------------
INSERT INTO `tb_detail_penjualan` VALUES (1, 1, 2, 1, 14400000, 14400000, 10, '2025-04-21 09:10:56', '2025-04-21 09:10:56');
INSERT INTO `tb_detail_penjualan` VALUES (2, 1, 1, 1, 15000000, 15000000, 0, '2025-04-21 09:10:56', '2025-04-21 09:10:56');
INSERT INTO `tb_detail_penjualan` VALUES (3, 2, 2, 1, 14400000, 14400000, 10, '2025-04-21 09:32:28', '2025-04-21 09:32:28');
INSERT INTO `tb_detail_penjualan` VALUES (4, 2, 1, 1, 15000000, 15000000, 0, '2025-04-21 09:32:28', '2025-04-21 09:32:28');

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
  `status` enum('Approved','Pending','Rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_izin`) USING BTREE,
  INDEX `FK-izinTokaryawan`(`id_karyawan` ASC) USING BTREE,
  INDEX `FK-izinToJenisIzin`(`id_jenis_izin` ASC) USING BTREE,
  CONSTRAINT `FK-izinToJenisIzin` FOREIGN KEY (`id_jenis_izin`) REFERENCES `tb_kategori_izin` (`id_kategori_izin`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-izinTokaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan` (`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
  `posisi_karyawan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gaji_karyawan` int NULL DEFAULT NULL,
  `alamat_karyawan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `id_shifts` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_karyawan`) USING BTREE,
  INDEX `FK-karyawanToshifts`(`id_shifts` ASC) USING BTREE,
  INDEX `FK-karyawanTousers`(`id_user` ASC) USING BTREE,
  CONSTRAINT `FK-karyawanToshifts` FOREIGN KEY (`id_shifts`) REFERENCES `tb_shifts` (`id_shifts`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-karyawanTousers` FOREIGN KEY (`id_user`) REFERENCES `tb_users` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_karyawan
-- ----------------------------
INSERT INTO `tb_karyawan` VALUES (1, 1, 'Teknisi', 5000000, 'Jl. Mawar No. 123', 1, '2025-04-21 08:53:04', '2025-04-21 08:53:04');
INSERT INTO `tb_karyawan` VALUES (2, 2, 'Owner', 90000000, 'Jl. Mawar No. 124', 1, '2025-04-21 08:53:59', '2025-04-21 08:53:59');

-- ----------------------------
-- Table structure for tb_kategori
-- ----------------------------
DROP TABLE IF EXISTS `tb_kategori`;
CREATE TABLE `tb_kategori`  (
  `id_kategori` int NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_kategori`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_kategori
-- ----------------------------
INSERT INTO `tb_kategori` VALUES (1, 'Elektronik', '2025-04-17 15:53:57', '2025-04-17 15:53:57');

-- ----------------------------
-- Table structure for tb_kategori_izin
-- ----------------------------
DROP TABLE IF EXISTS `tb_kategori_izin`;
CREATE TABLE `tb_kategori_izin`  (
  `id_kategori_izin` int NOT NULL AUTO_INCREMENT,
  `nama_kategori_izin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_kategori_izin`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_kategori_izin
-- ----------------------------

-- ----------------------------
-- Table structure for tb_kategori_pengeluaran
-- ----------------------------
DROP TABLE IF EXISTS `tb_kategori_pengeluaran`;
CREATE TABLE `tb_kategori_pengeluaran`  (
  `id_kategori_pengeluaran` int NOT NULL AUTO_INCREMENT,
  `nama_kategori_pengeluaran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
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
  PRIMARY KEY (`id_kehadiran`) USING BTREE,
  INDEX `FK-kehadiranTokaryawan`(`id_karyawan` ASC) USING BTREE,
  CONSTRAINT `FK-kehadiranTokaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan` (`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
  `total_harga` decimal(15, 0) NULL DEFAULT NULL,
  `status_pembelian` enum('Success','Pending','Canceled') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tanggal_pembelian` date NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pembelian`) USING BTREE,
  INDEX `FK-pembelianToSuppliers`(`id_suppliers` ASC) USING BTREE,
  CONSTRAINT `FK-pembelianToSuppliers` FOREIGN KEY (`id_suppliers`) REFERENCES `tb_suppliers` (`id_suppliers`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
  `total_pengeluaran` decimal(15, 0) NULL DEFAULT NULL,
  `deskripsi_pengeluaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `tanggal` date NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
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
  PRIMARY KEY (`id_penjualan`) USING BTREE,
  INDEX `FK-penjualanToCustomers`(`id_customers` ASC) USING BTREE,
  INDEX `FK-penjualanToKaryawan`(`id_karyawan` ASC) USING BTREE,
  CONSTRAINT `FK-penjualanToCustomers` FOREIGN KEY (`id_customers`) REFERENCES `tb_customers` (`id_customers`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK-penjualanToKaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan` (`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_penjualan
-- ----------------------------
INSERT INTO `tb_penjualan` VALUES (1, 1, 1, 'BDSNTS-20250421-0001', 29400000, 30000000, 600000, 0, 'Success', '2025-04-21 02:10:56', '2025-04-21 09:10:56', '2025-04-21 09:10:56');
INSERT INTO `tb_penjualan` VALUES (2, 1, 1, 'BDSNTS-20250421-0002', 29400000, 30000000, 600000, 0, 'Success', '2025-03-21 02:32:27', '2025-04-21 09:32:28', '2025-04-21 09:33:20');

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
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_produk`) USING BTREE,
  INDEX `FK-produkToSubKategori`(`id_kategori` ASC) USING BTREE,
  CONSTRAINT `FK-produkToSubKategori` FOREIGN KEY (`id_kategori`) REFERENCES `tb_subkategori` (`id_subkategori`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_produk
-- ----------------------------
INSERT INTO `tb_produk` VALUES (1, 2, 'Macbook', '001002MCBK', 'KAT001002MCBK652', 'Macbook Air keren', 15000000, 13000000, 0, 8, 5, 'Available', '1744880096491.jpg', 0, '2025-04-17 15:54:56', '2025-04-21 09:32:28');
INSERT INTO `tb_produk` VALUES (2, 1, 'Laptop Gaming', '001001LPTPGMNG', 'KAT001001LPTPGMNG809', 'Laptop Gaming Keren', 16000000, 14000000, 10, 8, 5, 'Available', '1744880139352.jpg', 0, '2025-04-17 15:55:39', '2025-04-21 09:32:28');

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
  PRIMARY KEY (`id_shifts`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_shifts
-- ----------------------------
INSERT INTO `tb_shifts` VALUES (1, 'Full-Time', '08:00:00', '16:00:00', '2025-04-17 15:57:01', '2025-04-17 15:57:01');

-- ----------------------------
-- Table structure for tb_stok_produk
-- ----------------------------
DROP TABLE IF EXISTS `tb_stok_produk`;
CREATE TABLE `tb_stok_produk`  (
  `id_laporan_stok` int NOT NULL AUTO_INCREMENT,
  `id_produk` int NULL DEFAULT NULL,
  `perubahan_stok` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alasan_perubahan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_karyawan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_laporan_stok`) USING BTREE,
  INDEX `FK-stokToProduk`(`id_produk` ASC) USING BTREE,
  INDEX `FK-stokToUsers`(`nama_karyawan` ASC) USING BTREE,
  CONSTRAINT `FK-stokToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk` (`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
  `nama_subkategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_subkategori`) USING BTREE,
  INDEX `FK-SubtoKategori`(`id_kategori` ASC) USING BTREE,
  CONSTRAINT `FK-SubtoKategori` FOREIGN KEY (`id_kategori`) REFERENCES `tb_kategori` (`id_kategori`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_subkategori
-- ----------------------------
INSERT INTO `tb_subkategori` VALUES (1, 1, 'Laptop', '2025-04-17 15:54:09', '2025-04-17 15:54:09');
INSERT INTO `tb_subkategori` VALUES (2, 1, 'Macbook', '2025-04-17 15:54:14', '2025-04-17 15:54:14');

-- ----------------------------
-- Table structure for tb_suppliers
-- ----------------------------
DROP TABLE IF EXISTS `tb_suppliers`;
CREATE TABLE `tb_suppliers`  (
  `id_suppliers` int NOT NULL AUTO_INCREMENT,
  `nama_suppliers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `contact_person` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `contact_suppliers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email_suppliers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alamat_suppliers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_suppliers`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_suppliers
-- ----------------------------

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
  PRIMARY KEY (`id_user`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_users
-- ----------------------------
INSERT INTO `tb_users` VALUES (1, 'BDSNTS', 'Budi Santoso', '$2b$10$caX12QUpKy6KtI2LaAuo2OlPhRs8C8LwgcIBHMnp7gnwtMW65Hl4m', '08123456789', 'kasir', 'aktif', '1745200384655.jpg', '2025-04-21 08:53:04', '2025-04-21 08:53:04');
INSERT INTO `tb_users` VALUES (2, 'PTRSYPRTM', 'Putra Suyapratama', '$2b$10$/YIR/z0VcIxqg1WXs6J6zuPWJzCoyALDMwDr27GaNVzoU0ejJR0Gm', '081210295730', 'admin', 'aktif', '1745200439821.jpg', '2025-04-21 08:53:59', '2025-04-21 08:53:59');

SET FOREIGN_KEY_CHECKS = 1;
