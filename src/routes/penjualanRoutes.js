const express = require("express");
const {
getAllPenjualan,
getPenjualanByID,
createPenjualan,
updatePenjualan,
deletePenjualan
} = require("../controllers/penjualanController");

const router = express.Router();

router.get("/", getAllPenjualan);
router.post("/", createPenjualan);
router.put("/:id", updatePenjualan);
router.delete("/:id", deletePenjualan); 

module.exports = router;