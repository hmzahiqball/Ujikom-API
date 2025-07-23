require('dotenv').config();
const path = require("path");
const express = require("express");
const cors = require("cors");
const authenticateToken = require("./middleware/auth");

const bodyParser = require("body-parser");
const userRoutes = require("./routes/userRoutes");
const supplierRoutes = require("./routes/supplierRoutes");
const kategoriRoutes = require("./routes/kategoriRoutes");
const shiftRoutes = require("./routes/shiftRoutes");
const produkRoutes = require("./routes/produkRoutes");
const karyawanRoutes = require("./routes/karyawanRoutes");
const customerRoutes = require("./routes/customerRoutes");
const stokRoutes = require("./routes/stokRoutes");
const promoRoutes = require("./routes/promoRoutes");
const absensiRoutes = require("./routes/absensiRoutes");
const kategoriIzinRoutes = require("./routes/kategoriIzinRoutes");
const kategoriPengeluaranRoutes = require("./routes/kategoriPengeluaranRoutes");
const izinKaryawanRoutes = require("./routes/izinKaryawanRoutes");
const pengeluaranRoutes = require("./routes/pengeluaranRoutes");
const pembelianRoutes = require("./routes/pembelianRoutes");
const penjualanRoutes = require("./routes/penjualanRoutes");

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use("/api/images", express.static(path.join(__dirname, "uploads")));

// 🔓 Public Routes 
app.use("/api/users", userRoutes);

// 🔐 Protected Routes 
app.use("/api/suppliers", authenticateToken, supplierRoutes);
app.use("/api/kategori", authenticateToken, kategoriRoutes);
app.use("/api/shifts", authenticateToken, shiftRoutes);
app.use("/api/promo", authenticateToken, promoRoutes);
app.use("/api/produk", authenticateToken, produkRoutes);
app.use("/api/karyawan", authenticateToken, karyawanRoutes);
app.use("/api/customer", authenticateToken, customerRoutes);
app.use("/api/laporanStok", authenticateToken, stokRoutes);
app.use("/api/laporanAbsen", authenticateToken, absensiRoutes);
app.use("/api/kategoriIzin", authenticateToken, kategoriIzinRoutes);
app.use("/api/kategoriPengeluaran", authenticateToken, kategoriPengeluaranRoutes);
app.use("/api/laporanIzinKaryawan", authenticateToken, izinKaryawanRoutes);
app.use("/api/laporanPengeluaran", authenticateToken, pengeluaranRoutes);
app.use("/api/laporanPembelian", authenticateToken, pembelianRoutes);
app.use("/api/laporanPenjualan", authenticateToken, penjualanRoutes);

module.exports = app; // Ekspor aplikasi Express