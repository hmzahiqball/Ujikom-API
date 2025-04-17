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
  console.log("Request Body:", req.body);

  try {
    const users = await User.findActiveUserByContact(p_contactUsers);

    if (!users || users.length === 0) {
      return res.status(200).json({ message: "Akun tidak ditemukan atau tidak aktif, coba lagi" });
    }

    const user = users[0];

    // Ambil password asli dari database
    const rawUserData = await User.getUserById(user.id_user);
    if (!rawUserData) {
      return res.status(200).json({ message: "Akun tidak ditemukan untuk validasi password" });
    }

    const isMatch = await User.comparePassword(p_passwordUsers, rawUserData.password_user);
    if (!isMatch) {
      return res.status(200).json({ message: "Password Salah, Coba Lagi" });
    }

    // Tambahkan URL gambar di sini
    const baseUrl = `${req.protocol}://${req.get("host")}`;
    const gambarUrl = user.gambar_user ? `${baseUrl}/api/images/${user.gambar_user}` : null;
    user.gambar_user = gambarUrl;

    return res.json({
      message: "Login berhasil",
      data: user,
    });
  } catch (error) {
    console.error("Login Error:", error);
    return res.status(500).json({ message: "Terjadi kesalahan pada server" });
  }
};

// POST: Membuat user baru
exports.createUser = async (req, res) => {
  upload.single("p_gambarUser")(req, res, async function (err) {
    if (err) {
      return res.status(400).json({ status: "error", message: err.message });
    }

    const { p_namaUsers, p_contactUsers, p_passwordUsers, p_roleUsers } = req.body;
    const p_gambarUser = req.file ? req.file.filename : null; // Simpan nama file gambar

    try {
      if (!p_namaUsers || !p_contactUsers || !p_passwordUsers || !p_roleUsers) {
        return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
      }

      const userId = await User.createUser(p_namaUsers, p_contactUsers, p_passwordUsers, p_roleUsers, p_gambarUser);
      return res.json({
        status: 200,
        message: "Berhasil Menambahkan Data Users",
        data: { p_idUser: userId, p_namaUsers, p_contactUsers, p_roleUsers, p_gambarUser },
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
    const { p_contactUsers, p_passwordUsers, p_roleUsers } = req.body;
    const p_gambarUser = req.file ? req.file.filename : null; // Simpan nama file baru jika diupload

    try {
      if (!id || !p_contactUsers || !p_roleUsers) {
        return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
      }

      // Ambil data user lama untuk cek apakah ada gambar sebelumnya
      const existingUser = await User.getUserById(id);
      let gambarUserFinal = existingUser.gambar_user;

      // Jika ada file baru diupload, gunakan file baru, jika tidak tetap pakai yang lama
      if (p_gambarUser) {
        gambarUserFinal = p_gambarUser;
      }

      // Jika password tidak dikirim (kosong), update tanpa password
      if (!p_passwordUsers || p_passwordUsers.trim() === "") {
        await User.updateUserWithoutPassword(id, p_contactUsers, p_roleUsers, gambarUserFinal);
      } else {
        await User.updateUser(id, p_contactUsers, p_passwordUsers, p_roleUsers, gambarUserFinal);
      }

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