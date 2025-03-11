const IzinKaryawan = require("../models/izinKaryawanModel");

exports.getAllIzinKaryawan = async (req, res) => {
  try {
    const izinKaryawan = await IzinKaryawan.getAllIzinKaryawan();
    res.json({
      message: "Berhasil Mendapatkan Data Laporan Izin Karyawan",
      data: izinKaryawan,
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.createIzinKaryawan = async (req, res) => {
  const { p_idKaryawan, p_idJenisIzin, p_startDate, p_endDate } = req.body;
  try {
    if (!p_idKaryawan || !p_idJenisIzin || !p_startDate || !p_endDate) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }

    const izinId = await IzinKaryawan.createIzinKaryawan(p_idKaryawan, p_idJenisIzin, p_startDate, p_endDate);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Laporan Izin Karyawan",
      data: { p_idIzinKaryawan: izinId, p_startDate, p_endDate},
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updateIzinKaryawan = async (req, res) => {
  const { p_startDate, p_endDate, p_status } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_startDate || !p_endDate || !p_status) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await IzinKaryawan.updateIzinKaryawan(id, p_startDate, p_endDate, p_status);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Laporan Izin Karyawan",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deleteIzinKaryawan = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Laporan Izin Tidak Dikenali" });
    }
    await IzinKaryawan.deleteIzinKaryawan(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Laporan Izin Karyawan",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};