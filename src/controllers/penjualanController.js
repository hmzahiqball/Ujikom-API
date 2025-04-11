const Penjualan = require("../models/penjualanModel");

exports.getAllPenjualan = async (req, res) => {
  try {
    const { idpetugas, tanggal } = req.query;
    const penjualan = await Penjualan.getAllPenjualan(idpetugas, tanggal);
    
    if (!penjualan) {
      return res.status(400).json({ status: 400, message: "Data tidak ditemukan" });
    }

    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Penjualan",
      data: penjualan,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createPenjualan = async (req, res) => {
    const { p_idCustomers, p_idKaryawan, p_totalHarga, p_detailPenjualan, p_tanggal } = req.body;
    try {
      if (!p_idCustomers || !p_idKaryawan || !p_totalHarga || !p_detailPenjualan || !p_tanggal) {
        return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
      }
      const penjualanId = await Penjualan.createPenjualan(p_idCustomers, p_idKaryawan, p_totalHarga, p_detailPenjualan, p_tanggal);
      return res.json({
        status: 200,
        message: "Berhasil Menambahkan Data Penjualan",
        data: { p_idPenjualan: penjualanId, p_idCustomers, p_idKaryawan, p_tanggal, p_totalHarga, p_statusPembelian: 'Success', p_detailPenjualan },
      });
    } catch (error) {
      return res.status(500).json({ status: "error", message: error.message });
    }
  };
  
exports.updatePenjualan = async (req, res) => {
  const { p_idCustomers, p_idKaryawan, p_totalHarga, p_statusPenjualan } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_idCustomers || !p_idKaryawan || !p_totalHarga || !p_statusPenjualan) {
      return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Penjualan.updatePenjualan(id, p_idCustomers, p_idKaryawan, p_totalHarga, p_statusPenjualan);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Penjualan",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deletePenjualan = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res.status(400).json({ status: "error", message: "ID Penjualan Tidak Dikenali" });
    }
    await Penjualan.deletePenjualan(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Penjualan",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};
  