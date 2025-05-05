const Purchase = require("../models/pembelianModel");

exports.getAllPembelian = async (req, res) => {
  try {
    const { tanggal } = req.query;
    const purchases = await Purchase.getAllPembelian(tanggal);
    
    if (!purchases) {
      return res.status(400).json({ status: 200, message: "Data Tidak Lengkap" });
    }
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Pembelian",
      data: purchases,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.getPembelianByID = async (req, res) => {
  const { id } = req.params;
  try {
    const purchases = await Purchase.getPembelianByID(id);
    if (!purchases) {
      return res.status(400).json({ status: "error", message: "ID Pembelian Tidak Dikenali" });
    }
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Pembelian",
      data: purchases,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createPembelian = async (req, res) => {
  const { p_idSuppliers, p_totalHarga, p_detailPembelian, p_tanggal } = req.body;
  try {
    if (!p_idSuppliers || !p_totalHarga || !p_detailPembelian || !p_tanggal) {
      return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const purchaseId = await Purchase.createPembelian(p_idSuppliers, p_totalHarga, p_detailPembelian, p_tanggal);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Pembelian",
      data: { p_idPembelian: purchaseId, p_idSuppliers, p_tanggal, p_totalHarga, p_statusPembelian: 'Pending', p_detailPembelian },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updatePembelian = async (req, res) => {
  const { p_totalHarga, p_statusPembelian } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_totalHarga || !p_statusPembelian) {
      return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Purchase.updatePembelian(id, p_totalHarga, p_statusPembelian);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Pembelian",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deletePembelian = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res.status(400).json({ status: "error", message: "ID Pembelian Tidak Dikenali" });
    }
    await Purchase.deletePembelian(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Pembelian",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};