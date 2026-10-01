-- Carga de los productos de data/productos.json (63) con existencia 10 c/u.
-- Es repetible: usa ON DUPLICATE KEY UPDATE / INSERT IGNORE, no duplica filas.
-- Ejecutar sobre la base que usa el back (la de DB_URL).

START TRANSACTION;

-- Categorias (por nombre; el id se calcula si no existe)
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'Carne' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'Carne');
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'Res' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'Res');
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'Nacional' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'Nacional');
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'USA' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'USA');
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'Choice' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'Choice');
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'Cerdo' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'Cerdo');
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'Añejos' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'Añejos');
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'Prime' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'Prime');
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'Ultra Premium' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'Ultra Premium');
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'Argentina' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'Argentina');
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'Japón' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'Japón');
INSERT INTO categoria (categoria_id, nombre) SELECT (SELECT COALESCE(MAX(c.categoria_id),0)+1 FROM categoria c), 'Australia' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM categoria WHERE nombre = 'Australia');

-- Aguja Norteña - Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-aguja-nortena-nacional',445.0,'MXN','$445.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-aguja-nortena-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-aguja-nortena-nacional','https://casabrassa.mx/product/aguja-nortena-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/aguja-nortena-4-1-A.jpg','assets/img/catalogo/aguja_norteña_nacional.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-aguja-nortena-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('aguja-nortena-nacional','AGUJA-NORTENA-NACIONAL','Aguja Norteña - Nacional',1,'Aguja Norteña – Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
T-Bone High Choice
Porterhouse High Choice
Sirloin High Choice
RibEye Prime
NewYork Prime','PRECIO-aguja-nortena-nacional','INV-aguja-nortena-nacional','IMG-aguja-nortena-nacional','INFO-aguja-nortena-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('aguja-nortena-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('aguja-nortena-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('aguja-nortena-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Arrachera Natural Importada
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-arrachera-natural-importada',990.0,'MXN','$990.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-arrachera-natural-importada','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-arrachera-natural-importada','https://casabrassa.mx/product/arrachera-natural-importada/','https://casabrassa.mx/wp-content/uploads/2021/01/aguja-nortena-4-1-ok.jpg','assets/img/catalogo/arrachera_natural_importada.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-arrachera-natural-importada','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('arrachera-natural-importada','ARRACHERA-NATURAL-IMPORTADA','Arrachera Natural Importada',1,'Arrachera Natural Importada
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.','PRECIO-arrachera-natural-importada','INV-arrachera-natural-importada','IMG-arrachera-natural-importada','INFO-arrachera-natural-importada',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('arrachera-natural-importada',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('arrachera-natural-importada',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('arrachera-natural-importada',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('arrachera-natural-importada',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Arrachera Natural - Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-arrachera-natural-nacional',462.0,'MXN','$462.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-arrachera-natural-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-arrachera-natural-nacional','https://casabrassa.mx/product/arrachera-natural-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/arrachera-natural-2-1024x683.jpg','assets/img/catalogo/arrachera_natural_nacional.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-arrachera-natural-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('arrachera-natural-nacional','ARRACHERA-NATURAL-NACIONAL','Arrachera Natural - Nacional',1,'Arrachera Natural – Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
T-Bone High Choice
Porterhouse High Choice
Sirloin High Choice
RibEye Prime
NewYork Prime','PRECIO-arrachera-natural-nacional','INV-arrachera-natural-nacional','IMG-arrachera-natural-nacional','INFO-arrachera-natural-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('arrachera-natural-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('arrachera-natural-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('arrachera-natural-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Arrachera Texana Importada
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-arrachera-texana-importada',1238.0,'MXN','$1,238.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-arrachera-texana-importada','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-arrachera-texana-importada','https://casabrassa.mx/product/arrachera-texana-importada/','https://casabrassa.mx/wp-content/uploads/2021/01/arrachera-texana-sterling-2-ok.jpg','assets/img/catalogo/arrachera_texana_importada.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-arrachera-texana-importada','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('arrachera-texana-importada','ARRACHERA-TEXANA-IMPORTADA','Arrachera Texana Importada',1,'Arrachera Texana Importada
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.','PRECIO-arrachera-texana-importada','INV-arrachera-texana-importada','IMG-arrachera-texana-importada','INFO-arrachera-texana-importada',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('arrachera-texana-importada',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('arrachera-texana-importada',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('arrachera-texana-importada',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('arrachera-texana-importada',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Brisket Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-brisket-choice',2415.0,'MXN','$2,415.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-brisket-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-brisket-choice','https://casabrassa.mx/product/brisket-choice/','https://casabrassa.mx/wp-content/uploads/2021/01/brisket-sterling--scaled-e1696989619383-1024x614.jpg','assets/img/catalogo/brisket_choice.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-brisket-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('brisket-choice','BRISKET-CHOICE','Brisket Choice',1,'Brisket Choice – Sterling Silver
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-brisket-choice','INV-brisket-choice','IMG-brisket-choice','INFO-brisket-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('brisket-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('brisket-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('brisket-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('brisket-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Brisket Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-brisket-nacional',1350.0,'MXN','$1,350.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-brisket-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-brisket-nacional','https://casabrassa.mx/product/brisket-nacional/','https://casabrassa.mx/wp-content/uploads/2022/06/brisket-nacional-1.jpg','assets/img/catalogo/brisket_nacional.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-brisket-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('brisket-nacional','BRISKET-NACIONAL','Brisket Nacional',1,'Brisket Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-brisket-nacional','INV-brisket-nacional','IMG-brisket-nacional','INFO-brisket-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('brisket-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('brisket-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('brisket-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Cabeza De Lomo De Puerco
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-cabeza-de-lomo-de-puerco',869.0,'MXN','$869.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-cabeza-de-lomo-de-puerco','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-cabeza-de-lomo-de-puerco','https://casabrassa.mx/product/cabeza-de-lomo-de-puerco/','https://casabrassa.mx/wp-content/uploads/2022/06/cabeza-de-lomo-de-puerco-1.jpg','assets/img/catalogo/cabeza_de_lomo_de_puerco.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-cabeza-de-lomo-de-puerco','1 kg','México','N/A',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('cabeza-de-lomo-de-puerco','CABEZA-DE-LOMO-DE-PUERCO','Cabeza De Lomo De Puerco',1,'Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.','PRECIO-cabeza-de-lomo-de-puerco','INV-cabeza-de-lomo-de-puerco','IMG-cabeza-de-lomo-de-puerco','INFO-cabeza-de-lomo-de-puerco',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cabeza-de-lomo-de-puerco',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cabeza-de-lomo-de-puerco',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- Cabreria - Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-cabreria-nacional',760.0,'MXN','$760.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-cabreria-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-cabreria-nacional','https://casabrassa.mx/product/cabreria-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/cabreria-nacional-4-1-1024x683.jpg','assets/img/catalogo/cabreria_nacional.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-cabreria-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('cabreria-nacional','CABRERIA-NACIONAL','Cabreria - Nacional',1,'Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.','PRECIO-cabreria-nacional','INV-cabreria-nacional','IMG-cabreria-nacional','INFO-cabreria-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cabreria-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cabreria-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cabreria-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Caña De Lomo De Puerco
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-cana-de-lomo-de-puerco',195.0,'MXN','$195.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-cana-de-lomo-de-puerco','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-cana-de-lomo-de-puerco','https://casabrassa.mx/product/cana-de-lomo-de-puerco/','https://casabrassa.mx/wp-content/uploads/2021/01/filete-nacional-3-1024x683.jpg','assets/img/catalogo/caña_de_lomo_de_puerco.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-cana-de-lomo-de-puerco','1 kg','México','N/A',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('cana-de-lomo-de-puerco','CANA-DE-LOMO-DE-PUERCO','Caña De Lomo De Puerco',1,'Caña De Lomo De Puerco
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-cana-de-lomo-de-puerco','INV-cana-de-lomo-de-puerco','IMG-cana-de-lomo-de-puerco','INFO-cana-de-lomo-de-puerco',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cana-de-lomo-de-puerco',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cana-de-lomo-de-puerco',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- Cecina de Yecapixtla
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-cecina-de-yecapixtla',540.0,'MXN','$540.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-cecina-de-yecapixtla','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-cecina-de-yecapixtla','https://casabrassa.mx/product/cecina-de-yecapixtla/','https://casabrassa.mx/wp-content/uploads/2021/01/cecina-2-1-1024x683.jpg','assets/img/catalogo/cecina-de-yecapixtla-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-cecina-de-yecapixtla','1 kg','Yecapixtla','0',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('cecina-de-yecapixtla','CECINA-DE-YECAPIXTLA','Cecina de Yecapixtla',1,'Cecina de Yecapixtla
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Cecina de Yecapixtla
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
T-Bone High Choice
Porterhouse High Choice
Sirloin High Choice
RibEye Prime
NewYork Prime','PRECIO-cecina-de-yecapixtla','INV-cecina-de-yecapixtla','IMG-cecina-de-yecapixtla','INFO-cecina-de-yecapixtla',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cecina-de-yecapixtla',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cecina-de-yecapixtla',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cecina-de-yecapixtla',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Costilla Cargada - Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-costilla-cargada-nacional',360.0,'MXN','$360.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-costilla-cargada-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-costilla-cargada-nacional','https://casabrassa.mx/product/costilla-cargada-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/costilla-cargada-1024x683.jpg','assets/img/catalogo/costilla-cargada-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-costilla-cargada-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('costilla-cargada-nacional','COSTILLA-CARGADA-NACIONAL','Costilla Cargada - Nacional',1,'COSTILLA CARGADA:
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Conoce nuestra línea de carne importada de Estados Unidos:
Arrachera Natural Importada
Arrachera Texana Importada
Cowboy Choice
RibEye Francés Choice
Sirloin Choice
Síguenos en Facebook','PRECIO-costilla-cargada-nacional','INV-costilla-cargada-nacional','IMG-costilla-cargada-nacional','INFO-costilla-cargada-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('costilla-cargada-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('costilla-cargada-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('costilla-cargada-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Costilla Descarnada - Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-costilla-descarnada-nacional',260.0,'MXN','$260.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-costilla-descarnada-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-costilla-descarnada-nacional','https://casabrassa.mx/product/costilla-descarnada-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/costilla-descarnada-2-2-1024x683.jpg','assets/img/catalogo/costilla-descarnada-2-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-costilla-descarnada-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('costilla-descarnada-nacional','COSTILLA-DESCARNADA-NACIONAL','Costilla Descarnada - Nacional',1,'Costilla Descarnada – Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
T-Bone High Choice
Porterhouse High Choice
Sirloin High Choice
RibEye Prime
NewYork Prime','PRECIO-costilla-descarnada-nacional','INV-costilla-descarnada-nacional','IMG-costilla-descarnada-nacional','INFO-costilla-descarnada-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('costilla-descarnada-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('costilla-descarnada-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('costilla-descarnada-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Costilla Sin Hueso - Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-costilla-sin-hueso-nacional',295.0,'MXN','$295.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-costilla-sin-hueso-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-costilla-sin-hueso-nacional','https://casabrassa.mx/product/costilla-s-hueso-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/costilla-sin-hueso-2-1024x683.jpg','assets/img/catalogo/costilla-sin-hueso-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-costilla-sin-hueso-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('costilla-sin-hueso-nacional','COSTILLA-SIN-HUESO-NACIONAL','Costilla Sin Hueso - Nacional',1,'Costilla Sin Hueso – Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
T-Bone High Choice
Porterhouse High Choice
Sirloin High Choice
RibEye Prime
NewYork Prime','PRECIO-costilla-sin-hueso-nacional','INV-costilla-sin-hueso-nacional','IMG-costilla-sin-hueso-nacional','INFO-costilla-sin-hueso-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('costilla-sin-hueso-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('costilla-sin-hueso-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('costilla-sin-hueso-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Costilla St. Louis
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-costilla-st-louis',198.0,'MXN','$198.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-costilla-st-louis','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-costilla-st-louis','https://casabrassa.mx/product/costilla-st-louise/','https://casabrassa.mx/wp-content/uploads/2022/06/costilla-st.-louis.jpg','assets/img/catalogo/costilla-st-louis.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-costilla-st-louis','1 kg','México','N/A',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('costilla-st-louis','COSTILLA-ST-LOUIS','Costilla St. Louis',1,'Costilla St. Louis
Descripción: Empacado individualmente o en paquetes de 2 piezas y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-costilla-st-louis','INV-costilla-st-louis','IMG-costilla-st-louis','INFO-costilla-st-louis',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('costilla-st-louis',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('costilla-st-louis',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- Cowboy Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-cowboy-choice',513.0,'MXN','$513.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-cowboy-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-cowboy-choice','https://casabrassa.mx/product/cowboy-choice/','https://casabrassa.mx/wp-content/uploads/2021/01/cowboy-sterling-scaled-e1696989321641-1024x618.jpg','assets/img/catalogo/cowboy-choice-sterling-silver-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-cowboy-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('cowboy-choice','COWBOY-CHOICE','Cowboy Choice',1,'Cowboy High Choice
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-cowboy-choice','INV-cowboy-choice','IMG-cowboy-choice','INFO-cowboy-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cowboy-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cowboy-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cowboy-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cowboy-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Cowboy Importado - Añejo
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-cowboy-importado-anejo',683.0,'MXN','$683.00 - $2,095.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-cowboy-importado-anejo','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-cowboy-importado-anejo','https://casabrassa.mx/product/cowboy-importado-anejo/','https://casabrassa.mx/wp-content/uploads/2021/04/cowboy-anejo-sterling-scaled-e1696989418253-1024x759.jpg','assets/img/catalogo/cowboy-a-ejo-sterling-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-cowboy-importado-anejo','1 kg',NULL,NULL,NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('cowboy-importado-anejo','COWBOY-IMPORTADO-ANEJO','Cowboy Importado - Añejo',1,'Maduración.
Se recomienda como mínimo 28 días, sin embargo, se podría consumir desde los 21 días. Menor a esto no se recomienda ya que las fibras aún no han terminado de consumirse por lo que la suavidad pudiera verse afectada.
Tipo de carne:
Solo se recomienda madurar cortes de gran calidad ya que el proceso requiere de carne con alto contenido graso (marmoleo)','PRECIO-cowboy-importado-anejo','INV-cowboy-importado-anejo','IMG-cowboy-importado-anejo','INFO-cowboy-importado-anejo',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cowboy-importado-anejo',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cowboy-importado-anejo',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cowboy-importado-anejo',(SELECT categoria_id FROM categoria WHERE nombre='Añejos'));

-- Cowboy - Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-cowboy-nacional',713.0,'MXN','$713.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-cowboy-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-cowboy-nacional','https://casabrassa.mx/product/cowboy-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/cowboy-nacional--1024x684.jpg','assets/img/catalogo/cowboy-nacional-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-cowboy-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('cowboy-nacional','COWBOY-NACIONAL','Cowboy - Nacional',1,'Cowboy – Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
T-Bone High Choice
Porterhouse High Choice
Sirloin High Choice
RibEye Prime
NewYork Prime','PRECIO-cowboy-nacional','INV-cowboy-nacional','IMG-cowboy-nacional','INFO-cowboy-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cowboy-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cowboy-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('cowboy-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Diezmillo S/Hueso Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-diezmillo-s-hueso-nacional',325.0,'MXN','$325.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-diezmillo-s-hueso-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-diezmillo-s-hueso-nacional','https://casabrassa.mx/product/diezmillo-s-hueso-nacional/','','assets/img/catalogo/diezmillo_shueso_nacional.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-diezmillo-s-hueso-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('diezmillo-s-hueso-nacional','DIEZMILLO-S-HUESO-NACIONAL','Diezmillo S/Hueso Nacional',1,'DIEZMILLO S/HUESO NACIONAL
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Conoce nuestra línea de carne importada de Estados Unidos:
Arrachera Natural Importada
Arrachera Texana Importada
Cowboy Choice
RibEye Francés Choice
Sirloin Choice
Síguenos en Facebook','PRECIO-diezmillo-s-hueso-nacional','INV-diezmillo-s-hueso-nacional','IMG-diezmillo-s-hueso-nacional','INFO-diezmillo-s-hueso-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('diezmillo-s-hueso-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('diezmillo-s-hueso-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('diezmillo-s-hueso-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Filete Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-filete-choice',998.0,'MXN','$998.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-filete-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-filete-choice','https://casabrassa.mx/product/filete-choice/','https://casabrassa.mx/wp-content/uploads/2021/01/filete-sterling--scaled-e1696989179921-1024x616.jpg','assets/img/catalogo/filete-choice-sterling-silver-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-filete-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('filete-choice','FILETE-CHOICE','Filete Choice',1,'Filete Choice – Sterling Silver
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-filete-choice','INV-filete-choice','IMG-filete-choice','INFO-filete-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('filete-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('filete-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('filete-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('filete-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Filete Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-filete-nacional',473.0,'MXN','$473.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-filete-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-filete-nacional','https://casabrassa.mx/product/filete-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/filete-nacional-2-1-1024x683.jpg','assets/img/catalogo/filete-nacional-2-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-filete-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('filete-nacional','FILETE-NACIONAL','Filete Nacional',1,'Filete Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-filete-nacional','INV-filete-nacional','IMG-filete-nacional','INFO-filete-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('filete-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('filete-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('filete-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Hamburguesa de Brisket Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-hamburguesa-de-brisket-nacional',290.0,'MXN','$290.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-hamburguesa-de-brisket-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-hamburguesa-de-brisket-nacional','https://casabrassa.mx/product/hamburguesa-de-brisket-nacional/','https://casabrassa.mx/wp-content/uploads/2022/06/hamburguesa-de-brisket-nacional.jpg','assets/img/catalogo/hamburguesa-de-brisket-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-hamburguesa-de-brisket-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('hamburguesa-de-brisket-nacional','HAMBURGUESA-DE-BRISKET-NACIONAL','Hamburguesa de Brisket Nacional',1,'Hamburguesa de Brisket Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
T-Bone High Choice
Porterhouse High Choice
Sirloin High Choice
RibEye Prime
NewYork Prime','PRECIO-hamburguesa-de-brisket-nacional','INV-hamburguesa-de-brisket-nacional','IMG-hamburguesa-de-brisket-nacional','INFO-hamburguesa-de-brisket-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-brisket-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-brisket-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-brisket-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Hamburguesa De La Casa
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-hamburguesa-de-la-casa',295.0,'MXN','$295.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-hamburguesa-de-la-casa','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-hamburguesa-de-la-casa','https://casabrassa.mx/product/hamburguesa-de-la-casa/','https://casabrassa.mx/wp-content/uploads/2022/06/hamburguesa-gourmet-1.jpg','assets/img/catalogo/hamburguesa-gourmet-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-hamburguesa-de-la-casa','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('hamburguesa-de-la-casa','HAMBURGUESA-DE-LA-CASA','Hamburguesa De La Casa',1,'Hamburguesa de la Casa Gourmet
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
Arrachera Natural Importada
Arrachera Texana Importada
Cowboy Choice
RibEye Francés Choice
Sirloin Choice','PRECIO-hamburguesa-de-la-casa','INV-hamburguesa-de-la-casa','IMG-hamburguesa-de-la-casa','INFO-hamburguesa-de-la-casa',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-la-casa',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-la-casa',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-la-casa',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Hamburguesa de Short Rib Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-hamburguesa-de-short-rib-nacional',290.0,'MXN','$290.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-hamburguesa-de-short-rib-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-hamburguesa-de-short-rib-nacional','https://casabrassa.mx/product/hamburguesa-de-short-rib-nacional/','https://casabrassa.mx/wp-content/uploads/2022/06/hamburguesa-de-short-rib-nacional.jpg','assets/img/catalogo/hamburguesa-de-short-rib-nacional-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-hamburguesa-de-short-rib-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('hamburguesa-de-short-rib-nacional','HAMBURGUESA-DE-SHORT-RIB-NACIONAL','Hamburguesa de Short Rib Nacional',1,'Hamburguesa de Short Rib Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
Arrachera Natural Importada
Arrachera Texana Importada
Cowboy Choice
RibEye Francés Choice
Sirloin Choice','PRECIO-hamburguesa-de-short-rib-nacional','INV-hamburguesa-de-short-rib-nacional','IMG-hamburguesa-de-short-rib-nacional','INFO-hamburguesa-de-short-rib-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-short-rib-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-short-rib-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-short-rib-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Hamburguesa de Sirloin con Tocino Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-hamburguesa-de-sirloin-con-tocino-nacional',290.0,'MXN','$290.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-hamburguesa-de-sirloin-con-tocino-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-hamburguesa-de-sirloin-con-tocino-nacional','https://casabrassa.mx/product/hamburguesa-de-sirloin-con-tocino-nacional/','https://casabrassa.mx/wp-content/uploads/2022/06/hamburguesa-de-sirlon-con-tocino-nacional.jpg','assets/img/catalogo/hamburguesa-de-sirloin-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-hamburguesa-de-sirloin-con-tocino-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('hamburguesa-de-sirloin-con-tocino-nacional','HAMBURGUESA-DE-SIRLOIN-CON-TOCINO-NACIONAL','Hamburguesa de Sirloin con Tocino Nacional',1,'Hamburguesa de Sirloin con Tocino Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-hamburguesa-de-sirloin-con-tocino-nacional','INV-hamburguesa-de-sirloin-con-tocino-nacional','IMG-hamburguesa-de-sirloin-con-tocino-nacional','INFO-hamburguesa-de-sirloin-con-tocino-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-sirloin-con-tocino-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-sirloin-con-tocino-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-de-sirloin-con-tocino-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Hamburguesa Clásica
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-hamburguesa-clasica',195.0,'MXN','$195.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-hamburguesa-clasica','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-hamburguesa-clasica','https://casabrassa.mx/product/hamburguesa-estandar/','https://casabrassa.mx/wp-content/uploads/2021/01/hamburguesa-clasica--1024x683.jpg','assets/img/catalogo/hamburguesa-cl-sica-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-hamburguesa-clasica','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('hamburguesa-clasica','HAMBURGUESA-CLASICA','Hamburguesa Clásica',1,'Hamburguesa Clásica
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
T-Bone High Choice
Porterhouse High Choice
Sirloin High Choice
RibEye Prime
NewYork Prime','PRECIO-hamburguesa-clasica','INV-hamburguesa-clasica','IMG-hamburguesa-clasica','INFO-hamburguesa-clasica',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-clasica',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-clasica',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('hamburguesa-clasica',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Lechón Tierno
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-lechon-tierno',1985.0,'MXN','$1,985.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-lechon-tierno','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-lechon-tierno','https://casabrassa.mx/product/lechon-tierno/','https://casabrassa.mx/wp-content/uploads/2022/06/LECHON-TIERNO-1.jpg','assets/img/catalogo/lech-n-tierno-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-lechon-tierno','6 kg','México','N/A',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('lechon-tierno','LECHON-TIERNO','Lechón Tierno',1,'Lechón Tierno
Descripción: Pieza entera con peso estimado entre 5 y 6Kg
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-lechon-tierno','INV-lechon-tierno','IMG-lechon-tierno','INFO-lechon-tierno',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('lechon-tierno',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('lechon-tierno',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- Molida 100% Nacional | Casa Brassa Mx
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-molida-100-nacional-casa-brassa-mx',295.0,'MXN','$295.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-molida-100-nacional-casa-brassa-mx','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-molida-100-nacional-casa-brassa-mx','https://casabrassa.mx/product/molida-100-nacional/','https://casabrassa.mx/wp-content/uploads/2022/06/MOLIDA-100-NACIONAL.jpg','assets/img/catalogo/molida-100-nacional-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-molida-100-nacional-casa-brassa-mx','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('molida-100-nacional-casa-brassa-mx','MOLIDA-100-NACIONAL-CASA-BRASSA-MX','Molida 100% Nacional | Casa Brassa Mx',1,'Molida 100% Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
Arrachera Natural Importada
Arrachera Texana Importada
Cowboy Choice
RibEye Francés Choice
Sirloin Choice','PRECIO-molida-100-nacional-casa-brassa-mx','INV-molida-100-nacional-casa-brassa-mx','IMG-molida-100-nacional-casa-brassa-mx','INFO-molida-100-nacional-casa-brassa-mx',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molida-100-nacional-casa-brassa-mx',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molida-100-nacional-casa-brassa-mx',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molida-100-nacional-casa-brassa-mx',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Molida 80/20 Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-molida-80-20-nacional',260.0,'MXN','$260.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-molida-80-20-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-molida-80-20-nacional','https://casabrassa.mx/product/molida-80-20-nacional/','https://casabrassa.mx/wp-content/uploads/2022/06/molida-80-20-nacional.jpg','assets/img/catalogo/molida_8020_nacional.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-molida-80-20-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('molida-80-20-nacional','MOLIDA-80-20-NACIONAL','Molida 80/20 Nacional',1,'Molida 80/20 Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
Arrachera Natural Importada
Arrachera Texana Importada
Cowboy Choice
RibEye Francés Choice
Sirloin Choice','PRECIO-molida-80-20-nacional','INV-molida-80-20-nacional','IMG-molida-80-20-nacional','INFO-molida-80-20-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molida-80-20-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molida-80-20-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molida-80-20-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Molida 90/10 Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-molida-90-10-nacional',280.0,'MXN','$280.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-molida-90-10-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-molida-90-10-nacional','https://casabrassa.mx/product/molida-90-10-nacional/','https://casabrassa.mx/wp-content/uploads/2022/06/MOLIDA-90-10-NACIONAL.jpg','assets/img/catalogo/molida_9010_nacional.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-molida-90-10-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('molida-90-10-nacional','MOLIDA-90-10-NACIONAL','Molida 90/10 Nacional',1,'Molida 90/10 Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-molida-90-10-nacional','INV-molida-90-10-nacional','IMG-molida-90-10-nacional','INFO-molida-90-10-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molida-90-10-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molida-90-10-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molida-90-10-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Molleja
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-molleja',365.0,'MXN','$365.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-molleja','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-molleja','https://casabrassa.mx/product/molleja-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/molleja-1024x683.jpg','assets/img/catalogo/molleja.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-molleja','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('molleja','MOLLEJA','Molleja',1,'Molleja
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
T-Bone High Choice
Porterhouse High Choice
Sirloin High Choice
RibEye Prime
NewYork Prime','PRECIO-molleja','INV-molleja','IMG-molleja','INFO-molleja',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molleja',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molleja',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('molleja',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Morcilla De Cebolla
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-morcilla-de-cebolla',38.0,'MXN','$38.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-morcilla-de-cebolla','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-morcilla-de-cebolla','https://casabrassa.mx/product/morcilla-de-cebolla/','https://casabrassa.mx/wp-content/uploads/2022/06/MORCILLA-DE-CEBOLLA.jpg','assets/img/catalogo/morcilla_de_cebolla.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-morcilla-de-cebolla','1 kg','Chihuahua','N/A',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('morcilla-de-cebolla','MORCILLA-DE-CEBOLLA','Morcilla De Cebolla',1,'Morcilla De Cebolla
Descripción: Paquetes con 2 piezas (190 a 200gr aprox) y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-morcilla-de-cebolla','INV-morcilla-de-cebolla','IMG-morcilla-de-cebolla','INFO-morcilla-de-cebolla',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('morcilla-de-cebolla',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('morcilla-de-cebolla',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- New York Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-new-york-choice',695.0,'MXN','$695.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-new-york-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-new-york-choice','https://casabrassa.mx/product/new-york-choice/','https://casabrassa.mx/wp-content/uploads/2021/01/newyork-sterling-scaled-e1696988954442-1024x616.jpg','assets/img/catalogo/new_york_choice.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-new-york-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('new-york-choice','NEW-YORK-CHOICE','New York Choice',1,'New York Choice
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.','PRECIO-new-york-choice','INV-new-york-choice','IMG-new-york-choice','INFO-new-york-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('new-york-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('new-york-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('new-york-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('new-york-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- New York - Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-new-york-nacional',415.0,'MXN','$415.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-new-york-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-new-york-nacional','https://casabrassa.mx/product/new-york-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/newyork-nacional-3-1024x683.jpg','assets/img/catalogo/new_york_nacional.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-new-york-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('new-york-nacional','NEW-YORK-NACIONAL','New York - Nacional',1,'New York – Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
Arrachera Natural Importada
Arrachera Texana Importada
Cowboy Choice
RibEye Francés Choice
Sirloin Choice','PRECIO-new-york-nacional','INV-new-york-nacional','IMG-new-york-nacional','INFO-new-york-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('new-york-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('new-york-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('new-york-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- New York Prime
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-new-york-prime',835.0,'MXN','$835.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-new-york-prime','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-new-york-prime','https://casabrassa.mx/product/new-york-prime/','https://casabrassa.mx/wp-content/uploads/2021/01/newyork-prime-scaled-e1696989051709-1024x614.jpg','assets/img/catalogo/new_york_prime.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-new-york-prime','1 kg','USA','Prime','Pinot Noir Americano') ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('new-york-prime','NEW-YORK-PRIME','New York Prime',1,'New York Prime
Raza: Black Angus 100%
Alimentación: Grano y Pastizales
HGP free, Libre de Hormonas y Aceleradores
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-new-york-prime','INV-new-york-prime','IMG-new-york-prime','INFO-new-york-prime',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('new-york-prime',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('new-york-prime',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('new-york-prime',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('new-york-prime',(SELECT categoria_id FROM categoria WHERE nombre='Prime'));

-- Panceta
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-panceta',495.0,'MXN','$495.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-panceta','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-panceta','https://casabrassa.mx/product/panceta/','https://casabrassa.mx/wp-content/uploads/2021/01/panceta-2-1-1024x683.jpg','assets/img/catalogo/panceta.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-panceta','1 kg','México','N/A',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('panceta','PANCETA','Panceta',1,'Panceta
Descripción: Se rebana conforme la necesidad y cantidad requerida por el cliente y es sellado al vacío.
Condiciones: El producto se encuentra refrigerado para conservar el sabor.
Casa Brassa
Síguenos en Facebook','PRECIO-panceta','INV-panceta','IMG-panceta','INFO-panceta',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('panceta',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('panceta',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- Picaña Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-picana-choice',1131.0,'MXN','$1,131.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-picana-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-picana-choice','https://casabrassa.mx/product/picana-sterling-silver/','https://casabrassa.mx/wp-content/uploads/2021/01/picana-sterling-4-1024x683.jpg','assets/img/catalogo/picaña_choice.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-picana-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('picana-choice','PICANA-CHOICE','Picaña Choice',1,'Picaña Choice
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-picana-choice','INV-picana-choice','IMG-picana-choice','INFO-picana-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('picana-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('picana-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('picana-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('picana-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Pierna De Cerdo S/Hueso
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-pierna-de-cerdo-s-hueso',1200.0,'MXN','$1,200.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-pierna-de-cerdo-s-hueso','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-pierna-de-cerdo-s-hueso','https://casabrassa.mx/product/pierna-de-cerdo-s-hueso/','https://casabrassa.mx/wp-content/uploads/2022/06/PIERNA-DE-CERDO-Sin-HUESO.jpg','assets/img/catalogo/pierna_de_cerdo_shueso.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-pierna-de-cerdo-s-hueso','1 kg','México','N/A',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('pierna-de-cerdo-s-hueso','PIERNA-DE-CERDO-S-HUESO','Pierna De Cerdo S/Hueso',1,'Pierna De Cerdo S/Hueso
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-pierna-de-cerdo-s-hueso','INV-pierna-de-cerdo-s-hueso','IMG-pierna-de-cerdo-s-hueso','INFO-pierna-de-cerdo-s-hueso',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('pierna-de-cerdo-s-hueso',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('pierna-de-cerdo-s-hueso',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- Pork Belly Premium
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-pork-belly-premium',195.0,'MXN','$195.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-pork-belly-premium','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-pork-belly-premium','https://casabrassa.mx/product/pork-belly-premium/','https://casabrassa.mx/wp-content/uploads/2021/01/pork-belly--1024x683.jpg','assets/img/catalogo/pork-belly-premium-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-pork-belly-premium','1 kg','México','N/A',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('pork-belly-premium','PORK-BELLY-PREMIUM','Pork Belly Premium',1,'Pork Belly Premium
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-pork-belly-premium','INV-pork-belly-premium','IMG-pork-belly-premium','INFO-pork-belly-premium',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('pork-belly-premium',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('pork-belly-premium',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- Pork Butt
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-pork-butt',891.0,'MXN','$891.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-pork-butt','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-pork-butt','https://casabrassa.mx/product/pork-butt/','https://casabrassa.mx/wp-content/uploads/2021/01/pork-butt-1024x683.jpg','assets/img/catalogo/pork-butt-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-pork-butt','1 kg','México','N/A',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('pork-butt','PORK-BUTT','Pork Butt',1,'Pork Butt
Descripción: Pieza entera entre 2.5 y 4.5 Kg empacado y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-pork-butt','INV-pork-butt','IMG-pork-butt','INFO-pork-butt',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('pork-butt',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('pork-butt',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- Pork Chop
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-pork-chop',561.0,'MXN','$561.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-pork-chop','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-pork-chop','https://casabrassa.mx/product/pork-chop/','https://casabrassa.mx/wp-content/uploads/2021/08/pork-chop--1024x683.jpg','assets/img/catalogo/pork-chop-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-pork-chop','1 kg',NULL,NULL,NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('pork-chop','PORK-CHOP','Pork Chop',1,'Pork Chop
Casa Brassa
Síguenos en Facebook','PRECIO-pork-chop','INV-pork-chop','IMG-pork-chop','INFO-pork-chop',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('pork-chop',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('pork-chop',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- Porterhouse Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-porterhouse-choice',714.0,'MXN','$714.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-porterhouse-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-porterhouse-choice','https://casabrassa.mx/product/porterhouse-choice/','https://casabrassa.mx/wp-content/uploads/2021/01/porterhouse-sterling-scaled-e1696988701228-1024x616.jpg','assets/img/catalogo/porterhouse_choice.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-porterhouse-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('porterhouse-choice','PORTERHOUSE-CHOICE','Porterhouse Choice',1,'Porterhouse High
Choice
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-porterhouse-choice','INV-porterhouse-choice','IMG-porterhouse-choice','INFO-porterhouse-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('porterhouse-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('porterhouse-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('porterhouse-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('porterhouse-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Porterhouse Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-porterhouse-nacional',387.0,'MXN','$387.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-porterhouse-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-porterhouse-nacional','https://casabrassa.mx/product/porterhouse-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/porterhouse-nacional-2-1-1024x683.jpg','assets/img/catalogo/porterhouse-nacional-2-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-porterhouse-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('porterhouse-nacional','PORTERHOUSE-NACIONAL','Porterhouse Nacional',1,'Porterhouse Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-porterhouse-nacional','INV-porterhouse-nacional','IMG-porterhouse-nacional','INFO-porterhouse-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('porterhouse-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('porterhouse-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('porterhouse-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Pulpa Negra Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-pulpa-negra-nacional',250.0,'MXN','$250.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-pulpa-negra-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-pulpa-negra-nacional','https://casabrassa.mx/product/pulpa-negra-nacional/','https://casabrassa.mx/wp-content/uploads/2022/06/PULPA-NEGRA-NACIONAL.jpg','assets/img/catalogo/pulpa-negra-nacional-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-pulpa-negra-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('pulpa-negra-nacional','PULPA-NEGRA-NACIONAL','Pulpa Negra Nacional',1,'Pulpa Negra Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
Arrachera Natural Importada
Arrachera Texana Importada
Cowboy Choice
RibEye Francés Choice
Sirloin Choice','PRECIO-pulpa-negra-nacional','INV-pulpa-negra-nacional','IMG-pulpa-negra-nacional','INFO-pulpa-negra-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('pulpa-negra-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('pulpa-negra-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('pulpa-negra-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Rib Eye Prime Argentina
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-rib-eye-prime-argentina',897.0,'MXN','$897.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-rib-eye-prime-argentina','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-rib-eye-prime-argentina','https://casabrassa.mx/product/rib-eye-prime-argentina/','','assets/img/catalogo/rib_eye_prime_argentina.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-rib-eye-prime-argentina','1 kg','Argentina',NULL,'Merlot con Barrica, Malbec con Barrica') ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('rib-eye-prime-argentina','RIB-EYE-PRIME-ARGENTINA','Rib Eye Prime Argentina',1,'Rib Eye Prime Argentina
Raza: Black Angus.
Alimentación: _____
Maduración: ____
Descripción: _____
Embalaje: _____
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-rib-eye-prime-argentina','INV-rib-eye-prime-argentina','IMG-rib-eye-prime-argentina','INFO-rib-eye-prime-argentina',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('rib-eye-prime-argentina',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('rib-eye-prime-argentina',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('rib-eye-prime-argentina',(SELECT categoria_id FROM categoria WHERE nombre='Ultra Premium'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('rib-eye-prime-argentina',(SELECT categoria_id FROM categoria WHERE nombre='Argentina'));

-- RibEye Frances Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-ribeye-frances-choice',855.0,'MXN','$855.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-ribeye-frances-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-ribeye-frances-choice','https://casabrassa.mx/product/ribeye-frances-choice/','https://casabrassa.mx/wp-content/uploads/2021/01/ribeye-frances-importado-1024x683.jpg','assets/img/catalogo/ribeye-frances-importado-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-ribeye-frances-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('ribeye-frances-choice','RIBEYE-FRANCES-CHOICE','RibEye Frances Choice',1,'Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.','PRECIO-ribeye-frances-choice','INV-ribeye-frances-choice','IMG-ribeye-frances-choice','INFO-ribeye-frances-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('ribeye-frances-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('ribeye-frances-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('ribeye-frances-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('ribeye-frances-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- RibEye - Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-ribeye-nacional',440.0,'MXN','$440.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-ribeye-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-ribeye-nacional','https://casabrassa.mx/product/ribeye-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/ribeye-nacional-2-1-1024x683.jpg','assets/img/catalogo/ribeye-nacional-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-ribeye-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('ribeye-nacional','RIBEYE-NACIONAL','RibEye - Nacional',1,'RibEye – Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
T-Bone High Choice
Porterhouse High Choice
Sirloin High Choice
RibEye Prime
NewYork Prime','PRECIO-ribeye-nacional','INV-ribeye-nacional','IMG-ribeye-nacional','INFO-ribeye-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('ribeye-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('ribeye-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('ribeye-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- RibEye Prime
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-ribeye-prime',1135.0,'MXN','$1,135.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-ribeye-prime','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-ribeye-prime','https://casabrassa.mx/product/ribeye-prime/','https://casabrassa.mx/wp-content/uploads/2021/01/ribeye-prime-2-1-scaled-e1696988463678-1024x616.jpg','assets/img/catalogo/ribeye-prime-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-ribeye-prime','1 kg','USA','Prime','Pinot Noir Americano') ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('ribeye-prime','RIBEYE-PRIME','RibEye Prime',1,'RibEye Prime
Raza: Black Angus 100%
Alimentación: Grano y Pastizales
HGP free, Libre de Hormonas y Aceleradores
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-ribeye-prime','INV-ribeye-prime','IMG-ribeye-prime','INFO-ribeye-prime',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('ribeye-prime',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('ribeye-prime',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('ribeye-prime',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('ribeye-prime',(SELECT categoria_id FROM categoria WHERE nombre='Prime'));

-- Rib Eye Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-rib-eye-choice',695.0,'MXN','$695.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-rib-eye-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-rib-eye-choice','https://casabrassa.mx/product/ribeye-sterling-silver/','https://casabrassa.mx/wp-content/uploads/2021/01/ribeye-sterling-scaled-e1696988124933-1024x614.jpg','assets/img/catalogo/ribeye-choice-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-rib-eye-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('rib-eye-choice','RIB-EYE-CHOICE','Rib Eye Choice',1,'RibEye Choice
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-rib-eye-choice','INV-rib-eye-choice','IMG-rib-eye-choice','INFO-rib-eye-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('rib-eye-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('rib-eye-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('rib-eye-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('rib-eye-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Short Rib Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-short-rib-choice',580.0,'MXN','$580.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-short-rib-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-short-rib-choice','https://casabrassa.mx/product/short-rib-choice/','https://casabrassa.mx/wp-content/uploads/2021/01/shortrib-sterling-scaled-e1696988009173-1024x628.jpg','assets/img/catalogo/short-rib-choice-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-short-rib-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('short-rib-choice','SHORT-RIB-CHOICE','Short Rib Choice',1,'Short Rib Choice
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-short-rib-choice','INV-short-rib-choice','IMG-short-rib-choice','INFO-short-rib-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('short-rib-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('short-rib-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('short-rib-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('short-rib-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Sliders de RibEye Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-sliders-de-ribeye-choice',695.0,'MXN','$695.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-sliders-de-ribeye-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-sliders-de-ribeye-choice','https://casabrassa.mx/product/sliders-de-ribeye-choice/','https://casabrassa.mx/wp-content/uploads/2021/01/slider--1024x683.jpg','assets/img/catalogo/sliders-de-ribeye-choice-sterling-silver-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-sliders-de-ribeye-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('sliders-de-ribeye-choice','SLIDERS-DE-RIBEYE-CHOICE','Sliders de RibEye Choice',1,'Sliders de RibEye Choice
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.','PRECIO-sliders-de-ribeye-choice','INV-sliders-de-ribeye-choice','IMG-sliders-de-ribeye-choice','INFO-sliders-de-ribeye-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('sliders-de-ribeye-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('sliders-de-ribeye-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('sliders-de-ribeye-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('sliders-de-ribeye-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- T-Bone Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-t-bone-choice',620.0,'MXN','$620.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-t-bone-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-t-bone-choice','https://casabrassa.mx/product/t-bone-choice/','https://casabrassa.mx/wp-content/uploads/2021/01/t-bone-sterling-2-1-scaled-e1696987815970-1024x616.jpg','assets/img/catalogo/t-bone-choice-sterling-silver-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-t-bone-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('t-bone-choice','T-BONE-CHOICE','T-Bone Choice',1,'T-Bone Choice
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-t-bone-choice','INV-t-bone-choice','IMG-t-bone-choice','INFO-t-bone-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('t-bone-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('t-bone-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('t-bone-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('t-bone-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- T-Bone Nacional por Casa Brassa Mx
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-t-bone-nacional-por-casa-brassa-mx',324.0,'MXN','$324.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-t-bone-nacional-por-casa-brassa-mx','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-t-bone-nacional-por-casa-brassa-mx','https://casabrassa.mx/product/t-bone-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/t-bone-nacional-3-1024x683.jpg','assets/img/catalogo/t-bone-nacional-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-t-bone-nacional-por-casa-brassa-mx','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('t-bone-nacional-por-casa-brassa-mx','T-BONE-NACIONAL-POR-CASA-BRASSA-MX','T-Bone Nacional por Casa Brassa Mx',1,'T-Bone Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El T-Bone Nacional se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa Mx
Síguenos en Redes Sociales','PRECIO-t-bone-nacional-por-casa-brassa-mx','INV-t-bone-nacional-por-casa-brassa-mx','IMG-t-bone-nacional-por-casa-brassa-mx','INFO-t-bone-nacional-por-casa-brassa-mx',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('t-bone-nacional-por-casa-brassa-mx',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('t-bone-nacional-por-casa-brassa-mx',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('t-bone-nacional-por-casa-brassa-mx',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Tocino
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-tocino',495.0,'MXN','$495.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-tocino','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-tocino','https://casabrassa.mx/product/tocino-applewood-o-red-lable/','https://casabrassa.mx/wp-content/uploads/2021/01/tocino-2-1024x683.jpg','assets/img/catalogo/tocino-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-tocino','1 kg','México','N/A',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('tocino','TOCINO','Tocino',1,'Tocino
Descripción: Se rebana conforme la necesidad y cantidad requerida por el cliente y es sellado al vacío.
Condiciones: El producto se encuentra refrigerado para conservar el sabor.
Casa Brassa
Síguenos en Facebook','PRECIO-tocino','INV-tocino','IMG-tocino','INFO-tocino',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tocino',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tocino',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- Tomahawk Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-tomahawk-choice',1313.0,'MXN','$1,313.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-tomahawk-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-tomahawk-choice','https://casabrassa.mx/product/tomahawk-choice-sterling-silver/','https://casabrassa.mx/wp-content/uploads/2021/01/tomahawk-importado-scaled-e1696987707207-1024x618.jpg','assets/img/catalogo/tomahawk-choice-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-tomahawk-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('tomahawk-choice','TOMAHAWK-CHOICE','Tomahawk Choice',1,'Tomahawk Choice
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.','PRECIO-tomahawk-choice','INV-tomahawk-choice','IMG-tomahawk-choice','INFO-tomahawk-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tomahawk-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tomahawk-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tomahawk-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tomahawk-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Tomahawk De Cerdo
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-tomahawk-de-cerdo',75.0,'MXN','$75.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-tomahawk-de-cerdo','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-tomahawk-de-cerdo','https://casabrassa.mx/product/tomahawk-de-cerdo/','https://casabrassa.mx/wp-content/uploads/2021/01/tomahawk-de-cerdo-2-1-1024x683.jpg','assets/img/catalogo/tomahawk-de-cerdo-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-tomahawk-de-cerdo','0.35 kg','México','N/A',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('tomahawk-de-cerdo','TOMAHAWK-DE-CERDO','Tomahawk De Cerdo',1,'Tomahawk de Cerdo
Descripción: Empacado individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-tomahawk-de-cerdo','INV-tomahawk-de-cerdo','IMG-tomahawk-de-cerdo','INFO-tomahawk-de-cerdo',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tomahawk-de-cerdo',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tomahawk-de-cerdo',(SELECT categoria_id FROM categoria WHERE nombre='Cerdo'));

-- Tomahawk Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-tomahawk-nacional',954.0,'MXN','$954.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-tomahawk-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-tomahawk-nacional','https://casabrassa.mx/product/tomahawk-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/tomahawk-nacional-2-1-1024x683.jpg','assets/img/catalogo/tomahawk-nacional-2-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-tomahawk-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('tomahawk-nacional','TOMAHAWK-NACIONAL','Tomahawk Nacional',1,'Tomahawk Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-tomahawk-nacional','INV-tomahawk-nacional','IMG-tomahawk-nacional','INFO-tomahawk-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tomahawk-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tomahawk-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tomahawk-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Sirloin Choice
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-sirloin-choice',346.0,'MXN','$346.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-sirloin-choice','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-sirloin-choice','https://casabrassa.mx/product/top-sirloin-choice/','https://casabrassa.mx/wp-content/uploads/2021/01/sirloin-sterling-2-1-scaled-e1696987917971-1024x620.jpg','assets/img/catalogo/sirloin-choice-sterling-silver-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-sirloin-choice','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('sirloin-choice','SIRLOIN-CHOICE','Sirloin Choice',1,'Sirloin Choice
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.','PRECIO-sirloin-choice','INV-sirloin-choice','IMG-sirloin-choice','INFO-sirloin-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('sirloin-choice',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('sirloin-choice',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('sirloin-choice',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('sirloin-choice',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Sirloin Nacional
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-sirloin-nacional',310.0,'MXN','$310.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-sirloin-nacional','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-sirloin-nacional','https://casabrassa.mx/product/top-sirloin-nacional/','https://casabrassa.mx/wp-content/uploads/2021/01/sirloin-nacional-2-1024x683.jpg','assets/img/catalogo/top-sirloin-nacional-top-sirloin-corte-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-sirloin-nacional','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('sirloin-nacional','SIRLOIN-NACIONAL','Sirloin Nacional',1,'Sirloin Nacional
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Conoce nuestra línea de carne importada de Estados Unidos:
Arrachera Natural Importada
Arrachera Texana Importada
Cowboy Choice
RibEye Francés Choice
Sirloin Choice','PRECIO-sirloin-nacional','INV-sirloin-nacional','IMG-sirloin-nacional','INFO-sirloin-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('sirloin-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('sirloin-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('sirloin-nacional',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Tuetano
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-tuetano',133.0,'MXN','$133.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-tuetano','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-tuetano','https://casabrassa.mx/product/tuetano/','https://casabrassa.mx/wp-content/uploads/2021/01/tuetano--1024x683.jpg','assets/img/catalogo/tuetano.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-tuetano','1 kg','Chihuahua','Suprema de Engorda',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('tuetano','TUETANO','Tuetano',1,'Tuetano
Raza: Angus Black, Hereford, Charolesa, Limousin. No mayor a 30 meses.
Alimentación: 90 días con Grano
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-tuetano','INV-tuetano','IMG-tuetano','INFO-tuetano',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tuetano',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tuetano',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('tuetano',(SELECT categoria_id FROM categoria WHERE nombre='Nacional'));

-- Vacio Importado
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-vacio-importado',1973.0,'MXN','$1,973.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-vacio-importado','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-vacio-importado','https://casabrassa.mx/product/vacio-importado/','https://casabrassa.mx/wp-content/uploads/2021/01/vacio-sterling--scaled-e1696987583481-1024x618.jpg','assets/img/catalogo/vacio-importado-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-vacio-importado','1 kg','USA','Choice o Superior',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('vacio-importado','VACIO-IMPORTADO','Vacio Importado',1,'Vacio Importado
Raza: Angus Black, Hereford.
Alimentación: Grano y Pastizales
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-vacio-importado','INV-vacio-importado','IMG-vacio-importado','INFO-vacio-importado',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('vacio-importado',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('vacio-importado',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('vacio-importado',(SELECT categoria_id FROM categoria WHERE nombre='USA'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('vacio-importado',(SELECT categoria_id FROM categoria WHERE nombre='Choice'));

-- Wagyu Rib Eye-Japón A5
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-wagyu-rib-eye-japon-a5',4400.0,'MXN','$4,400.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-wagyu-rib-eye-japon-a5','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-wagyu-rib-eye-japon-a5','https://casabrassa.mx/product/wagyu-rib-eye-japon-a5/','https://casabrassa.mx/wp-content/uploads/2021/01/ribeye-a5-wagyu-2-1024x683.jpg','assets/img/catalogo/wagyu-rib-eye-jap-n-a5-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-wagyu-rib-eye-japon-a5','1 kg','Japón',NULL,'Merlot con Barrica, Nebbiolo con Barrica') ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('wagyu-rib-eye-japon-a5','WAGYU-RIB-EYE-JAPON-A5','Wagyu Rib Eye-Japón A5',1,'Wagyu Rib Eye-Japón A5
Grado: A5+
Raza: Japanese Black (Kuroge).
Alimentación: 28 meses (700-900Kg) con pajas de arroz, forraje y grano
10Kg de Alimento = 1Kg de peso corporal
Maduración: 21+ dias en húmedo
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook','PRECIO-wagyu-rib-eye-japon-a5','INV-wagyu-rib-eye-japon-a5','IMG-wagyu-rib-eye-japon-a5','INFO-wagyu-rib-eye-japon-a5',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wagyu-rib-eye-japon-a5',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wagyu-rib-eye-japon-a5',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wagyu-rib-eye-japon-a5',(SELECT categoria_id FROM categoria WHERE nombre='Ultra Premium'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wagyu-rib-eye-japon-a5',(SELECT categoria_id FROM categoria WHERE nombre='Japón'));

-- WX Filete 3+
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-wx-filete-3',1895.0,'MXN','$1,895.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-wx-filete-3','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-wx-filete-3','https://casabrassa.mx/product/wx-filete-3/','https://casabrassa.mx/wp-content/uploads/2022/06/WX-FILETE-3.jpg','assets/img/catalogo/wx-filete-3-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-wx-filete-3','1 kg','Australia','BMS 3',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('wx-filete-3','WX-FILETE-3','WX Filete 3+',1,'WX Filete 3+
Raza: Wagyu & Black Angus.
Alimentación: 360 días con granos
HGP free, Libre de Hormonas y Aceleradores
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones WX Filete 3+: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Nuestra selección de la cava de vinos:
Vino Tinto Mexicano – Hacienda Encinillas – Mezcla Bordalesa – Chihuahua
Vino Tinto Francés – Côté Mas – Ensamble
Vino Tinto Español – Las Ocho – Ensamble – Vino de Pago
Vino Tinto Sudafricano – Mullineaux – Syrah
Vino Tinto Mexicano – Trasiego – Mezcla Mediterranea – Baja California','PRECIO-wx-filete-3','INV-wx-filete-3','IMG-wx-filete-3','INFO-wx-filete-3',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wx-filete-3',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wx-filete-3',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wx-filete-3',(SELECT categoria_id FROM categoria WHERE nombre='Ultra Premium'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wx-filete-3',(SELECT categoria_id FROM categoria WHERE nombre='Australia'));

-- WX Filete 5+
INSERT INTO precio (precio_id,monto,moneda,texto,nota) VALUES ('PRECIO-wx-filete-5',2190.0,'MXN','$2,190.00',NULL) ON DUPLICATE KEY UPDATE monto=VALUES(monto),moneda=VALUES(moneda),texto=VALUES(texto),nota=VALUES(nota);
INSERT INTO inventario (inventario_id,estado,cantidad) VALUES ('INV-wx-filete-5','disponible',10) ON DUPLICATE KEY UPDATE estado='disponible',cantidad=10;
INSERT INTO imagen (imagen_id,url,remota,local) VALUES ('IMG-wx-filete-5','https://casabrassa.mx/product/wx-filete-5/','https://casabrassa.mx/wp-content/uploads/2022/06/WX-FILETE-5.jpg','assets/img/catalogo/wx-filete-5-removebg-preview.png') ON DUPLICATE KEY UPDATE url=VALUES(url),remota=VALUES(remota),local=VALUES(local);
INSERT INTO informacion_adicional (info_id,peso,lugar_origen,nivel_marmoleado,maridaje) VALUES ('INFO-wx-filete-5','1 kg','Australia','BMS 5',NULL) ON DUPLICATE KEY UPDATE peso=VALUES(peso),lugar_origen=VALUES(lugar_origen),nivel_marmoleado=VALUES(nivel_marmoleado),maridaje=VALUES(maridaje);
INSERT INTO producto (id,sku,nombre,tiene_variantes,descripcion,precio_id,inventario_id,imagen_id,info_adicional_id,categoria_principal_id) VALUES ('wx-filete-5','WX-FILETE-5','WX Filete 5+',1,'WX Filete 5+
Raza: Wagyu&Black Angus.
Alimentación: 360 días con granos
HGP free, Libre de Hormonas y Aceleradores
Maduración: 21+ días en húmedo.
Descripción: Corte central y hecho a mano.
Embalaje: envuelto individualmente y sellado al vacío.
Condiciones: El producto se encuentra congelado para conservar el sabor y le será entregado congelado o parcialmente descongelado.
Casa Brassa
Síguenos en Facebook
Nuestra selección de la cava de vinos:
Vino Tinto Mexicano – Hacienda Encinillas – Mezcla Bordalesa – Chihuahua
Vino Tinto Francés – Côté Mas – Ensamble
Vino Tinto Español – Las Ocho – Ensamble – Vino de Pago
Vino Tinto Sudafricano – Mullineaux – Syrah
Vino Tinto Mexicano – Trasiego – Mezcla Mediterranea – Baja California','PRECIO-wx-filete-5','INV-wx-filete-5','IMG-wx-filete-5','INFO-wx-filete-5',(SELECT categoria_id FROM categoria WHERE nombre='Carne')) ON DUPLICATE KEY UPDATE sku=VALUES(sku),nombre=VALUES(nombre),tiene_variantes=VALUES(tiene_variantes),descripcion=VALUES(descripcion),precio_id=VALUES(precio_id),inventario_id=VALUES(inventario_id),imagen_id=VALUES(imagen_id),info_adicional_id=VALUES(info_adicional_id),categoria_principal_id=VALUES(categoria_principal_id);
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wx-filete-5',(SELECT categoria_id FROM categoria WHERE nombre='Carne'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wx-filete-5',(SELECT categoria_id FROM categoria WHERE nombre='Res'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wx-filete-5',(SELECT categoria_id FROM categoria WHERE nombre='Ultra Premium'));
INSERT IGNORE INTO productocategoria (producto_id,categoria_id) VALUES ('wx-filete-5',(SELECT categoria_id FROM categoria WHERE nombre='Australia'));

COMMIT;
