# Definición de Producto y Catálogo

<!--
OBJETIVO DEL DOCUMENTO

Definir cómo funciona el catálogo desde el punto de vista del negocio.

Este documento NO debe definir:

- Tablas de MySQL.
- Clases Java.
- Entidades JPA.
- JSON definitivo.
- Código.
- Relaciones de base de datos.

La finalidad es definir QUÉ ES un producto para nuestro negocio
y qué información necesita.
-->

## 1. Objetivo

Definir las características que tendrá un producto del catálogo, la forma en que será clasificado y la información que podrá consultar el cliente.

El documento establece las reglas de negocio relacionadas con productos, categorías, tags, precios, unidades de venta, disponibilidad y presentación dentro del catálogo.

---

# 2. Definición de producto

Para nuestra empresa de comercialización y distribución de cortes de carne de alta calidad, un **producto** representa cada artículo que forma parte de la oferta comercial y que puede ser consultado y adquirido por el cliente.

Inicialmente, el catálogo estará enfocado principalmente en **cortes finos de carne de res**.

Un producto representa el tipo de corte y su presentación comercial, y no una pieza física individual.

Por ejemplo:

> **Producto:** Tomahawk
> **Presentación:** 1 pieza de aproximadamente 450 g

Las diferentes piezas físicas del mismo producto no representan productos distintos. El negocio procurará mantener un peso establecido para cada producto.

El peso puede variar dependiendo del producto. Por ejemplo:

* Producto A: 350 g por pieza.
* Producto B: 450 g por pieza.
* Producto C: 600 g por pieza.

El cliente compra una o más piezas del producto y el precio se calcula tomando como referencia el peso establecido para cada pieza.

---

# 3. Información del producto

La información principal definida para un producto es:

| Información         | Descripción                                                                                                            |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **Nombre**          | Nombre comercial del producto o corte. Ejemplo: Tomahawk.                                                              |
| **Descripción**     | Descripción breve del producto y sus principales características.                                                      |
| **Precio**          | Precio establecido por kilogramo o por la unidad correspondiente.                                                      |
| **Unidad de venta** | Define cómo se comercializa el producto. Inicialmente, los cortes se venden por pieza tomando como referencia su peso. |
| **Imagen**          | Imagen principal del producto. Se buscará utilizar una fotografía con buena iluminación y fondo limpio.                |
| **Peso por pieza**  | Peso establecido o aproximado que representa cada pieza del producto. Puede variar dependiendo del corte.              |
| **Origen**          | Identifica si el producto es de origen nacional o internacional.                                                       |
| **Presentación**    | Forma en que se entrega comercialmente el producto.                                                                    |

### Peso y presentación

Cada producto tendrá un peso establecido para su presentación.

No todos los productos tendrán necesariamente el mismo peso.

Por ejemplo:

> Tomahawk → 450 g aprox. por pieza
> Rib Eye → 350 g aprox. por pieza
> Picaña → 600 g aprox. por pieza

El cliente **no podrá seleccionar un peso específico**.

La compra se realizará mediante la selección de piezas:

> 1 pieza → aproximadamente 450 g
> 2 piezas → aproximadamente 900 g
> 3 piezas → aproximadamente 1.35 kg

El peso establecido para cada producto será utilizado para calcular el precio correspondiente.

---

# 4. Categorías

Las categorías constituyen la estructura principal de navegación y clasificación dentro del sitio web.

Su objetivo es permitir que el cliente encuentre productos relacionados con el tipo de corte o producto que está buscando.

Inicialmente, el catálogo estará enfocado en carnes de res y las categorías podrán representar los diferentes cortes disponibles, por ejemplo:

* Res
* Rib Eye
* Tomahawk
* Picaña
* New York
* Cowboy
* Otros cortes que se incorporen posteriormente

La estructura definitiva de categorías podrá ampliarse conforme evolucione el catálogo.

## Clasificación mediante categorías

Un producto debe contar con **una categoría principal**.

De manera opcional, puede asociarse a una o más categorías secundarias cuando esto ayude a mejorar la navegación o filtrado.

Ejemplo:

> **Producto:** Tomahawk
> **Categoría principal:** Res
> **Categoría secundaria:** Tomahawk
> **Categoría secundaria:** Premium

Un producto puede pertenecer únicamente a una categoría si no necesita categorías adicionales.

La asignación de categorías debe evitar la duplicación del mismo producto dentro del catálogo.

### Categorías y tags

Las categorías se utilizan principalmente para **organizar, navegar y filtrar** el catálogo.

Las tags tienen principalmente una función de **identificación visual, clasificación complementaria o comunicación de una condición comercial**.

Una misma característica puede existir como categoría y como tag cuando el negocio considere útil que pueda utilizarse tanto para navegación como para destacar visualmente el producto.

Por ejemplo, `PREMIUM` puede existir como una categoría para permitir navegar por productos premium y también utilizarse como tag para destacarlo visualmente.

---

# 5. Tags de productos

Las tags son etiquetas utilizadas para destacar o identificar visualmente determinadas características o condiciones de un producto.

Las tags propuestas inicialmente son:

* PREMIUM
* NUEVO
* DESCUENTO
* NACIONAL
* INTERNACIONAL
* MÁS VENDIDO
* HOT SALE
* POR TEMPORADA

| Tag               | Significado                                                                                         | Asignación                              |
| ----------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------- |
| **PREMIUM**       | Identifica productos considerados de calidad superior o de características especiales.              | Manual                                  |
| **NUEVO**         | Identifica productos recientemente incorporados al catálogo.                                        | Automática durante los primeros 10 días |
| **DESCUENTO**     | Indica que el producto tiene una promoción o reducción sobre su precio habitual.                    | Manual                                  |
| **NACIONAL**      | Identifica productos cuyo origen ha sido definido por el negocio como nacional.                     | Manual                                  |
| **INTERNACIONAL** | Identifica productos cuyo origen ha sido definido por el negocio como internacional/importado.      | Manual                                  |
| **MÁS VENDIDO**   | Identifica el producto con mayor cantidad de piezas vendidas durante el periodo establecido.        | Automática                              |
| **HOT SALE**      | Identifica productos participantes en una campaña de Hot Sale.                                      | Manual                                  |
| **POR TEMPORADA** | Identifica productos cuya comercialización está relacionada con una temporada o periodo específico. | Manual                                  |

## Reglas de las tags

### Una sola tag por producto

Un producto puede tener **como máximo una tag activa**.

Por lo tanto, no es posible mostrar simultáneamente:

> PREMIUM + NACIONAL

ni:

> DESCUENTO + INTERNACIONAL

ni:

> HOT SALE + PREMIUM

La selección de la tag debe realizarse considerando cuál es la característica o condición que el negocio desea destacar en ese momento.

### Prioridad de tags

Cuando un producto cumple con varias condiciones que podrían justificar diferentes tags, el administrador decidirá manualmente cuál debe mostrarse.

Por ejemplo:

> Un producto puede ser Premium, Nacional y tener descuento.

Debido a que solamente puede mostrar una tag, el administrador decidirá cuál de estas características tendrá prioridad visual.

### MÁS VENDIDO

`MÁS VENDIDO` constituye una excepción a la asignación manual.

El producto que ocupe el primer lugar en ventas durante el periodo definido será identificado automáticamente con esta tag.

Cuando un producto se convierta en el producto número uno en ventas, `MÁS VENDIDO` **reemplazará automáticamente la tag que tuviera anteriormente**.

Ejemplo:

> Rib Eye → DESCUENTO
> Rib Eye se convierte en el producto #1 en ventas
> Rib Eye → MÁS VENDIDO

La tag anterior se elimina y no se conservan ambas.

### NUEVO

Un producto podrá identificarse como `NUEVO` durante los primeros **10 días** posteriores a su incorporación al catálogo.

Después de los 10 días, la tag `NUEVO` se elimina.

El producto quedará sin tag hasta que el administrador le asigne manualmente otra.

### DESCUENTO

La tag `DESCUENTO` se asigna manualmente.

Representa una condición comercial en la que el producto tiene un precio promocional respecto a su precio habitual.

Cuando se utilice esta tag, deberá existir una diferencia clara entre el precio habitual y el precio promocional.

### HOT SALE

La tag `HOT SALE` se asigna manualmente.

Durante una campaña de Hot Sale, esta tag funciona como la identificación visual de la promoción correspondiente.

Debido a que solamente se permite una tag por producto, un producto marcado como `HOT SALE` no mostrará simultáneamente la tag `DESCUENTO`.

### NACIONAL e INTERNACIONAL

`NACIONAL` e `INTERNACIONAL` son mutuamente excluyentes.

Un producto no puede tener ambas tags.

El administrador será responsable de determinar manualmente si el producto debe clasificarse como nacional o internacional.

---

# 6. Precio y unidad de venta

La comercialización de los cortes se realizará mediante **piezas con un peso establecido para cada producto**.

El precio de referencia se expresará por kilogramo.

Ejemplo:

> **Tomahawk**
> Precio: $500 MXN / kg
> Peso por pieza: 450 g aprox.

El cliente no comprará una cantidad arbitraria de gramos.

En su lugar, seleccionará la cantidad de piezas que desea adquirir.

## Cálculo del precio

El precio se calculará utilizando el peso establecido de la pieza.

Por ejemplo:

> Precio: $500 MXN / kg
> Peso por pieza: 450 g
> Cantidad: 2 piezas
> Peso total: 900 g = 0.9 kg
> Precio: 0.9 × $500 = **$450 MXN**

Otro producto podría tener:

> Precio: $500 MXN / kg
> Peso por pieza: 600 g
> Cantidad: 2 piezas
> Peso total: 1.2 kg
> Precio: 1.2 × $500 = **$600 MXN**

El peso de referencia es propio de cada producto.

### Fraccionamiento

El cliente podrá aumentar o disminuir la cantidad de piezas desde el carrito.

No podrá solicitar un gramaje personalizado.

Por ejemplo:

> 1 pieza
> 2 piezas
> 3 piezas

No será posible solicitar:

> 750 g

si la presentación del producto corresponde a piezas de 450 g.

### Experiencia de compra

En la card del producto no existirá un selector de cantidad.

El cliente encontrará un botón:

> **Agregar al carrito**

La primera vez que agregue el producto, se incorporará una pieza.

Si vuelve a seleccionar `Agregar al carrito`, se agregará otra pieza del mismo producto.

La modificación de la cantidad mediante `+` y `-` se realizará únicamente desde el carrito.

---

# 7. Disponibilidad

Los productos tendrán diferentes estados de disponibilidad que indican si pueden ser adquiridos en determinado momento.

| Estado            | Visible en catálogo | Se puede agregar al carrito |
| ----------------- | ------------------: | --------------------------: |
| **Disponible**    |                  Sí |                          Sí |
| **Agotado**       |                  Sí |                          No |
| **No disponible** |                  Sí |                          No |
| **Descontinuado** |                  No |                          No |

### Disponible

El producto forma parte de la oferta activa y puede ser adquirido por el cliente.

### Agotado

El producto forma parte del catálogo, pero actualmente no se encuentra disponible para compra.

Debe continuar apareciendo en el catálogo con una indicación clara de que está agotado.

### No disponible

El producto continúa formando parte del catálogo, pero temporalmente no puede adquirirse.

Debe continuar visible para el cliente.

### Descontinuado

El producto dejó de formar parte de la oferta comercial.

Los productos descontinuados no deben aparecer en el catálogo disponible para el cliente.

---

# 8. Información visible en la card

## Card de producto

La tarjeta debe presentar la información indispensable de forma compacta para facilitar una navegación rápida.

Debe mostrar:

* Imagen principal del producto.
* Tag asignada, si existe. **Máximo una tag.**
* Nombre del producto.
* Categoría o tipo de corte.
* Origen breve, cuando corresponda.
* Precio.
* Peso de referencia por pieza.
* Botón `Agregar al carrito`.

### Ejemplo conceptual de card

> **PREMIUM**
> Tomahawk
> Res · Nacional
> $500 MXN / kg
> 450 g aprox. por pieza
> **Agregar al carrito**

La card **no debe mostrar**:

* Selector `+ / -`.
* Marmoleo.
* Información adicional que no sea necesaria para una decisión rápida de compra.

La cantidad será administrada desde el carrito.

---

# 9. Detalle del producto

La ficha del producto será la vista ampliada que se muestra cuando el cliente desea conocer más información.

Debe mostrar la información definida para el producto, incluyendo:

* Imagen del producto.
* Nombre.
* Descripción.
* Categoría principal.
* Categorías secundarias, si existen.
* Tag, si existe.
* Precio.
* Unidad de venta.
* Peso de referencia por pieza.
* Origen.
* Disponibilidad.
* Cantidad de piezas.
* Precio estimado de acuerdo con la cantidad seleccionada.
* Botón para agregar al carrito.

El detalle del producto no requiere información de marmoleo ni características adicionales que no hayan sido definidas por el negocio.

---

# 10. Ejemplo de producto

## Producto

**Tomahawk**

### Categorías

* Principal: Res
* Secundaria: Tomahawk
* Secundaria: Premium

### Tag

**PREMIUM**

### Precio / unidad

**$500 MXN / kg**

### Presentación

**1 pieza de aproximadamente 450 g**

### Información principal

Corte Tomahawk de res presentado como una pieza individual. El cliente puede agregar una o más piezas al carrito.

### Ejemplo de compra

> 1 pieza → 450 g aprox. → $225 MXN aprox.
> 2 piezas → 900 g aprox. → $450 MXN aprox.
> 3 piezas → 1.35 kg aprox. → $675 MXN aprox.

El peso de referencia y el precio dependerán de cada producto.

---

# 11. Decisiones tomadas

1. El catálogo estará enfocado inicialmente principalmente en **cortes finos de carne de res**.
2. Un producto representa un tipo de producto/presentación comercial y no una pieza física individual.
3. Un producto debe tener una categoría principal.
4. Un producto puede tener categorías secundarias de manera opcional.
5. Un producto puede pertenecer únicamente a una categoría cuando no necesite categorías adicionales.
6. `PREMIUM` puede utilizarse como categoría y también como tag cuando el negocio lo considere necesario.
7. Un producto puede tener **una sola tag como máximo**.
8. El administrador decide manualmente qué tag tiene prioridad cuando un producto cumple varias condiciones.
9. `NUEVO` se mantiene durante los primeros 10 días desde la incorporación del producto al catálogo.
10. Después de los 10 días, `NUEVO` se elimina y el producto queda sin tag hasta que se le asigne otra.
11. `DESCUENTO` se asigna manualmente.
12. `HOT SALE` se asigna manualmente y sustituye visualmente a `DESCUENTO` durante la campaña.
13. `NACIONAL` e `INTERNACIONAL` son mutuamente excluyentes.
14. `MÁS VENDIDO` se asigna automáticamente al producto que tenga mayor cantidad de piezas vendidas durante el periodo definido.
15. `MÁS VENDIDO` reemplaza automáticamente cualquier tag anterior del producto.
16. Los productos se comercializan por piezas con un peso establecido para cada producto.
17. El peso de una pieza puede variar según el producto; no todos los productos tendrán necesariamente 450 g.
18. El cliente no puede solicitar un peso personalizado.
19. El cliente selecciona únicamente la cantidad de piezas.
20. El precio se calcula utilizando el peso establecido de las piezas y el precio por kilogramo.
21. El selector `+ / -` estará disponible únicamente en el carrito.
22. En la card, cada clic en `Agregar al carrito` agrega una pieza adicional del producto.
23. Los productos disponibles, agotados y temporalmente no disponibles continúan apareciendo en el catálogo.
24. Los productos descontinuados dejan de aparecer en el catálogo.
25. Las cards no mostrarán marmoleo ni información adicional de calidad que no haya sido definida.
26. La card mostrará únicamente la información necesaria para identificar y evaluar rápidamente el producto.

---

# 12. Decisiones pendientes para reunión

Las siguientes decisiones todavía deben ser confirmadas con el equipo.

### Alcance del catálogo

**¿El catálogo inicial se limitará exclusivamente a cortes finos de res o también se contempla comercializar productos complementarios como sazonadores, utensilios de cocina, accesorios para parrilla u otros productos relacionados?**

### Estructura definitiva de categorías

**¿Cuáles serán exactamente las categorías iniciales del catálogo?**

Se propone inicialmente considerar categorías relacionadas con los cortes de res, como:

* Res
* Rib Eye
* Tomahawk
* Picaña
* New York
* Cowboy
* Otros cortes que el equipo determine.

Debe definirse si esta será la estructura definitiva o si se utilizará una jerarquía diferente.

### Periodo de cálculo de MÁS VENDIDO

**¿Durante qué periodo se determinará el producto más vendido?**

Por ejemplo:

* Últimos 7 días.
* Últimos 30 días.
* Mes calendario.
* Otro periodo.

La regla actual establece que será el producto con **mayor cantidad de piezas vendidas**, pero falta definir el periodo.

### Precio y variaciones de peso

**¿El negocio desea mantener el precio calculado estrictamente con base en el peso establecido de cada pieza, aceptando pequeñas variaciones físicas, o será necesario ajustar el precio según el peso real de cada pieza?**

Esta decisión debe quedar definida antes de implementar el proceso de venta.

### Definición de origen

**¿Qué criterio utilizará el administrador para determinar si un producto es NACIONAL o INTERNACIONAL?**

Por ejemplo, debe definirse si el origen se determina exclusivamente por el origen de la carne o mediante algún otro criterio comercial.

### Presentaciones futuras

**¿En el futuro un mismo producto podrá manejar diferentes presentaciones o pesos, o cada presentación deberá considerarse un producto independiente?**

Ejemplo:

> Tomahawk 450 g
> Tomahawk 800 g

Actualmente se considera una sola presentación por producto, pero esta decisión puede revisarse si el catálogo crece.
