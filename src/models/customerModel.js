const db = require("../config/db");
const formatWIB = require("../utils/time");

class Customer {
  static async getAllCustomers() {
    const [rows] = await db.query("SELECT id_customers, nama_customers, gender_customers, tglLahir_customers, telp_customers, email_customers, alamat_customers, status_customers, created_at, updated_at FROM tb_customers");
    return rows.map(row => ({
      ...row,
      created_at: formatWIB(row.created_at),
      updated_at: formatWIB(row.updated_at),
    }));
  }

  static async createCustomer(p_namaCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers) {
    const [result] = await db.query(
      "INSERT INTO tb_customers (nama_customers, telp_customers, email_customers, alamat_customers, status_customers) VALUES (?, ?, ?, ?, 'aktif')",
      [p_namaCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers]
    );
    return result.insertId;
  }

  static async updateCustomer(p_idCustomers, p_namaCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers, p_statusCustomers) {
    await db.query(
      "UPDATE tb_customers SET nama_customers = ?, telp_customers = ?, email_customers = ?, alamat_customers = ?, status_customers = ? WHERE id_customers = ?",
      [p_namaCustomers, p_telpCustomers, p_emailCustomers, p_alamatCustomers, p_statusCustomers, p_idCustomers]
    );
  }

  static async deleteCustomer(p_idCustomers) {
    await db.query("DELETE FROM tb_customers WHERE id_customers = ?", [p_idCustomers]);
  }
}

module.exports = Customer;
