# Ujikom POS — Backend API (Express.js + MySQL)

This is the backend REST API for the Point of Sale (POS) application, built with Node.js and Express.js. It serves the Laravel-based frontend for both web and desktop (Electron) versions.

Frontend repositories:
- Web: https://github.com/putra28/ujikom-pos
- Electron: https://github.com/putra28/ujikom-pos-electron

---

## 📦 Features

- User Authentication & Management
- Full CRUD for Products, Categories, Staff, Suppliers, and Members
- Sales & Purchase Transaction Management
- Employee Shifts & Attendance
- Leave Requests
- Reporting for Sales, Purchases, Expenses, and Stock Changes

---

## ⚙️ Installation

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
The server will run on http://localhost:1111 or the port defined in your .env file.

---
## 📝 Notes
- Don't forget to import the Postman collection.
- Add authentication headers for each endpoint when testing

---
