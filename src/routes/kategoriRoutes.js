const express = require("express");
const {
    getAllKategori,
    createKategori,
    updateKategori,
    deleteKategori,
    createSubKategori,
    updateSubKategori,
    deleteSubKategori,
} = require("../controllers/kategoriController");

const router = express.Router();

router.get("/", getAllKategori);
router.post("/", createKategori);
router.put("/:id", updateKategori);
router.delete("/:id", deleteKategori);

router.post("/:category_id/subkategori", createSubKategori);
router.put("/:category_id/subkategori/:id", updateSubKategori);
router.delete("/:category_id/subkategori/:id", deleteSubKategori);

module.exports = router;