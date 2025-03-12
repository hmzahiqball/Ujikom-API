const express = require("express");
const {
getAllPembelian,
getPembelianByID,
createPembelian,
updatePembelian,
deletePembelian
} = require("../controllers/pembelianController");

const router = express.Router();

router.get("/", getAllPembelian);
router.get("/:id", getPembelianByID);
router.post("/", createPembelian);
router.put("/:id", updatePembelian);
router.delete("/:id", deletePembelian); 

module.exports = router;