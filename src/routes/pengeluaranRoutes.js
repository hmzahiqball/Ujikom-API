const express = require("express");
const {
  getAllPengeluaran,
  createPengeluaran,
  updatePengeluaran,
  deletePengeluaran,
} = require("../controllers/pengeluaranController");

const router = express.Router();

router.get("/", getAllPengeluaran);
router.post("/", createPengeluaran);
router.put("/:id", updatePengeluaran);
router.delete("/:id", deletePengeluaran); 

module.exports = router;