-- Script reejecutable: borra y recrea la base de datos completa.
-- Se puede importar tantas veces como se quiera (phpMyAdmin > Importar, o
-- automáticamente tras cada "git pull" con el hook de .githooks/).
DROP DATABASE IF EXISTS COCHES_PROYECTO;
CREATE DATABASE COCHES_PROYECTO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE COCHES_PROYECTO;

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
    (12, '7516KSD', 'Volkswagen', 'Polo', 2019, 64300, 'gasolina', 'manual', 12800.00, 'vendido', '2026-09-24', 'img/coches/volkswagen-polo.jpg'),
    (13, '3149LPH', 'Peugeot', '208', 2020, 54700, 'gasolina', 'manual', 13600.00, 'disponible', '2026-10-14', 'img/coches/peugeot-208.jpg'),
    (14, '8862LGW', 'Peugeot', '3008', 2021, 88300, 'diésel', 'automático', 22500.00, 'vendido', '2026-08-19', 'img/coches/peugeot-3008.jpg'),
    (15, '5427KYN', 'Ford', 'Focus', 2019, 91200, 'gasolina', 'manual', 12900.00, 'disponible', '2026-09-29', 'img/coches/ford-focus.jpg'),
    (16, '1793LSF', 'Ford', 'Kuga', 2021, 62800, 'híbrido', 'automático', 24900.00, 'disponible', '2026-11-07', 'img/coches/ford-kuga.jpg'),
    (17, '6038MCK', 'Kia', 'Sportage', 2023, 28400, 'híbrido', 'automático', 29500.00, 'vendido', '2026-09-10', 'img/coches/kia-sportage.jpg'),
    (18, '2714MGT', 'Kia', 'Niro EV', 2023, 21900, 'eléctrico', 'automático', 27900.00, 'disponible', '2026-11-11', 'img/coches/kia-niro.jpg'),
    (19, '9450LWB', 'Hyundai', 'Tucson', 2022, 47600, 'híbrido', 'automático', 26800.00, 'disponible', '2026-10-17', 'img/coches/hyundai-tucson.jpg'),
    (20, '4186KZX', 'Hyundai', 'Kona', 2019, 73500, 'híbrido', 'automático', 15900.00, 'vendido', '2026-08-30', 'img/coches/hyundai-kona.jpg'),
    (21, '7302LRM', 'Tesla', 'Model 3', 2021, 69800, 'eléctrico', 'automático', 26500.00, 'disponible', '2026-10-25', 'img/coches/tesla-model3.jpg'),
    (22, '3891LVJ', 'Dacia', 'Sandero', 2021, 39500, 'otros', 'manual', 10900.00, 'vendido', '2026-09-08', 'img/coches/dacia-sandero.jpg'),
    (23, '6625KWC', 'Fiat', '500', 2019, 48200, 'gasolina', 'manual', 9800.00, 'disponible', '2026-11-13', 'img/coches/fiat-500.jpg'),
    (24, '5078LMZ', 'BMW', 'Serie 1', 2020, 84100, 'diésel', 'automático', 21400.00, 'vendido', '2026-08-02', 'img/coches/bmw-serie1.jpg'),
    (25, '2457LBX', 'Opel', 'Corsa', 2020, 58900, 'gasolina', 'manual', 11400.00, 'disponible', '2026-10-02', 'img/coches/opel-corsa.jpg'),
    (26, '8193MDH', 'Opel', 'Astra', 2022, 41300, 'diésel', 'manual', 19600.00, 'vendido', '2026-08-14', 'img/coches/opel-astra.jpg'),
    (27, '4620LHK', 'Citroën', 'C3', 2021, 52600, 'gasolina', 'manual', 11900.00, 'disponible', '2026-11-09', 'img/coches/citroen-c3.jpg'),
    (28, '7085LTW', 'Citroën', 'C4', 2021, 66400, 'diésel', 'automático', 16700.00, 'disponible', '2026-10-19', 'img/coches/citroen-c4.jpg'),
    (29, '1349LJP', 'Škoda', 'Octavia Combi', 2020, 112500, 'diésel', 'manual', 15800.00, 'vendido', '2026-07-30', 'img/coches/skoda-octavia.jpg'),
    (30, '5876MFR', 'Škoda', 'Fabia', 2022, 33800, 'gasolina', 'manual', 14200.00, 'disponible', '2026-11-15', 'img/coches/skoda-fabia.jpg'),
    (31, '3912LXB', 'Nissan', 'Qashqai', 2021, 57200, 'híbrido', 'automático', 22900.00, 'vendido', '2026-09-12', 'img/coches/nissan-qashqai.jpg'),
    (32, '6748KTN', 'Mazda', 'CX-5', 2018, 98700, 'gasolina', 'automático', 17500.00, 'disponible', '2026-10-28', 'img/coches/mazda-cx5.jpg'),
    (33, '9204LNC', 'Audi', 'A3 Sportback', 2021, 61900, 'diésel', 'automático', 24300.00, 'disponible', '2026-11-04', 'img/coches/audi-a3.jpg'),
    (34, '2561LGS', 'Mercedes-Benz', 'Clase A Sedán', 2020, 72400, 'gasolina', 'automático', 23800.00, 'vendido', '2026-09-05', 'img/coches/mercedes-clase-a.jpg'),
    (35, '8037MBV', 'Cupra', 'Formentor', 2022, 39100, 'gasolina', 'automático', 31500.00, 'disponible', '2026-11-18', 'img/coches/cupra-formentor.jpg'),
    (36, '4785MHL', 'MG', 'ZS EV', 2023, 24600, 'eléctrico', 'automático', 21200.00, 'vendido', '2026-09-15', 'img/coches/mg-zs-ev.jpg'),
    (37, '2929MMX', 'SEAT', 'Ibiza', 2018, 123400, 'gasolina', 'manual', 8700.00, 'vendido', '2026-04-10', 'img/coches/seat-ibiza.jpg'),
    (38, '4078LFX', 'SEAT', 'León', 2021, 81100, 'diésel', 'manual', 15200.00, 'vendido', '2026-02-09', 'img/coches/seat-leon.jpg'),
    (39, '9133MXS', 'Toyota', 'Corolla', 2021, 63400, 'híbrido', 'automático', 18700.00, 'vendido', '2026-06-17', 'img/coches/toyota-corolla.jpg'),
    (40, '5911KHK', 'Toyota', 'Yaris', 2020, 83700, 'híbrido', 'automático', 14100.00, 'vendido', '2026-02-18', 'img/coches/toyota-yaris.jpg'),
    (41, '6627MTM', 'Toyota', 'RAV4', 2021, 75200, 'híbrido', 'automático', 26800.00, 'vendido', '2026-02-14', 'img/coches/toyota-rav4.jpg'),
    (42, '6604KVS', 'Renault', 'Clio', 2020, 74100, 'gasolina', 'manual', 10300.00, 'disponible', '2026-09-06', 'img/coches/renault-clio.jpg'),
    (43, '6140LPZ', 'Renault', 'Captur', 2022, 46500, 'gasolina', 'manual', 15800.00, 'vendido', '2026-09-19', 'img/coches/renault-captur.jpg'),
    (44, '2533LVD', 'Volkswagen', 'Golf', 2017, 160900, 'gasolina', 'manual', 11500.00, 'disponible', '2026-09-08', 'img/coches/volkswagen-golf.jpg'),
    (45, '6072MYT', 'Volkswagen', 'Polo', 2022, 66900, 'gasolina', 'manual', 14000.00, 'vendido', '2026-06-02', 'img/coches/volkswagen-polo.jpg'),
    (46, '8564LHZ', 'Peugeot', '208', 2019, 78200, 'gasolina', 'manual', 11100.00, 'vendido', '2026-03-08', 'img/coches/peugeot-208.jpg'),
    (47, '5709KKR', 'Peugeot', '3008', 2018, 138300, 'diésel', 'automático', 15700.00, 'vendido', '2026-07-27', 'img/coches/peugeot-3008.jpg'),
    (48, '7580MLG', 'Ford', 'Focus', 2018, 117400, 'diésel', 'manual', 10100.00, 'vendido', '2026-08-16', 'img/coches/ford-focus.jpg'),
    (49, '6878MRK', 'Kia', 'Sportage', 2022, 57600, 'gasolina', 'manual', 25200.00, 'vendido', '2026-03-26', 'img/coches/kia-sportage.jpg'),
    (50, '4822KVY', 'Hyundai', 'Tucson', 2018, 103200, 'diésel', 'manual', 17000.00, 'vendido', '2026-04-11', 'img/coches/hyundai-tucson.jpg'),
    (51, '7864MPZ', 'Tesla', 'Model 3', 2019, 109700, 'eléctrico', 'automático', 17900.00, 'disponible', '2026-11-12', 'img/coches/tesla-model3.jpg'),
    (52, '3056MWZ', 'Dacia', 'Sandero', 2019, 131600, 'gasolina', 'manual', 7800.00, 'disponible', '2026-09-07', 'img/coches/dacia-sandero.jpg'),
    (53, '7428LRR', 'Fiat', '500', 2020, 110200, 'híbrido', 'manual', 9100.00, 'vendido', '2026-03-02', 'img/coches/fiat-500.jpg'),
    (54, '4122KJT', 'BMW', 'Serie 1', 2020, 69000, 'gasolina', 'automático', 19900.00, 'vendido', '2026-04-01', 'img/coches/bmw-serie1.jpg'),
    (55, '2677KYG', 'Opel', 'Corsa', 2021, 57100, 'eléctrico', 'automático', 16500.00, 'disponible', '2026-11-08', 'img/coches/opel-corsa.jpg'),
    (56, '6957MBD', 'Škoda', 'Octavia Combi', 2017, 168900, 'gasolina', 'automático', 11700.00, 'vendido', '2026-04-24', 'img/coches/skoda-octavia.jpg'),
    (57, '5132LZP', 'Nissan', 'Qashqai', 2018, 129500, 'gasolina', 'manual', 14400.00, 'vendido', '2026-09-07', 'img/coches/nissan-qashqai.jpg'),
    (58, '8634LVM', 'Audi', 'A3 Sportback', 2023, 44900, 'gasolina', 'automático', 27800.00, 'vendido', '2026-02-20', 'img/coches/audi-a3.jpg'),
    (59, '5337LHW', 'Cupra', 'Formentor', 2022, 55200, 'híbrido', 'automático', 33400.00, 'disponible', '2026-09-03', 'img/coches/cupra-formentor.jpg'),
    (60, '9654LGX', 'Volkswagen', 'ID.3', 2020, 150300, 'eléctrico', 'automático', 15400.00, 'vendido', '2026-01-21', 'img/coches/volkswagen-id3.jpg'),
    (61, '3475MHC', 'SEAT', 'Ibiza', 2023, 53800, 'gasolina', 'manual', 10100.00, 'vendido', '2026-09-02', 'img/coches/seat-ibiza.jpg'),
    (62, '2162LFX', 'SEAT', 'León', 2021, 67000, 'gasolina', 'manual', 10300.00, 'vendido', '2026-09-05', 'img/coches/seat-leon.jpg'),
    (63, '6590LGX', 'SEAT', 'Arona', 2021, 66400, 'gasolina', 'manual', 9100.00, 'vendido', '2026-08-02', 'img/coches/seat-arona.jpg'),
    (64, '7320MNV', 'Toyota', 'Corolla', 2022, 72800, 'híbrido', 'automático', 13900.00, 'vendido', '2026-07-21', 'img/coches/toyota-corolla.jpg'),
    (65, '9126LBV', 'Toyota', 'Yaris', 2020, 75600, 'híbrido', 'automático', 8100.00, 'disponible', '2026-09-23', 'img/coches/toyota-yaris.jpg'),
    (66, '9555MKY', 'Toyota', 'RAV4', 2023, 59400, 'híbrido', 'automático', 22400.00, 'vendido', '2026-06-17', 'img/coches/toyota-rav4.jpg'),
    (67, '3786KPN', 'Renault', 'Clio', 2019, 90700, 'diésel', 'manual', 5600.00, 'vendido', '2026-07-01', 'img/coches/renault-clio.jpg'),
    (68, '3763LDH', 'Renault', 'Zoe', 2020, 70100, 'eléctrico', 'automático', 11100.00, 'vendido', '2026-08-12', 'img/coches/renault-zoe.jpg'),
    (69, '4957JSH', 'Renault', 'Captur', 2017, 166600, 'diésel', 'manual', 4500.00, 'disponible', '2026-09-16', 'img/coches/renault-captur.jpg'),
    (70, '9292MRK', 'Volkswagen', 'Golf', 2022, 72100, 'diésel', 'automático', 14400.00, 'vendido', '2026-05-10', 'img/coches/volkswagen-golf.jpg'),
    (71, '7675KVC', 'Volkswagen', 'Polo', 2018, 137500, 'gasolina', 'automático', 5000.00, 'vendido', '2026-06-01', 'img/coches/volkswagen-polo.jpg'),
    (72, '1569MSK', 'Volkswagen', 'ID.3', 2022, 58900, 'eléctrico', 'automático', 19300.00, 'vendido', '2026-04-02', 'img/coches/volkswagen-id3.jpg'),
    (73, '3477MVC', 'Peugeot', '208', 2022, 49500, 'gasolina', 'automático', 10300.00, 'disponible', '2026-10-17', 'img/coches/peugeot-208.jpg'),
    (74, '8849KBJ', 'Peugeot', '3008', 2019, 130200, 'gasolina', 'automático', 9300.00, 'vendido', '2026-07-11', 'img/coches/peugeot-3008.jpg'),
    (75, '8937MYV', 'Ford', 'Focus', 2023, 50900, 'gasolina', 'manual', 13700.00, 'vendido', '2026-06-11', 'img/coches/ford-focus.jpg'),
    (76, '3282NBR', 'Ford', 'Kuga', 2024, 29000, 'diésel', 'manual', 21400.00, 'vendido', '2026-03-10', 'img/coches/ford-kuga.jpg'),
    (77, '6343MKY', 'Kia', 'Niro EV', 2023, 59100, 'eléctrico', 'automático', 23600.00, 'vendido', '2026-08-08', 'img/coches/kia-niro.jpg'),
    (78, '3187LGF', 'Hyundai', 'Kona', 2021, 61300, 'gasolina', 'manual', 9600.00, 'vendido', '2026-07-27', 'img/coches/hyundai-kona.jpg'),
    (79, '3307LDF', 'Hyundai', 'Tucson', 2021, 86600, 'híbrido', 'automático', 14300.00, 'disponible', '2026-10-21', 'img/coches/hyundai-tucson.jpg'),
    (80, '9825LNR', 'Tesla', 'Model 3', 2020, 89800, 'eléctrico', 'automático', 16200.00, 'disponible', '2026-11-17', 'img/coches/tesla-model3.jpg'),
    (81, '3974MHR', 'Dacia', 'Sandero', 2022, 50800, 'otros', 'manual', 7200.00, 'vendido', '2026-04-18', 'img/coches/dacia-sandero.jpg'),
    (82, '9271JCB', 'Fiat', '500', 2017, 179000, 'gasolina', 'manual', 3000.00, 'disponible', '2026-11-03', 'img/coches/fiat-500.jpg'),
    (83, '7519MYH', 'BMW', 'Serie 1', 2022, 44100, 'diésel', 'automático', 17100.00, 'vendido', '2026-05-04', 'img/coches/bmw-serie1.jpg'),
    (84, '1686NKR', 'Opel', 'Astra', 2024, 30200, 'gasolina', 'manual', 18500.00, 'disponible', '2026-10-04', 'img/coches/opel-astra.jpg'),
    (85, '9243LXV', 'Citroën', 'C3', 2021, 74100, 'gasolina', 'manual', 6800.00, 'vendido', '2026-02-24', 'img/coches/citroen-c3.jpg'),
    (86, '6307LWM', 'Citroën', 'C4', 2021, 91600, 'gasolina', 'manual', 10000.00, 'vendido', '2026-06-03', 'img/coches/citroen-c4.jpg'),
    (87, '4105NDZ', 'Škoda', 'Fabia', 2024, 38300, 'gasolina', 'manual', 12700.00, 'vendido', '2026-06-20', 'img/coches/skoda-fabia.jpg'),
    (88, '7885LFD', 'Nissan', 'Qashqai', 2021, 76000, 'híbrido', 'automático', 13600.00, 'vendido', '2026-02-11', 'img/coches/nissan-qashqai.jpg'),
    (89, '1324NTV', 'Mazda', 'CX-5', 2024, 36500, 'diésel', 'manual', 23300.00, 'vendido', '2026-09-26', 'img/coches/mazda-cx5.jpg'),
    (90, '4694MBC', 'Mercedes-Benz', 'Clase A Sedán', 2022, 44600, 'diésel', 'automático', 18600.00, 'vendido', '2026-08-15', 'img/coches/mercedes-clase-a.jpg'),
    (91, '7628MST', 'MG', 'ZS EV', 2023, 58900, 'eléctrico', 'automático', 18900.00, 'vendido', '2026-05-06', 'img/coches/mg-zs-ev.jpg'),
    (92, '4732MDC', 'Kia', 'Sportage', 2023, 53900, 'diésel', 'manual', 19000.00, 'disponible', '2026-11-15', 'img/coches/kia-sportage.jpg');

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
    'ines.costa@example.com', '+34645678901'),

(5, '00000005M', 'Marta', 'Ferrer Pons', 'mujer',
    'marta.ferrer@example.com', '+34656789012'),

(6, '00000006Y', 'Joan', 'Mas Riera', 'hombre',
    'joan.mas@example.com', '+34667890123'),

(7, '00000007F', 'Lucía', 'Navarro Ruiz', 'mujer',
    'lucia.navarro@example.com', '+34678901234'),

(8, '00000008P', 'Sergio', 'Moreno Llull', 'hombre',
    'sergio.moreno@example.com', '+34689012345'),

(9, '00000009D', 'Sam', 'Bauzà Roig', 'prefiero no decirlo',
    'sam.bauza@example.com', NULL),

(10, '00000010X', 'Elena', 'Torres Campins', 'mujer',
    'elena.torres@example.com', '+34690123456'),

(11, '00000011B', 'David', 'Pujol Amengual', 'hombre',
    'david.pujol@example.com', '+34601234567'),

(12, '00000012N', 'Aina', 'Sastre Coll', 'mujer',
    'aina.sastre@example.com', '+34611223344'),

(13, '00000013J', 'Hugo', 'Fernández Oliver', 'hombre',
    'hugo.fernandez@example.com', '+34622334455'),

(14, '00000014Z', 'Noa', 'Garcia Bennasar', 'prefiero no decirlo',
    'noa.garcia@example.com', NULL),

(15, '00000015S', 'Carmen', 'López Vich', 'mujer',
    'carmen.lopez@example.com', '+34633445566'),

(16, '00000016Q', 'Miguel', 'Cerdà Vives', 'hombre',
    'miguel.cerda@example.com', '+34696290869'),

(17, '00000017V', 'Laura', 'Bestard Mir', 'mujer',
    'laura.bestard@example.com', '+34622215229'),

(18, '00000018H', 'Andreu', 'Salom Ramis', 'hombre',
    'andreu.salom@example.com', '+34645046288'),

(19, '00000019L', 'Paula', 'Jiménez Rotger', 'mujer',
    'paula.jimenez@example.com', '+34679578048'),

(20, '00000020C', 'Kai', 'Ribas Ferrà', 'prefiero no decirlo',
    'kai.ribas@example.com', NULL),

(21, '00000021K', 'Rosa', 'Alemany Pou', 'mujer',
    'rosa.alemany@example.com', '+34659217612'),

(22, '00000022E', 'Tomeu', 'Crespí Nadal', 'hombre',
    'tomeu.crespi@example.com', '+34632420002'),

(23, '00000023T', 'Julia', 'Sánchez Font', 'mujer',
    'julia.sanchez@example.com', '+34657740731'),

(24, '00000024R', 'Iván', 'Marí Torrens', 'hombre',
    'ivan.mari@example.com', '+34639902737'),

(25, '00000025W', 'Neus', 'Oliver Mut', 'mujer',
    'neus.oliver@example.com', NULL),

(26, '00000026A', 'Óscar', 'Prats Gelabert', 'hombre',
    'oscar.prats@example.com', '+34681483341'),

(27, '00000027G', 'Irene', 'Tous Caldentey', 'mujer',
    'irene.tous@example.com', '+34682687908'),

(28, '00000028M', 'Bernat', 'Font Cladera', 'hombre',
    'bernat.font@example.com', '+34633199223'),

(29, '00000029Y', 'Sofía', 'Mora Esteva', 'mujer',
    'sofia.mora@example.com', '+34676019675'),

(30, '00000030F', 'Arnau', 'Roca Pascual', 'hombre',
    'arnau.roca@example.com', '+34660066929'),

(31, '00000031P', 'Alba', 'Vila Siquier', 'mujer',
    'alba.vila@example.com', NULL),

(32, '00000032D', 'Daniel', 'Ortega Massanet', 'hombre',
    'daniel.ortega@example.com', '+34691146825'),

(33, '00000033X', 'Marina', 'Bonet Florit', 'mujer',
    'marina.bonet@example.com', '+34638978467'),

(34, '00000034B', 'Rubén', 'Castro Albertí', 'hombre',
    'ruben.castro@example.com', '+34670363114'),

(35, '00000035N', 'Cris', 'Riera Sbert', 'prefiero no decirlo',
    'cris.riera@example.com', '+34694128697'),

(36, '00000036J', 'Nuria', 'Vallespir Coll', 'mujer',
    'nuria.vallespir@example.com', '+34694905819'),

(37, '00000037Z', 'Jaume', 'Llompart Fiol', 'hombre',
    'jaume.llompart@example.com', '+34693150370'),

(38, '00000038S', 'Eva', 'Domínguez Sureda', 'mujer',
    'eva.dominguez@example.com', NULL),

(39, '00000039Q', 'Marc', 'Juan Bover', 'hombre',
    'marc.juan@example.com', '+34699661292'),

(40, '00000040V', 'Carla', 'Morey Tugores', 'mujer',
    'carla.morey@example.com', '+34691281085'),

(41, '00000041H', 'Álvaro', 'Herrera Gual', 'hombre',
    'alvaro.herrera@example.com', '+34645190862');

INSERT INTO ventas (id_coche, id_cliente, fecha_venta, precio_final) VALUES
    (2,  1, '2026-08-12', 14900.00),
    (5,  2, '2026-09-04', 16800.00),
    (9,  3, '2026-09-18', 11500.00),
    (12, 4, '2026-10-15', 12500.00),
    (14, 5, '2026-09-02', 21800.00),
    (17, 6, '2026-10-01', 28900.00),
    (20, 7, '2026-09-21', 15200.00),
    (22, 8, '2026-09-27', 10600.00),
    (24, 10, '2026-08-25', 20500.00),
    (26, 11, '2026-09-01', 19000.00),
    (29, 12, '2026-08-21', 15300.00),
    (31, 13, '2026-10-06', 22400.00),
    (34, 3,  '2026-10-10', 23100.00),
    (36, 15, '2026-10-22', 20700.00),
    (41, 7, '2026-02-27', 26200.00),
    (60, 20, '2026-03-01', 15000.00),
    (58, 9, '2026-03-07', 27600.00),
    (38, 18, '2026-03-23', 15000.00),
    (40, 16, '2026-04-01', 13700.00),
    (49, 22, '2026-04-06', 24900.00),
    (53, 27, '2026-04-07', 8300.00),
    (46, 19, '2026-04-14', 10900.00),
    (54, 12, '2026-04-14', 19500.00),
    (37, 23, '2026-04-22', 8100.00),
    (50, 24, '2026-05-03', 16600.00),
    (56, 21, '2026-06-08', 11200.00),
    (45, 17, '2026-07-02', 13200.00),
    (39, 2, '2026-07-22', 18100.00),
    (47, 1, '2026-09-02', 15500.00),
    (57, 26, '2026-09-20', 14200.00),
    (48, 5, '2026-09-26', 9700.00),
    (43, 25, '2026-11-01', 15300.00),
    (88, 35, '2026-03-28', 12700.00),
    (85, 34, '2026-04-04', 6300.00),
    (76, 33, '2026-04-29', 21300.00),
    (72, 39, '2026-05-02', 19200.00),
    (70, 38, '2026-05-25', 13900.00),
    (83, 36, '2026-05-25', 16400.00),
    (91, 13, '2026-06-05', 18500.00),
    (81, 18, '2026-06-07', 6500.00),
    (71, 6, '2026-06-09', 4100.00),
    (75, 8, '2026-06-24', 13200.00),
    (87, 31, '2026-07-07', 12400.00),
    (86, 40, '2026-07-22', 9500.00),
    (74, 11, '2026-07-25', 9000.00),
    (66, 16, '2026-07-27', 21900.00),
    (78, 30, '2026-08-07', 9400.00),
    (64, 21, '2026-08-12', 13800.00),
    (67, 4, '2026-08-13', 5300.00),
    (90, 32, '2026-08-22', 18400.00),
    (63, 41, '2026-08-25', 8800.00),
    (77, 28, '2026-08-29', 22900.00),
    (68, 27, '2026-09-09', 10900.00),
    (61, 23, '2026-09-22', 10000.00),
    (62, 29, '2026-10-15', 9400.00),
    (89, 37, '2026-11-02', 22900.00);

