const Shifts = require("../models/shiftModel");

exports.getAllShifts = async (req, res) => {
  try {
    const shifts = await Shifts.getAllShifts();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Jadwal Shifts",
      data: shifts,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.getAllShifts_notFiltered = async (req, res) => {
  try {
    const shifts = await Shifts.getAllShifts_notFiltered();
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Jadwal Shifts",
      data: shifts,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.getShiftsByID = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const shifts = await Shifts.getShiftsByID(id);
    if (!shifts) {
      return res
        .status(200)
        .json({ status: "200", message: "Jadwal Shift Tidak Tersedia" });
    }
    return res.json({
      status: 200,
      message: "Berhasil Mendapatkan Data Jadwal Shifts",
      data: shifts,
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.createShifts = async (req, res) => {
  const { p_namaShifts, p_startTime, p_endTime } = req.body;
  try {
    if (!p_namaShifts || !p_startTime || !p_endTime) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    const shiftsId = await Shifts.createShifts(p_namaShifts, p_startTime, p_endTime);
    return res.json({
      status: 200,
      message: "Berhasil Menambahkan Data Jadwal Shift",
      data: { p_idShifts: shiftsId, p_namaShifts, p_startTime, p_endTime },
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.updateShifts = async (req, res) => {
  const { p_namaShifts, p_startTime, p_endTime } = req.body;
  const { id } = req.params;
  try {
    if (!id || !p_namaShifts || !p_startTime || !p_endTime) {
      return res
        .status(400)
        .json({ status: "error", message: "Data Tidak Lengkap" });
    }
    await Shifts.updateShifts(id, p_namaShifts, p_startTime, p_endTime);
    return res.json({
      status: 200,
      message: "Berhasil Update Data Jadwal Shift",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};

exports.deleteShifts = async (req, res) => {
  const { id } = req.params;
  try {
    if (!id) {
      return res
        .status(400)
        .json({ status: "error", message: "ID Jadwal Shift Tidak Dikenali" });
    }
    await Shifts.deleteShifts(id);
    return res.json({
      status: 200,
      message: "Berhasil Menghapus Data Jadwal Shift",
    });
  } catch (error) {
    return res.status(500).json({ status: "error", message: error.message });
  }
};