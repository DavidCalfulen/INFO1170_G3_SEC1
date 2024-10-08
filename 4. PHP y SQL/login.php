<?php
// Conexión a la base de datos
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "aaaa"; // Cambia si tu base de datos tiene otro nombre

$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Obtener datos del formulario de login
$correo_electronico = $_POST['correo_electronico'];
$contrasena = $_POST['contrasena'];

// Verificar si el correo existe
$sql = "SELECT * FROM usuario WHERE correo_electronico = '$correo_electronico'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Usuario encontrado
    $row = $result->fetch_assoc();
    
    // Verificar la contraseña
    if (password_verify($contrasena, $row['contraseña'])) {
        echo "Inicio de sesión exitoso. Bienvenido, " . $row['nombre_completo'];
    } else {
        echo "Contraseña incorrecta.";
    }
} else {
    echo "No se encontró ningún usuario con ese correo.";
}

// Cerrar la conexión
$conn->close();
?>
