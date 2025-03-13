const db = require("../config/db");

class User {
  static async getAllUsers() {
    const [rows] = await db.query("SELECT id_user, nama_user, contact_user, role_user, created_at, updated_at FROM tb_users");
    return rows;
  }

  static async createUser(p_namaUsers, p_contactUsers, p_password_users, p_role_users) {
    const [result] = await db.query(
      "INSERT INTO tb_users (nama_user, password_user, contact_user, role_user) VALUES (?, ?, ?, ?)",
      [p_namaUsers, p_contactUsers, p_password_users, p_role_users]
    );
    return result.insertId;
  }

  static async updateUser(p_idUsers, p_namaUsers, p_contactUsers, p_password_users, p_role_users) {
    await db.query(
      "UPDATE tb_users SET nama_user = ?, contact_user = ?, password_user = ?, role_user = ? WHERE id_user = ?",
      [p_namaUsers, p_contactUsers, p_password_users, p_role_users, p_idUsers]
    );
  }

  static async deleteUser(p_idUsers) {
    await db.query("DELETE FROM tb_users WHERE id_user = ?", [p_idUsers]);
  }
}

module.exports = User;
