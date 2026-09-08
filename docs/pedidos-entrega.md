# Definición de pedidos, entrega y Pick & Collect
Autores: Diana Cruz & Brenda Flores

<!--
OBJETIVO
Definir qué ocurre con un pedido después de la compra y
cómo llega al cliente.

Para la primera versión de Pa' la Asada:
1. Se contará con entrega a domicilio.
2. Pick & Collect no estará disponible inicialmente.

NO definir todavía implementación técnica.
-->

---

## 1. Objetivo

Definir el ciclo de vida de los pedidos de Pa' la Asada desde que se confirma una compra hasta que el pedido es entregado o finaliza por alguna incidencia.

También se establecen las reglas generales para la preparación, despacho y entrega de los productos, considerando que en la primera versión del e-commerce únicamente estará disponible la **entrega a domicilio dentro de las zonas de cobertura establecidas en Ciudad de México**.

El objetivo es que el cliente conozca qué ocurre con su pedido después de realizar la compra y que el negocio tenga reglas claras para prepararlo, conservarlo y entregarlo correctamente.

---

## 2. Definición de pedido

<!--
¿Qué entendemos por pedido?
¿Qué información necesitamos conocer para poder gestionarlo?
-->

### Definición

Un pedido es el registro de una compra realizada por un cliente en Pa' la Asada.

El pedido se genera cuando el **pago ha sido confirmado** y contiene toda la información necesaria para identificar al cliente, conocer los productos y cantidades adquiridas, preparar la compra y realizar la entrega en el domicilio seleccionado.

Si el pago no se confirma, la compra no pasa al proceso de preparación.

### Información principal

- **Número de pedido:** identificador único de la compra.
- **Cliente:** nombre de la persona que realizó el pedido.
- **Información de contacto:** teléfono, correo electrónico y medio de contacto disponible.
- **Productos:** productos incluidos en la compra.
- **Cantidades:** número de piezas, paquetes o kilogramos solicitados.
- **Precio de los productos:** precio correspondiente a cada producto.
- **Subtotal:** importe de los productos antes del costo de envío.
- **Costo de envío:** importe correspondiente al servicio de entrega.
- **Total:** importe final pagado por el cliente.
- **Método de pago:** forma mediante la cual se realizó el pago.
- **Estado del pago:** confirmación de que el pago fue aprobado.
- **Modalidad de entrega:** entrega a domicilio.
- **Dirección:** domicilio completo en el que se realizará la entrega.
- **Código postal:** utilizado para validar la zona de cobertura.
- **Fecha de entrega:** día seleccionado o asignado para recibir el pedido.
- **Rango de horario:** periodo aproximado en el que se realizará la entrega.
- **Fecha del pedido:** fecha y hora en la que se confirmó la compra.
- **Estado del pedido:** etapa actual dentro de su ciclo de vida.
- **Indicaciones de entrega:** referencias o instrucciones proporcionadas por el cliente cuando sean necesarias.

---

## 3. Ciclo de vida del pedido

<!--
Definir las etapas por las que pasa un pedido.
-->

### Estados definidos

Flujo normal:

1. Confirmado
2. En preparación
3. Listo para entrega
4. En ruta
5. Entregado

Estados alternos:

6. Entrega no realizada
7. Cancelado

### Significado de cada estado

| Estado | ¿Qué significa? | ¿Qué debe ocurrir para avanzar? |
| --- | --- | --- |
| **Confirmado** | El pago fue aprobado y el pedido quedó registrado. | El negocio valida la información del pedido y comienza su preparación. |
| **En preparación** | El negocio está pesando, cortando, preparando y empacando los productos solicitados. | Todos los productos deben estar preparados, verificados y correctamente empacados. |
| **Listo para entrega** | El pedido terminó de prepararse y está disponible para ser despachado. | Debe asignarse a un repartidor y salir del punto de operación. |
| **En ruta** | El pedido fue recogido por el repartidor y se dirige al domicilio del cliente. | El repartidor debe llegar al domicilio y completar correctamente la entrega. |
| **Entregado** | El cliente o una persona autorizada recibió el pedido. | Estado final del flujo normal. |
| **Entrega no realizada** | El repartidor llegó al domicilio, pero no fue posible completar la entrega. | Se debe determinar si procede un nuevo intento de entrega o la finalización del pedido según la causa de la incidencia. |
| **Cancelado** | El pedido fue cancelado antes de iniciar su preparación o por una incidencia que impide continuar con la compra. | Estado final alternativo. Cuando corresponda, deberá gestionarse el reembolso aplicable. |

### Flujo principal

**Confirmado → En preparación → Listo para entrega → En ruta → Entregado**

### Flujos alternos

- **Confirmado → Cancelado**
- **En ruta → Entrega no realizada**
- **Entrega no realizada → En ruta**, si se autoriza y es posible realizar un nuevo intento el mismo día.
- **Entrega no realizada → Cancelado**, si definitivamente no puede completarse la entrega.

---

## 4. Entrega a domicilio

<!--
Definir cómo funciona el servicio a domicilio.
Considerar:

- Zona de cobertura.
- Costo de envío.
- Horarios.
- Fecha de entrega.
- Disponibilidad.
-->

### Definición

La entrega a domicilio será la única modalidad disponible durante la primera versión de Pa' la Asada.

El cliente deberá proporcionar una dirección dentro de la zona de cobertura habilitada en **Ciudad de México**.

Antes de completar la compra, deberá verificarse que la dirección pueda recibir el pedido y mostrarse al cliente el costo de envío, la fecha y los rangos de entrega disponibles.

La disponibilidad de la entrega dependerá del inventario, la capacidad de preparación y la disponibilidad de reparto.

### Reglas

- Inicialmente solo se realizarán entregas dentro de Ciudad de México.
- Estar dentro de Ciudad de México no garantiza automáticamente el servicio; la dirección deberá encontrarse dentro de los códigos postales o zonas habilitadas por el negocio.
- La cobertura deberá validarse antes de finalizar la compra.
- El cliente deberá proporcionar una dirección completa y referencias cuando sean necesarias.
- El costo de envío deberá mostrarse antes de confirmar la compra.
- El pedido deberá estar pagado y confirmado antes de comenzar su preparación.
- La entrega estará sujeta a la disponibilidad de inventario y reparto.
- El cliente deberá elegir una fecha y un rango de horario disponible.
- Una vez que el repartidor recoja el pedido, el estado cambiará a **En ruta**.
- Cuando el pedido sea recibido correctamente, cambiará a **Entregado**.
- Los productos deberán mantenerse bajo las condiciones de conservación correspondientes durante su preparación, almacenamiento y traslado.
- Los pedidos no deberán dejarse afuera del domicilio ni en un lugar sin supervisión cuando no haya una persona disponible para recibirlos.

---

## 5. Horarios de entrega

<!--
Definir si el cliente puede elegir día y/o horario.
-->

### Definición

El cliente podrá seleccionar una **fecha y un rango de horario** para recibir su pedido, siempre que exista disponibilidad de preparación y reparto.

No se ofrecerá inicialmente la selección de una hora exacta, ya que los tiempos de entrega pueden variar por tráfico, distancia, preparación de otros pedidos y capacidad de reparto.

### Reglas

- El cliente deberá seleccionar una fecha disponible para la entrega.
- El cliente podrá elegir entre los rangos de horario disponibles para ese día.
- No se mostrarán rangos que hayan alcanzado la capacidad máxima de reparto.
- La fecha y el rango seleccionados deberán quedar asociados al pedido.
- Si un rango ya no está disponible, deberán mostrarse otras opciones.
- Los pedidos solicitados después del horario límite para entrega el mismo día pasarán al siguiente día disponible.
- La entrega dentro de un rango representa una ventana estimada y no una hora exacta.

---

## 6. Pick & Collect

<!--
Definir cómo funciona la recolección en tienda.
Considerar:

- Selección de día.
- Selección de horario.
- Lugar de recolección.
- Tiempo máximo para recoger.
-->

### Definición

En la primera versión de Pa' la Asada no estará disponible la modalidad **Pick & Collect**, debido a que el negocio no contará con una tienda física o punto de recolección para los clientes.

Todos los pedidos realizados mediante el e-commerce serán gestionados mediante **entrega a domicilio**.

La implementación de Pick & Collect podrá evaluarse en versiones futuras si el negocio llega a contar con una sucursal o punto de recolección adecuado.

### Información que selecciona el cliente

No aplica para la primera versión del e-commerce.

### Reglas

- Pick & Collect no estará disponible inicialmente.
- El cliente no podrá seleccionar una sucursal o punto de recolección.
- Todos los pedidos serán gestionados mediante entrega a domicilio.
- No existirán reglas de tiempo máximo de recolección porque no habrá recolección física.
- Esta modalidad podrá incorporarse posteriormente si el negocio cuenta con la infraestructura necesaria.

---

## 7. Preparación y despacho

<!--
Definir qué ocurre internamente entre la confirmación
del pedido y su entrega.
No diseñar todavía el panel administrativo.
Solo describir el proceso del negocio.
-->

### Proceso

1. Antes de finalizar la compra, se valida que exista suficiente inventario para cubrir las cantidades solicitadas.
2. El pedido se genera cuando el pago queda confirmado.
3. Al confirmarse el pago, los productos correspondientes se apartan o descuentan del inventario disponible.
4. El negocio revisa la información del pedido.
5. Se pesan, cortan, preparan y empacan los productos según corresponda.
6. Antes del despacho se verifica que los productos y cantidades coincidan con la compra.
7. Los productos se mantienen bajo las condiciones de conservación requeridas.
8. Cuando el pedido está completamente preparado, cambia a **Listo para entrega**.
9. El pedido se asigna a un repartidor.
10. Cuando el repartidor recoge el pedido, cambia a **En ruta**.
11. Se notifica al cliente que su pedido ha sido despachado.
12. El repartidor realiza la entrega en el domicilio y rango de horario correspondientes.
13. Cuando el cliente recibe correctamente la compra, el pedido cambia a **Entregado**.

### Reglas de disponibilidad

- Los productos sin existencias no podrán comprarse.
- El catálogo solamente permitirá comprar productos disponibles.
- La cantidad solicitada nunca podrá superar las existencias actuales del producto.
- Inicialmente no existirá un límite fijo de kilogramos o piezas por cliente.
- La cantidad máxima dependerá del inventario disponible.

Por ejemplo, si existen **10 kg de carne molida**, el cliente podrá comprar hasta 10 kg. Si intenta solicitar 12 kg, deberá informársele que solamente existen 10 kg disponibles.

- Antes de confirmar el pago se realizará una última validación de inventario.
- Al confirmarse el pago, las existencias correspondientes al pedido dejarán de estar disponibles para otros clientes.
- Cuando las existencias de un producto lleguen a cero, el producto no podrá agregarse al carrito.
- Si el inventario cambia antes de completar el pago, el cliente deberá ajustar su compra.

### Tiempo de preparación

Se buscará preparar y entregar los pedidos **el mismo día**, siempre que:

- El pago haya sido confirmado.
- Exista inventario suficiente.
- El pedido haya sido realizado antes del horario límite establecido.
- Exista capacidad de preparación.
- Exista disponibilidad de reparto.

Los pedidos que no cumplan estas condiciones se programarán para el siguiente día disponible.

---

## 8. Cancelaciones y problemas

<!--
Definir qué ocurre si:

- El cliente cancela.
- No se puede entregar.
- El cliente no recoge.
- Falta producto.
- Existe algún problema con el pedido.
-->

### Reglas

#### Cancelación por parte del cliente

- El cliente podrá solicitar la cancelación únicamente mientras la preparación no haya comenzado.
- Una vez iniciado el proceso de preparación, no se permitirá la cancelación por decisión del cliente.
- Esta regla se establece porque los productos pueden haber sido pesados, cortados o empacados específicamente para el pedido.
- Cuando una cancelación proceda, se gestionará el reembolso correspondiente de acuerdo con el método de pago utilizado.

#### Falta o cambio de inventario

- Los productos sin existencias no estarán disponibles para compra.
- El cliente no podrá solicitar una cantidad superior al inventario disponible.
- Antes del pago se comprobará nuevamente la disponibilidad.
- Si las existencias cambian antes de completar el pago, el cliente deberá modificar la cantidad solicitada.
- Si excepcionalmente se detecta una diferencia de inventario después de haberse confirmado el pago, el negocio deberá contactar al cliente.
- Se podrá ofrecer un producto sustituto únicamente con autorización del cliente.
- Si el cliente no acepta la sustitución, se realizará el reembolso correspondiente al producto faltante.
- Ningún producto será sustituido automáticamente sin autorización.

#### Entrega no realizada

- Los pedidos no deberán dejarse afuera del domicilio o en un lugar sin supervisión.
- Cuando no sea posible completar la entrega, el repartidor intentará contactar al cliente.
- Si no se obtiene respuesta después de los intentos establecidos, el pedido cambiará a **Entrega no realizada**.
- El pedido deberá regresar al punto de operación manteniendo las condiciones de conservación necesarias.
- Si la entrega falló por una dirección incorrecta, ausencia del cliente u otra causa atribuible al cliente, un nuevo intento podrá generar nuevamente el costo de envío.
- Si existe capacidad operativa y el producto continúa siendo apto, podrá realizarse un segundo intento durante el mismo día.
- No se propone reutilizar el mismo pedido para una entrega al día siguiente.
- Si el problema fue responsabilidad del negocio o del servicio de reparto, la entrega deberá reprogramarse sin costo adicional.
- Si no puede garantizarse la conservación adecuada de los productos, estos no deberán volver a enviarse.

#### Pedido incorrecto, incompleto o producto en malas condiciones

- El cliente deberá informar al negocio si recibe productos incorrectos, faltantes o en condiciones inadecuadas.
- El negocio deberá revisar la incidencia.
- Dependiendo del caso, podrá realizarse una reposición o un reembolso.
- Si el problema es responsabilidad del negocio, el cliente no deberá cubrir un nuevo costo de envío.

#### Pick & Collect

No aplica en la primera versión, debido a que no existirá recolección en tienda.

---

## 9. Responsabilidades

<!--
Definir de manera general quién realiza cada acción.
No definir todavía roles técnicos.
-->

### Cliente

- Seleccionar los productos y cantidades que desea comprar.
- Revisar la información de su compra antes de pagar.
- Realizar el pago correspondiente.
- Proporcionar información de contacto correcta y actualizada.
- Proporcionar una dirección completa dentro de la zona de cobertura.
- Proporcionar referencias de entrega cuando sean necesarias.
- Seleccionar la fecha y el rango de horario disponible.
- Mantenerse disponible mediante los medios de contacto registrados.
- Estar disponible para recibir el pedido.
- Informar oportunamente cualquier problema relacionado con la compra.
- Cubrir nuevamente el costo de envío cuando un nuevo intento sea necesario por una causa atribuible al cliente, si esta política es aprobada definitivamente.

### Negocio

- Mantener actualizado el inventario disponible.
- Evitar la venta de cantidades superiores a las existencias.
- Confirmar el pago antes de iniciar la preparación.
- Apartar o descontar del inventario los productos pagados.
- Preparar correctamente los productos solicitados.
- Verificar que productos y cantidades correspondan con el pedido.
- Empacar correctamente los productos.
- Mantener las condiciones adecuadas de conservación durante preparación, almacenamiento y traslado.
- Informar al cliente sobre cambios relevantes en el estado del pedido.
- Gestionar el despacho y la entrega.
- Intentar contactar al cliente cuando exista un problema durante la entrega.
- Gestionar cancelaciones, reposiciones o reembolsos cuando corresponda.
- Reprogramar sin costo adicional aquellas entregas que fallen por responsabilidad del negocio.
- Evitar que un producto que haya perdido las condiciones adecuadas de conservación sea entregado nuevamente.

---

## 10. Decisiones tomadas

1. La primera versión de Pa' la Asada contará únicamente con **entrega a domicilio**.
2. Pick & Collect no estará disponible inicialmente porque no existirá una tienda física o punto de recolección.
3. La cobertura inicial estará limitada a zonas habilitadas dentro de **Ciudad de México**.
4. El pedido se generará cuando el pago haya sido confirmado.
5. La preparación comenzará después de la confirmación del pago.
6. Los productos sin existencias no podrán comprarse.
7. El cliente no podrá solicitar una cantidad superior al inventario disponible.
8. No se establecerá inicialmente un límite fijo de piezas o kilogramos por cliente.
9. Antes del pago se realizará una última validación del inventario.
10. Al confirmarse el pago, los productos correspondientes se apartarán o descontarán del inventario.
11. Se buscará realizar la preparación y entrega el mismo día cuando las condiciones operativas lo permitan.
12. El cliente podrá cancelar únicamente antes de que comience la preparación.
13. Los pedidos no podrán dejarse sin supervisión cuando no exista una persona disponible para recibirlos.
14. Si una entrega falla por responsabilidad del negocio o del servicio de reparto, será reprogramada sin costo adicional para el cliente.
15. Los productos deberán mantenerse bajo las condiciones de conservación correspondientes durante la preparación, almacenamiento y entrega.
16. Ningún producto faltante será sustituido sin autorización del cliente.
17. El cliente podrá elegir una fecha y un rango de horario disponible, no una hora exacta.

---

## Propuestas para validar en reunión

<!--
Estas reglas todavía NO son decisiones definitivas.
Se incluyen como propuesta para facilitar la reunión del equipo.
-->

Las siguientes reglas se proponen para la primera versión de Pa' la Asada y deberán ser aprobadas o modificadas por el equipo.

### Horario límite para entrega el mismo día

Se propone que los pedidos pagados y confirmados **hasta las 2:00 p. m.** puedan considerarse para entrega el mismo día.

Los pedidos posteriores a este horario pasarán al siguiente día disponible.

La entrega el mismo día también dependerá de:

- Disponibilidad de inventario.
- Capacidad de preparación.
- Disponibilidad de reparto.

### Horario general de entregas

Se propone un horario de:

**10:00 a. m. a 8:00 p. m.**

### Rangos de entrega

Se propone utilizar ventanas de entrega en lugar de horas exactas:

- **10:00 a. m. a 1:00 p. m.**
- **1:00 p. m. a 4:00 p. m.**
- **4:00 p. m. a 8:00 p. m.**

La disponibilidad de cada rango dependerá de la capacidad de reparto.

### Costo de envío

Para iniciar, se propone un costo fijo de:

**$69 MXN por envío.**

Este importe es únicamente una propuesta inicial y deberá revisarse con base en los costos reales de operación.

La tarifa deberá mostrarse al cliente antes de confirmar la compra.

### Validación de cobertura

Se propone validar la cobertura mediante el **código postal** de la dirección.

Aunque la operación inicial se limite a Ciudad de México, únicamente podrán realizarse pedidos en los códigos postales habilitados por Pa' la Asada.

### Intentos de contacto

Se propone realizar hasta **3 intentos de contacto** cuando el repartidor llegue y no pueda localizar al cliente.

### Tiempo de espera

Se propone que el repartidor espere un máximo de **10 minutos** en el domicilio.

Durante ese periodo se realizarán los intentos de contacto.

Si no existe respuesta, el pedido se marcará como **Entrega no realizada** y regresará al punto de operación.

### Medios de contacto

Se propone utilizar:

- **WhatsApp:** medio principal para incidencias que requieran respuesta inmediata.
- **Llamada telefónica:** alternativa si el cliente no responde por WhatsApp.
- **Correo electrónico:** confirmaciones y actualizaciones generales del pedido.

### Segundo intento de entrega

Si la entrega falla por ausencia del cliente o por una dirección incorrecta, se propone:

- Regresar el pedido al punto de operación.
- Mantener las condiciones de conservación correspondientes.
- Permitir un segundo intento únicamente el mismo día, cuando exista capacidad de reparto y el producto siga siendo apto para la entrega.
- Cobrar nuevamente el costo de envío cuando la causa sea atribuible al cliente.

Si la falla fue responsabilidad de Pa' la Asada o del servicio de reparto, el nuevo intento no tendrá costo.

### Reembolso por entrega fallida

Se propone que, si definitivamente no puede realizarse una segunda entrega:

- El pedido pueda ser cancelado.
- El costo del primer envío no sea reembolsable cuando la causa sea atribuible al cliente.
- El tratamiento del importe correspondiente a productos ya preparados quede sujeto a la política definitiva que apruebe el equipo.

Si la imposibilidad de entrega fue responsabilidad del negocio:

- La reprogramación será gratuita.
- Si no es posible completar el pedido, se realizará el reembolso correspondiente.

### Límite de productos

Se propone **no establecer inicialmente un máximo fijo de piezas o kilogramos por cliente**.

El límite dependerá del inventario disponible.

Ejemplo:

Si existen 10 kg de carne molida, el cliente podrá comprar hasta 10 kg. Si intenta solicitar 12 kg, la compra no podrá continuar con esa cantidad y deberá mostrarse la existencia disponible.

Si posteriormente se detecta que determinados productos se agotan con demasiada facilidad por compras grandes, podrán establecerse límites específicos.

---

# 11. Decisiones pendientes para reunión

<!--
Registrar aquí cualquier decisión que el equipo no pudo resolver.
-->

### Preguntas para discutir en equipo

1. ¿Se aprueba que los pedidos para entrega el mismo día deban realizarse y pagarse antes de las **2:00 p. m.**?

2. ¿Se aprueba el horario general de entregas de **10:00 a. m. a 8:00 p. m.**?

3. ¿Se aprueban los rangos de entrega propuestos o deberán modificarse?

4. ¿El costo inicial de **$69 MXN** será suficiente para cubrir los gastos reales de reparto?

5. ¿Qué alcaldías o códigos postales de Ciudad de México estarán disponibles durante el lanzamiento?

6. ¿Existirá un monto mínimo de compra para solicitar entrega a domicilio?

7. ¿Existirá envío gratuito cuando el pedido supere determinado monto?

8. ¿Qué días de la semana estará disponible el servicio de entrega?

9. ¿Se aprueban los **3 intentos de contacto** y los **10 minutos de espera** en el domicilio?

10. ¿Se permitirá un segundo intento de entrega únicamente durante el mismo día cuando el primer intento falle por responsabilidad del cliente?

11. ¿Se aprueba que el cliente pague nuevamente el envío cuando la entrega falle por ausencia, dirección incorrecta u otra causa atribuible a él?

12. Si un pedido no puede volver a entregarse por responsabilidad del cliente, ¿se reembolsará el importe completo de los productos o algunos productos preparados específicamente para ese pedido no serán reembolsables?

13. ¿WhatsApp será el medio principal de contacto durante la entrega?

14. ¿Será necesario establecer en el futuro un máximo de piezas o kilogramos para determinados productos?

15. ¿Qué procedimiento seguirá el negocio cuando un pedido regrese después de una entrega fallida para verificar que los productos continúen siendo aptos para un segundo intento?

16. ¿Qué política se utilizará para pedidos de peso variable si el peso final preparado es ligeramente diferente al solicitado?

17. ¿Se requerirá que la persona que recibe el pedido confirme su recepción mediante firma, código, fotografía del pedido entregado u otro mecanismo?
