const express = require("express");
const {
getAllKaryawan,
getKaryawanByID,
createKaryawan,
updateKaryawan,
deleteKaryawan,
} = require("../controllers/karyawanController");

const router = express.Router();

router.get("/", getAllKaryawan);
router.get("/:id", getKaryawanByID);
router.post("/", createKaryawan);
router.put("/:id", updateKaryawan);
router.delete("/:id", deleteKaryawan);

module.exports = router;