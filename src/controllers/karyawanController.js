const Karyawan = require("../models/karyawanModel");

exports.getAllKaryawan = async (req, res) => {
  try {
    const karyawan = await Karyawan.getAllKaryawan();
    const baseUrl = `${req.protocol}://${req.get("host")}`;

    const formatted = karyawan.map(p => ({
      ...p,
      data_user: {
        ...p.data_user,
        gambar_user: p.data_user.gambar_user
          ? `${baseUrl}/api/images/${p.data_user.gambar_user}`
          : null,
      },
    }));

    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Karyawan",
      data: formatted,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.getKaryawanByID = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const karyawan = await Karyawan.getKaryawanByID(id);
    if (!karyawan) {
      return res
        .status(200)
        .json({ status: "200", message: "Data Karyawan Tidak Tersedia" });
    }
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Karyawan",
      data: karyawan,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createKaryawan = async (req, res) => {
    const { p_userKaryawan, p_posisiKaryawan, p_gajiKaryawan, p_alamatKaryawan, p_idShifts } = req.body;
    try {
        if (!p_userKaryawan || !p_posisiKaryawan || !p_gajiKaryawan || !p_alamatKaryawan || !p_idShifts) {
            return res
                .status(400)
                .json({ status: "error", message: "Data Tidak Lengkap" });
        }

        const result = await Karyawan.createKaryawan(p_userKaryawan, p_posisiKaryawan, p_gajiKaryawan, p_alamatKaryawan, p_idShifts);

        if (result.status === 500) {
            return res.status(500).json({ status: "error", message: result.message, error: result.error });
        }

        return res.status(201).json({
            status: 201,
            message: "Berhasil Menambahkan Data Karyawan",
            data: { p_idKaryawan: result.karyawan_id, p_idUsers: result.user_id, p_userKaryawan, p_posisiKaryawan, p_gajiKaryawan, p_alamatKaryawan, p_idShifts },
        });
    } catch (error) {
        return res.status(500).json({ status: "error", message: error.message });
    }
};

exports.updateKaryawan = async (req, res) => {
  const { p_posisiKaryawan, p_gajiKaryawan, p_alamatKaryawan, p_idShifts } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_posisiKaryawan || !p_gajiKaryawan || !p_alamatKaryawan || !p_idShifts) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Karyawan.updateKaryawan(id, p_posisiKaryawan, p_gajiKaryawan, p_alamatKaryawan, p_idShifts);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Karyawan",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deleteKaryawan = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Karyawan Tidak Dikenali" });
    }
    await Karyawan.deleteKaryawan(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Karyawan",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};