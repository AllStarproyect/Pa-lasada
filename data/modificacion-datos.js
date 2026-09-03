fetch('./data/productos.json')
  .then(res => res.json())
  .then(data => {
    data.productos = data.productos.map((producto, index) => ({
      ...producto,
      id: index + 1,      // nuevo id numérico (1, 2, 3...)
      tags: {
        premium: false,
        nuevo: false,
        descuento: false,
        nacional: false,
        internacional: false,
        masVendido: false,
        hotSale: false,
        porTemporada: false
      }
    }));
  const producto = data.productos.find(p => p.id === 3);
console.log(producto);
    // console.log(JSON.stringify(data, null, 2)); // verlo en consola
    // descargarJSON(data);
  })
  .catch(err => console.error('Error:', err));
