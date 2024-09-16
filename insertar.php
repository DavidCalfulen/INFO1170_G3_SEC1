<!-- archivo: insertar.php -->
<?php
// Configuración de la base de datos
$servername = "localhost";
$username = "root";  // Cambia esto por tu usuario de MySQL si es diferente
$password = "";      // Cambia esto por tu contraseña de MySQL si es diferente
$dbname = "mi_base_datos";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Obtener datos del formulario
$nombre = $_POST['nombre'];
$email = $_POST['email'];

// SQL para insertar datos
$sql = "INSERT INTO usuarios (nombre, email) VALUES (?, ?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $nombre, $email);

if ($stmt->execute()) {
    echo "Registro exitoso";
} else {
    echo "Error: " . $stmt->error;
}

// Cerrar conexión
$stmt->close();
$conn->close();
?>
