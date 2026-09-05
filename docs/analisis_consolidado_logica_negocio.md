# Análisis consolidado de lógica de negocio

## Documentos considerados

- **E1** = Entregable 1 — cliente y proceso de compra.
- **E2** = Definición de cliente y proceso de compra.
- **E3** = Reglas comerciales y operación.
- **E4** = Definición de Producto y Catálogo.
- **E5** = Definición de pedidos, entrega y Pick & Collect.

> **Objetivo:** comparar los documentos para identificar reglas coincidentes, diferencias, conflictos y decisiones que todavía requieren definición del equipo.

---

## 1. Comparativo general de reglas de negocio

| Tema | Lo establecido | Coincidencia / conflicto | Estado |
|---|---|---|---|
| **Compra como visitante** | El visitante puede navegar y agregar productos, pero debe registrarse/iniciar sesión para completar checkout. | Coinciden E1 y E2. | **Decisión consolidada** |
| **Usuario registrado** | Puede completar la compra y administrar direcciones; recibe beneficios como cupones. | Coinciden E1 y E2. | **Decisión consolidada** |
| **Datos del cliente** | Nombre, domicilio, pago y pedido. E2 agrega correo y teléfono. E5 también requiere teléfono, correo y dirección. | No es un conflicto directo; E2/E5 amplían la información de E1. | **Falta consolidar campos obligatorios** |
| **Varias direcciones** | El cliente puede tener varias direcciones, con nombre personalizado y una predeterminada. E2 fija máximo de 3. | Coinciden en el concepto; el límite de 3 aparece solamente en E2. | **Decisión parcialmente consolidada** |
| **Dirección antes del pedido** | Debe confirmarse la dirección de envío antes de generar el pedido. | Coinciden E1, E2 y E5. | **Decisión consolidada** |
| **Pick & Collect** | E1 contempla conceptualmente “dirección o punto a recoger”. E2 y E5 establecen que **no habrá Pick & Collect** inicialmente. E5 dice que todos los pedidos serán a domicilio. | **Conflicto directo:** E1 contempla pick-up; E2/E5 lo eliminan. | **Debe corregirse E1** |
| **Zona de entrega** | E1 habla de envío; E5 establece cobertura dentro de CDMX y códigos postales habilitados. | Compatible; E5 agrega precisión. | **Decisión consolidada** |
| **Fecha de entrega** | E2 inicialmente la deja como pendiente. E5 establece que el cliente seleccionará fecha y rango horario disponible. | E5 resuelve una decisión que E2 todavía marcaba pendiente. | **Decisión tomada en E5** |
| **Hora exacta de entrega** | E5 indica que no se seleccionará una hora exacta, sino un rango. | No existe contradicción posterior. | **Decisión consolidada** |
| **Carrito** | Permite agregar, modificar y eliminar productos. | Coinciden E1 y E2; E3/E4 complementan reglas de inventario/producto. | **Decisión consolidada** |
| **Carrito oculto durante navegación** | E2 lo establece explícitamente. | No aparece en los demás documentos. | **Decisión aislada** |
| **Cambios de precio en carrito** | E2 establece que deben notificarse y actualizarse continuamente. E3 determina que el precio es definido por negocio y que los cambios deben registrarse. | Son compatibles. | **Decisión consolidada parcialmente** |
| **Producto no disponible en carrito** | Se muestra deshabilitado/opaco y solamente se permite eliminarlo. | Coinciden E1 y E2. | **Decisión consolidada** |
| **Producto agotado** | E3/E4 determinan que permanece visible en catálogo pero no puede comprarse. E5 también impide comprar sin existencias. | Coincidencia clara. | **Decisión consolidada** |
| **Producto descontinuado** | E4 establece que deja de aparecer en catálogo; agotado/no disponible sí permanecen visibles. | No contradice los demás. | **Decisión consolidada** |
| **Inventario insuficiente** | No se puede vender más de lo disponible. E5 añade validación final antes del pago. | Coincidencia. | **Decisión consolidada** |
| **Momento del descuento de inventario** | E3: se descuenta cuando se confirma el pago. E5: después de confirmarse el pago se aparta/descuenta. | Coinciden. | **Decisión consolidada** |
| **Forma de venta** | E1/E2: productos por pieza y por peso; E4: los cortes se venden **por pieza con peso establecido** y el cliente **no puede solicitar gramaje personalizado**. | **Conflicto importante.** | **Decisión pendiente crítica** |
| **Peso solicitado** | E1 permite modificar peso. E2 habla de paquetes de 1 kg y no permite decimales. E4 elimina el peso personalizado y solo permite cantidad de piezas. | **Contradicción fuerte entre equipos.** | **Debe resolverse** |
| **Precio por kilogramo** | E3 permite precio por kilogramo o unidad. E4 especifica precio por kg pero calculado sobre el peso establecido de la pieza. | Compatibles bajo el modelo de E4. | **Debe depender de resolución del modelo de venta** |
| **Presentaciones** | E3 dice que presentaciones con inventario/precio independiente pueden tratarse como productos distintos. E4 actualmente trabaja una presentación por producto. | Bastante alineados. | **Decisión consolidada, con posible revisión futura** |
| **Cantidad máxima por producto** | E2 establece **10 unidades por producto**. E5 establece **ningún límite fijo inicial**; depende del inventario. | **Conflicto directo.** | **Debe resolverse** |
| **Límite total de kg** | E2 establece máximo de **10 kg** por cliente y pedido mínimo de 1 kg. E5 establece que inicialmente no habrá máximo fijo y que el límite será el inventario. | **Conflicto directo.** | **Debe resolverse** |
| **Promociones** | E3 establece descuentos, Hot Sale, temporada, vigencia y sincronización con tags. | No hay contradicción con los otros documentos. | **Decisión consolidada** |
| **Tags** | E3 permite varios tags simultáneos; E4 establece máximo **una tag activa**. | **Conflicto directo y relevante.** | **Debe resolverse** |
| **NUEVO** | E4: dura primeros 10 días y después desaparece. | No hay conflicto con E3 porque E3 no especifica límite de cantidad de tags. | **Decisión de E4** |
| **MÁS VENDIDO** | E4: reemplaza automáticamente la tag anterior. | Compatible con la regla de una sola tag de E4, pero entra en conflicto con el enfoque de múltiples tags de E3. | **Depende de regla de tags** |
| **Promociones acumulables** | E3 determina que no se acumulan automáticamente y que debe definirse si pueden combinarse. | No hay conflicto. | **Decisión consolidada** |
| **Métodos de pago** | E1: efectivo/tarjeta contra entrega, crédito/débito y **transferencia**. E2: efectivo/tarjeta contra entrega, crédito/débito y **PayPal**. E3 deja los métodos pendientes. E5 habla de confirmar el pago pero no define métodos. | **Conflicto directo: Transferencia vs. PayPal**, además del límite de contraentrega. | **Debe resolverse** |
| **Contraentrega** | E1/E2 proponen límite de $2,000 MXN, pero queda pendiente confirmar. | Coinciden en que no está definitivamente cerrado. | **Pendiente** |
| **Confirmación de compra** | E1/E2: compra confirmada si hay productos + dirección + método de pago. E5: el pedido se genera cuando el **pago ha sido confirmado**. | **Conflicto conceptual importante.** | **Debe definirse el flujo exacto** |
| **Preparación** | E5: empieza después del pago confirmado. | Compatible con E3. | **Decisión consolidada** |
| **Estados del pedido** | E5 define Confirmado → Preparación → Listo → En ruta → Entregado; además Cancelado y Entrega no realizada. | E2 lo deja como tema general; E5 lo concreta. | **Decisión tomada en E5** |
| **Cancelación** | E2: hasta **1 hora antes de la entrega**. E5: únicamente mientras **no haya comenzado la preparación**. | **Conflicto directo.** | **Debe resolverse** |
| **Pedido fallido / entrega no realizada** | E5 define contacto, segundo intento y posible cancelación. | No existe contradicción relevante. | **Decisión parcialmente tomada** |
| **Sustitución de producto faltante** | E5 establece que nunca se sustituye automáticamente; requiere autorización del cliente. | Sin conflicto. | **Decisión consolidada** |
| **Costo de envío** | E5 propone $69 MXN, pero explícitamente lo deja para aprobación. | No hay otra definición previa. | **Pendiente** |
| **Horario de entrega** | E5 propone 10:00–20:00 y ventanas de entrega, pero aún deben aprobarse. | E2 lo tenía pendiente. | **Propuesta, no decisión definitiva** |
| **Mínimo de compra** | E2 establece 1 kg mínimo. E5 pregunta si existirá monto mínimo de compra, por lo que parece referirse a un mínimo monetario, no necesariamente al kg. | No necesariamente conflicto, pero hay que distinguir ambos conceptos. | **Requiere precisión** |

---

## 2. Coincidencias fuertes entre los documentos

### Cliente y acceso

Existe consenso en que el visitante puede explorar el sitio, consultar productos y utilizar funcionalidades básicas, pero **debe iniciar sesión o registrarse para completar una compra**.

### Dirección y entrega

La dirección es un dato indispensable para el pedido y debe ser confirmada antes de finalizarlo. Además, E5 consolida que la primera versión será exclusivamente de **entrega a domicilio**, dentro de zonas habilitadas de Ciudad de México.

### Inventario

Hay una regla muy consistente:

> No se puede vender más producto del que realmente existe.

Además, el inventario se valida antes del pago y se descuenta/aparta cuando el pago queda confirmado.

### Productos agotados

También hay consenso en que un producto agotado **no desaparece del catálogo**, pero tampoco puede comprarse. E4 distingue correctamente entre disponible, agotado, no disponible y descontinuado.

### Preparación y entrega

El flujo definido por E5 es bastante concreto:

**Confirmado → En preparación → Listo para entrega → En ruta → Entregado**.

También existen las rutas alternativas de cancelación y entrega no realizada.

### Entrega programada

Está bastante definido que el cliente **selecciona una fecha y un rango horario**, no una hora exacta.

---

## 3. Conflictos que sí requieren decisión del equipo

### 1. ¿El producto se vende por peso o por pieza?

Este es probablemente el conflicto más importante.

**E1/E2** plantean:

- piezas + productos vendidos por peso;
- modificación de peso.

Pero **E4** establece un modelo diferente:

- el producto se vende por piezas;
- cada pieza tiene un peso de referencia;
- el cliente no puede pedir un gramaje personalizado.

Ejemplo:

**Modelo A**

> Quiero 1.5 kg de Rib Eye.

**Modelo B**

> Quiero 3 piezas de Rib Eye, aproximadamente 450 g cada una.

Los dos modelos requieren una lógica comercial y técnica diferente.

**Esta debería ser una prioridad absoluta de definición.**

---

### 2. ¿Existe límite de 10 kg / 10 unidades?

E2 establece:

- máximo 10 unidades por producto;
- máximo 10 kg por cliente común;
- mínimo 1 kg.

Pero E5 establece expresamente:

> inicialmente no habrá límite fijo de kilogramos o piezas por cliente; el límite será el inventario disponible.

Esto no puede coexistir tal como está redactado.

---

### 3. ¿Una compra está confirmada al seleccionar pago o cuando el pago realmente se aprueba?

E1/E2 definen la confirmación mediante:

1. productos;
2. dirección;
3. método de pago.

Pero E5 define que:

> el pedido se genera cuando **el pago ha sido confirmado**.

Esto puede parecer pequeño, pero tiene consecuencias enormes para:

- inventario;
- estados del pedido;
- cancelaciones;
- comprobante;
- preparación;
- pagos rechazados.

Aquí conviene distinguir entre **“checkout confirmado”** y **“pedido generado”**, si esa es la intención del equipo.

---

### 4. ¿Cuándo puede cancelar el cliente?

Hay dos reglas incompatibles:

**Regla A — E2**

> Puede cancelar hasta una hora antes de la entrega.

**Regla B — E5**

> Solo puede cancelar mientras no haya comenzado la preparación.

Por ejemplo, si el pedido se preparó a las 10:00 y la entrega es a las 18:00:

- E2 permitiría cancelarlo hasta las 17:00.
- E5 ya no permitiría cancelarlo desde las 10:00.

Debe existir una sola regla.

---

### 5. ¿Se permiten varias tags o solamente una?

E3 establece que un producto puede tener varios tags activos simultáneamente.

E4 establece explícitamente:

> máximo una tag activa por producto.

Además, E4 establece reglas de sustitución automática para `MÁS VENDIDO`, lo cual depende directamente de aceptar el modelo de una sola tag.

Este también es un conflicto estructural.

---

### 6. ¿Transferencia o PayPal?

Tenemos:

| Documento | Métodos |
|---|---|
| E1 | Contra entrega + crédito/débito + **transferencia** |
| E2 | Contra entrega + crédito/débito + **PayPal** |
| E3 | Pendiente |
| E5 | No define catálogo de métodos |

Por lo tanto, actualmente **ninguno de esos dos terceros métodos puede considerarse definitivamente decidido**.

---

### 7. ¿Existe Pick & Collect?

E1 todavía menciona:

> “Dirección a donde se enviará o punto a recoger”.

Pero E2 y E5 establecen que **no existe Pick & Collect en la primera versión**. E5 incluso señala que todos los pedidos se gestionarán mediante entrega a domicilio.

Aquí no parece necesario abrir una discusión: simplemente habría que **corregir E1 para eliminar la opción de pick-up**.

---

## 4. Decisiones que ya pueden considerarse consolidadas

Después de cruzar los documentos, pueden considerarse **decisiones prácticamente consolidadas** las siguientes:

1. **No se permite completar una compra como visitante.**
2. El visitante puede explorar el catálogo antes de registrarse.
3. El cliente puede administrar direcciones de entrega.
4. Debe seleccionarse/confirmarse una dirección antes de completar el pedido.
5. La primera versión utilizará **entrega a domicilio**.
6. **Pick & Collect no estará disponible inicialmente.**
7. La cobertura inicial será dentro de zonas habilitadas de Ciudad de México.
8. La cobertura debe validarse antes de completar la compra.
9. El inventario no puede venderse por encima de la existencia disponible.
10. Antes del pago debe realizarse una validación final de inventario.
11. El inventario se descuenta/aparta después de la confirmación del pago.
12. Un producto agotado permanece visible pero no puede comprarse.
13. Un producto temporalmente no disponible puede permanecer visible sin poder comprarse.
14. Un producto descontinuado deja de mostrarse en el catálogo.
15. La entrega utiliza **fecha + rango horario**, no hora exacta.
16. El pedido cuenta con estados definidos para preparación, despacho y entrega.
17. Un producto faltante no puede sustituirse automáticamente sin autorización del cliente.
18. Las promociones no deben acumularse automáticamente.
19. Los cambios importantes de precio, inventario y promociones deben registrarse.
20. El producto debe distinguirse comercialmente de la pieza física individual.

---

## 5. Decisiones que siguen pendientes

### Prioridad alta — afectan directamente el desarrollo

1. **¿Los productos se venden por pieza, por kg, o existen ambas modalidades?**
2. **¿El cliente puede seleccionar gramaje personalizado?**
3. **¿El peso de una pieza es fijo/aproximado o se utiliza el peso real?**
4. **¿Existe límite de 10 kg por cliente?**
5. **¿Existe límite de 10 piezas por producto?**
6. **¿Puede un pedido superar esos límites si existe suficiente inventario?**
7. **¿Cuándo exactamente se considera creado/confirmado un pedido?**
8. **¿Cuándo exactamente se considera confirmado un pago?**
9. **¿La cancelación se permite una hora antes de la entrega o solamente antes del inicio de preparación?**
10. **¿Un producto puede tener múltiples tags o solo una?**
11. **¿El método de pago será transferencia o PayPal, o ambos?**
12. **¿Cuál será el límite definitivo del pago contra entrega?**

### Prioridad media

13. ¿Cuál es el máximo de direcciones guardadas? E2 propone 3.
14. ¿Cuál es el costo definitivo de envío?
15. ¿Cuál será el horario de reparto?
16. ¿Cuáles serán exactamente las zonas/códigos postales cubiertos?
17. ¿Cuál será el horario límite para pedidos del mismo día?
18. ¿Habrá monto mínimo de compra?
19. ¿Habrá envío gratuito a partir de cierto monto?
20. ¿Cuántos intentos de contacto se harán al cliente?
21. ¿Cuánto tiempo esperará el repartidor?
22. ¿Cómo se acreditará que el pedido fue recibido?

---

## 6. Lista final para llevar a reunión

| # | Decisión | Prioridad |
|---|---|---|
| 1 | Modelo de venta: pieza vs kg vs ambos | 🔴 Crítica |
| 2 | ¿Se permite peso personalizado? | 🔴 Crítica |
| 3 | ¿Peso establecido o peso real? | 🔴 Crítica |
| 4 | Límite de 10 kg | 🔴 Crítica |
| 5 | Límite de 10 piezas por producto | 🔴 Crítica |
| 6 | Momento exacto en que nace el pedido | 🔴 Crítica |
| 7 | Momento exacto en que se confirma el pago | 🔴 Crítica |
| 8 | Política de cancelación | 🔴 Crítica |
| 9 | Una tag vs múltiples tags | 🔴 Crítica |
| 10 | Métodos de pago definitivos | 🔴 Crítica |
| 11 | Límite de contraentrega | 🟠 Alta |
| 12 | Número máximo de direcciones | 🟠 Alta |
| 13 | Horarios de entrega | 🟠 Alta |
| 14 | Zonas/códigos postales | 🟠 Alta |
| 15 | Costo de envío | 🟠 Alta |
| 16 | Monto mínimo de compra | 🟡 Media |
| 17 | Política de entrega fallida | 🟡 Media |
| 18 | Evidencia de recepción | 🟡 Media |

---

## 7. Conclusión

El proyecto **sí tiene una base común bastante sólida**. No parece que los equipos hayan diseñado negocios completamente distintos; la mayor parte del flujo coincide.

Los conflictos importantes están concentrados en **cinco áreas principales**:

1. **Modelo de venta/peso.**
2. **Límites de compra.**
3. **Confirmación del pedido y del pago.**
4. **Política de cancelaciones.**
5. **Reglas de tags.**

A esto se suma la definición final de **métodos de pago** y la necesidad de eliminar de E1 la referencia a Pick & Collect, ya que E2/E5 establecen que la primera versión será únicamente a domicilio.

Por ello, **no se recomienda tomar simplemente la sección “Decisiones tomadas” de cada documento y unirlas**. Primero deben resolverse las contradicciones y después generar una **versión maestra de reglas de negocio**.
