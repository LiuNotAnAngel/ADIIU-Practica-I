-- Selecciona la base de datos del proyecto en phpMyAdmin antes de importar.
-- Guarda las matrículas sin espacios ni guiones.
CREATE TABLE coches (
    id_coche SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    matricula CHAR(7) NOT NULL UNIQUE,
    marca VARCHAR(40) NOT NULL,
    modelo VARCHAR(80) NOT NULL,
    ano_matriculacion SMALLINT UNSIGNED NOT NULL,
    kilometraje_km MEDIUMINT UNSIGNED NOT NULL,
    combustible ENUM('diésel', 'gasolina', 'híbrido', 'eléctrico', 'otros') NOT NULL,
    tipo_cambio ENUM('manual', 'automático') NOT NULL,
    precio_anunciado DECIMAL(9, 2) UNSIGNED NOT NULL,
    estado_anuncio ENUM('disponible', 'vendido') NOT NULL DEFAULT 'disponible',
    fecha_publicacion DATE NOT NULL,
    ruta_foto VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE clientes (
    id_cliente SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    dni CHAR(9) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    genero ENUM('hombre', 'mujer', 'prefiero no decirlo') NOT NULL,
    correo_electronico VARCHAR(254) NOT NULL,
    telefono VARCHAR(16)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE ventas (
    id_venta SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_coche SMALLINT UNSIGNED NOT NULL UNIQUE,
    id_cliente SMALLINT UNSIGNED NOT NULL,
    fecha_venta DATE NOT NULL,
    precio_final DECIMAL(9, 2) UNSIGNED NOT NULL,
    FOREIGN KEY (id_coche) REFERENCES coches (id_coche),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO coches (
    id_coche, matricula, marca, modelo, ano_matriculacion, kilometraje_km,
    combustible, tipo_cambio, precio_anunciado, estado_anuncio, fecha_publicacion, ruta_foto
) VALUES
    (1,  '4812KMF', 'SEAT', 'Ibiza', 2018, 82400, 'gasolina', 'manual', 10900.00, 'disponible', '2026-09-03', 'img/coches/seat-ibiza.jpg'),
    (2,  '7354LDP', 'SEAT', 'León', 2020, 96500, 'diésel', 'manual', 15400.00, 'vendido', '2026-07-22', 'img/coches/seat-leon.jpg'),
    (3,  '2096LTC', 'SEAT', 'Arona', 2021, 51800, 'gasolina', 'automático', 16900.00, 'disponible', '2026-10-04', 'img/coches/seat-arona.jpg'),
    (4,  '6183LKV', 'Toyota', 'Corolla', 2020, 67300, 'híbrido', 'automático', 18800.00, 'disponible', '2026-09-16', 'img/coches/toyota-corolla.jpg'),
    (5,  '3527LXS', 'Toyota', 'Yaris', 2022, 43200, 'híbrido', 'automático', 17200.00, 'vendido', '2026-08-06', 'img/coches/toyota-yaris.jpg'),
    (6,  '9071MBD', 'Toyota', 'RAV4', 2022, 59400, 'híbrido', 'automático', 29900.00, 'disponible', '2026-10-11', 'img/coches/toyota-rav4.jpg'),
    (7,  '1638KVT', 'Renault', 'Clio', 2019, 71900, 'gasolina', 'manual', 10500.00, 'disponible', '2026-10-08', 'img/coches/renault-clio.jpg'),
    (8,  '5804LNR', 'Renault', 'Zoe', 2021, 38700, 'eléctrico', 'automático', 14300.00, 'disponible', '2026-10-21', 'img/coches/renault-zoe.jpg'),
    (9,  '2965KJB', 'Renault', 'Captur', 2018, 108200, 'diésel', 'manual', 11900.00, 'vendido', '2026-08-27', 'img/coches/renault-captur.jpg'),
    (10, '8241LLG', 'Volkswagen', 'Golf', 2020, 78600, 'diésel', 'manual', 18400.00, 'disponible', '2026-11-02', 'img/coches/volkswagen-golf.jpg'),
    (11, '4379LZR', 'Volkswagen', 'ID.3', 2022, 46100, 'eléctrico', 'automático', 21900.00, 'disponible', '2026-11-05', 'img/coches/volkswagen-id3.jpg'),
    (12, '7516KSD', 'Volkswagen', 'Polo', 2019, 64300, 'gasolina', 'manual', 12800.00, 'vendido', '2026-09-24', 'img/coches/volkswagen-polo.jpg');

INSERT INTO clientes (
    id_cliente, dni, nombre, apellidos, genero, correo_electronico, telefono
) VALUES
    (1, '00000001R', 'Clara', 'Vidal Serra', 'mujer',
    'clara.vidal@example.com', '+34612345678'),

(2, '00000002W', 'Pablo', 'Ríos Martín', 'hombre',
    'pablo.rios@example.com', '+34623456789'),

(3, '00000003A', 'Alex', 'Soler Vidal', 'prefiero no decirlo',
    'alex.soler@example.com', '+34634567890'),

(4, '00000004G', 'Inés', 'Costa Gil', 'mujer',
    'ines.costa@example.com', '+34645678901');

INSERT INTO ventas (id_coche, id_cliente, fecha_venta, precio_final) VALUES
    (2,  1, '2026-08-12', 14900.00),
    (5,  2, '2026-09-04', 16800.00),
    (9,  3, '2026-09-18', 11500.00),
    (12, 4, '2026-10-15', 12500.00);

