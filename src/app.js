const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const userRoutes = require("./routes/userRoutes");
const supplierRoutes = require("./routes/supplierRoutes");
const kategoriRoutes = require("./routes/kategoriRoutes");
const shiftRoutes = require("./routes/shiftRoutes");
const produkRoutes = require("./routes/produkRoutes");
const karyawanRoutes = require("./routes/karyawanRoutes");
const customerRoutes = require("./routes/customerRoutes");
const stokRoutes = require("./routes/stokRoutes");

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use("/api/users", userRoutes);
app.use("/api/suppliers", supplierRoutes);
app.use("/api/kategori", kategoriRoutes);
app.use("/api/shifts", shiftRoutes);
app.use("/api/produk", produkRoutes);
app.use("/api/karyawan", karyawanRoutes);
app.use("/api/customer", customerRoutes);
app.use("/api/laporanstok", stokRoutes);

module.exports = app; // Ekspor aplikasi Express