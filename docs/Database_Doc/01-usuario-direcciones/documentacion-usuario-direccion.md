DB-01 — Clientes y Direcciones
1. Representación de las tablas
1.1 Tabla usuarios

Esta tabla almacenará la información necesaria para identificar y gestionar a los clientes registrados.

| Campo        | Tipo de dato | PK | FK | NULL | Restricciones             | Descripción                         |
| ------------ | ------------ | -- | -- | ---- | ------------------------- | ----------------------------------- |
| `id`         | INT          | ✓  | —  | No   | AUTO_INCREMENT            | Identificador único del usuario     |
| `nombre`     | VARCHAR(100) | —  | —  | No   | —                         | Nombre del usuario                  |
| `correo`     | VARCHAR(150) | —  | —  | No   | UNIQUE                    | Correo electrónico                  |
| `telefono`   | VARCHAR(20)  | —  | —  | No   | —                         | Teléfono de contacto                |
| `password`   | VARCHAR(255) | —  | —  | No   | —                         | Contraseña almacenada mediante hash |
| `activo`     | BOOLEAN      | —  | —  | No   | DEFAULT TRUE              | Indica si la cuenta está activa     |
| `created_at` | DATETIME     | —  | —  | No   | DEFAULT CURRENT_TIMESTAMP | Fecha de creación                   |
| `updated_at` | DATETIME     | —  | —  | Sí   | —                         | Fecha de última actualización       |

1.2 Tabla direcciones

Esta tabla almacenará las diferentes direcciones de entrega que puede registrar un usuario.

| Campo            | Tipo de dato | PK | FK | NULL | Restricciones  | Descripción                              |
| ---------------- | ------------ | -- | -- | ---- | -------------- | ---------------------------------------- |
| `id`             | INT          | ✓  | —  | No   | AUTO_INCREMENT | Identificador de la dirección            |
| `usuario_id`     | INT          | —  | ✓  | No   | —              | Usuario al que pertenece                 |
| `nombre`         | VARCHAR(50)  | —  | —  | No   | —              | Nombre asignado a la dirección           |
| `calle`          | VARCHAR(150) | —  | —  | No   | —              | Calle                                    |
| `numero`         | VARCHAR(20)  | —  | —  | No   | —              | Número exterior/interior                 |
| `colonia`        | VARCHAR(100) | —  | —  | No   | —              | Colonia                                  |
| `municipio`      | VARCHAR(100) | —  | —  | No   | —              | Municipio                                |
| `estado`         | VARCHAR(100) | —  | —  | No   | —              | Estado                                   |
| `codigo_postal`  | VARCHAR(10)  | —  | —  | No   | —              | Código postal                            |
| `referencias`    | VARCHAR(255) | —  | —  | Sí   | —              | Referencias para la entrega              |
| `predeterminada` | BOOLEAN      | —  | —  | No   | DEFAULT FALSE  | Indica si es la dirección predeterminada |



Relación propuesta
usuarios
   1
   │
   │
   │ N
   ▼
direcciones

Un usuario puede tener múltiples direcciones y cada dirección pertenece a un único usuario. Esto coincide con la regla de negocio de que el cliente puede registrar varias direcciones y seleccionar una para realizar su compra


4. Decisiones tomadas

Esta sección sería la que yo pondría al final del documento.

4.1 Usuario como entidad principal

Se decidió utilizar una tabla usuarios para almacenar la información del cliente registrado.

No se creará inicialmente una tabla independiente llamada clientes, ya que las reglas actuales no establecen la necesidad de separar ambos conceptos.

4.2 Un usuario puede tener múltiples direcciones

Se decidió que las direcciones se manejarán en una tabla independiente llamada direcciones.

La relación será:

usuarios 1 ───── N direcciones

Esto permite que un mismo usuario tenga, por ejemplo:

Casa
Trabajo
Otra dirección

La regla de negocio establece explícitamente que el cliente puede tener múltiples direcciones y seleccionar la que utilizará antes del pedido.

4.3 Las direcciones tendrán un nombre

Se decidió incluir el campo:

nombre

para permitir identificar fácilmente cada dirección.

Ejemplo:

Casa
Trabajo
Casa de mis padres
4.4 Cada dirección pertenece a un usuario

Se decidió utilizar:

usuario_id

como llave foránea en direcciones.

Esto permite establecer la relación entre el cliente y sus direcciones.

4.5 El correo será único

Se decidió establecer correo como UNIQUE para evitar que existan múltiples cuentas utilizando el mismo correo electrónico.

4.6 Se manejará un estado del usuario

Se decidió utilizar:

activo BOOLEAN

en lugar de depender exclusivamente de eliminar registros.

Esto permite desactivar una cuenta sin necesariamente eliminar su información.

4.7 Se almacenará la contraseña mediante hash

Se decidió que el campo password almacenará posteriormente un hash de contraseña, no la contraseña original.

La implementación del algoritmo de hash queda fuera del diseño de la base de datos y será responsabilidad del backend.

4.8 Se incluirá una dirección predeterminada

Se decidió incluir:

predeterminada BOOLEAN

para identificar la dirección que el usuario utiliza normalmente.

Esto corresponde con la regla de negocio que contempla una dirección inicial predeterminada y la posibilidad de seleccionar otra antes de realizar una compra.

4.9 Se incluirán fechas de creación y modificación

La tabla usuarios tendrá:

created_at
updated_at

para permitir conocer cuándo se creó y cuándo fue modificada la información.

5. Decisiones pendientes

Aunque la tarea pide las decisiones tomadas, yo agregaría también esta sección porque algunas cosas todavía no están completamente definidas por las reglas de negocio.

5.1 ¿Nombre completo o nombre y apellidos?

Actualmente:

nombre

Pero queda pendiente determinar si posteriormente se utilizarán:

nombre
apellido_paterno
apellido_materno
5.2 Componentes exactos de una dirección

Se debe confirmar si serán suficientes:

calle
numero
colonia
municipio
estado
codigo_postal
referencias

o si se necesitarán datos adicionales.

5.3 Una o varias direcciones predeterminadas

Se debe definir cómo se garantizará que un usuario no tenga accidentalmente dos direcciones marcadas como predeterminadas.

5.4 ¿Qué ocurre al eliminar una dirección?

Queda pendiente definir si una dirección:

se elimina físicamente,
se desactiva,
o no puede eliminarse después de haber sido utilizada en un pedido.
5.5 Relación entre dirección y pedido

Esta es probablemente la decisión más importante que deben dejar pendiente con DB-03.

El pedido debe contener la información de la dirección de entrega.

Hay que decidir si:

PEDIDO
   │
   └── direccion_id
             ↓
       DIRECCIONES

o si el pedido debe conservar una copia de los datos de la dirección utilizada en ese momento.

No recomiendo que DB-01 decida esto por su cuenta; es una decisión que deben revisar con el equipo que está diseñando pedidos.