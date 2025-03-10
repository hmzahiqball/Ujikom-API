const express = require("express");
const {
    getAllKategoriIzin,
    getKategoriIzinByID,
    createKategoriIzin,
    updateKategoriIzin,
    deleteKategoriIzin,
} = require("../controllers/kategoriIzinController");

const router = express.Router();

router.get("/", getAllKategoriIzin);
router.get("/:id", getKategoriIzinByID);
router.post("/", createKategoriIzin);
router.put("/:id", updateKategoriIzin);
router.delete("/:id", deleteKategoriIzin);

module.exports = router;