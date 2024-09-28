<?php
// Datos de conexión a la base de datos
$servername = "localhost"; // O el servidor que uses
$username = "tu_usuario"; // Tu usuario de MySQL
$password = "tu_contraseña"; // Tu contraseña de MySQL
$dbname = "informes_emergencias";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Recibir datos del formulario
$id_emergencia = $_POST['id_emergencia'];
$fecha_actualizacion = $_POST['fecha_actualizacion'];
$hora_actualizacion = $_POST['hora_actualizacion'];
$estado_emergencia = $_POST['estado_emergencia'];
$tiempo_estimado_solucion = $_POST['tiempo_estimado_solucion'];
$tiempo_estimado_llegada = $_POST['tiempo_estimado_llegada'];
$descripcion_actual = $_POST['descripcion_actual'];
$acciones_tomadas = $_POST['acciones_tomadas'];
$proximos_pasos = $_POST['proximos_pasos'];
$comentarios_adicionales = $_POST['comentarios_adicionales'];

// Manejo de archivos subidos
if (!empty($_FILES['evidencia']['name'])) {
    $evidencia = 'uploads/' . basename($_FILES['evidencia']['name']);
    move_uploaded_file($_FILES['evidencia']['tmp_name'], $evidencia);
} else {
    $evidencia = null;
}

// Insertar datos en la base de datos
$sql = "INSERT INTO informes (id_emergencia, fecha_actualizacion, hora_actualizacion, estado_emergencia, tiempo_estimado_solucion, tiempo_estimado_llegada, descripcion_actual, acciones_tomadas, proximos_pasos, evidencia, comentarios_adicionales)
VALUES ('$id_emergencia', '$fecha_actualizacion', '$hora_actualizacion', '$estado_emergencia', '$tiempo_estimado_solucion', '$tiempo_estimado_llegada', '$descripcion_actual', '$acciones_tomadas', '$proximos_pasos', '$evidencia', '$comentarios_adicionales')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["status" => "success", "message" => "Datos insertados correctamente"]);
} else {
    echo json_encode(["status" => "error", "message" => "Error: " . $sql . "<br>" . $conn->error]);
}

// Cerrar la conexión
$conn->close();
?>
