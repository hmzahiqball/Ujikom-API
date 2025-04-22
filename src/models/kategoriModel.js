const db = require("../config/db");
const formatWIB = require("../utils/time");

class Kategori {
  static async getAllKategori() {
    const [categories] = await db.query(`
      SELECT 
        k.id_kategori AS p_id_kategori, 
        k.nama_kategori AS p_nama_kategori, 
        k.created_at, 
        k.updated_at
      FROM tb_kategori k
      WHERE k.is_deleted = 0
    `);

    const rows = [];

    for (const category of categories) {
      const [subcategories] = await db.query(`
        SELECT 
          s.id_subkategori AS id_subkategori, 
          s.nama_subkategori AS nama_subkategori,
          s.created_at,
          s.updated_at
        FROM tb_subkategori s
        WHERE s.id_kategori = ?
        AND s.is_deleted = 0
      `, [category.p_id_kategori]);

      const subcategoriesFormated = subcategories.map(subcategory => ({
        ...subcategory,
        created_at: formatWIB(subcategory.created_at),
        updated_at: formatWIB(subcategory.updated_at)
      }));

      rows.push({
        id_kategori: category.p_id_kategori,
        nama_kategori: category.p_nama_kategori,
        data_subkategori: subcategoriesFormated,
        created_at: formatWIB(category.created_at),
        updated_at: formatWIB(category.updated_at)
      });
    }

    return rows;
  }

  static async createKategori(p_namaKategori) {
    const [result] = await db.query(
      "INSERT INTO tb_kategori (nama_kategori) VALUES (?)",
      [p_namaKategori]
    );
    return result.insertId;
  }

  static async createSubKategori(p_idKategori, p_namaSubKategori) {
    const [result] = await db.query(
      "INSERT INTO tb_subkategori (id_kategori, nama_subkategori) VALUES (?, ?)",
      [p_idKategori, p_namaSubKategori]
    );
    return result.insertId;
  }

  static async updateKategori(p_idKategori, p_namaKategori) {
    await db.query(
      "UPDATE tb_kategori SET nama_kategori = ? WHERE id_kategori = ?",
      [p_namaKategori, p_idKategori]
    );
  }

  static async updateSubKategori(p_idSubKategori, p_namaSubKategori) {
    await db.query(
      "UPDATE tb_subkategori SET nama_subkategori = ? WHERE id_subkategori = ?",
      [p_namaSubKategori, p_idSubKategori]
    );
  }

  static async deleteKategori(p_idKategori) {
    await db.query(
      "UPDATE tb_kategori SET is_deleted = 1, deleted_at = NOW() WHERE id_kategori = ? AND is_deleted = 0",
      [p_idKategori]
    );
  }

  static async deleteSubKategori(p_idSubKategori) {
    await db.query(
      "UPDATE tb_subkategori SET is_deleted = 1, deleted_at = NOW() WHERE id_subkategori = ? AND is_deleted = 0",
      [p_idSubKategori]
    );
  }
}

module.exports = Kategori;
