const db = require("../config/db");
const formatWIB = require("../utils/time");
const moment = require("moment");

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
        b.id_kategori_pengeluaran,
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
        id_kategori_pengeluaran: row.id_kategori_pengeluaran,
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
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();
        
      // Insert into tb_pembelian
      const [kategoriResult] = await connection.query("SELECT kode_kategori_pengeluaran FROM tb_kategori_pengeluaran WHERE id_kategori_pengeluaran = ?", [p_idKategoriPengeluaran]);
      const kodePengeluaran = `${kategoriResult[0].kode_kategori_pengeluaran}-${moment(p_tanggal).format('DDMMYY')}`;
      const [pengeluaranResult] = await connection.query(
        "INSERT INTO tb_pengeluaran (id_kategori_pengeluaran, kode_pengeluaran, total_pengeluaran, deskripsi_pengeluaran, tanggal) VALUES (?, ?, ?, ?, ?)",
        [p_idKategoriPengeluaran, kodePengeluaran, p_totalPengeluaran, p_deskripsiPengeluaran, p_tanggal]
      );
      const pengeluaranId = pengeluaranResult.insertId;
        
      await connection.commit();
      return pengeluaranId;
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
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
