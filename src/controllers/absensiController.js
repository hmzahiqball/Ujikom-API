const Kehadiran = require("../models/absensiModel");

// GET: Mendapatkan semua user
exports.getAllKehadiran = async (req, res) => {
  try {
    const kehadiran = await Kehadiran.getAllKehadiran();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Laporan Absensi",
      data: kehadiran,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.clockIn = async (req, res) => {
  const { p_idKaryawan } = req.body;
  try {
    if (!p_idKaryawan) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const { p_idKehadiran, p_namaKaryawan, p_tanggal, p_waktuClockin } =
      await Kehadiran.clockIn(p_idKaryawan);
    return res.json({
      status: 200,
      message: "Berhasil Clock IN",
      data: {
        p_idKehadiran,
        p_namaKaryawan,
        p_tanggal,
        p_waktuClockin,
      },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.clockOut = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const { p_idKehadiran, p_tanggal, p_clockIn, p_namaKaryawan, p_clockOut, total_jam_kerja, total_overtime } =
      await Kehadiran.clockOut(id);
    return res.json({
      status: 200,
      message: "Berhasil Clock Out",
      data: {
        p_idKehadiran,
        p_namaKaryawan,
        p_tanggal,
        p_clockIn,
        p_clockOut,
        total_jam_kerja,
        total_overtime,
      },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deleteKehadiran = async (req, res) => {
    const { id } = req.params;
    try {
      if (!id) {
        return res
          .status(400)
          .json({ status: "error", message: "ID Kehadiran Tidak Dikenali" });
      }
      await Kehadiran.deleteKehadiran(id);
      return res.json({
        status: 200,
        message: "Berhasil Menghapus Data Kehadiran",
      });
    } catch (error) {
      return res.status(500).json({ status: "error", message: error.message });
    }
  };