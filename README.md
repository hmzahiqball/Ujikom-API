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

1. Clone the repository

```bash
git clone https://github.com/putra28/Ujikom-API.git
cd Ujikom-API
```

2. Install dependencies
```bash
npm install
```

3. Import the database
This project includes an SQL file (e.g., ujikom_pos.sql) containing the initial database structure and sample data. To import:
- Open phpMyAdmin / Adminer / MySQL terminal.
- Create a new database matching the name in your .env file, for example:
```bash
CREATE DATABASE db_name;
```
- Import the db_ujikompos.sql file into the database.

4. Run the server
```bash
npm run dev
```
The server will run on http://localhost:1111 or the port defined in your .env file.

---
## 📝 Notes
- Don't forget to import the Postman collection.
- Add authentication headers for each endpoint when testing

---
