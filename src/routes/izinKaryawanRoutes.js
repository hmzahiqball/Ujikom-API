const express = require("express");
const {
    getAllIzinKaryawan,
    createIzinKaryawan,
    updateIzinKaryawan,
    deleteIzinKaryawan,
} = require("../controllers/izinKaryawanController");

const router = express.Router();

router.get("/", getAllIzinKaryawan);
router.post("/", createIzinKaryawan);
router.put("/:id", updateIzinKaryawan);
router.delete("/:id", deleteIzinKaryawan);

module.exports = router;