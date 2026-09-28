/* Checkout solo para usuarios con sesión (regla del documento de compra) */
if (localStorage.getItem("usuarioLogueado") !== "true") {
    window.location.href = "./sign-in.html?mode=signin";
    throw new Error("Sesión requerida para realizar un pedido.");
}

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


/* =========================================================
   DIRECCIÓN DE ENVÍO Y MÉTODO DE PAGO (sincronizados con el perfil)
   ========================================================= */

const $ = (id) => document.getElementById(id);
let perfil = leerPerfil();
let dirSel = (direccionPrincipal(perfil) || {}).id || null;
let pagoSel = (pagoPredeterminado(perfil) || {}).id || null;

function llenarSelect(select, items, etiqueta, seleccionado) {
    select.replaceChildren();
    items.forEach((it) => {
        const opt = document.createElement("option");
        opt.value = it.id;
        opt.textContent = etiqueta(it);
        select.append(opt);
    });
    select.value = seleccionado;
}

function renderDirecciones() {
    const hay = perfil.direcciones.length > 0;
    $("selDireccion").hidden = !hay;
    $("dirDetalle").hidden = !hay;
    $("dirVacia").hidden = hay;

    const lleno = perfil.direcciones.length >= MAX_DIRECCIONES;
    $("btnNuevaDireccion").disabled = lleno;
    $("btnNuevaDireccion").title = lleno ? `Máximo ${MAX_DIRECCIONES} direcciones guardadas` : "";
    if (!hay) return;

    llenarSelect($("selDireccion"), perfil.direcciones,
        (d) => d.nombre + (d.predeterminada ? " (predeterminada)" : ""), dirSel);
    const d = perfil.direcciones.find((x) => x.id === dirSel);
    $("dirDetalle").textContent = d ? d.texto + (d.referencias ? ` · Ref: ${d.referencias}` : "") : "";
}

function renderPagos() {
    const hay = perfil.pagos.length > 0;
    $("selPago").hidden = !hay;
    $("pagoDetalle").hidden = !hay;
    $("pagoVacio").hidden = hay;
    if (!hay) return;

    llenarSelect($("selPago"), perfil.pagos,
        (x) => `${x.marca} •••• ${x.ultimos}` + (x.predeterminada ? " (predeterminada)" : ""), pagoSel);
    const x = perfil.pagos.find((y) => y.id === pagoSel);
    $("pagoDetalle").textContent = x ? `${x.titular ? x.titular + " · " : ""}Vence ${x.expira}` : "";
}

$("selDireccion").addEventListener("change", (e) => { dirSel = e.target.value; renderDirecciones(); });
$("selPago").addEventListener("change", (e) => { pagoSel = e.target.value; renderPagos(); });

/* ---------- Mostrar / ocultar formularios ---------- */
function toggleForm(id, abrir) {
    const form = $(id);
    form.hidden = !abrir;
    form.reset();
    form.querySelectorAll(".is-invalid").forEach((el) => el.classList.remove("is-invalid"));
    form.querySelector(".form-error").hidden = true;
    if (abrir) form.querySelector("input").focus();
}
$("btnNuevaDireccion").addEventListener("click", () => toggleForm("formDireccion", $("formDireccion").hidden));
$("btnNuevoPago").addEventListener("click", () => toggleForm("formPago", $("formPago").hidden));
document.querySelectorAll("[data-cancelar]").forEach((b) =>
    b.addEventListener("click", () => toggleForm(b.dataset.cancelar, false)));

function fallo(errId, inputId, mensaje) {
    $(inputId).classList.add("is-invalid");
    $(errId).textContent = mensaje;
    $(errId).hidden = false;
    $(inputId).focus();
}

/* ---------- Nueva dirección ---------- */
$("formDireccion").addEventListener("submit", (e) => {
    e.preventDefault();
    $("formDireccion").querySelectorAll(".is-invalid").forEach((el) => el.classList.remove("is-invalid"));
    $("errDireccion").hidden = true;

    const nombre = $("dNombre").value.trim();
    const calle = $("dCalle").value.trim();
    const colonia = $("dColonia").value.trim();
    const alcaldia = $("dAlcaldia").value.trim();
    const cp = $("dCp").value.trim();
    const ref = $("dRef").value.trim();

    if (perfil.direcciones.length >= MAX_DIRECCIONES) return fallo("errDireccion", "dNombre", `Solo puedes guardar ${MAX_DIRECCIONES} direcciones.`);
    if (nombre.length < 2) return fallo("errDireccion", "dNombre", "Ponle un nombre a la dirección (ej. Casa).");
    if (perfil.direcciones.some((d) => d.nombre.toLowerCase() === nombre.toLowerCase())) return fallo("errDireccion", "dNombre", "Ya tienes una dirección con ese nombre.");
    if (calle.length < 5) return fallo("errDireccion", "dCalle", "Escribe la calle y el número.");
    if (colonia.length < 3) return fallo("errDireccion", "dColonia", "Escribe la colonia.");
    if (alcaldia.length < 3) return fallo("errDireccion", "dAlcaldia", "Escribe la alcaldía.");
    if (!/^\d{5}$/.test(cp)) return fallo("errDireccion", "dCp", "El código postal debe tener 5 dígitos.");

    const nueva = {
        id: `dir-${Date.now()}`,
        nombre,
        texto: `${calle}, Col. ${colonia}, ${alcaldia}, Ciudad de México, CP ${cp}`,
        referencias: ref,
        predeterminada: perfil.direcciones.length === 0 // la primera es la predeterminada
    };
    perfil.direcciones.push(nueva);
    guardarPerfil(perfil);

    dirSel = nueva.id;
    toggleForm("formDireccion", false);
    renderDirecciones();
});

/* ---------- Nuevo método de pago ---------- */
function luhn(num) {
    let suma = 0, doble = false;
    for (let i = num.length - 1; i >= 0; i--) {
        let d = Number(num[i]);
        if (doble && (d *= 2) > 9) d -= 9;
        suma += d;
        doble = !doble;
    }
    return suma % 10 === 0;
}

function marcaTarjeta(num) {
    if (/^4/.test(num)) return "Visa";
    if (/^(5[1-5]|2[2-7])/.test(num)) return "Mastercard";
    if (/^3[47]/.test(num)) return "Amex";
    return "Tarjeta";
}

$("pNumero").addEventListener("input", (e) => {
    e.target.value = e.target.value.replace(/\D/g, "").slice(0, 16).replace(/(.{4})/g, "$1 ").trim();
});
$("pExpira").addEventListener("input", (e) => {
    const d = e.target.value.replace(/\D/g, "").slice(0, 4);
    e.target.value = d.length > 2 ? `${d.slice(0, 2)}/${d.slice(2)}` : d;
});

$("formPago").addEventListener("submit", (e) => {
    e.preventDefault();
    $("formPago").querySelectorAll(".is-invalid").forEach((el) => el.classList.remove("is-invalid"));
    $("errPago").hidden = true;

    const titular = $("pTitular").value.trim();
    const numero = $("pNumero").value.replace(/\D/g, "");
    const expira = $("pExpira").value;

    if (titular.length < 3) return fallo("errPago", "pTitular", "Escribe el nombre del titular.");
    if (numero.length < 13 || !luhn(numero)) return fallo("errPago", "pNumero", "El número de tarjeta no es válido.");

    const m = /^(0[1-9]|1[0-2])\/(\d{2})$/.exec(expira);
    if (!m) return fallo("errPago", "pExpira", "Usa el formato MM/AA.");
    const vence = new Date(2000 + Number(m[2]), Number(m[1]), 1); // primer día del mes siguiente
    if (vence <= new Date()) return fallo("errPago", "pExpira", "La tarjeta está vencida.");

    const nueva = {
        id: `pago-${Date.now()}`,
        marca: marcaTarjeta(numero),
        ultimos: numero.slice(-4), // nunca se guarda el número completo
        expira,
        titular,
        predeterminada: perfil.pagos.length === 0
    };
    perfil.pagos.push(nueva);
    guardarPerfil(perfil);

    pagoSel = nueva.id;
    toggleForm("formPago", false); // reset() también limpia el número
    renderPagos();
});

renderDirecciones();
renderPagos();