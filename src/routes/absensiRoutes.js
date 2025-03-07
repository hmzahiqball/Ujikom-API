const express = require("express");
const {
getAllKehadiran,
clockIn,
clockOut,
deleteKehadiran
} = require("../controllers/absensiController");

const router = express.Router();

router.get("/", getAllKehadiran);
router.post("/", clockIn);
router.put("/:id", clockOut);
router.delete("/:id", deleteKehadiran); 

module.exports = router;