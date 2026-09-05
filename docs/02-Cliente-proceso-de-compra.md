# Definición de cliente y proceso de compra

> **Objetivo del documento:** definir cómo interactúa una persona con la plataforma desde que consulta productos hasta que realiza una compra, sin entrar en implementación técnica (base de datos, clases, Spring Boot, endpoints).

---

## 1. Objetivo

Definir un proceso fácil y ágil para que el usuario ingrese al carrito y pueda completar su proceso de compra de forma eficiente y clara.

---

## 2. Tipos de usuario

### Visitante (sin registro)
Puede:
- Navegar y acceder a cualquier ventana de la plataforma.
- Ver el catálogo de productos.
- Agregar productos al carrito.
- Llenar el formulario de contacto.
- Al intentar hacer checkout, es redirigido a iniciar sesión / registrarse.

No puede:
- Finalizar una compra (pagar) sin haberse registrado o iniciado sesión.

### Cliente (registrado)
Puede, además de todo lo anterior:
- Iniciar sesión en su cuenta.
- Completar el proceso de compra (checkout y pago).
- Registrar y administrar varias direcciones de entrega.
- Recibir cupones exclusivos en su correo electrónico.

---

## 3. Registro de cliente

### Definición
Es obligatorio registrarse / iniciar sesión antes de completar una compra. El visitante puede explorar libremente el catálogo, pero el flujo de checkout lo desvía al registro o login.

### Información necesaria del cliente
- Nombre
- Correo electrónico
- Teléfono (contacto directo con el cliente)
- Domicilio (dirección de entrega)
- Método de pago
- Pedido (productos seleccionados)

---

## 4. Direcciones de entrega

- El servicio es exclusivo para **entrega a domicilio**; no existe modalidad de recolección en tienda (pick-up).
- El cliente puede registrar varias direcciones de entrega, con un **límite de 3 direcciones** personalizadas.
- Cada dirección puede guardarse con un **nombre personalizado** (ej. "Casa", "Oficina").
- La **primera dirección registrada** se establece como predeterminada.
- Antes de generar el pedido, el sistema debe pedir al cliente **confirmar** cuál dirección usará para ese envío.

---

## 5. Carrito

### Funcionalidades definidas
- Agregar productos al carrito.
- Modificar la cantidad o el peso de un producto directamente desde el carrito.
- Eliminar productos del carrito de uno en uno o vaciarlo por completo.
- Límite de **10 unidades** por producto vendido por pieza (sujeto también a stock disponible).
- El carrito permanece **oculto** mientras el usuario navega por la página.
- Notificación al usuario cuando un producto en su carrito **cambia de precio**, actualizando el monto de forma continua.

### Información que debe mostrar el carrito antes de continuar la compra
- Cantidad total de productos y cantidad por producto específico.
- Precio total de la compra.
- Precio individual por producto.
- Dirección de envío.
- Método de pago preseleccionado.
- Botón de confirmación de compra.

### Productos sin disponibilidad
Si un producto en el carrito deja de estar disponible antes de completar la compra:
- Se muestra una etiqueta indicando su estado: **"No disponible"** o **"Sin stock disponible"**.
- El producto se visualiza deshabilitado, con un efecto opaco.
- Únicamente permanece habilitado el botón para **eliminarlo del carrito**.

---

## 6. Cantidad y peso

### Definición
Los productos se agregan al carrito de dos formas:
- **Por pieza** (unidades).
- **Por peso**, en paquetes de **1 kilogramo**.

### Reglas de pedido
- Pedido mínimo: **1 kg** en total del carrito.
- Pedido máximo como cliente común: **10 kg** en total. Si se supera este límite, el pedido no puede realizarse y el sistema redirige automáticamente a la página de contacto, para solicitar cotización como mayorista.
- El cliente puede modificar cantidad o peso desde el carrito.
- **No se aceptan decimales** en el peso de los productos vendidos por peso.

---

## 7. Información antes de confirmar el pedido

El cliente debe proporcionar/confirmar, antes de cerrar el pedido:
- Dirección de envío.
- Productos a comprar (contenido final del carrito).
- Método de pago (preseleccionado o predefinido).
- Confirmación de su sesión de usuario (login).

---

## 8. Método de pago

### Métodos definidos (fase inicial)
- Efectivo / tarjeta contra entrega — límite propuesto de **$2,000 MXN** (monto a confirmar formalmente). El propio cliente define, al confirmar la compra, si pagará en efectivo o si requerirá terminal.
- Tarjeta de crédito / débito.
- PayPal.

---

## 9. Confirmación de compra

### Definición
Una compra se considera **confirmada** (se convierte en pedido) cuando se cumplen las tres condiciones siguientes:
1. Hay productos en el carrito.
2. Existe una dirección de envío confirmada y seleccionada.
3. Existe un método de pago seleccionado.

Al confirmarse, se genera un **comprobante digital tipo ticket**, descargable en PDF, que sirve como respaldo de pago y como base para una futura facturación digital.

---

## 10. Después de comprar

El cliente puede:
- Consultar el detalle de su pedido (productos, dirección, total, método de pago, fechas).
- Consultar el estado del pedido (en preparación, enviado, entregado, etc.).
- Ver su historial de compras pasadas.
- Cancelar un pedido en cualquier momento, siempre que sea con un mínimo de **1 hora de anticipación** a la hora de entrega programada.

---

## 11. Decisiones tomadas

- No se permite comprar como visitante; el registro/login es obligatorio para completar el checkout.
- El visitante sí puede usar el formulario de contacto sin registrarse.
- El registro requiere nombre, correo, teléfono, domicilio, método de pago y pedido.
- El servicio es solo a domicilio (no hay pick-up); máximo 3 direcciones guardadas por cliente, con una predeterminada.
- El carrito permanece oculto durante la navegación, permite eliminar productos de uno en uno o por completo, y notifica cambios de precio en tiempo real.
- Límite de 10 unidades por producto vendido por pieza.
- Los productos se agregan por pieza o por paquetes de 1 kg; pedido mínimo de 1 kg y máximo de 10 kg por cliente común (por encima de eso se redirige a cotización de mayorista); no se aceptan decimales en el peso.
- Un producto sin disponibilidad se marca como "No disponible"/"Sin stock disponible", se deshabilita visualmente y solo permite eliminarse.
- Métodos de pago iniciales: efectivo/tarjeta contra entrega (límite propuesto $2,000 MXN), tarjeta de crédito/débito y PayPal.
- Una compra se confirma cuando hay productos en el carrito, dirección seleccionada y método de pago seleccionado; al confirmarse se genera un comprobante PDF descargable.
- Después de la compra, el cliente puede consultar detalle, estado, historial y cancelar pedidos hasta 1 hora antes de la entrega.

---

## 12. Decisiones pendientes para reunión

1. Criterio para clasificar qué productos se venden por pieza y cuáles por peso (catálogo o categoría de producto).
2. Monto límite exacto y definitivo para el pago contra entrega en efectivo, y reglas de cambio/uso de terminal.
3. Proceso de verificación/validación de tarjeta como regla de negocio (¿se requiere código de verificación?).
4. Horario y tiempos de entrega.
5. Lógica de programación del pedido: ¿la entrega es siempre inmediata o el cliente puede programar fecha/hora?
