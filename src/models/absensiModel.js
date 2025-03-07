const db = require("../config/db");

class Karyawan {
  static async getAllKehadiran() {
    const [rows] = await db.query(`
        SELECT
            a.id_kehadiran,
            c.nama_user,
            b.id_karyawan,
            b.posisi_karyawan,
            d.id_shifts,
            d.nama_shifts,
            d.start_time,
            d.end_time,
            a.tanggal_kehadiran,
            a.clock_in,
            a.clock_out,
            a.total_jam_kerja,
            a.total_overtime,
            a.created_at,
            a.updated_at
        FROM
            tb_kehadiran a
        JOIN
            tb_karyawan b ON a.id_karyawan = b.id_karyawan
        JOIN
            tb_users c ON b.id_user = c.id_user
        JOIN
            tb_shifts d ON b.id_shifts = d.id_shifts;
    `);

    return rows.map(row => ({
        p_idKehadiran: row.id_kehadiran,
        p_tanggalKehadiran: row.tanggal_kehadiran,
        p_clockIn: row.clock_in,
        p_clockOut: row.clock_out,
        p_totalJamKerja: row.total_jam_kerja,
        p_totalOvertime: row.total_overtime,
        p_karyawan: {
            p_idKaryawan: row.id_karyawan,
            p_namaKaryawan: row.nama_user,
            p_posisiKaryawan: row.posisi_karyawan
        },
        p_shift: {
            p_idShifts: row.id_shifts,
            p_namaShifts: row.nama_shifts,
            p_startTime: row.start_time,
            p_endTime: row.end_time
        },
        created_at: row.created_at,
        updated_at: row.updated_at,
    }));
  }

  static async clockIn(p_idKaryawan) {
    const now = new Date();
    const tanggal = now.toISOString().split("T")[0]; // Format YYYY-MM-DD
    const clockInTime = now.toTimeString().split(" ")[0]; // Format HH:MM:SS

    const [result] = await db.query(`
        INSERT INTO tb_kehadiran (id_karyawan, tanggal_kehadiran, clock_in)
        VALUES (?, ?, ?)`, 
        [p_idKaryawan, tanggal, clockInTime]
    );

    const [karyawanRows] = await db.query(`
        SELECT b.nama_user 
        FROM 
            tb_karyawan a  
        JOIN 
            tb_users b ON a.id_user = b.id_user
        WHERE 
            a.id_karyawan = ? ;`, [p_idKaryawan]);
    const namaKaryawan = karyawanRows[0].nama_karyawan;

    return { p_idKehadiran: result.insertId, p_namaKaryawan: namaKaryawan, p_tanggal: tanggal, p_waktuClockin: clockInTime };
  }

  static async clockOut(p_idKehadiran) {
    const now = new Date();
    const tanggal = now.toISOString().split("T")[0]; // Format YYYY-MM-DD
    const clockOutTime = now.toTimeString().split(" ")[0]; // Format HH:MM:SS

    // Ambil data clock_in dan shift
    const [rows] = await db.query(`
        SELECT k.clock_in, s.start_time, s.end_time, us.nama_user
        FROM tb_kehadiran k
        JOIN tb_karyawan ka ON k.id_karyawan = ka.id_karyawan
        JOIN tb_users us ON ka.id_user = us.id_user
        JOIN tb_shifts s ON ka.id_shifts = s.id_shifts
        WHERE k.id_kehadiran = ?
    `, [p_idKehadiran]);

    if (rows.length === 0) throw new Error("Data kehadiran tidak ditemukan");

    const { clock_in, start_time, end_time, nama_karyawan } = rows[0];

    // Hitung Total Jam Kerja
    const totalWorkHours = calculateTimeDifference(clock_in, clockOutTime);

    // Hitung Overtime
    let overtime = "0j 0m";
    if (end_time) {
      overtime = calculateTimeDifference(end_time, clockOutTime);
    }

    // Update data ke database
    await db.query(`
        UPDATE tb_kehadiran 
        SET clock_out = ?, total_jam_kerja = ?, total_overtime = ?
        WHERE id_kehadiran = ?
    `, [clockOutTime, totalWorkHours, overtime, p_idKehadiran]);

    return { p_idKehadiran, p_tanggal: tanggal, p_clockIn: clock_in, p_namaKaryawan: nama_karyawan, p_clockOut: clockOutTime, total_jam_kerja: totalWorkHours, total_overtime: overtime };
  }

  static async deleteKehadiran(id_kehadiran) {
    const [result] = await db.query(`
        DELETE FROM tb_kehadiran WHERE id_kehadiran = ?
    `, [id_kehadiran]);

    if (result.affectedRows === 0) throw new Error("Data kehadiran tidak ditemukan atau sudah dihapus");
  }
}

// 🛠 Fungsi bantu untuk menghitung selisih waktu
function calculateTimeDifference(startTime, endTime) {
  const start = new Date(`1970-01-01T${startTime}Z`);
  const end = new Date(`1970-01-01T${endTime}Z`);
  const diffMs = end - start;

  if (diffMs <= 0) return "0j 0m";

  const hours = Math.floor(diffMs / (1000 * 60 * 60));
  const minutes = Math.floor((diffMs % (1000 * 60 * 60)) / (1000 * 60));

  return `${hours}j ${minutes}m`;
}

module.exports = Karyawan;
