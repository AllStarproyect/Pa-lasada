// Se captura aquí (fuera del listener async) porque document.currentScript
// solo es válido durante la ejecución síncrona del script.
const productModalScriptSrc = document.currentScript.src;

document.addEventListener("DOMContentLoaded", () => {

    // =====================================================
    // ELEMENTOS PRINCIPALES
    // =====================================================

    // Raíz del proyecto, calculada a partir de la ubicación real de este
    // script (js/productModal.js) para que funcione igual desde index.html
    // como desde pages/catalog.html.
    const rutaBase = new URL("../", productModalScriptSrc);

    const modalElement = document.getElementById("productModal");
    if (!modalElement) {
        return;
    }

    // =====================================================
    // ELEMENTOS DEL MODAL
    // =====================================================

    const modalImagen =
        document.getElementById("modalProductoImagen");
    const modalCategoria =
        document.getElementById("modalProductoCategoria");
    const modalNombre =
        document.getElementById("modalProductoNombre");
    const modalDescripcion =
        document.getElementById("modalProductoDescripcion");
    const modalPrecio =
        document.getElementById("modalProductoPrecio");
    const modalPeso =
        document.getElementById("modalProductoPeso");
    const modalOrigen =
        document.getElementById("modalProductoOrigen");
    const modalEstado =
        document.getElementById("modalProductoEstado");
    const modalCantidad =
        document.getElementById("modalCantidad");
    const botonRestar =
        document.getElementById("btnRestarCantidad");
    const botonSumar =
        document.getElementById("btnSumarCantidad");
    const botonAgregar =
        document.getElementById("modalAgregarCarrito");

    // =====================================================
    // VARIABLES
    // =====================================================

    let productos = [];
    let productoSeleccionado = null;

    // Texto del precio tal como se muestra en la tarjeta ("$445.00")
    const obtenerPrecioTexto = (producto) => {
        const precio = producto?.precio ?? {};
        return precio.texto ||
            `$${Number(precio.monto ?? 0).toFixed(2)}`;
    };

    // Peso de una pieza en kg (sin "Peso" en el JSON cuenta como 1 kg)
    const obtenerPesoKg = (producto) => {
        const texto = producto?.infoAdicional?.["Peso"];
        return window.PaLaAsadaCart
            ? window.PaLaAsadaCart.parseWeightKg(texto)
            : 1;
    };


    // =====================================================
    // CARGAR JSON
    // =====================================================

    window.PaLaAsadaAPI.obtenerProductos(new URL("data/productos.json", rutaBase).href)

        .then(lista => {
            let nuevos = [];
            try {
                nuevos = JSON.parse(localStorage.getItem("productosNuevos")) || [];
            } catch { }
            productos = [...lista, ...nuevos];
        })

        .catch(error => {
            console.error(
                "Error al cargar productos:",
                error
            );

        });


    // =====================================================
    // CLICK EN UNA CARD
    // =====================================================

    document.addEventListener("click", event => {
        if (event.target.closest(".product-card__add")) {
            return;
        }
        const card = event.target.closest(".product-card");

        if (!card) {
            return;
        }

        const productId =
            card.dataset.productId;
        const producto =
            productos.find(
                producto =>
                    producto.id === productId
            );
        if (!producto) {
            console.error(
                "No se encontró el producto:",
                productId
            );
            return;
        }

        productoSeleccionado = producto;
        cargarProductoModal(producto);
        const modal =
            bootstrap.Modal.getOrCreateInstance(
                modalElement
            );

        modal.show();

    });


    // =====================================================
    // CARGAR DATOS EN EL MODAL
    // =====================================================

    function cargarProductoModal(producto) {

        const categorias =
            Array.isArray(producto.categoria)
                ? producto.categoria
                : [];
        const precio =
            producto.precio ?? {};
        const inventario =
            producto.inventario ?? {};
        const info =
            producto.infoAdicional ?? {};
        const imagenes =
            producto.imagenes ?? {};

        // =================================================
        // NOMBRE
        // =================================================
        modalNombre.textContent =
            producto.nombre ?? "Producto";

        // =================================================
        // CATEGORÍA
        // =================================================

        modalCategoria.textContent =
            categorias.join(" · ");

        // =================================================
        // DESCRIPCIÓN
        // =================================================

        modalDescripcion.textContent =
            producto.descripcion ??
            "Sin descripción disponible.";

        // =================================================
        // PRECIO
        // =================================================

        if (precio.texto) {
            modalPrecio.textContent =
                precio.texto;

        } else {
            modalPrecio.textContent =
                `$${Number(
                    precio.monto ?? 0
                ).toFixed(2)}`;

        }
        // =================================================
        // PESO
        // =================================================

        modalPeso.textContent =
            info["Peso"] ??
            "No especificado";

        // =================================================
        // ORIGEN
        // =================================================

        modalOrigen.textContent =
            info["Lugar de orígen"] ??
            info["Lugar de origen"] ??
            "No especificado";

        // =================================================
        // INVENTARIO
        // =================================================

        const agotado =
            inventario.estado === "agotado" ||
            Number(inventario.cantidad) <= 0;

        modalEstado.classList.remove(
            "alert-success",
            "alert-danger",
            "alert-warning"
        );


        if (agotado) {

            modalEstado.textContent =
                "Producto agotado por el momento.";
            modalEstado.classList.add(
                "alert-danger"
            );

            botonAgregar.disabled = true;
        } else {

            modalEstado.textContent =
                "Producto disponible.";
            modalEstado.classList.add(
                "alert-success"
            );

            botonAgregar.disabled = false;

        }


        // =================================================
        // CANTIDAD
        // =================================================

        modalCantidad.value = 1;


        // =================================================
        // IMAGEN
        // =================================================

        const rutaImagen =
            imagenes.local ||
            imagenes.remota ||
            "assets/img/catalogo/placeholder.png";


        const imagenExterna =
            /^(https?:\/\/|data:)/i.test(
                rutaImagen
            );


        if (imagenExterna) {
            modalImagen.src =
                rutaImagen;

        } else {
            modalImagen.src =
                new URL(rutaImagen, rutaBase).href;

        }

        modalImagen.alt =
            producto.nombre ??
            "Producto";

    }

    // =====================================================
    // BOTÓN RESTAR
    // =====================================================

    botonRestar.addEventListener(
        "click",
        () => {

            let cantidad =
                Number(
                    modalCantidad.value
                );
            if (cantidad > 1) {
                cantidad--;
                modalCantidad.value =
                    cantidad;
            }

        }
    );


    // =====================================================
    // BOTÓN SUMAR
    // =====================================================

    botonSumar.addEventListener(
        "click",
        () => {

            let cantidad =
                Number(
                    modalCantidad.value
                );
            const stock =
                Number(
                    productoSeleccionado
                        ?.inventario
                        ?.cantidad ?? 0
                );
            // Las piezas que ya están en el carrito también cuentan
            const enCarrito = window.PaLaAsadaCart?.getInCart(
                productoSeleccionado?.nombre,
                obtenerPrecioTexto(productoSeleccionado)
            ) ?? 0;

            if (cantidad >= stock - enCarrito) {
                window.PaLaAsadaCart?.showToast(
                    enCarrito > 0
                        ? `Ya tienes ${enCarrito} en el carrito; solo hay ${stock} en existencia.`
                        : `Solo hay ${stock} en existencia.`,
                    "error"
                );
                return;
            }

            // No permitir elegir más piezas de las que caben en el límite de peso
            const carrito = window.PaLaAsadaCart;
            if (carrito) {
                const pesoPieza = obtenerPesoKg(productoSeleccionado);
                const piezasQueCaben = Math.floor(
                    (carrito.getRemainingKg() + 0.0001) / pesoPieza
                );

                if (cantidad + 1 > piezasQueCaben) {
                    carrito.showToast(
                        piezasQueCaben > 0
                            ? `Solo ${piezasQueCaben === 1 ? "cabe" : "caben"} ${piezasQueCaben} pieza${piezasQueCaben === 1 ? "" : "s"} más en tu pedido (máximo ${carrito.MAX_WEIGHT_KG} kg).`
                            : `Tu pedido ya llegó al máximo de ${carrito.MAX_WEIGHT_KG} kg.`,
                        "error"
                    );
                    return;
                }
            }

            cantidad++;
            modalCantidad.value =
                cantidad;

        }
    );


    // =====================================================
    // AGREGAR AL CARRITO
    // =====================================================

    botonAgregar.addEventListener(
        "click",
        () => {

            if (!productoSeleccionado) {
                return;
            }
            const cantidad =
                Number(
                    modalCantidad.value
                ) || 1;

            if (!window.PaLaAsadaCart) {
                console.error(
                    "El carrito (js/cart.js) no está cargado en esta página."
                );
                return;
            }

            const resultado =
                window.PaLaAsadaCart.addItem(
                    {
                        name: productoSeleccionado.nombre,
                        priceText: obtenerPrecioTexto(productoSeleccionado),
                        image: modalImagen.src,
                        weightText: productoSeleccionado.infoAdicional?.["Peso"],
                        stock: Number(productoSeleccionado.inventario?.cantidad ?? 0)
                    },
                    cantidad
                );

            // Si se agregó, se cierra el modal; si no cupo, se queda abierto
            // para que el cliente pueda bajar la cantidad.
            if (resultado?.ok) {
                bootstrap.Modal
                    .getOrCreateInstance(modalElement)
                    .hide();
            }
        }
    );

});