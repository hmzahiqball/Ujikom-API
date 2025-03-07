const Customer = require("../models/customerModel");

exports.getAllCustomers = async (req, res) => {
  try {
    const customers = await Customer.getAllCustomers();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Customers",
      data: customers,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createCustomer = async (req, res) => {
  const { p_namaCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers } = req.body;
  try {
    if (!p_namaCustomers || !p_telpCustomers || !p_emailCustomers || !p_alamatCustomers) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const userId = await Customer.createCustomer(p_namaCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Customers",
      data: { p_idCustomers: userId, p_namaCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updateCustomer = async (req, res) => {
  const { p_namaCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers, p_statusCustomers } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_namaCustomers || !p_telpCustomers || !p_emailCustomers || !p_alamatCustomers || !p_statusCustomers) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Customer.updateCustomer(id, p_namaCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers, p_statusCustomers);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Customers",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deleteCustomer = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Customers Tidak Dikenali" });
    }
    await Customer.deleteCustomer(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Customers",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};