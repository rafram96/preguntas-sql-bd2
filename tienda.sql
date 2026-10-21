-- BD2 - base "tienda" para los ejercicios 1 al 23
-- psql -U postgres -d tienda -f tienda.sql
-- Si borraste o cambiaste datos, córrelo de nuevo y queda como al inicio.

DROP TABLE IF EXISTS detalle_pedido, pedido, producto, categoria,
                     cliente, empleado, sede CASCADE;

CREATE TABLE sede (
    id_sede     INTEGER PRIMARY KEY,
    nombre      VARCHAR(40) NOT NULL,
    ciudad      VARCHAR(40) NOT NULL
);

CREATE TABLE empleado (
    id_empleado   INTEGER PRIMARY KEY,
    nombre        VARCHAR(40) NOT NULL,
    apellido      VARCHAR(40) NOT NULL,
    cargo         VARCHAR(30) NOT NULL,
    salario       NUMERIC(8,2) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    id_sede       INTEGER NOT NULL REFERENCES sede(id_sede),
    id_jefe       INTEGER REFERENCES empleado(id_empleado)
);

CREATE TABLE cliente (
    id_cliente     INTEGER PRIMARY KEY,
    nombre         VARCHAR(40) NOT NULL,
    apellido       VARCHAR(40) NOT NULL,
    email          VARCHAR(60) NOT NULL,
    ciudad         VARCHAR(40) NOT NULL,
    fecha_registro DATE NOT NULL
);

CREATE TABLE categoria (
    id_categoria INTEGER PRIMARY KEY,
    nombre       VARCHAR(40) NOT NULL
);

CREATE TABLE producto (
    id_producto  INTEGER PRIMARY KEY,
    nombre       VARCHAR(60) NOT NULL,
    id_categoria INTEGER NOT NULL REFERENCES categoria(id_categoria),
    precio       NUMERIC(8,2) NOT NULL CHECK (precio >= 0),
    stock        INTEGER NOT NULL CHECK (stock >= 0)
);

CREATE TABLE pedido (
    id_pedido   INTEGER PRIMARY KEY,
    id_cliente  INTEGER NOT NULL REFERENCES cliente(id_cliente),
    id_empleado INTEGER NOT NULL REFERENCES empleado(id_empleado),
    fecha       DATE NOT NULL,
    estado      VARCHAR(12) NOT NULL
                CHECK (estado IN ('pendiente','enviado','entregado','cancelado'))
);

CREATE TABLE detalle_pedido (
    id_pedido       INTEGER REFERENCES pedido(id_pedido),
    id_producto     INTEGER REFERENCES producto(id_producto),
    cantidad        INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(8,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_producto)
);

INSERT INTO sede VALUES
(1, 'San Isidro',      'Lima'),
(2, 'Miraflores',      'Lima'),
(3, 'Arequipa Centro', 'Arequipa'),
(4, 'Trujillo Plaza',  'Trujillo');

INSERT INTO empleado VALUES
( 1, 'Carmen', 'Rojas',     'Gerente',        9500.00, '2019-03-01', 1, NULL),
( 2, 'Luis',   'Paredes',   'Jefe de tienda', 6000.00, '2020-01-15', 1, 1),
( 3, 'Ana',    'Torres',    'Jefe de tienda', 5800.00, '2020-06-01', 2, 1),
( 4, 'Jorge',  'Quispe',    'Jefe de tienda', 5500.00, '2021-02-10', 3, 1),
( 5, 'María',  'Huamán',    'Vendedor',       3200.00, '2022-04-01', 1, 2),
( 6, 'Pedro',  'Salazar',   'Vendedor',       6200.00, '2021-08-20', 1, 2),
( 7, 'Lucía',  'Fernández', 'Vendedor',       3000.00, '2023-01-09', 2, 3),
( 8, 'Diego',  'Castillo',  'Vendedor',       3500.00, '2022-11-15', 2, 3),
( 9, 'Rosa',   'Mendoza',   'Vendedor',       5600.00, '2023-05-02', 3, 4),
(10, 'Kevin',  'Ramos',     'Vendedor',       2900.00, '2024-02-01', 3, 4);

INSERT INTO cliente VALUES
( 1, 'Rafael',    'Gómez',     'rafael.gomez@mail.com',  'Lima',     '2025-01-10'),
( 2, 'Sofía',     'García',    'sofia.garcia@mail.com',  'Lima',     '2025-02-03'),
( 3, 'Rafael',    'Vargas',    'rvargas@mail.com',       'Arequipa', '2025-03-15'),
( 4, 'Valeria',   'Chávez',    'valeria.ch@mail.com',    'Trujillo', '2025-03-20'),
( 5, 'Andrés',    'Gutiérrez', 'andres.g@mail.com',      'Lima',     '2025-04-11'),
( 6, 'Camila',    'Ríos',      'camila.rios@mail.com',   'Arequipa', '2025-05-05'),
( 7, 'Mateo',     'Flores',    'mateo.f@mail.com',       'Lima',     '2025-06-18'),
( 8, 'Daniela',   'Núñez',     'daniela.n@mail.com',     'Cusco',    '2025-07-01'),
( 9, 'Sebastián', 'León',      'sebas.leon@mail.com',    'Trujillo', '2025-08-09'),
(10, 'Lucía',     'Gonzales',  'lucia.gz@mail.com',      'Lima',     '2025-09-14'),
(11, 'Rafaela',   'Soto',      'rafaela.soto@mail.com',  'Arequipa', '2025-10-02'),
(12, 'Sofía',     'García',    'sofia.garcia@mail.com',  'Lima',     '2025-11-20'),
(13, 'Mateo',     'Flores',    'mateo.f@mail.com',       'Lima',     '2026-01-05'),
(14, 'Gabriel',   'Pinto',     'gabriel.p@mail.com',     'Cusco',    '2026-02-14');

INSERT INTO categoria VALUES
(1, 'Electrónica'),
(2, 'Periféricos'),
(3, 'Oficina'),
(4, 'Muebles');

INSERT INTO producto VALUES
( 1, 'Laptop Lenovo IdeaPad',  1, 2899.00,  12),
( 2, 'Monitor LG 24',          1,  649.90,  20),
( 3, 'Tablet Samsung A9',      1,  899.00,   8),
( 4, 'Audífonos Sony',         1,  459.00,  15),
( 5, 'Mouse inalámbrico',      2,   59.90,  80),
( 6, 'Teclado mecánico',       2,  189.00,  35),
( 7, 'Webcam HD',              2,  149.00,   0),
( 8, 'Hub USB-C',              2,   99.00,  40),
( 9, 'Resma papel A4',         3,   22.50, 200),
(10, 'Archivador',             3,   15.00,   0),
(11, 'Lapiceros x12',          3,   12.90, 150),
(12, 'Calculadora científica', 3,   79.00,  25),
(13, 'Silla ergonómica',       4,  799.00,  10),
(14, 'Escritorio en L',        4, 1099.00,   5),
(15, 'Lámpara LED',            4,   89.00,  30);

INSERT INTO pedido VALUES
( 1,  1,  5, '2025-11-05', 'entregado'),
( 2,  2,  5, '2025-11-12', 'entregado'),
( 3,  5,  6, '2025-11-20', 'entregado'),
( 4,  3,  9, '2025-12-02', 'entregado'),
( 5,  2,  6, '2025-12-10', 'entregado'),
( 6,  7,  7, '2025-12-15', 'cancelado'),
( 7,  4,  8, '2026-01-08', 'entregado'),
( 8,  6,  9, '2026-01-15', 'entregado'),
( 9,  2,  5, '2026-01-22', 'entregado'),
(10,  9,  8, '2026-02-03', 'enviado'),
(11,  5,  6, '2026-02-11', 'entregado'),
(12, 10,  7, '2026-02-19', 'pendiente'),
(13,  1,  6, '2026-01-25', 'pendiente'),
(14,  3, 10, '2026-03-04', 'entregado'),
(15,  7,  6, '2026-03-10', 'enviado'),
(16,  2,  6, '2026-03-18', 'entregado'),
(17,  6, 10, '2026-03-25', 'enviado'),
(18, 11,  9, '2026-04-02', 'pendiente'),
(19,  5,  5, '2026-04-09', 'entregado'),
(20,  4,  8, '2026-04-15', 'pendiente');

INSERT INTO detalle_pedido VALUES
( 1,  1,  1, 2899.00), ( 1,  5,  1,   59.90),
( 2,  2,  2,  649.90), ( 2,  6,  1,  189.00),
( 3,  9, 10,   22.50), ( 3, 11,  5,   12.90),
( 4, 13,  1,  799.00), ( 4, 15,  2,   89.00),
( 5,  4,  1,  459.00), ( 5,  8,  2,   99.00),
( 6,  3,  1,  899.00),
( 7,  5,  3,   59.90), ( 7,  6,  2,  189.00), ( 7,  8,  1,   99.00),
( 8, 12,  2,   79.00), ( 8,  9,  4,   22.50),
( 9,  1,  1, 2899.00), ( 9,  2,  1,  649.90),
(10, 15,  1,   89.00), (10, 11,  3,   12.90),
(11,  5,  2,   59.90), (11,  4,  1,  459.00),
(12,  9,  6,   22.50),
(13,  6,  1,  189.00), (13,  8,  1,   99.00),
(14,  3,  1,  899.00), (14,  5,  1,   59.90),
(15, 13,  2,  799.00),
(16,  6,  1,  189.00), (16,  3,  1,  899.00),
(17,  2,  1,  649.90), (17, 12,  1,   79.00),
(18,  1,  1, 2899.00),
(19,  9, 20,   22.50), (19, 15,  1,   89.00),
(20, 13,  1,  799.00), (20,  5,  2,   59.90);
