const jwt = require('jsonwebtoken');

function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1]; // ambil bagian kedua setelah 'Bearer'

  if (!token) {
    return res.status(401).json({ message: 'Token tidak ditemukan' });
  }

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ message: 'Token tidak valid' });

    req.user = user; // payload token tersedia di req.user
    next();
  });
}

module.exports = authenticateToken;
