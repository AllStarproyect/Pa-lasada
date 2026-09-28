# Documentación del Modelo de Base de Datos — Tienda

## 1. Introducción

Este documento describe el modelo relacional diseñado para el catálogo de productos de la tienda. Incluye el propósito de cada tabla, la justificación de sus atributos, y el tipo de relación (cardinalidad) que existe entre ellas, de acuerdo con las reglas de negocio definidas y las consideraciones adicionales solicitadas (categoría principal/secundaria, tags múltiples con condiciones comerciales, control de inventario e historial de auditoría).

---

## 2. Resumen de relaciones (cardinalidad)

| Tabla origen | Relación | Tabla destino | Cardinalidad | Descripción |
|---|---|---|---|---|
| `producto` | FK `categoria_principal_id` | `categoria` | **N:1** | Muchos productos pueden tener la misma categoría principal; cada producto tiene exactamente una. |
| `producto` | FK `precio_id` | `precio` | **1:1** | Cada producto tiene un único registro de precio, y ese registro pertenece a un solo producto. |
| `producto` | FK `inventario_id` | `inventario` | **1:1** | Cada producto tiene un único registro de inventario. |
| `producto` | FK `imagen_id` | `imagen` | **1:1** | Cada producto tiene una única imagen principal. |
| `producto` | FK `info_adicional_id` | `informacion_adicional` | **1:1** | Cada producto tiene un único registro de información adicional. |
| `producto` ↔ `categoria` | vía `productocategoria` | — | **N:M** | Un producto puede tener varias categorías secundarias; una categoría puede estar asignada como secundaria en varios productos. |
| `producto` ↔ `tag` | vía `producto_tag` | — | **N:M** | Un producto puede tener varios tags activos; un tag puede estar asignado a varios productos. |
| `producto_tag` | FK compuesta | `condicion_comercial` | **1:N** | Una asignación producto-tag puede tener condiciones comerciales (normalmente una, pero el diseño permite histórico de vigencias). |
| `producto` | FK `producto_id` | `historial_precio` | **1:N** | Un producto puede tener muchos registros históricos de cambio de precio. |
| `producto` | FK `producto_id` | `historial_inventario` | **1:N** | Un producto puede tener muchos registros históricos de movimiento de inventario. |

---

## 3. Detalle de cada tabla

### 3.1 `categoria`

**Propósito:** catálogo maestro de categorías de productos (ej. Res, Rib Eye, Tomahawk). Es la base tanto para la categoría principal como para las secundarias.

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `categoria_id` | INT | PK | Identificador único, usado como referencia desde `producto` (principal) y `productocategoria` (secundarias). |
| `nombre` | VARCHAR(80) NOT NULL | AK (candidata a única) | No debe repetirse el nombre de una categoría; se protege con `UNIQUE`. |

---

### 3.2 `producto`

**Propósito:** entidad central del catálogo. Representa cada tipo de corte/presentación comercial.

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `id` | VARCHAR(80) | PK | Identificador único del producto; usado por casi todas las demás tablas para referenciarlo. |
| `sku` | VARCHAR(80) NOT NULL | AK | Código de negocio único del producto (usado en sistemas externos, inventario físico, etc.). Se protege con `UNIQUE`. |
| `nombre` | VARCHAR(180) NOT NULL | Atributo | Nombre comercial visible al cliente. |
| `tieneVariantes` | TINYINT(1) | Atributo | Bandera booleana; indica si el producto maneja variantes (útil para lógica de UI, no relaciona datos). |
| `descripcion` | TEXT | Atributo | Texto libre para describir el producto. |
| `precio_id` | VARCHAR(80) | FK → `precio` | Relaciona el producto con su información de precio (1:1). |
| `inventario_id` | VARCHAR(80) | FK → `inventario` | Relaciona el producto con su stock (1:1). |
| `imagen_id` | VARCHAR(80) | FK → `imagen` | Relaciona el producto con su imagen principal (1:1). |
| `info_adicional_id` | VARCHAR(80) | FK → `informacion_adicional` | Relaciona el producto con datos complementarios como peso, origen, marmoleado (1:1). |
| `categoria_principal_id` | INT NOT NULL | FK → `categoria` | **Obligatoria** porque la regla de negocio exige que todo producto tenga una categoría principal. Se modela como columna directa (no como fila en una tabla intermedia) porque la relación es de cardinalidad fija 1 (nunca 0, nunca varias). |

**¿Por qué separar precio, inventario, imagen e información adicional en tablas propias en vez de columnas directas en `producto`?**
Cada una representa un concepto de negocio independiente que puede evolucionar por separado (ej. el precio cambia con frecuencia y necesita historial; el inventario se actualiza con cada venta; la imagen puede tener múltiples variantes en el futuro). Mantenerlas separadas evita que `producto` se sature de columnas y permite que cada tabla crezca sin afectar a las demás.

---

### 3.3 `productocategoria`

**Propósito:** relación N:M para las **categorías secundarias** de un producto (la principal ya vive en `producto.categoria_principal_id`, por lo que esta tabla no la repite).

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `producto_id` | VARCHAR(80) | PK compuesta, FK → `producto.id` | Junto con `categoria_id` forma la llave primaria; identifica de forma única cada asignación producto-categoría secundaria. |
| `categoria_id` | INT | PK compuesta, FK → `categoria.categoria_id` | Igual que el anterior. |

**¿Por qué una tabla intermedia y no una columna extra?**
Porque un producto puede tener **cero, una o varias** categorías secundarias, y una categoría puede ser secundaria en varios productos distintos. Una relación N:M solo puede modelarse con una tabla intermedia.

---

### 3.4 `precio`

**Propósito:** guarda la información comercial del precio de un producto, separada para permitir historial y evitar sobrecargar `producto`.

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `precio_id` | VARCHAR(80) | PK | Identifica de forma única el registro de precio. |
| `monto` | DECIMAL(10,2) NOT NULL | Atributo | Se usa `DECIMAL` (no `FLOAT`) porque el dinero requiere precisión exacta sin errores de redondeo. |
| `moneda` | CHAR(3) | Atributo | Código de moneda (ISO 4217, ej. "MXN"). |
| `texto` | VARCHAR(40) | Atributo | Representación textual lista para mostrar en frontend sin formatear. |
| `nota` | TEXT | Atributo | Comentario libre (ej. "precio de lanzamiento"). |

---

### 3.5 `inventario`

**Propósito:** controla la disponibilidad y cantidad de piezas de cada producto.

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `inventario_id` | VARCHAR(80) | PK | Identifica de forma única el registro de inventario. |
| `estado` | VARCHAR(20) | Atributo | Estado comercial (`disponible`, `agotado`, `no disponible`, `descontinuado`), usado para decidir si el producto se muestra o se puede comprar. |
| `cantidad` | INT NOT NULL DEFAULT 0 | Atributo | Número de piezas disponibles. |
| **`CHECK (cantidad >= 0)`** | Restricción | — | Evita que la cantidad quede en negativo a nivel de base de datos. Es una **última barrera de seguridad**, no la solución completa: la prevención principal de sobreventa debe hacerse en la aplicación mediante una actualización atómica dentro de una transacción (ej. `UPDATE inventario SET cantidad = cantidad - X WHERE cantidad >= X`), para manejar correctamente compras simultáneas. |

---

### 3.6 `imagen`

**Propósito:** guarda la referencia (no el archivo binario) a la imagen principal del producto.

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `imagen_id` | VARCHAR(80) | PK | Identifica de forma única cada imagen. |
| `url` | TEXT | Atributo | Dirección pública donde se sirve la imagen. |
| `remota` | TEXT | Atributo | URL de origen si la imagen proviene de un proveedor externo. |
| `local` | TEXT | Atributo | Ruta local/servidor propio si la imagen fue descargada o cacheada. |

No se guarda el archivo binario en la base de datos porque eso infla el tamaño de la BD y degrada el rendimiento; el estándar es almacenar el archivo en un servicio de almacenamiento (S3, CDN, disco) y solo referenciar la URL.

---

### 3.7 `informacion_adicional`

**Propósito:** datos complementarios del producto que no son indispensables para la decisión rápida de compra (por eso viven separados de `producto` y no se muestran en la card, solo en el detalle).

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `info_id` | VARCHAR(80) | PK | Identifica de forma única el registro. |
| `peso` | VARCHAR(30) | Atributo | Peso de referencia por pieza. |
| `lugar_origen` | VARCHAR(80) | Atributo | Origen del producto. |
| `nivel_marmoleado` | VARCHAR(80) | Atributo | Dato específico del negocio (cortes de carne). |
| `maridaje` | VARCHAR(180) | Atributo | Sugerencia de maridaje, puramente informativa. |

---

### 3.8 `tag`

**Propósito:** catálogo maestro de los tags posibles (`PREMIUM`, `NUEVO`, `DESCUENTO`, etc.), con su metadata de comportamiento.

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `tag_id` | INT AUTO_INCREMENT | PK | Identificador único del tag. |
| `nombre` | VARCHAR(20) NOT NULL | AK | Nombre del tag; debe ser único, se protege con `UNIQUE`. |
| `tipo_asignacion` | ENUM('manual','automatica') NOT NULL | Atributo | Define si el tag se asigna manualmente (ej. `PREMIUM`) o automáticamente por el sistema (ej. `NUEVO`, `MAS_VENDIDO`), según la regla de negocio original. |
| `es_promocional` | TINYINT(1) NOT NULL DEFAULT 0 | Atributo | Indica si el tag representa una condición comercial (descuento, campaña) y por lo tanto puede tener un registro asociado en `condicion_comercial`. |

**¿Por qué un catálogo y no un `ENUM` directo en `producto`?**
Porque ahora un producto puede tener **varios tags simultáneos**, lo cual requiere una relación N:M (ver `producto_tag`), y porque cada tag tiene metadata propia (tipo de asignación, si es promocional) que sería difícil de mantener con un simple `ENUM`.

---

### 3.9 `producto_tag`

**Propósito:** relación N:M que permite que un producto tenga múltiples tags activos al mismo tiempo, cumpliendo la regla de negocio actualizada.

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `producto_id` | VARCHAR(80) | PK compuesta, FK → `producto.id` | Identifica el producto al que se asigna el tag. |
| `tag_id` | INT | PK compuesta, FK → `tag.tag_id` | Identifica el tag asignado. Junto con `producto_id` forma la llave primaria, garantizando que un mismo tag no se asigne dos veces al mismo producto. |
| `fecha_asignacion` | DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP | Atributo | Necesaria para calcular la expiración de tags automáticos como `NUEVO` (10 días desde la asignación). |
| `fecha_expiracion` | DATETIME NULL | Atributo | Permite programar cuándo debe quitarse el tag automáticamente (ej. `NUEVO` a los 10 días), sin necesidad de recalcularlo en cada consulta. |

---

### 3.10 `condicion_comercial`

**Propósito:** guarda los datos de negocio específicos de un tag promocional aplicado a un producto (precio promocional, vigencia).

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `condicion_id` | INT AUTO_INCREMENT | PK | Identifica de forma única cada condición comercial registrada. |
| `producto_id`, `tag_id` | VARCHAR(80), INT | FK compuesta → `producto_tag` | Vincula la condición comercial a una asignación específica de tag sobre un producto. |
| `precio_promocional` | DECIMAL(10,2) NULL | Atributo | Precio especial durante la promoción (ej. para `DESCUENTO`, `HOT_SALE`). |
| `fecha_inicio`, `fecha_fin` | DATE NULL | Atributo | Vigencia de la promoción o temporada (ej. para `POR_TEMPORADA`). |

**¿Por qué una tabla separada y no columnas en `producto_tag`?**
Porque solo los tags marcados como `es_promocional = 1` necesitan estos datos. Si se agregaran directamente a `producto_tag`, la mayoría de las filas (tags no promocionales como `PREMIUM` o `NACIONAL`) tendrían esas columnas en `NULL` de forma permanente. Separarlas evita columnas desperdiciadas y dis-normaliza el modelo solo donde realmente aplica.

---

### 3.11 `historial_precio`

**Propósito:** registra cada cambio de precio de un producto, cumpliendo el requisito de auditoría del negocio.

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `historial_id` | INT AUTO_INCREMENT | PK | Identificador único de cada evento de cambio. |
| `producto_id` | VARCHAR(80) | FK → `producto.id` | Indica a qué producto pertenece el cambio (relación 1:N: un producto puede tener muchos registros de historial). |
| `precio_anterior` | DECIMAL(10,2) NULL | Atributo | Valor previo al cambio (NULL si es el primer precio registrado). |
| `precio_nuevo` | DECIMAL(10,2) NOT NULL | Atributo | Valor después del cambio. |
| `fecha_cambio` | DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP | Atributo | Marca temporal del cambio, indispensable para trazabilidad. |

**¿Por qué se necesita esta tabla?**
La regla de negocio exige explícitamente que los cambios de precio queden registrados. Sobrescribir el valor en `precio` destruiría esa trazabilidad. Una tabla relacional (en vez de un log genérico en texto/JSON) permite hacer consultas SQL directas sobre el historial (ej. "cuántas veces cambió el precio este mes").

---

### 3.12 `historial_inventario`

**Propósito:** registra cada movimiento de inventario (venta, reposición, ajuste, cancelación), también por requisito de auditoría.

| Campo | Tipo | Rol | Justificación |
|---|---|---|---|
| `historial_id` | INT AUTO_INCREMENT | PK | Identificador único de cada evento de movimiento. |
| `producto_id` | VARCHAR(80) | FK → `producto.id` | Producto al que pertenece el movimiento (relación 1:N). |
| `cantidad_anterior` | INT NOT NULL | Atributo | Cantidad antes del movimiento. |
| `cantidad_nueva` | INT NOT NULL | Atributo | Cantidad después del movimiento. |
| `tipo_movimiento` | ENUM('venta','ajuste_manual','reposicion','cancelacion') NOT NULL | Atributo | Clasifica el motivo del cambio; se modela distinto del historial de precio porque un movimiento de inventario sí tiene una causa categorizable, mientras que un cambio de precio no. |
| `fecha_movimiento` | DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP | Atributo | Marca temporal del movimiento. |

**¿Por qué dos tablas de historial separadas (precio e inventario) en vez de una sola genérica?**
Porque representan eventos de negocio distintos con atributos distintos: un cambio de inventario tiene un `tipo_movimiento` categorizable (venta, reposición, etc.) que no aplica a un cambio de precio. Combinarlas en una sola tabla obligaría a usar columnas genéricas (`campo_afectado`, `valor_anterior`, `valor_nuevo` como texto), perdiendo tipado fuerte y forzando conversiones en cada consulta. Separarlas mantiene el modelo simple, tipado y fácil de consultar.

---

## 4. Resumen de decisiones de diseño

1. **Categoría principal como columna obligatoria** en `producto` (no en tabla intermedia) porque su cardinalidad es fija (siempre exactamente una).
2. **Categorías secundarias en tabla N:M** (`productocategoria`) porque su cardinalidad es variable (cero, una o varias).
3. **Tags migrados de columna única a relación N:M** (`tag` + `producto_tag`) porque la regla de negocio cambió de "una sola tag" a "varias tags simultáneas".
4. **Condiciones comerciales separadas** de la asignación de tags para no forzar columnas `NULL` en tags no promocionales.
5. **Control de inventario en dos capas**: `CHECK` a nivel de base de datos como última defensa, más lógica transaccional en la aplicación como control principal contra sobreventa.
6. **Historial de precio e inventario como tablas relacionales dedicadas**, justificado por el requisito explícito de auditoría del negocio, evitando tanto la pérdida de trazabilidad (sobrescribir valores) como una solución genérica no tipada (log en texto/JSON).
