const db = require("../config/db");

class LaporanStok {
  static async getAllLaporanStok() {
    const [rows] = await db.query(`
        SELECT 
            A.id_laporan_stok,
            B.nama_produk,
            A.perubahan_stok,
            A.alasan_perubahan,
            A.nama_karyawan,
            A.created_at,
            A.updated_at
        FROM
            tb_stok_produk A
        JOIN
            tb_produk B ON A.id_produk = B.id_produk;`);
    return rows;
  }

  static async createLaporanStok(p_idProduk, p_namaKaryawan, p_perubahanStok, p_alasanPerubahan) {
    const [result] = await db.query(
      "INSERT INTO tb_stok_produk (id_produk, perubahan_stok, alasan_perubahan, nama_karyawan) VALUES (?, ?, ?, ?)",
      [p_idProduk, p_perubahanStok, p_alasanPerubahan, p_namaKaryawan]
    );
    return result.insertId;
  }

  static async deleteLaporanStok(p_idLaporanStok) {
    await db.query("DELETE FROM tb_stok_produk WHERE id_laporan_stok = ?", [p_idLaporanStok]);
  }
}

module.exports = LaporanStok;
