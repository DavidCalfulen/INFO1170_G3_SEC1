/* Descaragar e instalar Node con aterioridad, revisar que esté instalado con PATH

DESCRICION
Node.js es un entorno de ejecución de JavaScript, permite ejecutar código JavaScript fuera de un navegador, 
en un servidor, lo que significa que puedes usar JavaScript para crear aplicaciones del lado del servidor, como servidores 
web, APIs y herramientas de línea de comandos.

Node.js utiliza un modelo de I/O no bloqueante, basado en eventos, lo que lo hace eficiente y ligero. Esta arquitectura es
ideal para aplicaciones que manejan múltiples solicitudes simultáneas o que requieren mucha interacción con bases de datos 
o archivos.

¿Cuándo usar Node.js?
-APIs: Es excelente para construir APIs que manejan muchas conexiones al mismo tiempo, como servicios REST.
-Aplicaciones en tiempo real: Node.js es muy usado en aplicaciones como chats, videojuegos en línea y colaboraciones en 
 tiempo real (como Google Docs).
-Aplicaciones de red: Node.js puede crear servidores que manejen un tráfico alto y múltiples solicitudes.
-Microservicios: Al ser eficiente en manejo de múltiples conexiones, es ideal para implementar arquitectura de microservicios.
*/

// Importa el módulo 'http' de Node.js que nos permite crear servidores web
const http = require('http');

// Crea un servidor HTTP utilizando la función createServer. 
// Esta función toma un "callback" que maneja las solicitudes entrantes (req) y las respuestas (res).
const server = http.createServer((req, res) => {

  // Establece el código de estado de la respuesta a 200, lo que indica éxito.
  res.statusCode = 200;

  // Establece el encabezado 'Content-Type' para que el navegador sepa que estamos enviando texto.
  res.setHeader('Content-Type', 'text/plain');

  // Envía la respuesta final al cliente. En este caso, un simple "Hello, World!" en texto plano.
  res.end('Hello, World!\n');
});

// Define el puerto en el que el servidor va a escuchar las solicitudes. 
// Si no hay un puerto especificado en las variables de entorno (como cuando se despliega en servicios en la nube), usará el puerto 3000 por defecto.
const PORT = process.env.PORT || 3000;

// Inicia el servidor y hace que escuche en el puerto definido arriba. 
// Una vez que el servidor está listo, ejecuta el callback que muestra un mensaje en la consola indicnodeando que el servidor está en funcionamiento.
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
