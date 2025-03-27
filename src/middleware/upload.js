const multer = require("multer");
const path = require("path");
const fs = require("fs");

// Pastikan folder "uploads" ada
const uploadDir = path.join(__dirname, "../uploads");
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// Konfigurasi penyimpanan file
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, uploadDir); // Simpan ke folder yang sudah dipastikan ada
  },
  filename: function (req, file, cb) {
    const ext = path.extname(file.originalname);
    const filename = Date.now() + ext; // Nama unik berdasarkan timestamp
    cb(null, filename);
  },
});

// Filter file hanya untuk gambar
const fileFilter = (req, file, cb) => {
  if (file.mimetype.startsWith("image/")) {
    cb(null, true);
  } else {
    cb(new Error("Hanya gambar yang diperbolehkan"), false);
  }
};

// Middleware upload
const upload = multer({ storage, fileFilter });

module.exports = upload;
