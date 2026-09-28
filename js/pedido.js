

const carrito = JSON.parse(localStorage.getItem('paLaAsadaCart') || '[]');


console.log(carrito);

const contenedor = document.querySelector("#productos-pedido");  //busca el elemento con el id "productos-pedido" en el documento HTML y lo asigna a la variable contenedor

let subtotal = 0;

const formatoMoneda = new Intl.NumberFormat("es-MX", {
    style: "currency",
    currency: "MXN"
});

carrito.forEach((producto) => {
    const totalProducto = producto.price * producto.quantity;
    subtotal += totalProducto;

    const tarjeta = document.createElement("article");
    tarjeta.classList.add("tarjeta-pedido");

    const imagen = document.createElement("img");
    imagen.src = producto.image;
    imagen.alt = producto.name;

    const informacion = document.createElement("div");
    informacion.classList.add("tarjeta-pedido__info");

    const nombre = document.createElement("h3");
    nombre.textContent = producto.name;

    const detalle = document.createElement("p");
    detalle.textContent =
        `Cantidad: ${producto.quantity} · ${producto.priceText} c/u`;

    const precioTotal = document.createElement("span");
    precioTotal.classList.add("tarjeta-pedido__precio");
    precioTotal.textContent = formatoMoneda.format(totalProducto);

    informacion.append(nombre, detalle);
    tarjeta.append(imagen, informacion, precioTotal);
    contenedor.append(tarjeta);
});

document.querySelector("#subtotal").textContent =
    formatoMoneda.format(subtotal);

document.querySelector("#total-pagar").textContent =
    formatoMoneda.format(subtotal);
