const express = require("express");
const {
    getAllIzinKaryawan,
    getIzinKaryawanById,
    createIzinKaryawan,
    updateIzinKaryawan,
    deleteIzinKaryawan,
} = require("../controllers/izinKaryawanController");

const router = express.Router();

router.get("/", getAllIzinKaryawan);
router.get("/:id", getIzinKaryawanById);
router.post("/", createIzinKaryawan);
router.put("/:id", updateIzinKaryawan);
router.delete("/:id", deleteIzinKaryawan);

module.exports = router;