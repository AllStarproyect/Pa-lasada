

const carrito = JSON.parse(localStorage.getItem('paLaAsadaCart') || '[]');

const subtotal = carrito.reduce(
  (suma, producto) => suma + producto.price * producto.quantity,
  0
);

const formatoMoneda = new Intl.NumberFormat('es-MX', {
  style: 'currency',
  currency: 'MXN'
});

document.querySelector('#subtotal').textContent = formatoMoneda.format(subtotal);
document.querySelector('#total-pagar').textContent = formatoMoneda.format(subtotal);

console.log(carrito);

const contenedor = document.querySelector("#productos-pedido");  //busca el elemento con el id "productos-pedido" en el documento HTML y lo asigna a la variable contenedor

let subtotal = 0;

const formatoMoneda = new Intl.NumberFormat("es-MX", {
    style: "currency",
    currency: "MXN"
});

carrito.forEach((producto) => {  // recorre el arreglo carrito, Por cada producto del carrito se crea una tarjeta con sus datos 
    //crea tres elementos HTML: un artículo, un encabezado y un párrafo. Luego, se asigna el nombre del producto al encabezado y la cantidad al párrafo. Finalmente, se agregan estos elementos al contenedor en el documento HTML.
   
    const totalProducto = producto.price * producto.quantity;
    subtotal += totalProducto;
    
    const tarjeta = document.createElement("article");
    const nombre = document.createElement("h3");
    const cantidad = document.createElement("p");
    const imagen = document.createElement("img");
    const precio = document.createElement("p");

    nombre.textContent = producto.name;  
    cantidad.textContent = `Cantidad: ${producto.quantity}`;
    imagen.src = producto.image;
    imagen.alt = producto.name;
    imagen.width = 90;

    precio.textContent =
    `${producto.priceText} c/u · Total: ${formatoMoneda.format(totalProducto)}`;
    tarjeta.append(imagen, nombre, cantidad, precio);
    contenedor.append(tarjeta);
});

document.querySelector("#subtotal").textContent =
    formatoMoneda.format(subtotal);

document.querySelector("#total-pagar").textContent =
    formatoMoneda.format(subtotal);
