const express = require("express");
const {
    getAllShifts,
    getAllShifts_notFiltered,
    getShiftsByID,
    createShifts,
    updateShifts,
    deleteShifts,
} = require("../controllers/shiftController");

const router = express.Router();

router.get("/", getAllShifts);
router.get("/notfiltered", getAllShifts_notFiltered);
router.get("/:id", getShiftsByID);
router.post("/", createShifts);
router.put("/:id", updateShifts);
router.delete("/:id", deleteShifts);

module.exports = router;