// server.js
const WebSocket = require('ws');

const server = new WebSocket.Server({ port: 8080 });

server.on('connection', (socket) => {
    console.log('Cliente conectado');

    socket.on('message', (message) => {
        console.log('Mensaje recibido: ' + message);
        // Enviar una respuesta al cliente
        socket.send(`Eco: ${message}`);
    });

    socket.on('close', () => {
        console.log('Cliente desconectado');
    });
});

console.log('Servidor WebSocket escuchando en ws://localhost:8080');
