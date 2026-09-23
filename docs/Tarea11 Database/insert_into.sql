USE palasada;


-- =========================================
-- CATEGORIAS
-- =========================================

INSERT INTO categoria (categoria_id, nombre) VALUES
(1, 'Res'),
(2, 'Rib Eye'),
(3, 'Tomahawk'),
(4, 'Picaña'),
(5, 'New York'),
(6, 'Cowboy'),
(7, 'Arrachera'),
(8, 'T-Bone'),
(9, 'Sirloin'),
(10, 'Costilla');


-- =========================================
-- PRECIOS
-- Precio por kilogramo
-- =========================================

INSERT INTO precio (precio_id, monto, moneda, texto, nota) VALUES
('PRECIO001', 450.00, 'MXN', '$450.00 / kg', 'Precio por kilogramo'),
('PRECIO002', 500.00, 'MXN', '$500.00 / kg', 'Precio por kilogramo'),
('PRECIO003', 550.00, 'MXN', '$550.00 / kg', 'Precio por kilogramo'),
('PRECIO004', 420.00, 'MXN', '$420.00 / kg', 'Precio por kilogramo'),
('PRECIO005', 480.00, 'MXN', '$480.00 / kg', 'Precio por kilogramo'),
('PRECIO006', 520.00, 'MXN', '$520.00 / kg', 'Precio por kilogramo'),
('PRECIO007', 390.00, 'MXN', '$390.00 / kg', 'Precio por kilogramo'),
('PRECIO008', 460.00, 'MXN', '$460.00 / kg', 'Precio por kilogramo'),
('PRECIO009', 400.00, 'MXN', '$400.00 / kg', 'Precio por kilogramo'),
('PRECIO010', 430.00, 'MXN', '$430.00 / kg', 'Precio por kilogramo');


-- =========================================
-- INVENTARIO
-- Cantidad de piezas disponibles
-- =========================================

INSERT INTO inventario (inventario_id, estado, cantidad) VALUES
('INV001', 'Disponible', 20),
('INV002', 'Disponible', 15),
('INV003', 'Disponible', 10),
('INV004', 'Disponible', 25),
('INV005', 'Disponible', 18),
('INV006', 'Disponible', 12),
('INV007', 'Disponible', 30),
('INV008', 'Disponible', 16),
('INV009', 'Disponible', 22),
('INV010', 'Disponible', 14);


-- =========================================
-- IMAGENES
-- =========================================

INSERT INTO imagen (imagen_id, url, remota, local) VALUES
('IMG001', 'https://ejemplo.com/ribeye.jpg', NULL, NULL),
('IMG002', 'https://ejemplo.com/tomahawk.jpg', NULL, NULL),
('IMG003', 'https://ejemplo.com/picana.jpg', NULL, NULL),
('IMG004', 'https://ejemplo.com/newyork.jpg', NULL, NULL),
('IMG005', 'https://ejemplo.com/cowboy.jpg', NULL, NULL),
('IMG006', 'https://ejemplo.com/arrachera.jpg', NULL, NULL),
('IMG007', 'https://ejemplo.com/tbone.jpg', NULL, NULL),
('IMG008', 'https://ejemplo.com/sirloin.jpg', NULL, NULL),
('IMG009', 'https://ejemplo.com/costilla.jpg', NULL, NULL),
('IMG010', 'https://ejemplo.com/filete.jpg', NULL, NULL);


-- =========================================
-- INFORMACION ADICIONAL
-- Peso por pieza
-- =========================================

INSERT INTO informacion_adicional
(info_id, peso, lugar_origen, nivel_marmoleado, maridaje)
VALUES
('INFO001', '350 g', 'Mexico', 'Alto', NULL),
('INFO002', '450 g', 'Mexico', 'Alto', NULL),
('INFO003', '600 g', 'Mexico', 'Medio', NULL),
('INFO004', '400 g', 'Mexico', 'Alto', NULL),
('INFO005', '500 g', 'Mexico', 'Alto', NULL),
('INFO006', '300 g', 'Mexico', 'Medio', NULL),
('INFO007', '450 g', 'Mexico', 'Medio', NULL),
('INFO008', '400 g', 'Mexico', 'Medio', NULL),
('INFO009', '500 g', 'Mexico', 'Medio', NULL),
('INFO010', '350 g', 'Mexico', 'Alto', NULL);


-- =========================================
-- PRODUCTOS
-- =========================================

INSERT INTO producto
(id, sku, nombre, tieneVariantes, descripcion, precio_id,
inventario_id, imagen_id, info_adicional_id, categoria_principal_id)
VALUES

('PROD001',
'RES001',
'Rib Eye',
0,
'Corte Rib Eye de res de alta calidad.',
'PRECIO001',
'INV001',
'IMG001',
'INFO001',
2),

('PROD002',
'RES002',
'Tomahawk',
0,
'Corte Tomahawk de res con hueso.',
'PRECIO002',
'INV002',
'IMG002',
'INFO002',
3),

('PROD003',
'RES003',
'Picaña',
0,
'Corte Picaña de res.',
'PRECIO003',
'INV003',
'IMG003',
'INFO003',
4),

('PROD004',
'RES004',
'New York',
0,
'Corte New York de res.',
'PRECIO004',
'INV004',
'IMG004',
'INFO004',
5),

('PROD005',
'RES005',
'Cowboy',
0,
'Corte Cowboy de res.',
'PRECIO005',
'INV005',
'IMG005',
'INFO005',
6),

('PROD006',
'RES006',
'Arrachera',
0,
'Arrachera de res lista para preparar.',
'PRECIO006',
'INV006',
'IMG006',
'INFO006',
7),

('PROD007',
'RES007',
'T-Bone',
0,
'Corte T-Bone de res.',
'PRECIO007',
'INV007',
'IMG007',
'INFO007',
8),

('PROD008',
'RES008',
'Sirloin',
0,
'Corte Sirloin de res.',
'PRECIO008',
'INV008',
'IMG008',
'INFO008',
9),

('PROD009',
'RES009',
'Costilla de Res',
0,
'Costilla de res para asar.',
'PRECIO009',
'INV009',
'IMG009',
'INFO009',
10),

('PROD010',
'RES010',
'Filete de Res',
0,
'Filete de res de alta calidad.',
'PRECIO010',
'INV010',
'IMG010',
'INFO010',
1);


-- =========================================
-- CATEGORIAS SECUNDARIAS
-- =========================================

INSERT INTO productocategoria (producto_id, categoria_id) VALUES
('PROD001', 1),
('PROD002', 1),
('PROD003', 1),
('PROD004', 1),
('PROD005', 1),
('PROD006', 1),
('PROD007', 1),
('PROD008', 1),
('PROD009', 1),
('PROD010', 1);


-- =========================================
-- TAGS
-- =========================================

-- Ya existen en el script original:
--
-- 1 PREMIUM
-- 2 NUEVO
-- 3 DESCUENTO
-- 4 NACIONAL
-- 5 INTERNACIONAL
-- 6 MAS_VENDIDO
-- 7 HOT_SALE
-- 8 POR_TEMPORADA


-- =========================================
-- TAGS DE PRODUCTOS
-- Solo una tag activa por producto
-- =========================================

INSERT INTO producto_tag
(producto_id, tag_id, fecha_asignacion, fecha_expiracion)
VALUES

('PROD001', 1, NOW(), NULL),

('PROD002', 1, NOW(), NULL),

('PROD003', 4, NOW(), NULL),

('PROD004', 4, NOW(), NULL),

('PROD005', 1, NOW(), NULL),

('PROD006', 3, NOW(), NULL),

('PROD007', 6, NOW(), NULL),

('PROD008', 4, NOW(), NULL),

('PROD009', 8, NOW(), NULL),

('PROD010', 2, NOW(), DATE_ADD(NOW(), INTERVAL 10 DAY));


-- =========================================
-- CONDICIONES COMERCIALES
-- =========================================

INSERT INTO condicion_comercial
(producto_id, tag_id, precio_promocional, fecha_inicio, fecha_fin)
VALUES

('PROD006', 3, 480.00, '2026-09-01', '2026-09-30'),

('PROD009', 8, 380.00, '2026-09-01', '2026-09-30');


-- =========================================
-- HISTORIAL DE PRECIOS
-- =========================================

INSERT INTO historial_precio
(producto_id, precio_anterior, precio_nuevo, fecha_cambio)
VALUES

('PROD001', 420.00, 450.00, NOW()),
('PROD002', 470.00, 500.00, NOW()),
('PROD003', 520.00, 550.00, NOW()),
('PROD004', 400.00, 420.00, NOW()),
('PROD005', 450.00, 480.00, NOW()),
('PROD006', 500.00, 520.00, NOW()),
('PROD007', 370.00, 390.00, NOW()),
('PROD008', 440.00, 460.00, NOW()),
('PROD009', 380.00, 400.00, NOW()),
('PROD010', 370.00, 430.00, NOW());


-- =========================================
-- HISTORIAL DE INVENTARIO
-- =========================================

INSERT INTO historial_inventario
(producto_id, cantidad_anterior, cantidad_nueva, tipo_movimiento)
VALUES

('PROD001', 0, 20, 'reposicion'),
('PROD002', 0, 15, 'reposicion'),
('PROD003', 0, 10, 'reposicion'),
('PROD004', 0, 25, 'reposicion'),
('PROD005', 0, 18, 'reposicion'),
('PROD006', 0, 12, 'reposicion'),
('PROD007', 0, 30, 'reposicion'),
('PROD008', 0, 16, 'reposicion'),
('PROD009', 0, 22, 'reposicion'),
('PROD010', 0, 14, 'reposicion');


-- =========================================
-- USUARIOS
-- =========================================

INSERT INTO usuarios
(nombre, correo, telefono, password, activo)
VALUES

('Juan Perez', 'juan@gmail.com', '5551111111', '123456', 1),
('Maria Lopez', 'maria@gmail.com', '5552222222', '123456', 1),
('Carlos Garcia', 'carlos@gmail.com', '5553333333', '123456', 1),
('Ana Martinez', 'ana@gmail.com', '5554444444', '123456', 1),
('Luis Hernandez', 'luis@gmail.com', '5555555555', '123456', 1),
('Sofia Rodriguez', 'sofia@gmail.com', '5556666666', '123456', 1),
('Pedro Torres', 'pedro@gmail.com', '5557777777', '123456', 1),
('Laura Sanchez', 'laura@gmail.com', '5558888888', '123456', 1),
('Diego Flores', 'diego@gmail.com', '5559999999', '123456', 1),
('Daniela Ruiz', 'daniela@gmail.com', '5550000000', '123456', 1);


-- =========================================
-- DIRECCIONES
-- Ciudad de Mexico
-- =========================================

INSERT INTO direcciones
(usuario_id, nombre, calle, numero, colonia, municipio, estado,
codigo_postal, referencias, predeterminada)
VALUES

(1, 'Casa', 'Av. Reforma', '100', 'Juarez', 'Cuauhtemoc',
'Ciudad de Mexico', '06600', 'Casa blanca', 1),

(2, 'Casa', 'Av. Insurgentes', '200', 'Del Valle',
'Benito Juarez', 'Ciudad de Mexico', '03100', 'Porton negro', 1),

(3, 'Casa', 'Av. Universidad', '300', 'Copilco',
'Coyoacan', 'Ciudad de Mexico', '04360', 'Casa esquina', 1),

(4, 'Casa', 'Av. Tlalpan', '400', 'Centro',
'Coyoacan', 'Ciudad de Mexico', '04000', 'Frente al parque', 1),

(5, 'Casa', 'Av. Revolucion', '500', 'Mixcoac',
'Benito Juarez', 'Ciudad de Mexico', '03910', 'Casa gris', 1),

(6, 'Casa', 'Av. Patriotismo', '600', 'Escandon',
'Miguel Hidalgo', 'Ciudad de Mexico', '11800', 'Departamento 3', 1),

(7, 'Casa', 'Av. Division del Norte', '700', 'Narvarte',
'Benito Juarez', 'Ciudad de Mexico', '03020', 'Reja blanca', 1),

(8, 'Casa', 'Av. Coyoacan', '800', 'Xoco',
'Benito Juarez', 'Ciudad de Mexico', '03330', 'Casa azul', 1),

(9, 'Casa', 'Av. Chapultepec', '900', 'Roma Norte',
'Cuauhtemoc', 'Ciudad de Mexico', '06700', 'Edificio rojo', 1),

(10, 'Casa', 'Av. Mexico', '1000', 'Condesa',
'Cuauhtemoc', 'Ciudad de Mexico', '06140', 'Departamento 5', 1);


-- =========================================
-- CARRITOS
-- =========================================

INSERT INTO carrito (usuario_id) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);


-- =========================================
-- PRODUCTOS EN CARRITO
-- =========================================

INSERT INTO carrito_producto
(cantidad, carrito_id, producto_id)
VALUES

(2, 1, 'PROD001'),
(1, 2, 'PROD002'),
(2, 3, 'PROD003'),
(1, 4, 'PROD004'),
(2, 5, 'PROD005'),
(1, 6, 'PROD006'),
(3, 7, 'PROD007'),
(2, 8, 'PROD008'),
(1, 9, 'PROD009'),
(2, 10, 'PROD010');


-- =========================================
-- PEDIDOS
-- =========================================

INSERT INTO pedido
(estado, fecha_creacion, subtotal, envio, total, usuario_id)
VALUES

('entregado', NOW(), 315.00, 69.00, 384.00, 1),

('enviado', NOW(), 450.00, 69.00, 519.00, 2),

('en_proceso', NOW(), 660.00, 69.00, 729.00, 3),

('confirmado', NOW(), 168.00, 69.00, 237.00, 4),

('confirmado', NOW(), 480.00, 69.00, 549.00, 5),

('entregado', NOW(), 312.00, 69.00, 381.00, 6),

('cancelado', NOW(), 390.00, 69.00, 459.00, 7),

('enviado', NOW(), 460.00, 69.00, 529.00, 8),

('confirmado', NOW(), 380.00, 69.00, 449.00, 9),

('pendiente', NOW(), 860.00, 69.00, 929.00, 10);


-- =========================================
-- DETALLE DE PEDIDOS
-- =========================================

INSERT INTO detalle_pedido
(cantidad, precio_unitario, pedido_id, producto_id)
VALUES

(2, 157.50, 1, 'PROD001'),

(1, 450.00, 2, 'PROD002'),

(2, 330.00, 3, 'PROD003'),

(1, 168.00, 4, 'PROD004'),

(1, 480.00, 5, 'PROD005'),

(1, 312.00, 6, 'PROD006'),

(1, 390.00, 7, 'PROD007'),

(1, 460.00, 8, 'PROD008'),

(1, 380.00, 9, 'PROD009'),

(2, 430.00, 10, 'PROD010');


-- =========================================
-- ENTREGAS
-- Solo domicilio
-- =========================================

INSERT INTO entrega
(direccion_id, fecha_programada, rango_horario,
tipo_entrega, fecha_hora_entregado, pedido_id)
VALUES

(1, '2026-09-17', '10:00-13:00',
'domicilio', NOW(), 1),

(2, '2026-09-18', '13:00-16:00',
'domicilio', NULL, 2),

(3, '2026-09-18', '16:00-20:00',
'domicilio', NULL, 3),

(4, '2026-09-19', '10:00-13:00',
'domicilio', NULL, 4),

(5, '2026-09-19', '13:00-16:00',
'domicilio', NULL, 5),

(6, '2026-09-17', '16:00-20:00',
'domicilio', NOW(), 6),

(7, '2026-09-20', '10:00-13:00',
'domicilio', NULL, 7),

(8, '2026-09-20', '13:00-16:00',
'domicilio', NULL, 8),

(9, '2026-09-21', '16:00-20:00',
'domicilio', NULL, 9),

(10, '2026-09-21', '13:00-16:00',
'domicilio', NULL, 10);


-- =========================================
-- PAGOS
-- =========================================

INSERT INTO pago
(metodo_pago, estado_pago, monto, fecha_pago,
referencia_transaccion, pedido_id)
VALUES

('tarjeta', 'aprobado', 384.00, NOW(), 'TRANS001', 1),

('transferencia', 'aprobado', 519.00, NOW(), 'TRANS002', 2),

('tarjeta', 'aprobado', 729.00, NOW(), 'TRANS003', 3),

('tarjeta', 'aprobado', 237.00, NOW(), 'TRANS004', 4),

('transferencia', 'aprobado', 549.00, NOW(), 'TRANS005', 5),

('tarjeta', 'aprobado', 381.00, NOW(), 'TRANS006', 6),

('tarjeta', 'reembolsado', 459.00, NOW(), 'TRANS007', 7),

('tarjeta', 'aprobado', 529.00, NOW(), 'TRANS008', 8),

('transferencia', 'aprobado', 449.00, NOW(), 'TRANS009', 9),

('tarjeta', 'pendiente', 929.00, NULL, NULL, 10);