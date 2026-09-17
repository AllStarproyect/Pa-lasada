-- NOTA: las siguientes entidades son EXTERNAS (pertenecen a otro
-- módulo) y se asume que ya existen con una columna 'id' como PK.
-- Este script NO las crea, solo las referencia por FK:
--   cliente, producto

CREATE TABLE carrito (
    id INTEGER PRIMARY KEY,
    cliente_id INTEGER,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE carrito_producto (
    id INTEGER PRIMARY KEY,
    cantidad TEXT,
    carrito_id INTEGER,
    producto_id INTEGER,
    FOREIGN KEY (carrito_id) REFERENCES carrito(id),
    FOREIGN KEY (producto_id) REFERENCES producto(id)
);

CREATE TABLE detalle_pedido (
    id INTEGER PRIMARY KEY,
    cantidad TEXT,
    precio_unitario TEXT,
    pedido_id INTEGER,
    producto_id INTEGER,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id),
    FOREIGN KEY (producto_id) REFERENCES producto(id)
);

CREATE TABLE entrega (
    id INTEGER PRIMARY KEY,
    direccion TEXT,
    fecha_programada TEXT,
    rango_horario TEXT,
    tipo_entrega TEXT,
    fecha_hora_entregado TEXT,
    pedido_id INTEGER,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);

CREATE TABLE pago (
    id INTEGER PRIMARY KEY,
    metodo_pago TEXT,
    estado_pago TEXT,
    monto TEXT,
    fecha_pago TEXT,
    referencia_transaccion TEXT,
    pedido_id INTEGER,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);

CREATE TABLE pedido (
    id INTEGER PRIMARY KEY,
    estado TEXT,
    fecha_creacion TEXT,
    subtotal TEXT,
    envio TEXT,
    total TEXT,
    cliente_id INTEGER,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);
