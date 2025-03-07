const express = require("express");
const {
getAllProduk,
getProdukByID,
createProduk,
updateProduk,
deleteProduk,
} = require("../controllers/produkController");

const router = express.Router();

router.get("/", getAllProduk);
router.get("/:id", getProdukByID);
router.post("/", createProduk);
router.put("/:id", updateProduk);
router.delete("/:id", deleteProduk);

module.exports = router;