<?php
header('Content-Type: application/json; charset=utf-8');

$marca = filter_input(INPUT_GET, 'marca');
if ($marca === false) {
    http_response_code(400);
    echo json_encode(['error' => 'Marca no válida']);
    exit;
}

$db = new mysqli('127.0.0.1', 'root', '', 'bdproyecto');
$db->set_charset('utf8mb4');

$columnas = 'marca, modelo, ano_matriculacion, kilometraje_km, combustible,
             tipo_cambio, precio_anunciado, estado_anuncio, ruta_foto';
if ($marca === null || $marca === '') {
    $valor = 'disponible';
    $consulta = $db->prepare('SELECT ' . $columnas . ' FROM coches WHERE estado_anuncio = ?');
} else {
    $valor = $marca;
    $consulta = $db->prepare('SELECT ' . $columnas . ' FROM coches WHERE marca = ?');
}
$consulta->bind_param('s', $valor);
$consulta->execute();
$coches = $consulta->get_result()->fetch_all(MYSQLI_ASSOC);

// Una marca puede tener coches vendidos. El catálogo solo muestra los disponibles.
$disponibles = array();
foreach ($coches as $coche) {
    if ($coche['estado_anuncio'] === 'disponible') {
        $disponibles[count($disponibles)] = $coche;
    }
}
echo json_encode($disponibles);