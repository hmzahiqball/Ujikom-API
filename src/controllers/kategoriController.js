const Kategori = require("../models/kategoriModel");

exports.getAllKategori = async (req, res) => {
  try {
    const kategori = await Kategori.getAllKategori();
    res.json({
      message: "Berhasil Mendapatkan Data Kategori",
      data: kategori,
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.createKategori = async (req, res) => {
  const { p_namaKategori } = req.body;
  try {
    if (!p_namaKategori) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const kategoriId = await Kategori.createKategori(p_namaKategori);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Kategori",
      data: { p_idKategori: kategoriId, p_namaKategori},
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updateKategori = async (req, res) => {
  const { p_namaKategori } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_namaKategori) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Kategori.updateKategori(id, p_namaKategori);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Kategori",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deleteKategori = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Kategori Tidak Dikenali" });
    }
    await Kategori.deleteKategori(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Kategori",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createSubKategori = async (req, res) => {
  const { category_id } = req.params;
  const { p_namaSubKategori } = req.body;
  try {
    if (!category_id || !p_namaSubKategori) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const subKategoriId = await Kategori.createSubKategori(
      category_id,
      p_namaSubKategori
    );
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Sub Kategori",
      data: { p_idSubKategori: subKategoriId, p_namaSubKategori },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updateSubKategori = async (req, res) => {
  const { id, category_id } = req.params;
  const { p_namaSubKategori } = req.body;
  try {
    if (!category_id || !id || !p_namaSubKategori) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Kategori.updateSubKategori(id, p_namaSubKategori);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Sub Kategori",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deleteSubKategori = async (req, res) => {
  const { id, category_id } = req.params;
  try {
    if (!category_id || !id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Sub Kategori Tidak Dikenali" });
    }
    await Kategori.deleteSubKategori(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Sub Kategori",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};