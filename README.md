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

### 1. Clone repositori

```bash
git clone https://github.com/putra28/Ujikom-API.git
cd Ujikom-API
```

### 2. Install dependencies
```bash
npm install
```

### 3. Setup database
Terdapat dua cara untuk setup database:

#### Opsi 1: Import manual
- Di dalam folder ini terdapat file SQL (misalnya: db_ujikompos.sql) yang berisi struktur dan data awal database.
- Buka phpMyAdmin / Adminer / terminal MySQL.
- Buat database baru sesuai dengan nama di .env, misalnya:
```
CREATE DATABASE db_name;
```
- Import file SQL tersebut ke database:
```
mysql -u [username] -p db_name < db_ujikompos.sql
```
#### Opsi 2: Gunakan Prisma Migration + Seed
- Pastikan URL database di .env sudah sesuai.
- Jalankan migrasi untuk membuat struktur database
```
npx prisma migrate deploy
```
- Lalu jalankan seed data awal
```
npx prisma db seed
```


### 4. Jalankan Server
```bash
npm run dev
```
Server akan berjalan di http://localhost:1111 atau sesuai port yang ditentukan di .env.

---
## 📝 Notes

- Import Postman Collection, tambahkan headers Auth pada setiap endpoint

---
