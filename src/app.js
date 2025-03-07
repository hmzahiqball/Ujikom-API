const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const userRoutes = require("./routes/userRoutes");
const supplierRoutes = require("./routes/supplierRoutes");
const kategoriRoutes = require("./routes/kategoriRoutes");
const shiftRoutes = require("./routes/shiftRoutes");

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use("/api/users", userRoutes);
app.use("/api/suppliers", supplierRoutes);
app.use("/api/kategori", kategoriRoutes);
app.use("/api/shifts", shiftRoutes);

module.exports = app; // Ekspor aplikasi Express