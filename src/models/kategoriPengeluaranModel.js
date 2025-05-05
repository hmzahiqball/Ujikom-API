const db = require("../config/db");

class kategoriPengeluaran {
  static async getAllkategoriPengeluaran() {
    const [rows] = await db.query("SELECT id_kategori_pengeluaran, nama_kategori_pengeluaran, created_at, updated_at FROM tb_kategori_pengeluaran WHERE is_deleted = 0");
    return rows;
  }

  static async getkategoriPengeluaranByID(p_idkategoriPengeluaran) {
    const [result] = await db.query(
        "SELECT id_kategori_pengeluaran, nama_kategori_pengeluaran, created_at, updated_at FROM tb_kategori_pengeluaran WHERE id_kategori_pengeluaran = ? LIMIT 1", 
        [p_idkategoriPengeluaran]);
    return result[0];
  }

  static async createkategoriPengeluaran(p_namakategoriPengeluaran) {
    const [result] = await db.query(
      "INSERT INTO tb_kategori_pengeluaran (kode_kategori_pengeluaran, nama_kategori_pengeluaran) VALUES (CONCAT('SPL', LPAD(LAST_INSERT_ID() + 1, 3, '0')), ?)",
      [p_namakategoriPengeluaran]
    );
    return result.insertId;
  }

  static async updatekategoriPengeluaran(p_idkategoriPengeluaran, p_namakategoriPengeluaran) {
    await db.query(
      "UPDATE tb_kategori_pengeluaran SET nama_kategori_pengeluaran = ? WHERE id_kategori_pengeluaran = ?",
      [p_namakategoriPengeluaran, p_idkategoriPengeluaran]
    );
  }

  static async deletekategoriPengeluaran(p_idkategoriPengeluaran) {
    await db.query("UPDATE tb_kategori_pengeluaran SET is_deleted = 1, deleted_at = NOW() WHERE id_kategori_pengeluaran = ? AND is_deleted = 0", [p_idkategoriPengeluaran]);
  }
}

module.exports = kategoriPengeluaran;
