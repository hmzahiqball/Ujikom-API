const db = require("../config/db");
const formatWIB = require("../utils/time");

class Karyawan {
  static async getAllKaryawan() {
    const [rows] = await db.query(`
        SELECT
            k.id_karyawan AS id,
            k.posisi_karyawan AS position,
            k.gaji_karyawan AS salary,
            k.alamat_karyawan AS alamat,
            k.created_at,
            k.updated_at,
            u.id_user AS user_id, 
            u.kode_user AS kode_user,
            u.nama_user AS user_name, 
            u.contact_user AS user_contact, 
            u.role_user AS user_role, 
            u.status_user AS user_status, 
            u.gambar_user AS user_image, 
            s.id_shifts AS shift_id,
            s.nama_shifts AS shift_name,
            s.start_time AS shift_start_time,
            s.end_time AS shift_end_time
        FROM
            tb_karyawan k
        JOIN
            tb_users u ON k.id_user = u.id_user
        JOIN
            tb_shifts s ON k.id_shifts = s.id_shifts;
    `);

    const formattedRows = rows.map(row => ({
        id_karyawan: row.id,
        posisi_karyawan: row.position,
        gaji_karyawan: row.salary,
        alamat_karyawan: row.alamat,
        created_at: formatWIB(row.created_at),
        updated_at: formatWIB(row.updated_at),
        data_user: {
            id_user: row.user_id,
            kode_user: row.kode_user,
            nama_user: row.user_name,
            contact_user: row.user_contact,
            role_user: row.user_role,
            status_user: row.user_status,
            gambar_user: row.user_image,
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

  static async getKaryawanByID(p_idKaryawan) {
    const [rows] = await db.query(`
        SELECT
            k.id_karyawan AS id,
            k.posisi_karyawan AS position,
            k.gaji_karyawan AS salary,
            k.alamat_karyawan AS alamat,
            k.created_at,
            k.updated_at,
            u.id_user AS user_id, 
            u.kode_user AS kode_user,
            u.nama_user AS user_name, 
            u.contact_user AS user_contact, 
            u.role_user AS user_role, 
            u.status_user AS user_status, 
            u.gambar_user AS user_image, 
            s.id_shifts AS shift_id,
            s.nama_shifts AS shift_name,
            s.start_time AS shift_start_time,
            s.end_time AS shift_end_time
        FROM
            tb_karyawan k
        JOIN
            tb_users u ON k.id_user = u.id_user
        JOIN
            tb_shifts s ON k.id_shifts = s.id_shifts
        WHERE
            k.id_karyawan = ?;
    `, [p_idKaryawan]);

    if (rows.length === 0) {
        return null;
    }

    const row = rows[0];

    const formattedRows = rows.map(row => ({
        id_karyawan: row.id,
        posisi_karyawan: row.position,
        gaji_karyawan: row.salary,
        alamat_karyawan: row.alamat,
        created_at: formatWIB(row.created_at),
        updated_at: formatWIB(row.updated_at),
        data_user: {
            id_user: row.user_id,
            kode_user: row.kode_user,
            nama_user: row.user_name,
            contact_user: row.user_contact,
            role_user: row.user_role,
            status_user: row.user_status,
            gambar_user: row.user_image,
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

  static async createKaryawan(userData, p_posisiKaryawan, p_gajiKaryawan, p_alamatKaryawan, p_idShifts) {
    try {
      const [userResult] = await db.query(
        "INSERT INTO tb_users (kode_user, nama_user, password_user, contact_user, role_user, gambar_user, status_user) VALUES (?, ?, ?, ?, ?, ?, 'aktif')",
        [
          userData.p_kodeUser,
          userData.p_namaUsers,
          userData.p_passwordUsers,
          userData.p_contactUsers,
          userData.p_roleUsers,
          userData.p_gambarUser
        ]
      );
      const userId = userResult.insertId;
  
      const [karyawanResult] = await db.query(
        "INSERT INTO tb_karyawan (id_user, posisi_karyawan, gaji_karyawan, alamat_karyawan, id_shifts) VALUES (?, ?, ?, ?, ?)",
        [userId, p_posisiKaryawan, p_gajiKaryawan, p_alamatKaryawan, p_idShifts]
      );
      const karyawanId = karyawanResult.insertId;
  
      return { userId, karyawanId };
    } catch (error) {
      console.error("DB Error:", error);
      return { status: 500, message: "Gagal menambahkan data", error };
    }
  }

  static async updateKaryawan(p_idKaryawan, p_posisiKaryawan, p_gajiKaryawan, p_alamatKaryawan, p_idShifts) {
    await db.query(
      "UPDATE tb_karyawan SET posisi_karyawan = ?, gaji_karyawan = ?, alamat_karyawan = ?, id_shifts = ? WHERE id_karyawan = ?",
      [p_posisiKaryawan, p_gajiKaryawan, p_alamatKaryawan, p_idShifts, p_idKaryawan]
    );
  }

  static async deleteKaryawan(p_idKaryawan) {
    // Select id_user from tb_karyawan based on id_karyawan
    const [rows] = await db.query("SELECT id_user FROM tb_karyawan WHERE id_karyawan = ?", [p_idKaryawan]);
    if (rows.length === 0) {
      throw new Error("Karyawan tidak ditemukan");
    }
    const userId = rows[0].id_user;
    
    // Delete from tb_karyawan based on id_karyawan
    await db.query("DELETE FROM tb_karyawan WHERE id_karyawan = ?", [p_idKaryawan]);
    
    // Delete from tb_users based on id_user
    await db.query("DELETE FROM tb_users WHERE id_user = ?", [userId]);
  }
}

module.exports = Karyawan;
