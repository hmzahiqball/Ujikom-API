const KategoriPengeluaran = require("../models/kategoriPengeluaranModel");

exports.getAllkategoriPengeluaran = async (req, res) => {
  try {
    const kategoriPengeluaran = await KategoriPengeluaran.getAllkategoriPengeluaran();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Kategori Pengeluaran",
      data: kategoriPengeluaran,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.getkategoriPengeluaranByID = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const kategoriPengeluaran = await KategoriPengeluaran.getkategoriPengeluaranByID(id);
    if (!kategoriPengeluaran) {
      return res
        .status(200)
        .json({ status: "200", message: "Kategori Izin Tidak Tersedia" });
    }
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Kategori Pengeluaran",
      data: kategoriPengeluaran,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createkategoriPengeluaran = async (req, res) => {
  const { p_namakategoriPengeluaran } = req.body;
  try {
    if (!p_namakategoriPengeluaran) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const kategoriPengeluaranId = await KategoriPengeluaran.createkategoriPengeluaran(p_namakategoriPengeluaran);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Kategori Pengeluaran",
      data: { p_idkategoriPengeluaran: kategoriPengeluaranId, p_namakategoriPengeluaran },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updatekategoriPengeluaran = async (req, res) => {
  const { p_namakategoriPengeluaran } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_namakategoriPengeluaran) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await KategoriPengeluaran.updatekategoriPengeluaran(id, p_namakategoriPengeluaran);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Kategori Pengeluaran",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deletekategoriPengeluaran = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Kategori Pengeluaran Tidak Dikenali" });
    }
    await KategoriPengeluaran.deletekategoriPengeluaran(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Kategori Pengeluaran",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};