# 04-Reglas-comerciales-operación

## Definición de reglas comerciales y operación

```{=html}
<!--
OBJETIVO

Definir las reglas que determinan cómo funciona comercialmente
el negocio.

Este documento NO debe diseñar el panel administrativo.
Debe responder:
"¿Qué necesita hacer el negocio?"
y no:
"¿Cómo será programado el panel?"
-->
```

------------------------------------------------------------------------

## 1. Objetivo

Definir las reglas comerciales y operativas que determinan cómo funciona
el negocio, principalmente en relación con productos, precios,
inventario, promociones, catálogo, pedidos y disponibilidad.

El objetivo es establecer criterios comunes que la plataforma deberá
respetar y evitar interpretaciones contradictorias durante el
desarrollo.

Este documento describe **qué necesita hacer el negocio**, no cómo será
programado el sistema ni cómo se diseñará el panel administrativo.

------------------------------------------------------------------------

## 2. Precios

### Definición

El precio de un producto es el valor de venta al cliente y se define a
nivel de producto.

El precio puede estar asociado a una unidad de venta, como kilogramo,
pieza o paquete, dependiendo de la forma en que el negocio comercialice
el producto.

Si una misma referencia se vende en diferentes presentaciones con
precios o existencias independientes, cada presentación deberá
registrarse como un producto independiente mientras el modelo del
negocio no contemple variantes.

### Reglas

-   El precio de cada producto es definido manualmente por el personal
    autorizado del negocio.
-   El sistema no debe calcular automáticamente el precio a partir de
    costos, márgenes u otras fórmulas, salvo que el equipo acuerde
    posteriormente una regla diferente.
-   Cada producto tendrá un único precio vigente para su presentación
    actual.
-   Solo el personal autorizado del negocio podrá modificar los precios.
-   Todo cambio de precio deberá quedar registrado con fecha, valor
    anterior y valor nuevo.
-   Cuando un producto tenga una promoción vigente, el precio mostrado
    al cliente deberá corresponder al precio promocional.
-   Si una promoción termina, el precio deberá regresar al valor
    comercial correspondiente.
-   Si un producto se vende por peso variable, deberá definirse
    previamente la forma en que se determinará el precio final según el
    peso vendido.
-   Si existen presentaciones diferentes de un mismo producto, deberán
    distinguirse comercialmente para evitar confusión entre precio,
    unidad e inventario.

------------------------------------------------------------------------

## 3. Inventario

### Definición

La existencia de un producto representa la cantidad disponible para su
venta.

Un producto se considera disponible cuando cuenta con existencia
suficiente y el negocio permite su venta.

El inventario debe mantenerse actualizado para evitar vender cantidades
superiores a las disponibles.

### Reglas

-   Un producto marcado como no disponible no puede ser vendido,
    independientemente de la cantidad registrada en inventario.
-   Cuando la existencia de un producto llegue a cero, el producto
    deberá quedar como no disponible automáticamente.
-   No se puede vender una cantidad mayor a la existencia disponible.
-   Si el cliente solicita una cantidad superior a la disponible, la
    compra deberá limitarse a la existencia real o impedirse hasta que
    exista suficiente inventario.
-   La existencia deberá descontarse definitivamente cuando el pago de
    la compra sea confirmado.
-   Mientras una compra se encuentre en proceso de pago, la cantidad
    involucrada deberá considerarse reservada temporalmente si el
    negocio decide utilizar un esquema de reserva.
-   El personal responsable del inventario deberá mantener actualizadas
    las existencias.
-   Cuando una compra sea cancelada y corresponda restaurar inventario,
    la cantidad deberá reincorporarse a la existencia disponible.
-   Los ajustes manuales de inventario deberán quedar registrados para
    poder identificar cuándo, cuánto y por qué se modificó una
    existencia.

------------------------------------------------------------------------

## 4. Descuentos y promociones

### Tipos de promoción

El negocio podrá manejar, como mínimo, los siguientes tipos de
promociones:

-   **Descuento:** reducción del precio normal de un producto.
-   **Hot Sale:** promoción comercial especial que puede estar limitada
    a una campaña o periodo determinado.
-   **Por temporada:** promoción o selección de productos asociada a una
    temporada o campaña comercial.
-   **Promociones especiales:** cualquier otra promoción que el negocio
    decida implementar posteriormente.

### Reglas

-   Toda promoción deberá tener una condición comercial claramente
    definida por el negocio.
-   El precio mostrado al cliente deberá corresponder al precio vigente
    durante la promoción.
-   Una promoción deberá tener una vigencia definida por el negocio,
    aunque el modelo actual no automatice todavía su inicio o
    finalización.
-   Al finalizar una promoción, el negocio deberá retirar la condición
    promocional y actualizar el precio correspondiente.
-   No deberá mostrarse un producto como promocionado cuando la
    promoción ya no se encuentre vigente.
-   Si una promoción modifica el precio, el cambio deberá quedar
    registrado.
-   El negocio deberá determinar si una promoción puede combinarse con
    otra antes de aplicarla.
-   No se deberán aplicar automáticamente descuentos acumulativos
    mientras el negocio no haya definido una regla específica para ello.

------------------------------------------------------------------------

## 5. Relación entre promociones y tags

### Definición

Los tags comerciales son indicadores asociados a los productos para
comunicar características o condiciones comerciales.

Los tags pueden utilizarse para identificar productos como:

-   `premium`
-   `nuevo`
-   `descuento`
-   `nacional`
-   `internacional`
-   `masVendido`
-   `hotSale`
-   `porTemporada`

Los tags `descuento`, `hotSale` y `porTemporada` tienen relación directa
con condiciones promocionales.

Los tags `premium`, `nuevo`, `nacional`, `internacional` y `masVendido`
son principalmente informativos o de clasificación y no modifican por sí
mismos el precio.

### Reglas

-   `descuento = true` solo deberá utilizarse cuando el producto tenga
    actualmente un precio promocional.
-   `hotSale = true` solo deberá utilizarse durante una campaña
    comercial activa.
-   `porTemporada = true` solo deberá utilizarse mientras el producto
    pertenezca a una campaña o colección estacional vigente.
-   Un producto podrá tener varios tags activos simultáneamente.
-   La existencia de varios tags no significa automáticamente que los
    descuentos deban acumularse.
-   El negocio deberá definir previamente si dos promociones pueden
    aplicarse al mismo producto.
-   Los tags deberán mantenerse sincronizados con la condición comercial
    real del producto.
-   Cuando una promoción termine, deberán desactivarse los tags
    correspondientes.

------------------------------------------------------------------------

## 6. Disponibilidad de productos

### Reglas

-   Un producto está disponible cuando existe inventario suficiente y el
    negocio permite su venta.
-   Un producto está agotado cuando su existencia llega a cero.
-   Cuando un producto se encuentre agotado, deberá permanecer
    registrado en el catálogo, pero no deberá poder comprarse.
-   Un producto puede marcarse temporalmente como no disponible aunque
    tenga existencia, por ejemplo, por revisión del producto, problemas
    de preparación o decisión del negocio.
-   Un producto descontinuado deberá diferenciarse de un producto
    temporalmente agotado cuando el negocio determine que esa distinción
    sea necesaria.
-   Un producto no disponible no podrá agregarse a una nueva compra.
-   La disponibilidad deberá mantenerse actualizada de acuerdo con el
    inventario y las decisiones comerciales del negocio.

------------------------------------------------------------------------

## 7. Actualización del catálogo

### Información que debe poder actualizarse

El negocio deberá poder mantener actualizada la siguiente información:

### Productos

-   Identificador del producto.
-   SKU, cuando corresponda.
-   Nombre.
-   Categoría.
-   Descripción.
-   Unidad de venta.
-   Estado de disponibilidad.
-   Imágenes.

### Precios

-   Precio vigente.
-   Moneda.
-   Condición promocional, cuando corresponda.

### Inventario

-   Cantidad disponible.
-   Estado de disponibilidad.
-   Ajustes de inventario.

### Categorías

-   Categoría principal de cada producto.
-   Categorías adicionales, si el negocio decide permitir que un
    producto pertenezca a más de una categoría.

### Tags

-   `premium`
-   `nuevo`
-   `descuento`
-   `nacional`
-   `internacional`
-   `masVendido`
-   `hotSale`
-   `porTemporada`

### Promociones

-   Condición comercial.
-   Periodo de vigencia.
-   Productos participantes.
-   Precio promocional, cuando corresponda.

------------------------------------------------------------------------

## 8. Acciones del negocio

### Productos

-   Dar de alta productos.
-   Editar información de productos.
-   Retirar productos del catálogo.
-   Asignar productos a categorías.
-   Actualizar imágenes, descripciones y demás información comercial.
-   Definir la unidad de venta de cada producto.

### Precios

-   Definir el precio de cada producto.
-   Modificar precios.
-   Aplicar precios promocionales.
-   Restaurar el precio correspondiente al finalizar una promoción.
-   Mantener un registro de los cambios de precio.

### Inventario

-   Registrar existencias.
-   Actualizar existencias.
-   Revisar productos agotados.
-   Realizar ajustes de inventario.
-   Restaurar existencias cuando corresponda después de una cancelación.
-   Verificar que la disponibilidad del producto corresponda con su
    existencia real.

### Pedidos

-   Consultar los pedidos realizados.
-   Validar que las cantidades solicitadas no excedan las existencias
    disponibles.
-   Confirmar los pedidos de acuerdo con las condiciones de pago
    establecidas.
-   Gestionar la preparación de los pedidos.
-   Gestionar cancelaciones.
-   Actualizar el estado de los pedidos.
-   Restaurar inventario cuando una cancelación lo requiera.
-   Registrar los cambios relevantes relacionados con cada pedido.

### Promociones

-   Crear o definir campañas comerciales.
-   Activar y desactivar los tags relacionados con promociones.
-   Actualizar precios promocionales.
-   Revisar que las promociones estén vigentes.
-   Retirar promociones vencidas.
-   Evitar que un producto muestre información promocional que ya no
    corresponda.

------------------------------------------------------------------------

## 9. Reglas importantes del negocio

1.  Un producto que no esté disponible no puede ser vendido.
2.  No se puede vender una cantidad mayor a la existencia disponible.
3.  El precio de cada producto es definido por el negocio y debe
    mantenerse actualizado.
4.  Un precio promocional debe corresponder a una promoción vigente.
5.  Ningún tag promocional debe permanecer activo cuando la condición
    comercial que representa haya terminado.
6.  Los tags informativos no modifican por sí mismos el precio del
    producto.
7.  La existencia debe actualizarse después de una venta confirmada.
8.  Una cancelación que corresponda a una devolución de inventario
    deberá restaurar la cantidad correspondiente.
9.  Si existen diferentes presentaciones de un producto con precio o
    inventario independiente, deberán distinguirse como productos
    diferentes mientras no exista soporte para variantes.
10. Un producto agotado no debe poder agregarse a una nueva compra.
11. Las promociones no deberán acumularse automáticamente mientras el
    negocio no haya definido una regla de acumulación.
12. Los cambios importantes de precio, inventario y promociones deberán
    quedar registrados para fines de control del negocio.
13. Los productos descontinuados deberán diferenciarse de los productos
    temporalmente agotados cuando el negocio establezca esa necesidad.

------------------------------------------------------------------------

## 10. Decisiones tomadas

1.  El modelo actual no maneja variantes o presentaciones dentro de un
    mismo producto; cuando sea necesario manejar presentaciones con
    precios o existencias independientes, se registrarán como productos
    separados.
2.  El precio de cada producto es definido manualmente por el negocio.
3.  El inventario se descuenta definitivamente cuando el pago de la
    compra es confirmado.
4.  Cuando el inventario llega a cero, el producto debe quedar como no
    disponible.
5.  Un producto puede tener varios tags activos al mismo tiempo.
6.  Los tags `descuento`, `hotSale` y `porTemporada` representan
    condiciones comerciales y no deben permanecer activos cuando dichas
    condiciones hayan terminado.
7.  Los tags `premium`, `nuevo`, `nacional`, `internacional` y
    `masVendido` son informativos y no modifican directamente el precio.
8.  Las promociones deben mantener sincronizados el precio y los tags
    comerciales correspondientes.
9.  El negocio no debe asumir que varias promociones se acumulan
    únicamente porque varios tags estén activos.
10. El producto agotado permanece registrado en el catálogo, pero no
    puede ser comprado.
11. Un producto puede ser marcado como temporalmente no disponible
    aunque todavía tenga existencia.

------------------------------------------------------------------------

## 11. Decisiones pendientes para reunión

### Preguntas para discutir en equipo

1.  ¿El modelo debe ampliarse para soportar variantes o presentaciones
    dentro de un mismo producto, con precio e inventario independientes,
    o se mantiene la regla de "una presentación = un producto"?

2.  ¿Los productos se venderán por kilogramo, por pieza, por paquete o
    mediante una combinación de estas modalidades?

3.  Si un producto se vende por peso variable, ¿el precio se calculará
    con base en el peso final registrado en la venta?

4.  ¿Qué productos podrán venderse por peso variable y cuáles tendrán
    una cantidad fija por pieza o paquete?

5.  ¿Se debe agregar una entidad específica para promociones, con tipo,
    monto o porcentaje, fecha de inicio, fecha de fin y precio original,
    para automatizar su vigencia?

6.  Si las promociones continúan gestionándose manualmente, ¿quién será
    responsable de revisar y desactivar las promociones vencidas y con
    qué frecuencia?

7.  ¿Se pueden combinar dos o más promociones sobre un mismo producto?

8.  ¿Se permite aplicar un descuento a un producto que ya participa en
    una campaña como Hot Sale o Por Temporada?

9.  ¿Es necesario un campo de stock reservado para cubrir la reserva
    temporal de inventario durante el proceso de pago?

10. ¿Cuáles serán los estados que puede tener un pedido durante su ciclo
    de vida?

11. ¿En qué momento se considera confirmado un pedido?

12. ¿En qué momento se considera confirmado un pago?

13. ¿Qué métodos de pago aceptará el negocio?

14. ¿Hasta qué momento puede un cliente cancelar un pedido?

15. ¿Qué sucede con el inventario cuando un pedido pagado es cancelado?

16. ¿Quién puede autorizar la cancelación de un pedido?

17. ¿El negocio ofrecerá entrega a domicilio, recolección en tienda o
    ambas opciones?

18. Si existe entrega a domicilio, ¿qué zonas estarán disponibles y cómo
    se determinará el costo de envío?

19. ¿Existen horarios específicos para realizar pedidos, preparar
    pedidos y realizar entregas?

20. ¿Un producto descontinuado debe ocultarse del catálogo o permanecer
    visible como producto no disponible?

21. ¿Existe una cantidad mínima o máxima de compra para determinados
    productos?

22. ¿Qué ocurre cuando el peso final de un producto preparado para el
    cliente es diferente al peso solicitado inicialmente?

23. ¿Cómo se manejarán los cambios de precio cuando una promoción
    termine y cuál será el precio que deberá restaurarse?

24. ¿Qué información debe conservarse como historial de cambios de
    precios, inventario, promociones y pedidos?

------------------------------------------------------------------------

## 12. Criterio general de operación

La plataforma deberá respetar las reglas comerciales definidas en este
documento independientemente de la tecnología utilizada para
implementarlas.

Cuando una situación comercial no esté contemplada en estas reglas,
deberá ser definida por el equipo antes de implementar un comportamiento
permanente en la plataforma.

Las decisiones pendientes de la sección 11 deberán resolverse antes de
desarrollar las funcionalidades que dependan directamente de ellas, con
el objetivo de evitar interpretaciones diferentes entre los integrantes
del equipo.
