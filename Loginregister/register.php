<?php
// Conexión a la base de datos
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "aaaa"; // Cambia si tu base de datos tiene otro nombre

// Crear la conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Obtener datos del formulario de registro
$nombre_completo = $_POST['nombre_completo'];
$correo_electronico = $_POST['correo_electronico'];
$contrasena = $_POST['contrasena'];

// Hashear la contraseña para mayor seguridad
$hashed_password = password_hash($contrasena, PASSWORD_DEFAULT);

// Verificar si el correo ya está registrado
$sql_verificar = "SELECT * FROM usuario WHERE correo_electronico = '$correo_electronico'";
$result_verificar = $conn->query($sql_verificar);

if ($result_verificar->num_rows > 0) {
    echo "Error: El correo electrónico ya está registrado.";
} else {
    // Obtener el último número de cliente de la base de datos
    $sql_cliente = "SELECT MAX(numero_cliente) AS ultimo_cliente FROM usuario";
    $result_cliente = $conn->query($sql_cliente);

    // Asignar el número de cliente
    if ($result_cliente->num_rows > 0) {
        $row_cliente = $result_cliente->fetch_assoc();
        $numero_cliente = $row_cliente['ultimo_cliente'] + 1; // Incrementar el último número de cliente
    } else {
        $numero_cliente = 1; // Si no hay registros, empezar en 1
    }

    // Insertar el nuevo usuario con el número de cliente único
    $sql = "INSERT INTO usuario (nombre_completo, correo_electronico, contraseña, numero_cliente) 
            VALUES ('$nombre_completo', '$correo_electronico', '$hashed_password', $numero_cliente)";

    if ($conn->query($sql) === TRUE) {
        echo "Usuario registrado correctamente con el número de cliente: " . $numero_cliente;
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

// Cerrar la conexión
$conn->close();
?>
