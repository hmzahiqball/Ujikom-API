const http = require("http");
const app = require("./app"); // Impor aplikasi Express
require('dotenv').config();
const PORT = process.env.PORT || 1111;

const server = http.createServer(app);

server.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});