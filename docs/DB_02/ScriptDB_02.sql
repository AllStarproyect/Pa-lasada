-- =====================================================================
-- Script de creación de base de datos - Tienda
-- Incluye: categoría principal/secundaria, tags múltiples con
-- condiciones comerciales, control de inventario, e historial de
-- cambios de precio e inventario.
-- =====================================================================

USE tienda;

SET FOREIGN_KEY_CHECKS = 0;

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

SET FOREIGN_KEY_CHECKS = 1;