<?php
header('Content-Type: application/json; charset=utf-8');

$marca = filter_input(INPUT_GET, 'marca');
if ($marca === false) {
    http_response_code(400);
    echo json_encode(['error' => 'Marca no válida']);
    exit;
}

$db = new mysqli('127.0.0.1', 'root', '', 'coches_proyecto');
$db->set_charset('utf8mb4');

$columnas = 'matricula, marca, modelo, ano_matriculacion, kilometraje_km, combustible,
             tipo_cambio, precio_anunciado, estado_anuncio, ruta_foto';
if ($marca === null || $marca === '') {
    $valor = 'disponible';
    $consulta = $db->prepare('SELECT ' . $columnas . ' FROM coches WHERE estado_anuncio = ?');
    $consulta->bind_param('s', $valor);

} else {
    $consulta = $db->prepare('SELECT ' . $columnas .
        ' FROM coches WHERE marca = ? AND estado_anuncio = ?');
    $disponible = 'disponible';
    $consulta->bind_param('ss', $marca, $disponible);
}
$consulta->execute();
$coches = $consulta->get_result()->fetch_all(MYSQLI_ASSOC);


echo json_encode($coches);