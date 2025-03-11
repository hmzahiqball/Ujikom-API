const Pengeluaran = require("../models/pengeluaranModel");

exports.getAllPengeluaran = async (req, res) => {
  try {
    const pengeluaran = await Pengeluaran.getAllPengeluaran();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Laporan Pengeluaran",
      data: pengeluaran,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createPengeluaran = async (req, res) => {
  const { p_idKategoriPengeluaran, p_totalPengeluaran, p_deskripsiPengeluaran, p_tanggal } = req.body;
  try {
    if (!p_idKategoriPengeluaran || !p_totalPengeluaran || !p_deskripsiPengeluaran || !p_tanggal) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const pengeluaranId = await Pengeluaran.createPengeluaran(p_idKategoriPengeluaran, p_totalPengeluaran, p_deskripsiPengeluaran, p_tanggal);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Laporan Pengeluaran",
      data: { p_idPengeluaran: pengeluaranId, p_idKategoriPengeluaran, p_totalPengeluaran, p_deskripsiPengeluaran, p_tanggal },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updatePengeluaran = async (req, res) => {
  const { p_idKategoriPengeluaran, p_totalPengeluaran, p_deskripsiPengeluaran, p_tanggal } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_idKategoriPengeluaran || !p_totalPengeluaran || !p_deskripsiPengeluaran || !p_tanggal) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Pengeluaran.updatePengeluaran(id, p_idKategoriPengeluaran, p_totalPengeluaran, p_deskripsiPengeluaran, p_tanggal);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Laporan Pengeluaran",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deletePengeluaran = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Laporan Pengeluaran Tidak Dikenali" });
    }
    await Pengeluaran.deletePengeluaran(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Laporan Pengeluaran",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};