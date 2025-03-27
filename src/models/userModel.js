const db = require("../config/db");
const bcrypt = require("bcrypt");

class User {
  static async getAllUsers() {
    const [rows] = await db.query(
      "SELECT id_user, nama_user, contact_user, role_user, status_user, gambar_user, created_at, updated_at FROM tb_users"
    );
    return rows;
  }

  static async findActiveUserByContact(contact_user) {
    const [rows] = await db.query(
      "SELECT * FROM tb_users WHERE contact_user = ? AND status_user = 'aktif'",
      [contact_user]
    );
    return rows.length > 0 ? rows[0] : null;
  }

  static async getUserById(id_user) {
    const [rows] = await db.query(
      "SELECT * FROM tb_users WHERE id_user = ?",
      [id_user]
    );
    return rows.length > 0 ? rows[0] : null;
  }

  static async comparePassword(inputPassword, storedPassword) {
    return bcrypt.compare(inputPassword, storedPassword);
  }

  static async createUser(nama_user, contact_user, password_user, role_user, gambar_user, status_user = "aktif") {
    const hashedPassword = await bcrypt.hash(password_user, 10); // Enkripsi password
    const [result] = await db.query(
      "INSERT INTO tb_users (nama_user, password_user, contact_user, role_user, gambar_user, status_user) VALUES (?, ?, ?, ?, ?, ?)",
      [nama_user, hashedPassword, contact_user, role_user, gambar_user, status_user]
    );
    return result.insertId;
  }

  static async updateUser(p_idUsers, p_namaUsers, p_contactUsers, p_password_users, p_role_users, p_gambar_users) {
    await db.query(
      "UPDATE tb_users SET nama_user = ?, contact_user = ?, password_user = ?, role_user = ?, gambar_user = ? WHERE id_user = ?",
      [p_namaUsers, p_contactUsers, p_password_users, p_role_users, p_gambar_users, p_idUsers]
    );
  }

  static async deleteUser(p_idUsers) {
    await db.query("DELETE FROM tb_users WHERE id_user = ?", [p_idUsers]);
  }
}

module.exports = User;
