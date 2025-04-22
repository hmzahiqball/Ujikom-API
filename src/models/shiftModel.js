const db = require("../config/db");
const formatWIB = require("../utils/time");

class Shifts {
  static async getAllShifts() {
    const [rows] = await db.query("SELECT id_shifts, nama_shifts, start_time, end_time, created_at, updated_at FROM tb_shifts WHERE is_deleted = 0");
    return rows.map(row => ({
      ...row,
      created_at: formatWIB(row.created_at),
      updated_at: formatWIB(row.updated_at)
    }));
  }

  static async getShiftsByID(p_idShifts) {
    const [result] = await db.query(
        "SELECT id_shifts, nama_shifts, start_time, end_time, created_at, updated_at FROM tb_shifts WHERE id_shifts = ? LIMIT 1", 
        [p_idShifts]);
    return result[0];
  }

  static async createShifts(p_namaShifts, p_startTime, p_endTime) {
    const [result] = await db.query(
      "INSERT INTO tb_shifts (nama_shifts, start_time, end_time) VALUES (?, ?, ?)",
      [p_namaShifts, p_startTime, p_endTime]
    );
    return result.insertId;
  }

  static async updateShifts(p_idShifts, p_namaShifts, p_startTime, p_endTime) {
    await db.query(
      "UPDATE tb_shifts SET nama_shifts = ?, start_time = ?, end_time = ? WHERE id_shifts = ?",
      [p_namaShifts, p_startTime, p_endTime, p_idShifts]
    );
  }

  static async deleteShifts(p_idShifts) {
    await db.query("DELETE FROM tb_shifts WHERE id_shifts = ?", [p_idShifts]);
  }
}

module.exports = Shifts;
