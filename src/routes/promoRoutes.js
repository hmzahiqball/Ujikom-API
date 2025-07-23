const express = require("express");
const {
    getAllPromo,
    getAllPromo_notFiltered,
    getPromoByID,
    createPromo,
    updatePromo,
    deletePromo,
    createSetting,
    updateSetting
} = require("../controllers/promoController");

const router = express.Router();

router.get("/", getAllPromo);
router.get("/notfiltered", getAllPromo_notFiltered);
router.get("/:id", getPromoByID);
router.post("/", createPromo);
router.put("/:id", updatePromo);
router.delete("/:id", deletePromo);
router.post("/setting/", createSetting);
router.put("/setting/:id", updateSetting);

module.exports = router;