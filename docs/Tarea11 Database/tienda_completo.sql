-- =====================================================================
-- Script de creación de base de datos - Tienda (completo)
-- Incluye:
--   1. Catálogo: categoría, precio, inventario, imagen, producto,
--      tags con condiciones comerciales, historial de precio e
--      inventario.
--   2. Usuarios y direcciones.
--   3. Carrito de compras, pedidos, pagos y entregas.
-- Orden de creación respetado por las dependencias de llaves foráneas.
-- =====================================================================
create database palasada;
USE palasada;

SET FOREIGN_KEY_CHECKS = 0;

-- #######################################################################
-- # PARTE 1: CATÁLOGO (categoria, producto, tags, historiales)
-- #######################################################################

-- ---------------------------------------------------------------------
-- Tabla: categoria
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `categoria`;
CREATE TABLE `categoria` (
  `categoria_id` INT NOT NULL,
  `nombre`       VARCHAR(80) NOT NULL,
  PRIMARY KEY (`categoria_id`),
  UNIQUE KEY `uk_categoria_nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: precio
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `precio`;
CREATE TABLE `precio` (
  `precio_id` VARCHAR(80) NOT NULL,
  `monto`     DECIMAL(10,2) NOT NULL,
  `moneda`    CHAR(3) NULL,
  `texto`     VARCHAR(40) NULL,
  `nota`      TEXT NULL,
  PRIMARY KEY (`precio_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: inventario
-- CHECK (cantidad >= 0): última barrera para evitar cantidades negativas.
-- La prevención principal de sobreventa debe hacerse en la aplicación
-- con actualizaciones atómicas dentro de una transacción.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `inventario`;
CREATE TABLE `inventario` (
  `inventario_id` VARCHAR(80) NOT NULL,
  `estado`        VARCHAR(20) NULL,
  `cantidad`      INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`inventario_id`),
  CONSTRAINT `chk_inventario_cantidad` CHECK (`cantidad` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: imagen
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `imagen`;
CREATE TABLE `imagen` (
  `imagen_id` VARCHAR(80) NOT NULL,
  `url`       TEXT NULL,
  `remota`    TEXT NULL,
  `local`     TEXT NULL,
  PRIMARY KEY (`imagen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: informacion_adicional
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `informacion_adicional`;
CREATE TABLE `informacion_adicional` (
  `info_id`           VARCHAR(80) NOT NULL,
  `peso`              VARCHAR(30) NULL,
  `lugar_origen`      VARCHAR(80) NULL,
  `nivel_marmoleado`  VARCHAR(80) NULL,
  `maridaje`          VARCHAR(180) NULL,
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: producto
-- `categoria_principal_id` es obligatoria (NOT NULL): todo producto
-- debe tener una categoría principal.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `id`                    VARCHAR(80) NOT NULL,
  `sku`                   VARCHAR(80) NOT NULL,
  `nombre`                VARCHAR(180) NOT NULL,
  `tieneVariantes`        TINYINT(1) NULL,
  `descripcion`           TEXT NULL,
  `precio_id`             VARCHAR(80) NULL,
  `inventario_id`         VARCHAR(80) NULL,
  `imagen_id`             VARCHAR(80) NULL,
  `info_adicional_id`     VARCHAR(80) NULL,
  `categoria_principal_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_producto_sku` (`sku`),
  CONSTRAINT `fk_producto_precio`
    FOREIGN KEY (`precio_id`) REFERENCES `precio` (`precio_id`)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_producto_inventario`
    FOREIGN KEY (`inventario_id`) REFERENCES `inventario` (`inventario_id`)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_producto_imagen`
    FOREIGN KEY (`imagen_id`) REFERENCES `imagen` (`imagen_id`)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_producto_info_adicional`
    FOREIGN KEY (`info_adicional_id`) REFERENCES `informacion_adicional` (`info_id`)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_producto_categoria_principal`
    FOREIGN KEY (`categoria_principal_id`) REFERENCES `categoria` (`categoria_id`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: productocategoria
-- Representa SOLO categorías adicionales/secundarias (N:M).
-- La categoría principal vive en producto.categoria_principal_id.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `productocategoria`;
CREATE TABLE `productocategoria` (
  `producto_id`  VARCHAR(80) NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`producto_id`, `categoria_id`),
  CONSTRAINT `fk_prodcat_producto`
    FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `fk_prodcat_categoria`
    FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`categoria_id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: tag (catálogo)
-- `es_promocional` marca si el tag lleva condición comercial asociada
-- (DESCUENTO, HOT_SALE, POR_TEMPORADA).
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `tag_id`          INT NOT NULL AUTO_INCREMENT,
  `nombre`          VARCHAR(20) NOT NULL,
  `tipo_asignacion` ENUM('manual','automatica') NOT NULL,
  `es_promocional`  TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `uk_tag_nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `tag` (`nombre`, `tipo_asignacion`, `es_promocional`) VALUES
  ('PREMIUM',        'manual',      0),
  ('NUEVO',          'automatica',  0),
  ('DESCUENTO',      'manual',      1),
  ('NACIONAL',       'manual',      0),
  ('INTERNACIONAL',  'manual',      0),
  ('MAS_VENDIDO',    'automatica',  0),
  ('HOT_SALE',       'manual',      1),
  ('POR_TEMPORADA',  'manual',      1);

-- ---------------------------------------------------------------------
-- Tabla: producto_tag (N:M)
-- Un producto puede tener varios tags activos simultáneamente.
-- `fecha_expiracion` permite calcular vencimiento automático (ej. NUEVO).
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `producto_tag`;
CREATE TABLE `producto_tag` (
  `producto_id`      VARCHAR(80) NOT NULL,
  `tag_id`           INT NOT NULL,
  `fecha_asignacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_expiracion` DATETIME NULL,
  PRIMARY KEY (`producto_id`, `tag_id`),
  CONSTRAINT `fk_prodtag_producto`
    FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `fk_prodtag_tag`
    FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: condicion_comercial
-- Guarda los datos de negocio de un tag promocional aplicado a un
-- producto (precio promocional, vigencia). Solo aplica cuando el tag
-- tiene es_promocional = 1; se separa de producto_tag para no dejar
-- columnas NULL en tags no promocionales.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `condicion_comercial`;
CREATE TABLE `condicion_comercial` (
  `condicion_id`       INT NOT NULL AUTO_INCREMENT,
  `producto_id`        VARCHAR(80) NOT NULL,
  `tag_id`             INT NOT NULL,
  `precio_promocional` DECIMAL(10,2) NULL,
  `fecha_inicio`       DATE NULL,
  `fecha_fin`          DATE NULL,
  PRIMARY KEY (`condicion_id`),
  CONSTRAINT `fk_condcom_producto_tag`
    FOREIGN KEY (`producto_id`, `tag_id`) REFERENCES `producto_tag` (`producto_id`, `tag_id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: historial_precio
-- Registra cada cambio de precio de un producto (auditoría).
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `historial_precio`;
CREATE TABLE `historial_precio` (
  `historial_id`    INT NOT NULL AUTO_INCREMENT,
  `producto_id`     VARCHAR(80) NOT NULL,
  `precio_anterior` DECIMAL(10,2) NULL,
  `precio_nuevo`    DECIMAL(10,2) NOT NULL,
  `fecha_cambio`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`historial_id`),
  CONSTRAINT `fk_histprecio_producto`
    FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: historial_inventario
-- Registra cada movimiento de inventario (venta, reposición, ajuste).
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `historial_inventario`;
CREATE TABLE `historial_inventario` (
  `historial_id`       INT NOT NULL AUTO_INCREMENT,
  `producto_id`        VARCHAR(80) NOT NULL,
  `cantidad_anterior`  INT NOT NULL,
  `cantidad_nueva`     INT NOT NULL,
  `tipo_movimiento`    ENUM('venta','ajuste_manual','reposicion','cancelacion') NOT NULL,
  `fecha_movimiento`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`historial_id`),
  CONSTRAINT `fk_histinv_producto`
    FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- #######################################################################
-- # PARTE 2: USUARIOS Y DIRECCIONES
-- #######################################################################


-- ---------------------------------------------------------------------
-- Tabla: usuarios
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id`          INT NOT NULL AUTO_INCREMENT,
  `nombre`      VARCHAR(100) NOT NULL,
  `correo`      VARCHAR(150) NOT NULL,
  `telefono`    VARCHAR(20) NOT NULL,
  `password`    VARCHAR(255) NOT NULL,
  `activo`      BOOLEAN NOT NULL DEFAULT TRUE,
  `created_at`  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`  DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_usuarios_correo` (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: direcciones
-- `predeterminada` indica la dirección por defecto del usuario para
-- envíos. El control de que solo haya UNA predeterminada por usuario
-- debe hacerse en la aplicación (o con un trigger), ya que MySQL no
-- soporta un índice único condicional de forma nativa.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `direcciones`;
CREATE TABLE `direcciones` (
  `id`              INT NOT NULL AUTO_INCREMENT,
  `usuario_id`      INT NOT NULL,
  `nombre`          VARCHAR(50) NOT NULL,
  `calle`           VARCHAR(150) NOT NULL,
  `numero`          VARCHAR(20) NOT NULL,
  `colonia`         VARCHAR(100) NOT NULL,
  `municipio`       VARCHAR(100) NOT NULL,
  `estado`          VARCHAR(100) NOT NULL,
  `codigo_postal`   VARCHAR(10) NOT NULL,
  `referencias`     VARCHAR(255) NULL,
  `predeterminada`  BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_direcciones_usuario`
    FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- #######################################################################
-- # PARTE 3: CARRITO, PEDIDOS, PAGOS Y ENTREGAS
-- #######################################################################


-- ---------------------------------------------------------------------
-- Tabla: carrito
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `carrito`;
CREATE TABLE `carrito` (
  `id`          INT NOT NULL AUTO_INCREMENT,
  `usuario_id`  INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_carrito_usuario`
    FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: carrito_producto
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `carrito_producto`;
CREATE TABLE `carrito_producto` (
  `id`          INT NOT NULL AUTO_INCREMENT,
  `cantidad`    INT NOT NULL DEFAULT 1,
  `carrito_id`  INT NOT NULL,
  `producto_id` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `chk_carritoprod_cantidad` CHECK (`cantidad` > 0),
  CONSTRAINT `fk_carritoprod_carrito`
    FOREIGN KEY (`carrito_id`) REFERENCES `carrito` (`id`)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `fk_carritoprod_producto`
    FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: pedido
-- Creada antes que detalle_pedido / entrega / pago porque dependen
-- de ella.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `pedido`;
CREATE TABLE `pedido` (
  `id`              INT NOT NULL AUTO_INCREMENT,
  `estado`          ENUM('pendiente','confirmado','en_proceso','enviado','entregado','cancelado')
                    NOT NULL DEFAULT 'pendiente',
  `fecha_creacion`  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `subtotal`        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `envio`           DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `total`           DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `usuario_id`      INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pedido_usuario`
    FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: detalle_pedido
-- Guarda una "fotografía" del precio del producto al momento de la
-- compra (precio_unitario), independiente del precio actual en
-- la tabla `precio`.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `detalle_pedido`;
CREATE TABLE `detalle_pedido` (
  `id`              INT NOT NULL AUTO_INCREMENT,
  `cantidad`        INT NOT NULL DEFAULT 1,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  `pedido_id`       INT NOT NULL,
  `producto_id`     VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `chk_detpedido_cantidad` CHECK (`cantidad` > 0),
  CONSTRAINT `fk_detpedido_pedido`
    FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `fk_detpedido_producto`
    FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: entrega
-- `direccion_id` toma la dirección desde la tabla `direcciones`
-- (módulo de usuarios) en vez de guardarla como texto libre.
-- ON DELETE RESTRICT: evita borrar una dirección que ya está
-- referenciada por una entrega; el usuario debería usar otra
-- dirección o cancelar/reasignar la entrega primero.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `entrega`;
CREATE TABLE `entrega` (
  `id`                    INT NOT NULL AUTO_INCREMENT,
  `direccion_id`          INT NOT NULL,
  `fecha_programada`      DATE NULL,
  `rango_horario`         VARCHAR(40) NULL,
  `tipo_entrega`          ENUM('domicilio','recoleccion') NOT NULL DEFAULT 'domicilio',
  `fecha_hora_entregado`  DATETIME NULL,
  `pedido_id`             INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_entrega_pedido` (`pedido_id`),
  CONSTRAINT `fk_entrega_pedido`
    FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `fk_entrega_direccion`
    FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabla: pago
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `pago`;
CREATE TABLE `pago` (
  `id`                       INT NOT NULL AUTO_INCREMENT,
  `metodo_pago`              VARCHAR(40) NULL,
  `estado_pago`              ENUM('pendiente','aprobado','rechazado','reembolsado')
                             NOT NULL DEFAULT 'pendiente',
  `monto`                    DECIMAL(10,2) NOT NULL,
  `fecha_pago`               DATETIME NULL,
  `referencia_transaccion`   VARCHAR(120) NULL,
  `pedido_id`                INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pago_pedido`
    FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


SET FOREIGN_KEY_CHECKS = 1;
