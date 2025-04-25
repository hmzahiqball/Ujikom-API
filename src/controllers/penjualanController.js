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
  const {
    p_idCustomers,
    p_idKaryawan,
    p_totalHarga,
    p_totalBayar,
    p_totalKembalian,
    p_diskon,
    p_detailPenjualan,
    p_tanggal
  } = req.body;

  try {
    // Validasi wajib
    if (!p_idCustomers || !p_idKaryawan || !p_totalHarga || !p_totalBayar || !p_detailPenjualan || !p_tanggal) {
      return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
    }

    const { penjualanId, kodePenjualan } = await Penjualan.createPenjualan({
      idCustomers: p_idCustomers,
      idKaryawan: p_idKaryawan,
      totalHarga: p_totalHarga,
      totalBayar: p_totalBayar,
      totalKembalian: p_totalKembalian || 0,
      diskon: p_diskon || 0,
      detailPenjualan: p_detailPenjualan,
      tanggal: p_tanggal
    });

    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Penjualan",
      data: {
        idPenjualan: penjualanId,
        kode_penjualan: kodePenjualan,
        idCustomers: p_idCustomers,
        idKaryawan: p_idKaryawan,
        tanggal: p_tanggal,
        totalHarga: p_totalHarga,
        totalBayar: p_totalBayar,
        totalKembalian: p_totalKembalian || 0,
        diskon: p_diskon || 0,
        statusPembayaran: 'Success',
        detailPenjualan: p_detailPenjualan,
      },
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
  