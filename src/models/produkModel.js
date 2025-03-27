const db = require("../config/db");

class Produk {
  static async getAllProduk() {
    const [rows] = await db.query(
        "SELECT id_produk, id_kategori, nama_produk, sku_produk, barcode_produk, deskripsi_produk, harga_produk, modal_produk, stok_produk, stok_minimum_produk, gambar_produk, created_at, updated_at FROM tb_produk");
    return rows;
  }

  static async getProdukByID(p_idProduk) {
    const [result] = await db.query(
        "SELECT id_produk, id_kategori, nama_produk, sku_produk, barcode_produk, deskripsi_produk, harga_produk, modal_produk, stok_produk, stok_minimum_produk, gambar_produk, created_at, updated_at FROM tb_produk WHERE id_produk = ? LIMIT 1", 
        [p_idProduk]);
    return result[0];
  }

  static async createProduk(p_idKategori, p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_stokProduk, p_stokMinimumProduk, p_gambarProduk) {
    const [result] = await db.query(
      "INSERT INTO tb_produk (id_kategori, nama_produk, sku_produk, barcode_produk, deskripsi_produk, harga_produk, modal_produk, stok_produk, stok_minimum_produk, gambar_produk) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
      [p_idKategori, p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_stokProduk, p_stokMinimumProduk, p_gambarProduk]
    );
    return result.insertId;
  }

  static async updateProduk(p_idProduk, p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_stokProduk, p_stokMinimumProduk, p_gambarProduk) {
    await db.query(
      "UPDATE tb_produk SET nama_produk = ?, sku_produk = ?, barcode_produk = ?, deskripsi_produk = ?, harga_produk = ?, modal_produk = ?, stok_produk = ?, stok_minimum_produk = ?, gambar_produk = ? WHERE id_produk = ?",
      [p_namaProduk, p_skuProduk, p_barcodeProduk, p_deskripsiProduk, p_hargaProduk, p_modalProduk, p_stokProduk, p_stokMinimumProduk, p_gambarProduk, p_idProduk]
    );
  }

  static async deleteProduk(p_idProduk) {
    await db.query("DELETE FROM tb_produk WHERE id_produk = ?", [p_idProduk]);
  }
}

module.exports = Produk;
