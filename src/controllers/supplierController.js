const Suppliers = require("../models/supplierModel");

exports.getAllSuppliers = async (req, res) => {
  try {
    const suppliers = await Suppliers.getAllSuppliers();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Suppliers",
      data: suppliers,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createSuppliers = async (req, res) => {
  const { p_namaSuppliers, p_contactPerson, p_contactSuppliers, p_emailSuppliers, p_alamatSuppliers } = req.body;
  try {
    if (!p_namaSuppliers || !p_contactPerson || !p_contactSuppliers || !p_emailSuppliers || !p_alamatSuppliers) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const supplierId = await Suppliers.createSuppliers(p_namaSuppliers, p_contactPerson, p_contactSuppliers, p_emailSuppliers, p_alamatSuppliers);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Supplier",
      data: { p_idSuppliers: supplierId, p_namaSuppliers, p_contactPerson, p_contactSuppliers, p_emailSuppliers, p_alamatSuppliers },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updateSuppliers = async (req, res) => {
  const { p_namaSuppliers, p_contactPerson, p_contactSuppliers, p_emailSuppliers, p_alamatSuppliers } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_namaSuppliers || !p_contactPerson || !p_contactSuppliers || !p_emailSuppliers || !p_alamatSuppliers) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Suppliers.updateSuppliers(id, p_namaSuppliers, p_contactPerson, p_contactSuppliers, p_emailSuppliers, p_alamatSuppliers);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Supplier",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deleteSuppliers = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Supplier Tidak Dikenali" });
    }
    await Suppliers.deleteSuppliers(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Supplier",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};