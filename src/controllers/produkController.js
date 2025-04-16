const Produk = require("../models/produkModel");
const upload = require("../middleware/upload");

exports.getAllProduk = async (req, res) => {
  try {
    const produk = await Produk.getAllProduk();
    const baseUrl = `${req.protocol}://${req.get("host")}`;

    const formatted = produk.map(p => ({
      ...p,
      gambar_produk: p.gambar_produk
        ? `${baseUrl}/api/images/${p.gambar_produk}`
        : null,
    }));

    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Produk",
      data: formatted,
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

    const baseUrl = `${req.protocol}://${req.get("host")}`;
    const formatted = produk.map(p => ({
      ...p,
      gambar_produk: p.gambar_produk
        ? `${baseUrl}/api/images/${p.gambar_produk}`
        : null,
    }));

    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Produk",
      data: formatted,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createProduk = async (req, res) => {
  upload.single("p_gambarProduk")(req, res, async function (err) {
    if (err) {
      return res.status(400).json({ status: "error", message: err.message });
    }

    const { p_idKategori, p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_diskonProduk, p_stokProduk, p_stokMinimumProduk, p_statusProduk } = req.body;
    const p_gambarProduk = req.file ? req.file.filename : null; // Simpan nama file

    try {
      if (!p_idKategori || !p_namaProduk || !p_skuProduk || !p_barcodeProduk || !p_deskripsiProduk || !p_hargaProduk || !p_modalProduk || !p_diskonProduk || !p_stokProduk || !p_stokMinimumProduk || !p_gambarProduk || !p_statusProduk) {
        return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
      }

      const produkId = await Produk.createProduk(p_idKategori, p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_diskonProduk, p_stokProduk, p_stokMinimumProduk, p_statusProduk, p_gambarProduk);
      
      return res.json({
        status: 200,
        message: "Berhasil Menambahkan Data Produk",
        data: { p_idProduk: produkId, p_idKategori, p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_diskonProduk, p_stokProduk, p_stokMinimumProduk, p_statusProduk, p_gambarProduk },
      });
    } catch (error) {
      return res.status(500).json({ status: "error", message: error.message });
    }
  });
};

exports.updateProduk = async (req, res) => {
  upload.single("p_gambarProduk")(req, res, async function (err) {
    if (err) {
      return res.status(400).json({ status: "error", message: err.message });
    }

    const { id } = req.params;
    const {
      p_modalProduk,
      p_hargaProduk,
      p_diskonProduk,
      p_stokProduk,
      p_stokMinimumProduk,
      p_statusProduk,
      p_deskripsiProduk,
    } = req.body;

    const p_gambarProduk = req.file ? req.file.filename : null;

    try {
      // Validasi data minimal
      if (
        !id ||
        !p_modalProduk ||
        !p_hargaProduk ||
        p_diskonProduk === undefined ||
        !p_stokProduk ||
        !p_stokMinimumProduk ||
        !p_statusProduk ||
        !p_deskripsiProduk
      ) {
        return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
      }

      // Cek data lama
      const existingProduk = await Produk.getProdukByID(id);
      if (!existingProduk) {
        return res.status(404).json({ status: "error", message: "Produk tidak ditemukan" });
      }

      await Produk.updateProduk(
        id,
        p_modalProduk,
        p_hargaProduk,
        p_diskonProduk,
        p_stokProduk,
        p_stokMinimumProduk,
        p_statusProduk,
        p_deskripsiProduk,
        p_gambarProduk // hanya diupdate di model jika tidak null
      );

      return res.json({ status: 200, message: "Produk berhasil diupdate" });
    } catch (error) {
      return res.status(500).json({ status: "error", message: error.message });
    }
  });
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