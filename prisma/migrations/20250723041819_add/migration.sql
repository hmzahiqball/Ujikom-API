-- CreateTable
CREATE TABLE `tb_customers` (
    `id_customers` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_customers` VARCHAR(255) NULL,
    `telp_customers` VARCHAR(255) NULL,
    `email_customers` VARCHAR(255) NULL,
    `alamat_customers` TEXT NULL,
    `tglLahir_customers` DATE NULL,
    `gender_customers` ENUM('Laki-Laki', 'Perempuan') NULL,
    `status_customers` ENUM('aktif', 'non-aktif') NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    PRIMARY KEY (`id_customers`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_detail_pembelian` (
    `id_detail_pembelian` INTEGER NOT NULL AUTO_INCREMENT,
    `id_pembelian` INTEGER NULL,
    `id_produk` INTEGER NULL,
    `kuantitas` INTEGER NULL,
    `harga` DECIMAL(15, 0) NULL,
    `subtotal` DECIMAL(15, 0) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    INDEX `FK-detailPemToProduk`(`id_produk`),
    INDEX `FK-detailToPembelian`(`id_pembelian`),
    PRIMARY KEY (`id_detail_pembelian`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_detail_penjualan` (
    `id_detail_penjualan` INTEGER NOT NULL AUTO_INCREMENT,
    `id_penjualan` INTEGER NULL,
    `id_produk` INTEGER NULL,
    `kuantitas` INTEGER NULL,
    `harga` DECIMAL(15, 0) NULL,
    `subtotal` DECIMAL(15, 0) NULL,
    `diskon_produk` INTEGER NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    INDEX `FK-detailToPenjualan`(`id_penjualan`),
    INDEX `FK-detailToProduk`(`id_produk`),
    PRIMARY KEY (`id_detail_penjualan`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_izin_karyawan` (
    `id_izin` INTEGER NOT NULL AUTO_INCREMENT,
    `id_karyawan` INTEGER NULL,
    `id_jenis_izin` INTEGER NULL,
    `start_date` DATE NULL,
    `end_date` DATE NULL,
    `status` ENUM('Approved', 'Pending', 'Rejected', 'Canceled') NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    INDEX `FK-izinToJenisIzin`(`id_jenis_izin`),
    INDEX `FK-izinTokaryawan`(`id_karyawan`),
    PRIMARY KEY (`id_izin`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_karyawan` (
    `id_karyawan` INTEGER NOT NULL AUTO_INCREMENT,
    `id_user` INTEGER NOT NULL,
    `posisi_karyawan` VARCHAR(255) NULL,
    `gaji_karyawan` INTEGER NULL,
    `alamat_karyawan` TEXT NULL,
    `id_shifts` INTEGER NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    INDEX `FK-karyawanToshifts`(`id_shifts`),
    INDEX `FK-karyawanTousers`(`id_user`),
    PRIMARY KEY (`id_karyawan`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_kategori` (
    `id_kategori` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_kategori` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    PRIMARY KEY (`id_kategori`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_kategori_izin` (
    `id_kategori_izin` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_kategori_izin` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    PRIMARY KEY (`id_kategori_izin`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_kategori_pengeluaran` (
    `id_kategori_pengeluaran` INTEGER NOT NULL AUTO_INCREMENT,
    `kode_kategori_pengeluaran` VARCHAR(255) NULL,
    `nama_kategori_pengeluaran` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    PRIMARY KEY (`id_kategori_pengeluaran`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_kehadiran` (
    `id_kehadiran` INTEGER NOT NULL AUTO_INCREMENT,
    `id_karyawan` INTEGER NULL,
    `tanggal_kehadiran` DATE NULL,
    `clock_in` TIME(0) NULL,
    `clock_out` TIME(0) NULL,
    `total_jam_kerja` VARCHAR(255) NULL,
    `total_overtime` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    INDEX `FK-kehadiranTokaryawan`(`id_karyawan`),
    PRIMARY KEY (`id_kehadiran`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_pembelian` (
    `id_pembelian` INTEGER NOT NULL AUTO_INCREMENT,
    `id_suppliers` INTEGER NULL,
    `kode_pembelian` VARCHAR(255) NULL,
    `total_harga` DECIMAL(15, 0) NULL,
    `tanggal_pembelian` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    INDEX `FK-pembelianToSuppliers`(`id_suppliers`),
    PRIMARY KEY (`id_pembelian`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_pengeluaran` (
    `id_pengeluaran` INTEGER NOT NULL AUTO_INCREMENT,
    `id_kategori_pengeluaran` INTEGER NULL,
    `kode_pengeluaran` VARCHAR(255) NULL,
    `total_pengeluaran` DECIMAL(15, 0) NULL,
    `deskripsi_pengeluaran` TEXT NULL,
    `tanggal` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    INDEX `FK-pengeluaranToKategori`(`id_kategori_pengeluaran`),
    PRIMARY KEY (`id_pengeluaran`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_penjualan` (
    `id_penjualan` INTEGER NOT NULL AUTO_INCREMENT,
    `id_customers` INTEGER NULL,
    `id_karyawan` INTEGER NULL,
    `kode_penjualan` VARCHAR(255) NULL,
    `total_harga` DECIMAL(20, 0) NULL,
    `total_bayar` DECIMAL(20, 0) NULL,
    `total_kembalian` DECIMAL(20, 0) NULL,
    `diskon_penjualan` INTEGER NULL,
    `status_pembayaran` ENUM('Success', 'Pending', 'Canceled') NULL,
    `tanggal_penjualan` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    INDEX `FK-penjualanToCustomers`(`id_customers`),
    INDEX `FK-penjualanToKaryawan`(`id_karyawan`),
    PRIMARY KEY (`id_penjualan`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_produk` (
    `id_produk` INTEGER NOT NULL AUTO_INCREMENT,
    `id_kategori` INTEGER NULL,
    `nama_produk` VARCHAR(255) NULL,
    `sku_produk` VARCHAR(255) NULL,
    `barcode_produk` VARCHAR(255) NULL,
    `deskripsi_produk` VARCHAR(255) NULL,
    `harga_produk` DECIMAL(15, 0) NULL,
    `modal_produk` DECIMAL(15, 0) NULL,
    `diskon_produk` INTEGER NULL,
    `stok_produk` INTEGER NULL,
    `stok_minimum_produk` INTEGER NULL,
    `status_produk` ENUM('Available', 'Kosong') NULL,
    `gambar_produk` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    INDEX `FK-produkToSubKategori`(`id_kategori`),
    PRIMARY KEY (`id_produk`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_shifts` (
    `id_shifts` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_shifts` VARCHAR(255) NULL,
    `start_time` TIME(0) NULL,
    `end_time` TIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    PRIMARY KEY (`id_shifts`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_stok_produk` (
    `id_laporan_stok` INTEGER NOT NULL AUTO_INCREMENT,
    `kode_laporan` VARCHAR(255) NULL,
    `id_produk` INTEGER NULL,
    `perubahan_stok` VARCHAR(255) NULL,
    `alasan_perubahan` VARCHAR(255) NULL,
    `nama_karyawan` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    INDEX `FK-stokToProduk`(`id_produk`),
    INDEX `FK-stokToUsers`(`nama_karyawan`),
    PRIMARY KEY (`id_laporan_stok`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_subkategori` (
    `id_subkategori` INTEGER NOT NULL AUTO_INCREMENT,
    `id_kategori` INTEGER NULL,
    `nama_subkategori` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    INDEX `FK-SubtoKategori`(`id_kategori`),
    PRIMARY KEY (`id_subkategori`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_suppliers` (
    `id_suppliers` INTEGER NOT NULL AUTO_INCREMENT,
    `kode_suppliers` VARCHAR(255) NULL,
    `nama_suppliers` VARCHAR(255) NULL,
    `contact_person` VARCHAR(255) NULL,
    `contact_suppliers` VARCHAR(255) NULL,
    `email_suppliers` VARCHAR(255) NULL,
    `alamat_suppliers` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    PRIMARY KEY (`id_suppliers`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tb_users` (
    `id_user` INTEGER NOT NULL AUTO_INCREMENT,
    `kode_user` VARCHAR(255) NULL,
    `nama_user` VARCHAR(255) NULL,
    `password_user` VARCHAR(255) NULL,
    `contact_user` VARCHAR(255) NULL,
    `role_user` ENUM('admin', 'kasir') NULL,
    `status_user` ENUM('aktif', 'non-aktif') NULL,
    `gambar_user` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_deleted` BOOLEAN NULL DEFAULT false,
    `deleted_at` DATETIME(0) NULL,
    `deleted_by` INTEGER NULL,

    PRIMARY KEY (`id_user`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `tb_detail_pembelian` ADD CONSTRAINT `FK-detailPemToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk`(`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_detail_pembelian` ADD CONSTRAINT `FK-detailToPembelian` FOREIGN KEY (`id_pembelian`) REFERENCES `tb_pembelian`(`id_pembelian`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_detail_penjualan` ADD CONSTRAINT `FK-detailToPenjualan` FOREIGN KEY (`id_penjualan`) REFERENCES `tb_penjualan`(`id_penjualan`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_detail_penjualan` ADD CONSTRAINT `FK-detailToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk`(`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_izin_karyawan` ADD CONSTRAINT `FK-izinToJenisIzin` FOREIGN KEY (`id_jenis_izin`) REFERENCES `tb_kategori_izin`(`id_kategori_izin`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_izin_karyawan` ADD CONSTRAINT `FK-izinTokaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan`(`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_karyawan` ADD CONSTRAINT `FK-karyawanToshifts` FOREIGN KEY (`id_shifts`) REFERENCES `tb_shifts`(`id_shifts`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_karyawan` ADD CONSTRAINT `FK-karyawanTousers` FOREIGN KEY (`id_user`) REFERENCES `tb_users`(`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_kehadiran` ADD CONSTRAINT `FK-kehadiranTokaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan`(`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_pembelian` ADD CONSTRAINT `FK-pembelianToSuppliers` FOREIGN KEY (`id_suppliers`) REFERENCES `tb_suppliers`(`id_suppliers`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_pengeluaran` ADD CONSTRAINT `FK-pengeluaranToKategori` FOREIGN KEY (`id_kategori_pengeluaran`) REFERENCES `tb_kategori_pengeluaran`(`id_kategori_pengeluaran`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_penjualan` ADD CONSTRAINT `FK-penjualanToCustomers` FOREIGN KEY (`id_customers`) REFERENCES `tb_customers`(`id_customers`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_penjualan` ADD CONSTRAINT `FK-penjualanToKaryawan` FOREIGN KEY (`id_karyawan`) REFERENCES `tb_karyawan`(`id_karyawan`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_produk` ADD CONSTRAINT `FK-produkToSubKategori` FOREIGN KEY (`id_kategori`) REFERENCES `tb_subkategori`(`id_subkategori`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_stok_produk` ADD CONSTRAINT `FK-stokToProduk` FOREIGN KEY (`id_produk`) REFERENCES `tb_produk`(`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tb_subkategori` ADD CONSTRAINT `FK-SubtoKategori` FOREIGN KEY (`id_kategori`) REFERENCES `tb_kategori`(`id_kategori`) ON DELETE RESTRICT ON UPDATE RESTRICT;
