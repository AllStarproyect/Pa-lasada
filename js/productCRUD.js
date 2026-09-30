//Areglo global para almacenar los objetos

//Nombres de id preliminares

//Llamada
let productos = [];

fetch(new URL("../data/productos.json", document.currentScript.src))
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

// Clave de localStorage donde se guardan los productos creados desde /admin.
// catalog.js y productModal.js la leen para mostrarlos junto a productos.json.
const CLAVE_PRODUCTOS_NUEVOS = "productosNuevos";

function leerProductosNuevos() {
    try {
        return JSON.parse(localStorage.getItem(CLAVE_PRODUCTOS_NUEVOS)) || [];
    } catch {
        return [];
    }
}

// Genera un id de texto (igual que los de productos.json) a partir del sku,
// agregando un sufijo numérico si ya existe.
function generarNuevoId(sku) {
    const base = sku.toLowerCase();
    const usados = new Set([...productos, ...leerProductosNuevos()].map(p => String(p.id)));
    let id = base;
    for (let n = 2; usados.has(id); n++) {
        id = `${base}-${n}`;
    }
    return id;
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

// Devuelve [tag, ...categorías marcadas] (el tag es opcional)
function obtenerCategorias() {
    const tag = document.getElementById("tag")?.value;
    const marcadas = Array.from(document.querySelectorAll('input[name="categoria"]:checked'))
        .map(check => check.value);
    return tag ? [tag, ...marcadas] : marcadas;
}

// ---------------------------------------------------------
// VISTA PREVIA (card en vivo)
// ---------------------------------------------------------
let imagenPreviewUrl = null;

function actualizarVistaPrevia() {
    const tag = document.getElementById("tag")?.value;
    const marcadas = Array.from(document.querySelectorAll('input[name="categoria"]:checked'))
        .map(check => check.value);
    const precio = Number(document.getElementById("precio").value);
    const pesaje = document.getElementById("pesaje").value;

    document.getElementById("previewNombre").textContent =
        document.getElementById("nombre").value.trim() || "Título del producto";
    document.getElementById("previewCategoria").textContent =
        (marcadas.join(" · ") || "Categoría").toUpperCase();
    document.getElementById("previewPrecio").textContent = precio > 0 ? `$${precio}` : "$0";
    document.getElementById("previewPeso").textContent = pesaje ? `${pesaje} kg aprox.` : "";
    document.getElementById("contadorDescripcion").textContent =
        document.getElementById("descripcion").value.length;

    const badge = document.getElementById("previewTag");
    badge.hidden = !tag;
    badge.textContent = (tag || "").toUpperCase();
}

const inputArchivo = document.getElementById("imagenArchivo");
if (formProduct && inputArchivo) {
    formProduct.addEventListener("input", actualizarVistaPrevia);
    formProduct.addEventListener("reset", () => setTimeout(actualizarVistaPrevia));

    inputArchivo.addEventListener("change", () => {
        const archivo = inputArchivo.files[0];
        const preview = document.getElementById("previewImagen");
        if (imagenPreviewUrl) URL.revokeObjectURL(imagenPreviewUrl);
        if (!archivo) {
            document.getElementById("imagen").value = "";
            return;
        }
        imagenPreviewUrl = URL.createObjectURL(archivo);
        preview.src = imagenPreviewUrl;
        // Se guarda como data URL para que el catálogo pueda mostrarla
        const lector = new FileReader();
        lector.onload = () => {
            document.getElementById("imagen").value = lector.result;
        };
        lector.readAsDataURL(archivo);
    });
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
    const categorias = obtenerCategorias();
    const categoria = categorias.join(",");
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
        id: generarNuevoId(sku),
        sku: sku, // antes faltaba a nivel raíz, aunque el modelo del JSON lo pide
        nombre: nombre,
        categoria: ["Carne", ...categorias],
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
            "Peso": pesaje ? `${pesaje} kg` : "",
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

    try {
        const guardados = leerProductosNuevos();
        guardados.push(nuevoProducto);
        localStorage.setItem(CLAVE_PRODUCTOS_NUEVOS, JSON.stringify(guardados));
    } catch (error) {
        mostrarAlerta("No se pudo guardar el producto (¿imagen demasiado grande?).", "danger");
        productos.pop();
        return;
    }

    mostrarAlerta("Producto guardado correctamente. Ya aparece en el catálogo.", "success");

    if (jsonPreview) {
        // La imagen va como data URL (muy larga): en la vista previa se abrevia
        const resumen = structuredClone(nuevoProducto);
        if (resumen.imagenes.local.startsWith("data:")) {
            resumen.imagenes.local = `[imagen incrustada, ${Math.round(resumen.imagenes.local.length / 1024)} KB]`;
        }
        jsonPreview.textContent = JSON.stringify(resumen, null, 2);
    }

    formProduct.reset();
    actualizarVistaPrevia();
    renderizarTabla();
});

//Cargar la lista al iniciar
document.addEventListener("DOMContentLoaded", renderizarTabla);

// ---------------------------------------------------------
// READ / DELETE (productos creados desde el panel)
// ---------------------------------------------------------
// Solo se pueden eliminar los guardados en localStorage; los de
// productos.json son un archivo estático y no se modifican desde aquí.
function renderizarTabla() {
    const lista = document.getElementById("listaAdmin");
    const vacio = document.getElementById("listaAdminVacia");
    if (!lista) return;

    const guardados = leerProductosNuevos();
    lista.innerHTML = "";
    if (vacio) vacio.hidden = guardados.length > 0;

    guardados.forEach(producto => {
        const item = document.createElement("li");
        item.className = "admin-list__item";

        const img = document.createElement("img");
        img.className = "admin-list__thumb";
        img.alt = "";
        img.src = producto.imagenes?.local || "../assets/img/catalogo/placeholder.png";
        img.addEventListener("error", () => {
            img.src = "../assets/img/catalogo/placeholder.png";
        }, { once: true });

        const info = document.createElement("div");
        info.className = "admin-list__info";
        const nombre = document.createElement("span");
        nombre.className = "admin-list__name";
        nombre.textContent = producto.nombre;
        const meta = document.createElement("span");
        meta.className = "admin-list__meta";
        meta.textContent = `${producto.precio?.texto ?? ""} · ${producto.inventario?.cantidad ?? 0} pzas · ${(producto.categoria || []).slice(1).join(", ")}`;
        info.append(nombre, meta);

        const boton = document.createElement("button");
        boton.type = "button";
        boton.className = "admin-list__delete";
        boton.textContent = "Eliminar";
        boton.addEventListener("click", () => deleteProducto(producto.id));

        item.append(img, info, boton);
        lista.appendChild(item);
    });
}

function deleteProducto(id) {
    const producto = leerProductosNuevos().find(p => String(p.id) === String(id));
    if (!producto || !confirm(`¿Eliminar "${producto.nombre}"? Dejará de aparecer en el catálogo.`)) return;

    const restantes = leerProductosNuevos().filter(p => String(p.id) !== String(id));
    localStorage.setItem(CLAVE_PRODUCTOS_NUEVOS, JSON.stringify(restantes));
    productos = productos.filter(p => String(p.id) !== String(id));

    mostrarAlerta("Producto eliminado.", "success");
    renderizarTabla();
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
            const categorias = obtenerCategorias();
            const categoria = categorias.join(",");
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
            productos[i].categoria = ["Carne", ...categorias];
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