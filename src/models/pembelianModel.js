const db = require("../config/db");

class Pembelian {
  static async getAllPembelian() {
    const [rows] = await db.query(`
      SELECT 
          p.id_pembelian,
          p.total_harga,
          p.status_pembelian,
          p.created_at AS pembelian_created_at,
          p.updated_at AS pembelian_updated_at,
          
          s.id_suppliers,
          s.nama_suppliers,
          s.contact_person,
          s.contact_suppliers,
          s.email_suppliers,
          s.alamat_suppliers,
          
          dp.id_detail_pembelian,
          dp.kuantitas,
          dp.harga,
          dp.subtotal,
          
          pr.id_produk,
          pr.nama_produk,
          pr.sku_produk,
          pr.barcode_produk,
          pr.deskripsi_produk,
          pr.harga_produk,
          pr.modal_produk,
          pr.stok_produk,
          pr.stok_minimum_produk,
          
          sk.id_subkategori,
          sk.nama_subkategori,
          
          k.id_kategori,
          k.nama_kategori
      FROM tb_pembelian p
      LEFT JOIN tb_suppliers s ON p.id_suppliers = s.id_suppliers
      LEFT JOIN tb_detail_pembelian dp ON p.id_pembelian = dp.id_pembelian
      LEFT JOIN tb_produk pr ON dp.id_produk = pr.id_produk
      LEFT JOIN tb_subkategori sk ON pr.id_kategori = sk.id_subkategori
      LEFT JOIN tb_kategori k ON sk.id_kategori = k.id_kategori
    `);

    const pembelian = {};
    
    rows.forEach(row => {
      if (!pembelian[row.id_pembelian]) {
        pembelian[row.id_pembelian] = {
          id_pembelian: row.id_pembelian,
          total_harga: row.total_harga,
          status_pembelian: row.status_pembelian,
          created_at: row.pembelian_created_at,
          updated_at: row.pembelian_updated_at,
          supplier: {
            id_suppliers: row.id_suppliers,
            nama_suppliers: row.nama_suppliers,
            contact_person: row.contact_person,
            contact_suppliers: row.contact_suppliers,
            email_suppliers: row.email_suppliers,
            alamat_suppliers: row.alamat_suppliers,
          },
          detail_pembelian: []
        };
      }
      
      pembelian[row.id_pembelian].detail_pembelian.push({
        id_detail_pembelian: row.id_detail_pembelian,
        kuantitas: row.kuantitas,
        harga: row.harga,
        subtotal: row.subtotal,
        produk: {
          id_produk: row.id_produk,
          nama_produk: row.nama_produk,
          sku_produk: row.sku_produk,
          barcode_produk: row.barcode_produk,
          deskripsi_produk: row.deskripsi_produk,
          harga_produk: row.harga_produk,
          modal_produk: row.modal_produk,
          stok_produk: row.stok_produk,
          stok_minimum_produk: row.stok_minimum_produk,
          subkategori: {
            id_subkategori: row.id_subkategori,
            nama_subkategori: row.nama_subkategori,
            kategori: {
              id_kategori: row.id_kategori,
              nama_kategori: row.nama_kategori
            }
          }
        }
      });
    });
    
    return Object.values(pembelian);
  }

  static async getPembelianByID(p_idPembelian) {
    const [rows] = await db.query(`
      SELECT 
          p.id_pembelian,
          p.total_harga,
          p.status_pembelian,
          p.created_at AS pembelian_created_at,
          p.updated_at AS pembelian_updated_at,
          
          s.id_suppliers,
          s.nama_suppliers,
          s.contact_person,
          s.contact_suppliers,
          s.email_suppliers,
          s.alamat_suppliers,
          
          dp.id_detail_pembelian,
          dp.kuantitas,
          dp.harga,
          dp.subtotal,
          
          pr.id_produk,
          pr.nama_produk,
          pr.sku_produk,
          pr.barcode_produk,
          pr.deskripsi_produk,
          pr.harga_produk,
          pr.modal_produk,
          pr.stok_produk,
          pr.stok_minimum_produk,
          
          sk.id_subkategori,
          sk.nama_subkategori,
          
          k.id_kategori,
          k.nama_kategori
      FROM tb_pembelian p
      LEFT JOIN tb_suppliers s ON p.id_suppliers = s.id_suppliers
      LEFT JOIN tb_detail_pembelian dp ON p.id_pembelian = dp.id_pembelian
      LEFT JOIN tb_produk pr ON dp.id_produk = pr.id_produk
      LEFT JOIN tb_subkategori sk ON pr.id_kategori = sk.id_subkategori
      LEFT JOIN tb_kategori k ON sk.id_kategori = k.id_kategori
      WHERE p.id_pembelian = ?;
    `, [p_idPembelian]);
    
    if (rows.length === 0) {
        return null;
    }
    const pembelian = {};
    
    rows.forEach(row => {
      if (!pembelian[row.id_pembelian]) {
        pembelian[row.id_pembelian] = {
          id_pembelian: row.id_pembelian,
          total_harga: row.total_harga,
          status_pembelian: row.status_pembelian,
          created_at: row.pembelian_created_at,
          updated_at: row.pembelian_updated_at,
          supplier: {
            id_suppliers: row.id_suppliers,
            nama_suppliers: row.nama_suppliers,
            contact_person: row.contact_person,
            contact_suppliers: row.contact_suppliers,
            email_suppliers: row.email_suppliers,
            alamat_suppliers: row.alamat_suppliers,
          },
          detail_pembelian: []
        };
      }
      
      pembelian[row.id_pembelian].detail_pembelian.push({
        id_detail_pembelian: row.id_detail_pembelian,
        kuantitas: row.kuantitas,
        harga: row.harga,
        subtotal: row.subtotal,
        produk: {
          id_produk: row.id_produk,
          nama_produk: row.nama_produk,
          sku_produk: row.sku_produk,
          barcode_produk: row.barcode_produk,
          deskripsi_produk: row.deskripsi_produk,
          harga_produk: row.harga_produk,
          modal_produk: row.modal_produk,
          stok_produk: row.stok_produk,
          stok_minimum_produk: row.stok_minimum_produk,
          subkategori: {
            id_subkategori: row.id_subkategori,
            nama_subkategori: row.nama_subkategori,
            kategori: {
              id_kategori: row.id_kategori,
              nama_kategori: row.nama_kategori
            }
          }
        }
      });
    });
    
    return Object.values(pembelian);
  }

  static async createPembelian(p_idSuppliers, p_totalHarga, p_details, p_tanggal) {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();
      
      // Insert into tb_pembelian
      const [purchaseResult] = await connection.query(
        "INSERT INTO tb_pembelian (id_suppliers, total_harga, status_pembelian, tanggal_pembelian) VALUES (?, ?, 'Pending', ?)",
        [p_idSuppliers, p_totalHarga, p_tanggal]
      );
      const purchaseId = purchaseResult.insertId;

      // Insert into tb_detail_pembelian
      for (const detail of p_details) {
        const { p_idProduk, p_kuantitas, p_harga, p_subTotal } = detail;
        await connection.query(
          "INSERT INTO tb_detail_pembelian (id_pembelian, id_produk, kuantitas, harga, subtotal) VALUES (?, ?, ?, ?, ?)",
          [purchaseId, p_idProduk, p_kuantitas, p_harga, p_subTotal]
        );
      }
      
      await connection.commit();
      return purchaseId;
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }

  static async updatePembelian(p_idPembelian, p_idSuppliers, p_totalHarga, p_statusPembelian) {
    await db.query(
      "UPDATE tb_pembelian SET id_suppliers = ?, total_harga = ?, status_pembelian = ? WHERE id_pembelian = ?",
      [p_idSuppliers, p_totalHarga, p_statusPembelian, p_idPembelian]
    );
  }

  static async deletePembelian(p_idPembelian) {
    await db.query("DELETE FROM tb_pembelian WHERE id_pembelian = ?", [p_idPembelian]);
  }
}

module.exports = Pembelian;
