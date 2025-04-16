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
      `SELECT 
        u.id_user AS user_id, 
        u.kode_user AS kode_user,
        u.nama_user AS user_name, 
        u.contact_user AS user_contact, 
        u.role_user AS user_role, 
        u.status_user AS user_status, 
        u.gambar_user AS user_image, 
        u.created_at, 
        u.updated_at, 
        k.id_karyawan AS employee_id, 
        k.posisi_karyawan AS position, 
        k.gaji_karyawan AS salary, 
        k.alamat_karyawan AS alamat, 
        s.id_shifts AS shift_id, 
        s.nama_shifts AS shift_name, 
        s.start_time AS shift_start_time, 
        s.end_time AS shift_end_time 
      FROM 
        tb_users u 
      LEFT JOIN 
        tb_karyawan k ON u.id_user = k.id_user 
      LEFT JOIN 
        tb_shifts s ON k.id_shifts = s.id_shifts 
      WHERE 
        u.contact_user = ? AND u.status_user = 'aktif'`,
      [contact_user]
    );
    
    const formattedRows = rows.map(row => ({
        id_user: row.user_id,
        kode_user: row.kode_user,
        nama_user: row.user_name,
        contact_user: row.user_contact,
        role_user: row.user_role,
        status_user: row.user_status,
        created_at: row.created_at,
        updated_at: row.updated_at,
        gambar_user: row.user_image,
        data_user: {
            id_karyawan: row.employee_id,
            posisi_karyawan: row.position,
            gaji_karyawan: row.salary,
            alamat_karyawan: row.alamat,
        },
        data_shift: {
            id_shift: row.shift_id,
            nama_shift: row.shift_name,
            start_time: row.shift_start_time,
            end_time: row.shift_end_time,
        },
    }));

    return formattedRows;
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

  static async updateUser(p_idUsers, p_contactUsers, p_password_users, p_role_users, p_gambar_users) {
    await db.query(
      "UPDATE tb_users SET contact_user = ?, password_user = ?, role_user = ?, gambar_user = ? WHERE id_user = ?",
      [p_contactUsers, p_password_users, p_role_users, p_gambar_users, p_idUsers]
    );
  }

  static async updateUserWithoutPassword(p_idUsers, p_contactUsers, p_role_users, p_gambar_users) {
    await db.query(
      "UPDATE tb_users SET contact_user = ?, role_user = ?, gambar_user = ? WHERE id_user = ?",
      [p_contactUsers, p_role_users, p_gambar_users, p_idUsers]
    );
  }

  static async deleteUser(p_idUsers) {
    await db.query("DELETE FROM tb_users WHERE id_user = ?", [p_idUsers]);
  }
}

module.exports = User;
