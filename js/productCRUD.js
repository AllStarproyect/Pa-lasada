//Areglo global para almacenar los objetos

//Nombres de id preliminares

//Llamada
let productos = [];

fetch("./data/productos.json")
    .then(response => response.json())
    .then(data => {
        productos = data.productos;
    })
    .catch(error => {
        console.error("No se pudo cargar productos.json:", error);
    });


const formProduct = document.getElementById("formProducto");
const formAlert = document.getElementById("alertaProducto");
const jsonPreview = document.getElementById("jsonPreview");

// ---------------------------------------------------------
// UTILIDADES
// ---------------------------------------------------------

// Muestra un mensaje en el componente Alert de Bootstrap (alertaProducto)
// tipo: "danger" (error), "success", "warning", etc.
function mostrarAlerta(mensaje, tipo = "danger") {
    if (!formAlert) return;
    formAlert.textContent = mensaje;
    formAlert.className = `alert alert-${tipo}`;
    formAlert.classList.remove("d-none"); // por si el HTML la oculta con d-none
}

// Genera el siguiente id numérico disponible a partir del arreglo actual.
// Se calcula al momento de guardar (no al cargar el script), para evitar
// que el fetch asíncrono todavía no haya llenado "productos".
function generarNuevoId() {
    let nuevoId = 1;
    for (let i = 0; i < productos.length; i++) {
        if (productos[i].id >= nuevoId) {
            nuevoId = productos[i].id + 1; //Genera automaticamente el ID del producto
        }
    }
    return nuevoId;
}

// Valida los campos obligatorios del formulario.
// Devuelve un arreglo de mensajes de error (vacío si todo está bien).
function validarProducto({ nombre, precio, inventario, categoria, descripcion }) {
    const errores = [];

    if (!nombre || nombre.trim() === "") {
        errores.push("El nombre es obligatorio.");
    }
    if (isNaN(precio) || precio <= 0) {
        errores.push("El precio debe ser un número mayor a 0.");
    }
    if (isNaN(inventario) || inventario < 0) {
        errores.push("El inventario no puede ser negativo.");
    }
    if (!categoria || categoria.trim() === "") {
        errores.push("Debes seleccionar una categoría.");
    }
    if (!descripcion || descripcion.trim() === "") {
        errores.push("La descripción es obligatoria.");
    }

    return errores;
}

// Nombre
// Precio
// Pesaje
// Descripción
// Inventario (Cantidad)
// Categoria (Select List)
// Imagen?

// ---------------------------------------------------------
// CREATE (Guardar nuevo producto)
// ---------------------------------------------------------
formProduct.addEventListener("submit", function (event) {
    event.preventDefault();

    const nombre = document.getElementById("nombre").value;
    const precio = Number(document.getElementById("precio").value);
    const inventario = Number(document.getElementById("inventario").value);
    const categoria = document.getElementById("categoria").value;
    const pesaje = document.getElementById("pesaje").value;
    const descripcion = document.getElementById("descripcion").value;
    const imagen = document.getElementById("imagen").value;

    // Validación (Rúbrica: función de JS que valida y muestra errores con alertas de Bootstrap)
    const errores = validarProducto({ nombre, precio, inventario, categoria, descripcion });
    if (errores.length > 0) {
        mostrarAlerta(errores.join(" "), "danger");
        return; // se detiene la creación si hay errores
    }

    //agragar sku, y en un plceholder( un ejemplo)
    const sku = nombre
        .normalize("NFD").replace(/[\u0300-\u036f]/g, "") // quita acentos (ej. "Norteña" -> "Nortena")
        .toUpperCase()
        .trim()
        .replaceAll(" ", "-");

    const nuevoProducto = {
        id: generarNuevoId(),
        sku: sku, // antes faltaba a nivel raíz, aunque el modelo del JSON lo pide
        nombre: nombre,
        categoria: [
            "Carne",
            categoria
        ],
        precio: {
            monto: precio,
            moneda: "MXN",
            texto: `$${precio.toFixed(2)}`,
            nota: null
        },

        inventario: {
            estado: inventario > 0 ? "disponible" : "agotado",
            cantidad: inventario,
            sku: sku
        },
        tieneVariantes: false,
        descripcion: descripcion,

        infoAdicional: {
            "Peso": pesaje,
            "Lugar de orígen": "s/d",
            "Nivel de Marmoleado": "s/d"
        },
        imagenes: {
            url: "",
            remota: "",
            local: imagen
        }

    };

    productos.push(nuevoProducto); // CREATE
    console.log(productos);

    mostrarAlerta("Producto guardado correctamente.", "success");

    if (jsonPreview) {
        jsonPreview.textContent = JSON.stringify(nuevoProducto, null, 2);
    }

    formProduct.reset();
});

//Cargar la lista al iniciar
document.addEventListener("DOMContentLoaded", renderizarTabla);

// Placeholder: se implementará en la tarea de Lectura/Listado (Read).
// Se deja aquí vacía para que el listener de arriba no rompa el script.
function renderizarTabla() {
    // TODO: recorrer "productos" y pintar las filas de la tabla
}

// ---------------------------------------------------------
// UPDATE (queda preparado para la siguiente tarea)
// ---------------------------------------------------------
function updateProducto(id) {
    for (let i = 0; i < productos.length; i++) {
        if (productos[i].id == id) {  //Compara el id para encontrar el producto a modificar

            //lectura de atributos
            const nombre = document.getElementById("nombre").value;
            const precio = Number(document.getElementById("precio").value);
            const inventario = Number(document.getElementById("inventario").value);
            const categoria = document.getElementById("categoria").value;
            const pesaje = document.getElementById("pesaje").value;
            const descripcion = document.getElementById("descripcion").value;
            const imagen = document.getElementById("imagen").value;

            const errores = validarProducto({ nombre, precio, inventario, categoria, descripcion });
            if (errores.length > 0) {
                mostrarAlerta(errores.join(" "), "danger");
                return;
            }

            //Actualizacion (respetando la estructura de objetos anidados del modelo)
            productos[i].nombre = nombre;
            productos[i].precio.monto = precio;
            productos[i].precio.texto = `$${precio.toFixed(2)}`;
            productos[i].inventario.cantidad = inventario;
            productos[i].inventario.estado = inventario > 0 ? "disponible" : "agotado";
            productos[i].categoria = ["Carne", categoria];
            productos[i].descripcion = descripcion;
            productos[i].infoAdicional.Peso = pesaje;
            productos[i].imagenes.local = imagen;

            console.log("Producto actualizado:");
            console.log(productos[i]);

            mostrarAlerta("Producto actualizado correctamente.", "success");
            return;
        }

    }

    mostrarAlerta("No se encontró un producto con el ID: " + id, "warning");
    console.log("No se encontró un producto con el ID: " + id);
}