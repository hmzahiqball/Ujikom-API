# Ujikom POS — Backend API (Express.js + MySQL)

Ini adalah backend REST API untuk aplikasi Point of Sale (POS), dibangun dengan Node.js dan Express.js. API ini digunakan oleh frontend berbasis Laravel (baik versi web maupun desktop/Electron).

Repositori frontend:
- Web: https://github.com/putra28/ujikom-pos
- Electron: https://github.com/putra28/ujikom-pos-electron

---

## 📦 Fitur

- Autentikasi & Manajemen Pengguna
- CRUD Produk, Kategori, Petugas, Supplier, Member
- Manajemen Transaksi Penjualan & Pembelian
- Shift & Kehadiran Karyawan
- Izin Absensi
- Laporan Penjualan, Pembelian, Pengeluaran, dan Stok

---

## ⚙️ Instalasi

1. Clone repositori

```bash
git clone https://github.com/putra28/Ujikom-API.git
cd Ujikom-API
```

2. Install dependencies
```bash
npm install
```

3. Import database
Di dalam folder ini terdapat file SQL (misalnya: ujikom_pos.sql) yang berisi struktur dan data awal database. Silakan impor ke MySQL:
- Buka phpMyAdmin / Adminer / terminal MySQL.
- Buat database baru dengan nama sesuai di .env, misalnya:
```bash
CREATE DATABASE db_name;
```
- Import file db_ujikompos.sql ke database tersebut.

4. Jalankan Server
```bash
npm run dev
```
Server akan berjalan di http://localhost:1111 atau sesuai port yang ditentukan di .env.

---
## 📝 Notes

- Import Postman Collection, tambahkan headers Auth pada setiap endpoint

---
