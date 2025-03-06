const express = require("express");
const {
  getAllSuppliers,
  createSuppliers,
  updateSuppliers,
  deleteSuppliers,
} = require("../controllers/supplierController");

const router = express.Router();

router.get("/", getAllSuppliers);
router.post("/", createSuppliers);
router.put("/:id", updateSuppliers);
router.delete("/:id", deleteSuppliers); 

module.exports = router;