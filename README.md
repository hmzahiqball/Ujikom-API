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

<<<<<<< HEAD
### 1. Clone repositori
=======
1. Clone the repository
>>>>>>> f2178b46fd7b1d4aea7f67ec68e4cb30a6525ae7

```bash
git clone https://github.com/putra28/Ujikom-API.git
cd Ujikom-API
```

### 2. Install dependencies
```bash
npm install
```

<<<<<<< HEAD
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
=======
3. Import the database
This project includes an SQL file (e.g., ujikom_pos.sql) containing the initial database structure and sample data. To import:
- Open phpMyAdmin / Adminer / MySQL terminal.
- Create a new database matching the name in your .env file, for example:
```bash
CREATE DATABASE db_name;
```
- Import the db_ujikompos.sql file into the database.

4. Run the server
>>>>>>> f2178b46fd7b1d4aea7f67ec68e4cb30a6525ae7
```bash
npm run dev
```
The server will run on http://localhost:1111 or the port defined in your .env file.

---
## 📝 Notes
- Don't forget to import the Postman collection.
- Add authentication headers for each endpoint when testing

---
