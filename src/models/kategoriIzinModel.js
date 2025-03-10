const db = require("../config/db");

class KategoriIzin {
  static async getAllKategoriIzin() {
    const [rows] = await db.query("SELECT id_kategori_izin, nama_kategori_izin, created_at, updated_at FROM tb_kategori_izin");
    return rows;
  }

  static async getKategoriIzinByID(p_idKategoriIzin) {
    const [result] = await db.query(
        "SELECT id_kategori_izin, nama_kategori_izin, created_at, updated_at FROM tb_kategori_izin WHERE id_kategori_izin = ? LIMIT 1", 
        [p_idKategoriIzin]);
    return result[0];
  }

  static async createKategoriIzin(p_namaKategoriIzin) {
    const [result] = await db.query(
      "INSERT INTO tb_kategori_izin (nama_kategori_izin) VALUES (?)",
      [p_namaKategoriIzin]
    );
    return result.insertId;
  }

  static async updateKategoriIzin(p_idKategoriIzin, p_namaKategoriIzin) {
    await db.query(
      "UPDATE tb_kategori_izin SET nama_kategori_izin = ? WHERE id_kategori_izin = ?",
      [p_namaKategoriIzin, p_idKategoriIzin]
    );
  }

  static async deleteKategoriIzin(p_idKategoriIzin) {
    await db.query("DELETE FROM tb_kategori_izin WHERE id_kategori_izin = ?", [p_idKategoriIzin]);
  }
}

module.exports = KategoriIzin;
