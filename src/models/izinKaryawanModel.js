const db = require("../config/db");

class IzinKaryawan {
  static async getAllIzinKaryawan() {
    const [rows] = await db.query(`
      SELECT 
        a.id_izin,
        a.id_karyawan,
        c.nama_user,
        b.posisi_karyawan,
        c.role_user,
        a.id_jenis_izin,
        d.nama_kategori_izin,
        a.start_date,
        a.end_date,
        a.status,
        a.created_at,
        a.updated_at
      FROM tb_izin_karyawan a
      JOIN
        tb_karyawan b on a.id_karyawan = b.id_karyawan
      JOIN
        tb_users c on b.id_user = c.id_user
      JOIN
        tb_kategori_izin d on a.id_jenis_izin = d.id_kategori_izin
      WHERE a.is_deleted = 0;
    `);

    const formattedRows = rows.map(row => ({
        id_izin_karyawan: row.id_izin,
        data_karyawan: {
            id_karyawan: row.id_karyawan,
            nama_karyawan: row.nama_user,
            posisi_karyawan: row.posisi_karyawan,
            role_karyawan: row.role_user,
        },
        data_izin: {
            id_jenis_izin: row.id_jenis_izin,
            nama_kategori_perizinan: row.nama_kategori_izin,
        },
        start_date: row.start_date,
        end_date: row.end_date,
        status: row.status,
        created_at: row.created_at,
        updated_at: row.updated_at,
    }));

    return formattedRows;
  }

  static async createIzinKaryawan(p_idKaryawan, p_idJenisIzin, p_startDate, p_endDate) {
    const [result] = await db.query(
      "INSERT INTO tb_izin_karyawan (id_karyawan, id_jenis_izin, start_date, end_date, status) VALUES (?, ?, ?, ?, 'Pending')",
      [p_idKaryawan, p_idJenisIzin, p_startDate, p_endDate]
    );
    return result.insertId;
  }

  static async updateIzinKaryawan(p_idIzinKaryawan, p_startDate, p_endDate, p_status) {
    await db.query(
      "UPDATE tb_izin_karyawan SET start_date = ?, end_date = ?, status = ? WHERE id_izin = ?",
      [p_startDate, p_endDate, p_status, p_idIzinKaryawan]
    );
  }

  static async deleteIzinKaryawan(p_idIzinKaryawan) {
    await db.query("DELETE FROM tb_izin_karyawan WHERE id_izin = ?", [p_idIzinKaryawan]);
  }
}

module.exports = IzinKaryawan;
