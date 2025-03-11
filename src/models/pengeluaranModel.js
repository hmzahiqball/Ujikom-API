const db = require("../config/db");

class Pengeluaran {
  static async getAllPengeluaran() {
    const [rows] = await db.query(`
      SELECT 
        a.id_pengeluaran,
        b.nama_kategori_pengeluaran,
        a.total_pengeluaran,
        a.deskripsi_pengeluaran,
        a.tanggal,
        a.created_at,
        a.updated_at
      FROM tb_pengeluaran a
      JOIN
        tb_kategori_pengeluaran b on a.id_kategori_pengeluaran = b.id_kategori_pengeluaran;
    `);

    const formattedRows = rows.map(row => ({
        id_pengeluaran: row.id_pengeluaran,
        nama_kategori_pengeluaran: row.nama_kategori_pengeluaran,
        total_pengeluaran: row.total_pengeluaran,
        deskripsi_pengeluaran: row.deskripsi_pengeluaran,
        tanggal: row.tanggal,
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
    await db.query("DELETE FROM tb_pengeluaran WHERE id_pengeluaran = ?", [p_idPengeluaran]);
  }
}

module.exports = Pengeluaran;
