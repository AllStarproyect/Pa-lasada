document.addEventListener("DOMContentLoaded", () => {

    // =====================================================
    // ELEMENTOS PRINCIPALES
    // =====================================================

    const productGrid = document.querySelector(
        ".catalog-section .product-grid"
    );
    const modalElement = document.getElementById("productModal");
    if (!productGrid || !modalElement) {
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


    // =====================================================
    // CARGAR JSON
    // =====================================================

    fetch("../data/productos.json")

        .then(response => {
            if (!response.ok) {
                throw new Error(
                    "No se pudo cargar productos.json"
                );

            }
            return response.json();

        })

        .then(data => {
            productos = data.productos;
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

    productGrid.addEventListener("click", event => {
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
            /^https?:\/\//i.test(
                rutaImagen
            );


        if (imagenExterna) {
            modalImagen.src =
                rutaImagen;

        } else {
            modalImagen.src =
                `../${rutaImagen}`;

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
            if (cantidad < stock) {
                cantidad++;
                modalCantidad.value =
                    cantidad;

            }

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
                );
            console.log(
                "Producto:",
                productoSeleccionado
            );
            console.log(
                "Cantidad:",
                cantidad
            );
        }
    );

});