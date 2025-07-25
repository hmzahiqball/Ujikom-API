const express = require("express");
const {
getAllPenjualan,
getPenjualanByKode,
createPenjualan,
updatePenjualan,
deletePenjualan
} = require("../controllers/penjualanController");

const router = express.Router();
getPenjualanByKode
router.get("/", getAllPenjualan);
router.get("/kode/:kode", getPenjualanByKode);
router.post("/", createPenjualan);
router.put("/:id", updatePenjualan);
router.delete("/:id", deletePenjualan); 

module.exports = router;