const KategoriIzin = require("../models/kategoriIzinModel");

exports.getAllKategoriIzin = async (req, res) => {
  try {
    const kategoriIzin = await KategoriIzin.getAllKategoriIzin();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Kategori Izin",
      data: kategoriIzin,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.getKategoriIzinByID = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const kategoriIzin = await KategoriIzin.getKategoriIzinByID(id);
    if (!kategoriIzin) {
      return res
        .status(200)
        .json({ status: "200", message: "Kategori Izin Tidak Tersedia" });
    }
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Kategori Izin",
      data: kategoriIzin,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createKategoriIzin = async (req, res) => {
  const { p_namaKategoriIzin } = req.body;
  try {
    if (!p_namaKategoriIzin) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const kategoriIzinId = await KategoriIzin.createKategoriIzin(p_namaKategoriIzin);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Kategori Izin",
      data: { p_idKategoriIzin: kategoriIzinId, p_namaKategoriIzin },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updateKategoriIzin = async (req, res) => {
  const { p_namaKategoriIzin } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_namaKategoriIzin) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await KategoriIzin.updateKategoriIzin(id, p_namaKategoriIzin);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Kategori Izin",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deleteKategoriIzin = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Kategori Izin Tidak Dikenali" });
    }
    await KategoriIzin.deleteKategoriIzin(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Kategori Izin",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};