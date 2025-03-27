const User = require("../models/userModel");
const upload = require("../middleware/upload");

// GET: Mendapatkan semua user
exports.getAllUsers = async (req, res) => {
  try {
    const users = await User.getAllUsers();
    
    // Tambahkan URL gambar dalam response
    const baseUrl = `${req.protocol}://${req.get("host")}`;
    users.forEach(p => {
      if (p.gambar_user) {
        p.gambar_user = `${baseUrl}/api/images/${p.gambar_user}`;
      }
    });

    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Users",
      data: users,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

// POST: Melakukan login
exports.login = async (req, res) => {
  const { p_contactUsers, p_passwordUsers } = req.body;
  console.log("Request Body:", req.body); // Log request body
  try {
    const user = await User.findActiveUserByContact(p_contactUsers);
    if (!user) {
      return res.status(401).json({ message: "Akun tidak ditemukan atau tidak aktif, coba lagi" });
    }

    const isMatch = await User.comparePassword(p_passwordUsers, user.password_user);
    if (!isMatch) {
      return res.status(401).json({ message: "Password Salah, Coba Lagi" });
    }

    // Buat URL gambar jika ada
    const baseUrl = `${req.protocol}://${req.get("host")}`;
    const gambarUserUrl = user.gambar_user ? `${baseUrl}/api/images/${user.gambar_user}` : null;

    return res.json({
      message: "Login berhasil",
      data: {
        id_user: user.id_user,
        nama_user: user.nama_user,
        contact_user: user.contact_user,
        role_user: user.role_user,
        status_user: user.status_user,
        gambar_user: gambarUserUrl, // Tambahkan URL gambar user
        created_at: user.created_at,
        updated_at: user.updated_at,
      },
    });
  } catch (error) {
    return res.status(500).json({ message: "Terjadi kesalahan pada server" });
  }
};

// POST: Membuat user baru
exports.createUser = async (req, res) => {
  upload.single("p_gambarUser")(req, res, async function (err) {
    if (err) {
      return res.status(400).json({ status: "error", message: err.message });
    }

    const { p_namaUsers, p_emailUsers, p_passwordUsers, p_roleUsers } = req.body;
    const p_gambarUser = req.file ? req.file.filename : null; // Simpan nama file gambar

    try {
      if (!p_namaUsers || !p_emailUsers || !p_passwordUsers || !p_roleUsers) {
        return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
      }

      const userId = await User.createUser(p_namaUsers, p_emailUsers, p_passwordUsers, p_roleUsers, p_gambarUser);
      return res.json({
        status: 200,
        message: "Berhasil Menambahkan Data Users",
        data: { p_idUser: userId, p_namaUsers, p_emailUsers, p_roleUsers, p_gambarUser },
      });
    } catch (error) {
      return res.status(500).json({ status: "error", message: error.message });
    }
  });
};

// PUT: Memperbarui user berdasarkan ID
exports.updateUser = async (req, res) => {
  upload.single("p_gambarUser")(req, res, async function (err) {
    if (err) {
      return res.status(400).json({ status: "error", message: err.message });
    }

    const { id } = req.params;
    const { p_namaUsers, p_emailUsers, p_passwordUsers, p_roleUsers } = req.body;
    const p_gambarUser = req.file ? req.file.filename : null; // Simpan nama file baru jika diupload

    try {
      if (!id || !p_namaUsers || !p_emailUsers || !p_passwordUsers || !p_roleUsers) {
        return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
      }

      // Ambil data user lama untuk cek apakah ada gambar sebelumnya
      const existingUser = await User.getUserById(id);
      let gambarUserFinal = existingUser.gambar_user;

      // Jika ada file baru diupload, gunakan file baru, jika tidak tetap pakai yang lama
      if (p_gambarUser) {
        gambarUserFinal = p_gambarUser;
      }

      await User.updateUser(id, p_namaUsers, p_emailUsers, p_passwordUsers, p_roleUsers, gambarUserFinal);

      return res.json({
        status: 200,
        message: "Berhasil Update Data User",
      });
    } catch (error) {
      return res.status(500).json({ status: "error", message: error.message });
    }
  });
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