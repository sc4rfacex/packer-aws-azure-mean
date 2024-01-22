const http = require('http');

const hostname = 'localhost';
const port = 3000;

/**
 * The server object that handles incoming requests and sends responses.
 * @type {http.Server}
 */
const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello UNIR! - Anthony Lopez Arizmendi - Herramientas DevOps\n');
});

server.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
});