const db = require("../config/db");
const formatWIB = require("../utils/time");

class Pengeluaran {
  static async getAllPengeluaran(tanggal = null) {
    const whereClauses = ["a.is_deleted = 0"];
    const values = [];

    if (tanggal) {
      if (tanggal.includes("_")) {
        const [start, end] = tanggal.split("_");
        whereClauses.push(`DATE(a.tanggal) BETWEEN ? AND ?`);
        values.push(start, end);
      } else {
        whereClauses.push(`DATE(a.tanggal) = ?`);
        values.push(tanggal);
      }
    }

    const [rows] = await db.query(`
      SELECT 
        a.id_pengeluaran,
        a.kode_pengeluaran,
        b.nama_kategori_pengeluaran,
        a.total_pengeluaran,
        a.deskripsi_pengeluaran,
        a.tanggal,
        a.created_at,
        a.updated_at
      FROM tb_pengeluaran a
      JOIN
        tb_kategori_pengeluaran b on a.id_kategori_pengeluaran = b.id_kategori_pengeluaran
      WHERE ${whereClauses.join(" AND ")}
    `, values);

    const formattedRows = rows.map(row => ({
        id_pengeluaran: row.id_pengeluaran,
        kode_pengeluaran: row.kode_pengeluaran,
        nama_kategori_pengeluaran: row.nama_kategori_pengeluaran,
        total_pengeluaran: row.total_pengeluaran,
        deskripsi_pengeluaran: row.deskripsi_pengeluaran,
        tanggal: formatWIB(row.tanggal),
        created_at: row.created_at,
        updated_at: row.updated_at,
    }));

    return formattedRows;
  }

  static async createPengeluaran(p_idKategoriPengeluaran, p_totalPengeluaran, p_deskripsiPengeluaran, p_tanggal) {
    const [result] = await db.query(
      "INSERT INTO tb_pengeluaran (id_kategori_pengeluaran, total_pengeluaran, deskripsi_pengeluaran, tanggal) VALUES (?, ?, ?, ?)",
      [p_idKategoriPengeluaran, p_totalPengeluaran, p_deskripsiPengeluaran, p_tanggal]
    );
    return result.insertId;
  }

  static async updatePengeluaran(p_idPengeluaran, p_idKategoriPengeluaran, p_totalPengeluaran, p_deskripsiPengeluaran, p_tanggal) {
    await db.query(
      "UPDATE tb_pengeluaran SET id_kategori_pengeluaran = ?, total_pengeluaran = ?, deskripsi_pengeluaran = ?, tanggal = ? WHERE id_pengeluaran = ?",
      [p_idKategoriPengeluaran, p_totalPengeluaran, p_deskripsiPengeluaran, p_tanggal, p_idPengeluaran]
    );
  }

  static async deletePengeluaran(p_idPengeluaran) {
    await db.query(
      "UPDATE tb_pengeluaran SET is_deleted = 1, deleted_at = NOW() WHERE id_pengeluaran = ? AND is_deleted = 0",
      [p_idPengeluaran]
    );
  }
}

module.exports = Pengeluaran;
