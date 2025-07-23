const Promo = require("../models/promoModel");

exports.getAllPromo = async (req, res) => {
  try {
    const promos = await Promo.getAllPromo();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Promo",
      data: promos,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.getAllPromo_notFiltered = async (req, res) => {
  try {
    const promos = await Promo.getAllPromo_notFiltered();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Promo",
      data: promos,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.getPromoByID = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const promo = await Promo.getPromoByID(id);
    if (!promo) {
      return res
        .status(200)
        .json({ status: "200", message: "Promo Tidak Tersedia" });
    }
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Promo",
      data: promo,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createPromo = async (req, res) => {
  const { p_namaPromo, p_kodePromo, p_tipePromo, p_totalPromo, p_kuotaPromo, p_tanggalMulai, p_tanggalAkhir, p_minBelanja, p_statusPromo } = req.body;
  try {
    if (!p_namaPromo || !p_kodePromo || !p_tipePromo || !p_totalPromo || !p_kuotaPromo || !p_tanggalMulai || !p_tanggalAkhir || !p_minBelanja || !p_statusPromo) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const promoId = await Promo.createPromo(p_namaPromo, p_kodePromo, p_tipePromo, p_totalPromo, p_kuotaPromo, p_tanggalMulai, p_tanggalAkhir, p_minBelanja, p_statusPromo);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Promo",
      data: { p_idPromo: promoId, p_namaPromo, p_kodePromo, p_tipePromo, p_totalPromo, p_kuotaPromo, p_tanggalMulai, p_tanggalAkhir, p_minBelanja, p_statusPromo },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updatePromo = async (req, res) => {
  const { p_namaPromo, p_kodePromo, p_tipePromo, p_totalPromo, p_kuotaPromo, p_tanggalMulai, p_tanggalAkhir, p_minBelanja, p_statusPromo } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_namaPromo || !p_kodePromo || !p_tipePromo || !p_totalPromo || !p_kuotaPromo || !p_tanggalMulai || !p_tanggalAkhir || !p_minBelanja || !p_statusPromo) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Promo.updatePromo(id, p_namaPromo, p_kodePromo, p_tipePromo, p_totalPromo, p_kuotaPromo, p_tanggalMulai, p_tanggalAkhir, p_minBelanja, p_statusPromo);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Promo",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createSetting = async (req, res) => {
  const { p_key, p_value } = req.body;
  try {
    if (!p_key || !p_value) {
      return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const settingId = await Promo.createSetting(p_key, p_value);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Setting",
      data: { p_idSettings: settingId, p_key, p_value },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updateSetting = async (req, res) => {
  const { p_value } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_value) {
      return res.status(400).json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Promo.updateSetting(id, p_value);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Setting",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deletePromo = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Promo Tidak Dikenali" });
    }
    await Promo.deletePromo(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Promo",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

