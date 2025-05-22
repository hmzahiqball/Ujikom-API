const express = require("express");
const {
  getAllUsers,
  login,
  createUser,
  updateUser,
  deleteUser,
} = require("../controllers/userController");

const authenticateToken = require("../middleware/auth");

const router = express.Router();

// 🔓 Public route
router.post("/login", login);

// 🔐 Protected routes
router.get("/", authenticateToken, getAllUsers);
router.post("/", authenticateToken, createUser);
router.put("/:id", authenticateToken, updateUser);
router.delete("/:id", authenticateToken, deleteUser);

module.exports = router;
