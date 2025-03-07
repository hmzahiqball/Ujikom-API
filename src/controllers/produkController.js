const Produk = require("../models/produkModel");

exports.getAllProduk = async (req, res) => {
  try {
    const produk = await Produk.getAllProduk();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Produk",
      data: produk,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.getProdukByID = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const produk = await Produk.getProdukByID(id);
    if (!produk) {
      return res
        .status(200)
        .json({ status: "200", message: "Data Produk Tidak Tersedia" });
    }
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Produk",
      data: produk,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createProduk = async (req, res) => {
  const { p_idKategori, p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_stokProduk, p_stokMinimumProduk } = req.body;
  try {
    if (!p_idKategori || !p_namaProduk || !p_skuProduk || !p_barcodeProduk || !p_deskripsiProduk || !p_hargaProduk || !p_modalProduk || !p_stokProduk || !p_stokMinimumProduk) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const produkId = await Produk.createProduk(p_idKategori, p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_stokProduk, p_stokMinimumProduk);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Produk",
      data: { p_idProduk: produkId, p_idKategori, p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_stokProduk, p_stokMinimumProduk },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updateProduk = async (req, res) => {
  const { p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_stokProduk, p_stokMinimumProduk } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_namaProduk || !p_skuProduk || !p_barcodeProduk || !p_deskripsiProduk || !p_hargaProduk || !p_modalProduk || !p_stokProduk || !p_stokMinimumProduk) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Produk.updateProduk(id, p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_stokProduk, p_stokMinimumProduk);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Produk",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deleteProduk = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Produk Tidak Dikenali" });
    }
    await Produk.deleteProduk(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Produk",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};