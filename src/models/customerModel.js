const db = require("../config/db");
const formatWIB = require("../utils/time");

class Customer {
  static async getAllCustomers() {
    const [rows] = await db.query("SELECT id_customers, nama_customers, gender_customers, DATE_FORMAT(tglLahir_customers, '%Y-%m-%d') AS tglLahir_customers, telp_customers, email_customers, alamat_customers, status_customers, created_at, updated_at FROM tb_customers WHERE is_deleted = 0 AND status_customers = 'aktif'");
    return rows.map(row => ({
      ...row,
      created_at: formatWIB(row.created_at),
      updated_at: formatWIB(row.updated_at),
    }));
  }

  static async createCustomer(p_namaCustomers, p_genderCustomers, p_tglLahirCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers) {
    const [result] = await db.query(
      "INSERT INTO tb_customers (nama_customers, gender_customers, tglLahir_customers, telp_customers, email_customers, alamat_customers, status_customers) VALUES (?, ?, ?, ?, ?, ?, 'aktif')",
      [p_namaCustomers, p_genderCustomers, p_tglLahirCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers]
    );
    return result.insertId;
  }

  static async updateCustomer(p_idCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers, p_statusCustomers) {
    await db.query(
      "UPDATE tb_customers SET telp_customers = ?, email_customers = ?, alamat_customers = ?, status_customers = ? WHERE id_customers = ?",
      [p_telpCustomers, p_emailCustomers, p_alamatCustomers, p_statusCustomers, p_idCustomers]
    );
  }

  static async deleteCustomer(p_idCustomers) {
    await db.query("UPDATE tb_customers SET status_customers = 'non-aktif', is_deleted = 1, deleted_at = NOW() WHERE id_customers = ? AND is_deleted = 0 AND status_customers = 'aktif'", [p_idCustomers]);
  }
}

module.exports = Customer;
