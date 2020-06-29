const http = require('http');
const express = require('express');
const app = express();
const hostname = 'localhost';
const port = 3000;
const appUrl = require('./router.js')(app);
const server = http.createServer(appUrl);

server.listen(port, hostname, () => {
    console.log(`服务器运行在 http://${hostname}:${port}/`);
});
