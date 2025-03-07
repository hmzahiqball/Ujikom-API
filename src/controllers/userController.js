const User = require("../models/userModel");

// GET: Mendapatkan semua user
exports.getAllUsers = async (req, res) => {
  try {
    const users = await User.getAllUsers();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Users",
      data: users,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

// POST: Membuat user baru
exports.createUser = async (req, res) => {
  const { p_namaUsers, p_emailUsers, p_password_users, p_role_users } = req.body;
  try {
    if (!p_namaUsers || !p_emailUsers || !p_password_users || !p_role_users) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const userId = await User.createUser(p_namaUsers, p_emailUsers, p_password_users, p_role_users);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Users",
      data: { p_idUser: userId, p_namaUsers, p_emailUsers, p_role_users },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

// PUT: Memperbarui user berdasarkan ID
exports.updateUser = async (req, res) => {
  const { p_namaUsers, p_emailUsers, p_password_users, p_role_users } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_namaUsers || !p_emailUsers || !p_password_users || !p_role_users) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await User.updateUser(id, p_namaUsers, p_emailUsers, p_password_users, p_role_users);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Users",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

// DELETE: Menghapus user berdasarkan ID
exports.deleteUser = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Users Tidak Dikenali" });
    }
    await User.deleteUser(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Users",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};