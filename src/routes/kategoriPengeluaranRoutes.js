const express = require("express");
const {
    getAllkategoriPengeluaran,
    getkategoriPengeluaranByID,
    createkategoriPengeluaran,
    updatekategoriPengeluaran,
    deletekategoriPengeluaran,
} = require("../controllers/kategoriPengeluaranController");

const router = express.Router();

router.get("/", getAllkategoriPengeluaran);
router.get("/:id", getkategoriPengeluaranByID);
router.post("/", createkategoriPengeluaran);
router.put("/:id", updatekategoriPengeluaran);
router.delete("/:id", deletekategoriPengeluaran);

module.exports = router;