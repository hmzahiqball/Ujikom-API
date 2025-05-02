const LaporanStok = require("../models/stokModel");

exports.getAllLaporanStok = async (req, res) => {
  try {
    const { tanggal } = req.query;
    const laporanStok = await LaporanStok.getAllLaporanStok(tanggal);
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Laporan Stok",
      data: laporanStok,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createLaporanStok = async (req, res) => {
  const { p_kodeLaporan, p_idProduk, p_namaKaryawan, p_perubahanStok, p_alasanPerubahan } = req.body;
  try {
    if (!p_kodeLaporan || !p_idProduk || !p_namaKaryawan || !p_perubahanStok || !p_alasanPerubahan) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const laporanStokId = await LaporanStok.createLaporanStok(p_kodeLaporan, p_idProduk, p_namaKaryawan, p_perubahanStok, p_alasanPerubahan);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Laporan Stok",
      data: { p_idLaporanStok: laporanStokId, p_kodeLaporan, p_namaKaryawan, p_perubahanStok, p_alasanPerubahan },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deleteLaporanStok = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Laporan Tidak Dikenali" });
    }
    await LaporanStok.deleteLaporanStok(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Laporan Stok",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};