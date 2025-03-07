const express = require("express");
const {
    getAllShifts,
    getShiftsByID,
    createShifts,
    updateShifts,
    deleteShifts,
} = require("../controllers/shiftController");

const router = express.Router();

router.get("/", getAllShifts);
router.get("/:id", getShiftsByID);
router.post("/", createShifts);
router.put("/:id", updateShifts);
router.delete("/:id", deleteShifts);

module.exports = router;