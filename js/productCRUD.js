//Areglo global para almacenar los objetos

//Nombres de id preliminares

//Llamada
let productos = [];
// Productos que hay en la base de datos (back)
let productosApi = [];

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
    // Si el id ya existe en la BD el back lo SOBRESCRIBIRÍA, por eso se revisa contra todos
    const usados = new Set([...productos, ...productosApi].map(p => String(p.id)));
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

function reducirImagen(archivo, maximo) {
    return new Promise((resolve) => {
        const url = URL.createObjectURL(archivo);
        const img = new Image();
        img.onload = () => {
            const escala = Math.min(1, maximo / Math.max(img.width, img.height));
            const canvas = document.createElement("canvas");
            canvas.width = Math.round(img.width * escala);
            canvas.height = Math.round(img.height * escala);
            canvas.getContext("2d").drawImage(img, 0, 0, canvas.width, canvas.height);
            URL.revokeObjectURL(url);
            resolve(canvas.toDataURL("image/webp", 0.8));
        };
        img.src = url;
    });
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
        // Se reduce a máx. 500 px y se guarda como data URL WebP (cabe en la columna TEXT)
        reducirImagen(archivo, 500).then((dataUrl) => {
            document.getElementById("imagen").value = dataUrl;
        });
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
formProduct.addEventListener("submit", async function (event) {
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

    if (!localStorage.getItem("token") || localStorage.getItem("rol") !== "ADMIN") {
        mostrarAlerta("Inicia sesión con una cuenta de administrador para guardar productos.", "danger");
        return;
    }

    const sku = nombre
        .normalize("NFD").replace(/[\u0300-\u036f]/g, "") // quita acentos (ej. "Norteña" -> "Nortena")
        .toUpperCase()
        .trim()
        .replaceAll(" ", "-");

    // Categoría principal: la primera marcada que exista en la BD; si no, "Carne"
    const resCategorias = await window.PaLaAsadaAPI.peticion("GET", "/categorias");
    const listaCategorias = Array.isArray(resCategorias.data) ? resCategorias.data : [];
    const principal =
        categorias.map(c => listaCategorias.find(x => x.nombre === c)).find(Boolean)
        || listaCategorias.find(x => x.nombre === "Carne");
    if (!principal) {
        mostrarAlerta("No se pudieron cargar las categorías del servidor.", "danger");
        return;
    }

    const id = generarNuevoId(sku);

    // Formato del back (Producto con sus objetos anidados)
    const payload = {
        id,
        sku,
        nombre,
        tieneVariantes: false,
        descripcion,
        precio: {
            precioId: `PRECIO-${id}`,
            monto: precio,
            moneda: "MXN",
            texto: `$${precio.toFixed(2)}`,
            nota: null
        },
        inventario: {
            inventarioId: `INV-${id}`,
            estado: inventario > 0 ? "disponible" : "agotado",
            cantidad: inventario
        },
        imagen: {
            imagenId: `IMG-${id}`,
            url: null,
            remota: null,
            local: imagen || null
        },
        informacionAdicional: {
            infoId: `INFO-${id}`,
            peso: pesaje ? `${pesaje} kg` : null,
            lugarOrigen: "s/d",
            nivelMarmoleado: "s/d",
            maridaje: null
        },
        categoriaPrincipal: { categoriaId: principal.categoriaId }
    };

    const boton = formProduct.querySelector('[type="submit"]');
    if (boton) boton.disabled = true;
    const respuesta = await window.PaLaAsadaAPI.peticion("POST", "/productos", payload);
    if (boton) boton.disabled = false;

    if (!respuesta.ok) {
        const motivo = respuesta.status === 401 || respuesta.status === 403
            ? "Tu sesión no tiene permisos de administrador o expiró; vuelve a iniciar sesión."
            : (typeof respuesta.data === "string" && respuesta.data) || `Error ${respuesta.status}`;
        mostrarAlerta(`No se pudo guardar el producto: ${motivo}`, "danger");
        return;
    }

    productosApi.push(window.PaLaAsadaAPI.adaptarProducto(respuesta.data));
    mostrarAlerta("Producto guardado en la base de datos. Ya aparece en el catálogo.", "success");

    if (jsonPreview) {
        const resumen = structuredClone(payload);
        if (resumen.imagen.local?.startsWith("data:")) {
            resumen.imagen.local = `[imagen incrustada, ${Math.round(resumen.imagen.local.length / 1024)} KB]`;
        }
        jsonPreview.textContent = JSON.stringify(resumen, null, 2);
    }

    formProduct.reset();
    actualizarVistaPrevia();
    renderizarTabla();
});

//Cargar la lista al iniciar
document.addEventListener("DOMContentLoaded", async () => {
    const res = await window.PaLaAsadaAPI.peticion("GET", "/productos");
    if (res.ok && Array.isArray(res.data)) {
        productosApi = res.data.map(window.PaLaAsadaAPI.adaptarProducto);
    }
    renderizarTabla();
});

// ---------------------------------------------------------
// READ / DELETE (productos creados desde el panel)
// ---------------------------------------------------------
// Lista los productos de la BD que no vienen del catálogo inicial (productos.json),
// es decir, los creados desde este panel, y permite eliminarlos.
function renderizarTabla() {
    const lista = document.getElementById("listaAdmin");
    const vacio = document.getElementById("listaAdminVacia");
    if (!lista) return;

    const idsIniciales = new Set(productos.map(p => String(p.id)));
    const guardados = productosApi.filter(p => !idsIniciales.has(String(p.id)));
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

async function deleteProducto(id) {
    const producto = productosApi.find(p => String(p.id) === String(id));
    if (!producto || !confirm(`¿Eliminar "${producto.nombre}"? Dejará de aparecer en el catálogo.`)) return;

    const respuesta = await window.PaLaAsadaAPI.peticion("DELETE", `/productos/${encodeURIComponent(id)}`);
    if (!respuesta.ok) {
        mostrarAlerta(`No se pudo eliminar el producto (error ${respuesta.status}).`, "danger");
        return;
    }

    productosApi = productosApi.filter(p => String(p.id) !== String(id));
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