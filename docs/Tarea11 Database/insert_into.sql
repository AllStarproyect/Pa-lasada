USE tienda2;

-- =========================================
-- CATEGORIAS
-- =========================================

INSERT INTO categoria (categoria_id, nombre) VALUES
(1, 'Carnes'),
(2, 'Cervezas'),
(3, 'Vinos'),
(4, 'Refrescos'),
(5, 'Botanas');


-- =========================================
-- PRECIOS
-- =========================================

INSERT INTO precio (precio_id, monto, moneda, texto, nota) VALUES
('PRECIO001', 250.00, 'MXN', '$250.00', 'Precio normal'),
('PRECIO002', 45.00, 'MXN', '$45.00', 'Precio normal'),
('PRECIO003', 180.00, 'MXN', '$180.00', 'Precio normal'),
('PRECIO004', 35.00, 'MXN', '$35.00', 'Precio normal'),
('PRECIO005', 60.00, 'MXN', '$60.00', 'Precio normal'),
('PRECIO006', 320.00, 'MXN', '$320.00', 'Precio normal'),
('PRECIO007', 75.00, 'MXN', '$75.00', 'Precio normal'),
('PRECIO008', 120.00, 'MXN', '$120.00', 'Precio normal'),
('PRECIO009', 50.00, 'MXN', '$50.00', 'Precio normal'),
('PRECIO010', 95.00, 'MXN', '$95.00', 'Precio normal');


-- =========================================
-- INVENTARIO
-- =========================================

INSERT INTO inventario (inventario_id, estado, cantidad) VALUES
('INV001', 'disponible', 20),
('INV002', 'disponible', 50),
('INV003', 'disponible', 15),
('INV004', 'disponible', 40),
('INV005', 'disponible', 30),
('INV006', 'disponible', 10),
('INV007', 'disponible', 25),
('INV008', 'disponible', 18),
('INV009', 'disponible', 35),
('INV010', 'disponible', 22);


-- =========================================
-- IMAGENES
-- =========================================

INSERT INTO imagen (imagen_id, url, remota, local) VALUES
('IMG001', 'https://ejemplo.com/carne.jpg', NULL, NULL),
('IMG002', 'https://ejemplo.com/cerveza1.jpg', NULL, NULL),
('IMG003', 'https://ejemplo.com/vino.jpg', NULL, NULL),
('IMG004', 'https://ejemplo.com/refresco.jpg', NULL, NULL),
('IMG005', 'https://ejemplo.com/botana.jpg', NULL, NULL),
('IMG006', 'https://ejemplo.com/carne2.jpg', NULL, NULL),
('IMG007', 'https://ejemplo.com/cerveza2.jpg', NULL, NULL),
('IMG008', 'https://ejemplo.com/vino2.jpg', NULL, NULL),
('IMG009', 'https://ejemplo.com/refresco2.jpg', NULL, NULL),
('IMG010', 'https://ejemplo.com/botana2.jpg', NULL, NULL);


-- =========================================
-- INFORMACION ADICIONAL
-- =========================================

INSERT INTO informacion_adicional
(info_id, peso, lugar_origen, nivel_marmoleado, maridaje)
VALUES
('INFO001', '1 kg', 'Nuevo Leon', 'Alto', 'Vino tinto'),
('INFO002', '355 ml', 'Mexico', NULL, 'Carnes'),
('INFO003', '750 ml', 'Chile', NULL, 'Carnes rojas'),
('INFO004', '600 ml', 'Mexico', NULL, 'Botanas'),
('INFO005', '500 g', 'Mexico', NULL, 'Cerveza'),
('INFO006', '1 kg', 'Sonora', 'Medio', 'Vino tinto'),
('INFO007', '473 ml', 'Mexico', NULL, 'Hamburguesas'),
('INFO008', '750 ml', 'Argentina', NULL, 'Carnes'),
('INFO009', '600 ml', 'Mexico', NULL, 'Botanas'),
('INFO010', '400 g', 'Mexico', NULL, 'Cerveza');


-- =========================================
-- PRODUCTOS
-- =========================================

INSERT INTO producto
(id, sku, nombre, tieneVariantes, descripcion, precio_id,
 inventario_id, imagen_id, info_adicional_id, categoria_principal_id)
VALUES
('PROD001', 'CARNE001', 'Rib Eye', 0, 'Rib Eye de primera calidad', 'PRECIO001', 'INV001', 'IMG001', 'INFO001', 1),

('PROD002', 'CERVEZA001', 'Cerveza Nacional', 0, 'Cerveza nacional 355 ml', 'PRECIO002', 'INV002', 'IMG002', 'INFO002', 2),

('PROD003', 'VINO001', 'Vino Tinto', 0, 'Vino tinto de mesa', 'PRECIO003', 'INV003', 'IMG003', 'INFO003', 3),

('PROD004', 'REFRESCO001', 'Refresco Cola', 0, 'Refresco de cola 600 ml', 'PRECIO004', 'INV004', 'IMG004', 'INFO004', 4),

('PROD005', 'BOTANA001', 'Papas Fritas', 0, 'Papas fritas 500 g', 'PRECIO005', 'INV005', 'IMG005', 'INFO005', 5),

('PROD006', 'CARNE002', 'Sirloin', 0, 'Corte de sirloin', 'PRECIO006', 'INV006', 'IMG006', 'INFO006', 1),

('PROD007', 'CERVEZA002', 'Cerveza Premium', 0, 'Cerveza premium 473 ml', 'PRECIO007', 'INV007', 'IMG007', 'INFO007', 2),

('PROD008', 'VINO002', 'Vino Malbec', 0, 'Vino Malbec argentino', 'PRECIO008', 'INV008', 'IMG008', 'INFO008', 3),

('PROD009', 'REFRESCO002', 'Refresco Lima', 0, 'Refresco sabor lima', 'PRECIO009', 'INV009', 'IMG009', 'INFO009', 4),

('PROD010', 'BOTANA002', 'Cacahuates', 0, 'Cacahuates salados', 'PRECIO010', 'INV010', 'IMG010', 'INFO010', 5);


-- =========================================
-- CATEGORIAS SECUNDARIAS
-- =========================================

INSERT INTO productocategoria (producto_id, categoria_id) VALUES
('PROD001', 5),
('PROD002', 5),
('PROD003', 1),
('PROD004', 5),
('PROD005', 2),
('PROD006', 5),
('PROD007', 5),
('PROD008', 1),
('PROD009', 5),
('PROD010', 2);


-- =========================================
-- TAGS
-- =========================================

-- Los tags ya vienen creados en tu script.
-- PREMIUM = 1
-- NUEVO = 2
-- DESCUENTO = 3
-- NACIONAL = 4
-- INTERNACIONAL = 5
-- MAS_VENDIDO = 6
-- HOT_SALE = 7
-- POR_TEMPORADA = 8


INSERT INTO producto_tag
(producto_id, tag_id, fecha_asignacion, fecha_expiracion)
VALUES
('PROD001', 1, NOW(), NULL),
('PROD002', 4, NOW(), NULL),
('PROD003', 5, NOW(), NULL),
('PROD004', 4, NOW(), NULL),
('PROD005', 6, NOW(), NULL),
('PROD006', 1, NOW(), NULL),
('PROD007', 7, NOW(), NULL),
('PROD008', 5, NOW(), NULL),
('PROD009', 2, NOW(), NULL),
('PROD010', 8, NOW(), NULL);


-- =========================================
-- CONDICIONES COMERCIALES
-- =========================================

INSERT INTO condicion_comercial
(producto_id, tag_id, precio_promocional, fecha_inicio, fecha_fin)
VALUES
('PROD007', 7, 60.00, '2026-09-01', '2026-09-30'),

('PROD010', 8, 80.00, '2026-09-01', '2026-12-31');


-- =========================================
-- HISTORIAL DE PRECIOS
-- =========================================

INSERT INTO historial_precio
(producto_id, precio_anterior, precio_nuevo, fecha_cambio)
VALUES
('PROD001', 230.00, 250.00, NOW()),
('PROD002', 40.00, 45.00, NOW()),
('PROD003', 160.00, 180.00, NOW()),
('PROD004', 30.00, 35.00, NOW()),
('PROD005', 55.00, 60.00, NOW()),
('PROD006', 300.00, 320.00, NOW()),
('PROD007', 70.00, 75.00, NOW()),
('PROD008', 110.00, 120.00, NOW()),
('PROD009', 45.00, 50.00, NOW()),
('PROD010', 85.00, 95.00, NOW());


-- =========================================
-- HISTORIAL DE INVENTARIO
-- =========================================

INSERT INTO historial_inventario
(producto_id, cantidad_anterior, cantidad_nueva, tipo_movimiento)
VALUES
('PROD001', 0, 20, 'reposicion'),
('PROD002', 0, 50, 'reposicion'),
('PROD003', 0, 15, 'reposicion'),
('PROD004', 0, 40, 'reposicion'),
('PROD005', 0, 30, 'reposicion'),
('PROD006', 0, 10, 'reposicion'),
('PROD007', 0, 25, 'reposicion'),
('PROD008', 0, 18, 'reposicion'),
('PROD009', 0, 35, 'reposicion'),
('PROD010', 0, 22, 'reposicion');


-- =========================================
-- USUARIOS
-- =========================================

INSERT INTO usuarios
(nombre, correo, telefono, password, activo)
VALUES
('Juan Perez', 'juan@gmail.com', '8111111111', '123456', 1),
('Maria Lopez', 'maria@gmail.com', '8122222222', '123456', 1),
('Carlos Garcia', 'carlos@gmail.com', '8133333333', '123456', 1),
('Ana Martinez', 'ana@gmail.com', '8144444444', '123456', 1),
('Luis Hernandez', 'luis@gmail.com', '8155555555', '123456', 1),
('Sofia Rodriguez', 'sofia@gmail.com', '8166666666', '123456', 1),
('Pedro Torres', 'pedro@gmail.com', '8177777777', '123456', 1),
('Laura Sanchez', 'laura@gmail.com', '8188888888', '123456', 1),
('Diego Flores', 'diego@gmail.com', '8199999999', '123456', 1),
('Daniela Ruiz', 'daniela@gmail.com', '8100000000', '123456', 1);


-- =========================================
-- DIRECCIONES
-- =========================================

INSERT INTO direcciones
(usuario_id, nombre, calle, numero, colonia, municipio, estado, codigo_postal, referencias, predeterminada)
VALUES
(1, 'Casa', 'Av. Universidad', '100', 'Anahuac', 'San Nicolas', 'Nuevo Leon', '66450', 'Casa blanca', 1),

(2, 'Casa', 'Av. Sendero', '200', 'Las Puentes', 'San Nicolas', 'Nuevo Leon', '66460', 'Casa azul', 1),

(3, 'Casa', 'Av. Lincoln', '300', 'Mitras', 'Monterrey', 'Nuevo Leon', '64170', 'Frente al parque', 1),

(4, 'Casa', 'Av. Leones', '400', 'Cumbres', 'Monterrey', 'Nuevo Leon', '64610', 'Porton negro', 1),

(5, 'Casa', 'Av. Rangel Frias', '500', 'Chepevera', 'Monterrey', 'Nuevo Leon', '64030', 'Casa esquina', 1),

(6, 'Casa', 'Av. Garza Sada', '600', 'Contry', 'Monterrey', 'Nuevo Leon', '64860', 'Casa blanca', 1),

(7, 'Casa', 'Av. Revolucion', '700', 'Ladrillera', 'Monterrey', 'Nuevo Leon', '64830', 'Frente a tienda', 1),

(8, 'Casa', 'Av. Madero', '800', 'Centro', 'Monterrey', 'Nuevo Leon', '64000', 'Departamento 2', 1),

(9, 'Casa', 'Av. Gonzalitos', '900', 'Vista Hermosa', 'Monterrey', 'Nuevo Leon', '64620', 'Casa gris', 1),

(10, 'Casa', 'Av. Acapulco', '1000', 'Linda Vista', 'Guadalupe', 'Nuevo Leon', '67123', 'Casa con reja', 1);


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
(2, 1, 'PROD002'),
(1, 1, 'PROD005'),
(1, 2, 'PROD001'),
(2, 2, 'PROD004'),
(1, 3, 'PROD003'),
(3, 3, 'PROD002'),
(2, 4, 'PROD007'),
(1, 5, 'PROD006'),
(2, 6, 'PROD009'),
(1, 7, 'PROD008');


-- =========================================
-- PEDIDOS
-- =========================================

INSERT INTO pedido
(estado, fecha_creacion, subtotal, envio, total, usuario_id)
VALUES
('entregado', NOW(), 340.00, 50.00, 390.00, 1),

('enviado', NOW(), 250.00, 50.00, 300.00, 2),

('en_proceso', NOW(), 180.00, 50.00, 230.00, 3),

('confirmado', NOW(), 150.00, 50.00, 200.00, 4),

('pendiente', NOW(), 320.00, 50.00, 370.00, 5),

('entregado', NOW(), 240.00, 50.00, 290.00, 6),

('cancelado', NOW(), 120.00, 50.00, 170.00, 7),

('enviado', NOW(), 270.00, 50.00, 320.00, 8),

('confirmado', NOW(), 100.00, 50.00, 150.00, 9),

('pendiente', NOW(), 95.00, 50.00, 145.00, 10);


-- =========================================
-- DETALLE DE PEDIDOS
-- =========================================

INSERT INTO detalle_pedido
(cantidad, precio_unitario, pedido_id, producto_id)
VALUES
(2, 45.00, 1, 'PROD002'),
(1, 250.00, 1, 'PROD001'),

(1, 250.00, 2, 'PROD001'),

(1, 180.00, 3, 'PROD003'),

(2, 75.00, 4, 'PROD007'),

(1, 320.00, 5, 'PROD006'),

(2, 120.00, 6, 'PROD008'),

(1, 120.00, 7, 'PROD008'),

(3, 90.00, 8, 'PROD002'),

(2, 50.00, 9, 'PROD009'),

(1, 95.00, 10, 'PROD010');


-- =========================================
-- ENTREGAS
-- =========================================

INSERT INTO entrega
(direccion_id, fecha_programada, rango_horario, tipo_entrega, fecha_hora_entregado, pedido_id)
VALUES
(1, '2026-09-17', '10:00-12:00', 'domicilio', NOW(), 1),

(2, '2026-09-18', '12:00-14:00', 'domicilio', NULL, 2),

(3, '2026-09-18', '14:00-16:00', 'domicilio', NULL, 3),

(4, '2026-09-19', '10:00-12:00', 'domicilio', NULL, 4),

(5, '2026-09-19', '12:00-14:00', 'domicilio', NULL, 5),

(6, '2026-09-17', '16:00-18:00', 'domicilio', NOW(), 6),

(7, '2026-09-20', '10:00-12:00', 'domicilio', NULL, 7),

(8, '2026-09-20', '12:00-14:00', 'domicilio', NULL, 8),

(9, '2026-09-21', '14:00-16:00', 'domicilio', NULL, 9),

(10, '2026-09-21', '16:00-18:00', 'domicilio', NULL, 10);


-- =========================================
-- PAGOS
-- =========================================

INSERT INTO pago
(metodo_pago, estado_pago, monto, fecha_pago, referencia_transaccion, pedido_id)
VALUES
('tarjeta', 'aprobado', 390.00, NOW(), 'TRANS001', 1),

('transferencia', 'aprobado', 300.00, NOW(), 'TRANS002', 2),

('tarjeta', 'aprobado', 230.00, NOW(), 'TRANS003', 3),

('efectivo', 'pendiente', 200.00, NULL, NULL, 4),

('tarjeta', 'pendiente', 370.00, NULL, NULL, 5),

('transferencia', 'aprobado', 290.00, NOW(), 'TRANS006', 6),

('tarjeta', 'reembolsado', 170.00, NOW(), 'TRANS007', 7),

('tarjeta', 'aprobado', 320.00, NOW(), 'TRANS008', 8),

('efectivo', 'pendiente', 150.00, NULL, NULL, 9),

('transferencia', 'pendiente', 145.00, NULL, NULL, 10);