const db = require("../config/db");
const formatWIB = require("../utils/time");

class Promo {
  static async getAllPromo() {
    const [rows] = await db.query("SELECT id_promo, nama_promo, kode_promo, tipe_promo, total_promo, kuota_promo, tanggal_mulai, tanggal_akhir, min_belanja, status_promo, created_at, updated_at FROM tb_promo WHERE status_promo = 'aktif'");
    return rows.map(row => ({
      ...row,
      tanggal_mulai: row.tanggal_mulai.toISOString().split('T')[0],
      tanggal_akhir: row.tanggal_akhir.toISOString().split('T')[0],
      created_at: formatWIB(row.created_at),
      updated_at: formatWIB(row.updated_at)
    }));
  }

  static async getAllPromo_notFiltered() {
    const [rows] = await db.query("SELECT id_promo, nama_promo, kode_promo, tipe_promo, total_promo, kuota_promo, tanggal_mulai, tanggal_akhir, min_belanja, status_promo, created_at, updated_at FROM tb_promo");
    return rows.map(row => ({
      ...row,
      tanggal_mulai: row.tanggal_mulai.toISOString().split('T')[0],
      tanggal_akhir: row.tanggal_akhir.toISOString().split('T')[0],
      created_at: formatWIB(row.created_at),
      updated_at: formatWIB(row.updated_at)
    }));
  }

  static async getPromoByID(p_idPromo) {
    const [result] = await db.query(
        "SELECT id_promo, nama_promo, kode_promo, tipe_promo, total_promo, kuota_promo, tanggal_mulai, tanggal_akhir, min_belanja, status_promo, created_at, updated_at FROM tb_promo WHERE id_promo = ? LIMIT 1", 
        [p_idPromo]);
        return rows.map(row => ({
      ...row,
      tanggal_mulai: row.tanggal_mulai.toISOString().split('T')[0],
      tanggal_akhir: row.tanggal_akhir.toISOString().split('T')[0],
      created_at: formatWIB(row.created_at),
      updated_at: formatWIB(row.updated_at)
    }));
  }

  static async getTax() {
    const [result] = await db.query(
      "SELECT * FROM tb_settings WHERE key_settings = ? LIMIT 1", 
      ['tax']
    );
    return result;
  }

  static async createSetting(p_key, p_value) {
    const [result] = await db.query(
      "INSERT INTO tb_settings (key_settings, value) VALUES (?, ?)",
      [p_key, p_value]
    );
    return result.insertId;
  }

  static async updateSetting(p_idSettings, p_value) {
    if (!p_idSettings || p_idSettings === 999) {
      // Cek dulu, udah ada setting tax belum?
      const [existing] = await db.query(
        "SELECT * FROM tb_settings WHERE key_settings = 'tax' LIMIT 1"
      );
    
      if (existing.length > 0) {
        // Update aja langsung
        await db.query(
          "UPDATE tb_settings SET value = ? WHERE key_settings = 'tax'",
          [p_value]
        );
      } else {
        // Insert baru karena belum ada
        await db.query(
          "INSERT INTO tb_settings (key_settings, value) VALUES (?, ?)",
          ['tax', p_value]
        );
      }
      return;
    }
  
    // Kalau id nya valid dan bukan 999, update by id
    const [result] = await db.query(
      "UPDATE tb_settings SET value = ? WHERE id_settings = ?",
      [p_value, p_idSettings]
    );
  
    console.log('-> Update result:', result);
  
    // Kalau ga keupdate (id ga valid?), fallback ke insert tax
    if (result.affectedRows === 0) {
      await db.query(
        "INSERT INTO tb_settings (key_settings, value) VALUES (?, ?)",
        ['tax', p_value]
      );
    }
  }

  static async createPromo(p_namaPromo, p_kodePromo, p_tipePromo, p_totalPromo, p_kuotaPromo, p_tanggalMulai, p_tanggalAkhir, p_minBelanja, p_statusPromo) {
    const [result] = await db.query(
      "INSERT INTO tb_promo (nama_promo, kode_promo, tipe_promo, total_promo, kuota_promo, tanggal_mulai, tanggal_akhir, min_belanja, status_promo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
      [p_namaPromo, p_kodePromo, p_tipePromo, p_totalPromo, p_kuotaPromo, p_tanggalMulai, p_tanggalAkhir, p_minBelanja, p_statusPromo]
    );
    return result.insertId;
  }

  static async updatePromo(p_idPromo, p_namaPromo, p_kodePromo, p_tipePromo, p_totalPromo, p_kuotaPromo, p_tanggalMulai, p_tanggalAkhir, p_minBelanja, p_statusPromo) {
    await db.query(
      "UPDATE tb_promo SET nama_promo = ?, kode_promo = ?, tipe_promo = ?, total_promo = ?, kuota_promo = ?, tanggal_mulai = ?, tanggal_akhir = ?, min_belanja = ?, status_promo = ? WHERE id_promo = ?",
      [p_namaPromo, p_kodePromo, p_tipePromo, p_totalPromo, p_kuotaPromo, p_tanggalMulai, p_tanggalAkhir, p_minBelanja, p_statusPromo, p_idPromo]
    );
  }

  static async deletePromo(p_idPromo) {
    await db.query("UPDATE tb_promo SET status_promo = 'nonaktif' WHERE id_promo = ?", [p_idPromo]);
  }
}

module.exports = Promo;

