<?php
header('Content-Type: application/json; charset=utf-8');

$db = new mysqli('localhost', 'root', '', 'COCHES_PROYECTO');
$db->set_charset('utf8mb4');

$tipo = filter_input(INPUT_GET, 'tipo', FILTER_UNSAFE_RAW) ?? '';

switch ($tipo) {

    // Ventas por mes para una marca
    case 'ventas_mes':
        $marca = filter_input(INPUT_GET, 'marca', FILTER_UNSAFE_RAW) ?? '';
        $stmt = $db->prepare(
            "SELECT DATE_FORMAT(v.fecha_venta, '%Y-%m') AS mes, COUNT(*) AS total
             FROM ventas v
             JOIN coches c ON c.id_coche = v.id_coche
             WHERE c.marca = ?
             GROUP BY mes
             ORDER BY mes"
        );
        $stmt->bind_param('s', $marca);
        $stmt->execute();
        echo json_encode($stmt->get_result()->fetch_all(MYSQLI_ASSOC));
        break;

    // Lista de marcas para rellenar el selector
    case 'marcas':
        $res = $db->query("SELECT DISTINCT marca FROM coches ORDER BY marca");
        echo json_encode($res->fetch_all(MYSQLI_ASSOC));
        break;

    // Precio medio anunciado por marca
    case 'precio_marca':
        $res = $db->query(
            "SELECT marca, ROUND(AVG(precio_anunciado), 2) AS precio_medio
             FROM coches
             GROUP BY marca
             ORDER BY precio_medio DESC"
        );
        echo json_encode($res->fetch_all(MYSQLI_ASSOC));
        break;

    // Disponibles, vendidos y total
    case 'disponibilidad':
        $res = $db->query(
            "SELECT estado_anuncio AS estado, COUNT(*) AS total
             FROM coches
             GROUP BY estado_anuncio"
        );
        echo json_encode($res->fetch_all(MYSQLI_ASSOC));
        break;
        // Totales para los indicadores
    case 'resumen':
        $res = $db->query(
            "SELECT
                COUNT(*) AS total,
                SUM(estado_anuncio = 'disponible') AS disponibles,
                SUM(estado_anuncio = 'vendido') AS vendidos
             FROM coches"
        );
        echo json_encode($res->fetch_assoc());
        break;

    default:
        http_response_code(400);
        echo json_encode(['error' => 'Tipo no válido']);
}