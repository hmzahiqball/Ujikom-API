const express = require("express");
const {
getAllProduk,
getProdukByID,
createProduk,
updateProduk,
updateStokProduk,
deleteProduk,
} = require("../controllers/produkController");

const router = express.Router();

router.get("/", getAllProduk);
router.get("/:id", getProdukByID);
router.post("/", createProduk);
router.put("/:id", updateProduk);
router.put("/stok/:id", updateStokProduk);
router.delete("/:id", deleteProduk);

module.exports = router;