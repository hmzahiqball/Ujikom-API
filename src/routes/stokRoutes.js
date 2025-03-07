const express = require("express");
const {
getAllLaporanStok,
createLaporanStok,
deleteLaporanStok,
} = require("../controllers/stokController");

const router = express.Router();

router.get("/", getAllLaporanStok);
router.post("/", createLaporanStok);
router.delete("/:id", deleteLaporanStok);

module.exports = router;