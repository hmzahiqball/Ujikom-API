const db = require("../config/db");
const formatWIB = require("../utils/time");

class Penjualan {
  static async getAllPenjualan(idpetugas = null, tanggal = null) {
    const whereClauses = [];
    const values = [];
  
    // Filter berdasarkan id petugas (jika ada)
    if (idpetugas) {
      whereClauses.push("p.id_karyawan = ?");
      values.push(idpetugas);
    }
  
    // Filter berdasarkan tanggal (jika ada)
    if (tanggal) {
      if (tanggal.includes("_")) {
        // Format rentang tanggal: YYYY-MM-DD_YYYY-MM-DD
        const [start, end] = tanggal.split("_");
        whereClauses.push("DATE(p.tanggal_penjualan) BETWEEN ? AND ?");
        values.push(start, end);
      } else {
        // Format tanggal tunggal: YYYY-MM-DD
        whereClauses.push("DATE(p.tanggal_penjualan) = ?");
        values.push(tanggal);
      }
    }
  
    // Susun query akhir
    const query = `
      SELECT 
          p.id_penjualan, prm.nama_promo, prm.kode_promo, p.persen_pajak, p.total_pajak, p.tipe_pembayaran, p.total_harga, p.total_bayar, p.total_kembalian, p.diskon_penjualan, p.status_pembayaran, p.kode_penjualan, p.tanggal_penjualan,
          p.created_at AS penjualan_created_at, p.updated_at AS penjualan_updated_at,
          s.id_customers, s.nama_customers, s.telp_customers, s.email_customers,
          kar.id_karyawan, u.nama_user, u.contact_user, kar.posisi_karyawan,
          dp.id_detail_penjualan, dp.kuantitas, dp.harga, dp.subtotal, dp.diskon_produk,
          pr.id_produk, pr.nama_produk, pr.sku_produk, pr.barcode_produk, pr.deskripsi_produk,
          pr.harga_produk, pr.modal_produk, pr.stok_produk, pr.stok_minimum_produk,
          sk.id_subkategori, sk.nama_subkategori, k.id_kategori, k.nama_kategori
      FROM tb_penjualan p
      LEFT JOIN tb_customers s ON p.id_customers = s.id_customers
      LEFT JOIN tb_karyawan kar ON p.id_karyawan = kar.id_karyawan
      LEFT JOIN tb_users u ON kar.id_user = u.id_user
      LEFT JOIN tb_detail_penjualan dp ON p.id_penjualan = dp.id_penjualan
      LEFT JOIN tb_produk pr ON dp.id_produk = pr.id_produk
      LEFT JOIN tb_subkategori sk ON pr.id_kategori = sk.id_subkategori
      LEFT JOIN tb_kategori k ON sk.id_kategori = k.id_kategori
      LEFT JOIN tb_promo prm ON p.id_promo = prm.id_promo
      ${whereClauses.length ? `WHERE ${whereClauses.join(" AND ")} AND ` : "WHERE "}p.is_deleted = 0
    `;
  
    const [rows] = await db.query(query, values);
  
    // Format ulang hasil penjualan
    const penjualan = {};

    rows.forEach(row => {
      if (!penjualan[row.id_penjualan]) {
        penjualan[row.id_penjualan] = {
          id_penjualan: row.id_penjualan,
          kode_penjualan: row.kode_penjualan,
          nama_promo: row.nama_promo === null ? "-" : row.nama_promo,
          kode_promo: row.kode_promo === null ? "-" : row.kode_promo,
          persen_pajak: row.persen_pajak,
          total_pajak: row.total_pajak,
          total_harga: row.total_harga,
          total_bayar: row.total_bayar,
          total_kembalian: row.total_kembalian,
          diskon_penjualan: row.diskon_penjualan,
          total_kuantitas: 0,
          total_pendapatan: 0, // Pendapatan = total harga jual - total modal
          tipe_pembayaran: row.tipe_pembayaran,
          status_pembayaran: row.status_pembayaran,
          tanggal_penjualan: formatWIB(row.tanggal_penjualan),
          created_at: formatWIB(row.penjualan_created_at),
          updated_at: formatWIB(row.penjualan_updated_at),
          customers: {
            id_customers: row.id_customers,
            nama_customers: row.nama_customers,
            telp_customers: row.telp_customers,
            email_customers: row.email_customers,
          },
          karyawan: {
            id_karyawan: row.id_karyawan,
            nama_user: row.nama_user,
            posisi_karyawan: row.posisi_karyawan,
            contact_user: row.contact_user,
          },
          detail_penjualan: [],
        };
      }
    
      // Isi detail penjualan jika ada
      if (row.id_detail_penjualan) {
        penjualan[row.id_penjualan].detail_penjualan.push({
          id_detail_penjualan: row.id_detail_penjualan,
          kuantitas: row.kuantitas,
          harga: row.harga,
          subtotal: row.subtotal,
          diskon_produk: row.diskon_produk,
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
                nama_kategori: row.nama_kategori,
              },
            },
          },
        });
      
        // Tambahkan ke total kuantitas dan pendapatan
        penjualan[row.id_penjualan].total_kuantitas += row.kuantitas;
        const harga_jual_total = row.harga * row.kuantitas;
        const harga_modal_total = row.modal_produk * row.kuantitas;
        penjualan[row.id_penjualan].total_pendapatan += harga_jual_total - harga_modal_total;
      }
    });

    return Object.values(penjualan);
  }

  static async getPenjualanByKode(kode_penjualan) {
    const query = `
      SELECT 
        p.id_penjualan, prm.nama_promo, prm.kode_promo, p.persen_pajak, p.total_pajak, p.tipe_pembayaran, 
        p.total_harga, p.total_bayar, p.total_kembalian, p.diskon_penjualan, p.status_pembayaran, p.kode_penjualan, 
        p.tanggal_penjualan,
        p.created_at AS penjualan_created_at, p.updated_at AS penjualan_updated_at,
        s.id_customers, s.nama_customers, s.telp_customers, s.email_customers,
        kar.id_karyawan, u.nama_user, u.contact_user, kar.posisi_karyawan,
        dp.id_detail_penjualan, dp.kuantitas, dp.harga, dp.subtotal, dp.diskon_produk,
        pr.id_produk, pr.nama_produk, pr.sku_produk, pr.barcode_produk, pr.deskripsi_produk,
        pr.harga_produk, pr.modal_produk, pr.stok_produk, pr.stok_minimum_produk,
        sk.id_subkategori, sk.nama_subkategori, k.id_kategori, k.nama_kategori
      FROM tb_penjualan p
      LEFT JOIN tb_customers s ON p.id_customers = s.id_customers
      LEFT JOIN tb_karyawan kar ON p.id_karyawan = kar.id_karyawan
      LEFT JOIN tb_users u ON kar.id_user = u.id_user
      LEFT JOIN tb_detail_penjualan dp ON p.id_penjualan = dp.id_penjualan
      LEFT JOIN tb_produk pr ON dp.id_produk = pr.id_produk
      LEFT JOIN tb_subkategori sk ON pr.id_kategori = sk.id_subkategori
      LEFT JOIN tb_kategori k ON sk.id_kategori = k.id_kategori
      LEFT JOIN tb_promo prm ON p.id_promo = prm.id_promo
      WHERE p.is_deleted = 0 AND p.kode_penjualan = ?
    `;

    const [rows] = await db.query(query, [kode_penjualan]);

    if (!rows.length) return null;

    const row = rows[0];
    const penjualan = {
      id_penjualan: row.id_penjualan,
      kode_penjualan: row.kode_penjualan,
      nama_promo: row.nama_promo ?? "-",
      kode_promo: row.kode_promo ?? "-",
      persen_pajak: row.persen_pajak,
      total_pajak: row.total_pajak,
      total_harga: row.total_harga,
      total_bayar: row.total_bayar,
      total_kembalian: row.total_kembalian,
      diskon_penjualan: row.diskon_penjualan,
      tipe_pembayaran: row.tipe_pembayaran,
      status_pembayaran: row.status_pembayaran,
      tanggal_penjualan: formatWIB(row.tanggal_penjualan),
      created_at: formatWIB(row.penjualan_created_at),
      updated_at: formatWIB(row.penjualan_updated_at),
      customers: {
        id_customers: row.id_customers,
        nama_customers: row.nama_customers,
        telp_customers: row.telp_customers,
        email_customers: row.email_customers,
      },
      karyawan: {
        id_karyawan: row.id_karyawan,
        nama_user: row.nama_user,
        posisi_karyawan: row.posisi_karyawan,
        contact_user: row.contact_user,
      },
      detail_penjualan: [],
      total_kuantitas: 0,
      total_pendapatan: 0,
    };

    rows.forEach(item => {
      if (item.id_detail_penjualan) {
        penjualan.detail_penjualan.push({
          id_detail_penjualan: item.id_detail_penjualan,
          kuantitas: item.kuantitas,
          harga: item.harga,
          subtotal: item.subtotal,
          diskon_produk: item.diskon_produk,
          produk: {
            id_produk: item.id_produk,
            nama_produk: item.nama_produk,
            sku_produk: item.sku_produk,
            barcode_produk: item.barcode_produk,
            deskripsi_produk: item.deskripsi_produk,
            harga_produk: item.harga_produk,
            modal_produk: item.modal_produk,
            stok_produk: item.stok_produk,
            stok_minimum_produk: item.stok_minimum_produk,
            subkategori: {
              id_subkategori: item.id_subkategori,
              nama_subkategori: item.nama_subkategori,
              kategori: {
                id_kategori: item.id_kategori,
                nama_kategori: item.nama_kategori,
              },
            },
          },
        });

        penjualan.total_kuantitas += item.kuantitas;
        const total_jual = item.harga * item.kuantitas;
        const total_modal = item.modal_produk * item.kuantitas;
        penjualan.total_pendapatan += (total_jual - total_modal);
      }
    });

    return penjualan;
  }


  static async createPenjualan({
      idCustomers,
      idKaryawan,
      idPromo,
      totalHarga,
      totalBayar,
      totalKembalian,
      diskon,
      persenPajak,
      totalPajak,
      tipePembayaran,
      detailPenjualan,
      tanggal
    }) {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();
      
      // Generate kode penjualan (misal: PNJ-20250417-0001)
      const datePart = new Date().toISOString().slice(0,10).replace(/-/g, '');
      const [kodeResult] = await connection.query("SELECT COUNT(*) as total FROM tb_penjualan WHERE DATE(tanggal_penjualan) = CURDATE()");
      const urutan = String(kodeResult[0].total + 1).padStart(4, '0');
        
      // Ambil kode_user dari id_karyawan → id_user → kode_user
      const [userKodeResult] = await connection.query(`
        SELECT u.kode_user
        FROM tb_karyawan k
        JOIN tb_users u ON k.id_user = u.id_user
        WHERE k.id_karyawan = ?
      `, [idKaryawan]);

      if (userKodeResult.length === 0) {
        throw new Error('Kode user tidak ditemukan untuk karyawan ini');
      }

      const kodeUser = userKodeResult[0].kode_user;
      const kodePenjualan = `${kodeUser}-${datePart}-${urutan}`;
      
      // Insert tb_penjualan
      const [penjualanResult] = await connection.query(
        `INSERT INTO tb_penjualan 
          (id_customers, id_karyawan, id_promo, kode_penjualan, persen_pajak, total_pajak, total_harga, total_bayar, total_kembalian, diskon_penjualan, tipe_pembayaran, status_pembayaran, tanggal_penjualan)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Success', ?)`,
        [idCustomers, idKaryawan, idPromo, kodePenjualan, persenPajak, totalPajak, totalHarga, totalBayar, totalKembalian, diskon, tipePembayaran, tanggal]
      );
      
      const penjualanId = penjualanResult.insertId;
      
      // Insert ke detail penjualan
      for (const detail of detailPenjualan) {
        const { p_idProduk, p_kuantitas, p_harga, p_subTotal, p_diskonProduk } = detail;
        await connection.query(
          "INSERT INTO tb_detail_penjualan (id_penjualan, id_produk, kuantitas, harga, subtotal, diskon_produk) VALUES (?, ?, ?, ?, ?, ?)",
          [penjualanId, p_idProduk, p_kuantitas, p_harga, p_subTotal, p_diskonProduk]
        );

        // Kurangi stok produk
        await connection.query(
          "UPDATE tb_produk SET stok_produk = stok_produk - ? WHERE id_produk = ?",
          [p_kuantitas, p_idProduk]
        );
      }
      
      let namaPromo = null;
      let kodePromo = null;

      if (idPromo) {
        const [promoResult] = await connection.query(
          "SELECT nama_promo, kode_promo FROM tb_promo WHERE id_promo = ?",
          [idPromo]
        );
      
        if (promoResult.length > 0) {
          namaPromo = promoResult[0].nama_promo;
          kodePromo = promoResult[0].kode_promo;
        }
      }
      
      await connection.commit();
      return { penjualanId, kodePenjualan, namaPromo, kodePromo };
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
  
    
  static async updatePenjualan(p_idPenjualan, p_idCustomers, p_idKaryawan, p_totalHarga, p_statusPenjualan) {
    await db.query(
      "UPDATE tb_penjualan SET id_customers = ?, id_karyawan = ?, total_harga = ?, status_pembayaran = ? WHERE id_penjualan = ?",
      [p_idCustomers, p_idKaryawan, p_totalHarga, p_statusPenjualan, p_idPenjualan]
    );
  }

  static async deletePenjualan(p_idPenjualan) {
    await db.query("UPDATE tb_penjualan SET is_deleted = 1, deleted_at = NOW() WHERE id_penjualan = ? AND is_deleted = 0", [p_idPenjualan]);
  }
}

module.exports = Penjualan;
