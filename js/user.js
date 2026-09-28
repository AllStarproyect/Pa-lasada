/* =========================================================
   USER PROFILE
   - "usuario" / "usuarioLogueado": los escribe sign-in.js
   - "usuarioPerfil": datos extra del perfil (puntos, pagos,
     pedidos, favoritos, dirección). Se crean con mock data
     si aún no existen.
   ========================================================= */

const KEY_USER = "usuario";
const KEY_PROFILE = "usuarioPerfil";
const SIGN_IN_URL = "./sign-in.html"; // en este proyecto el login es sign-in.html
const POINTS_GOAL = 5000;

/* Catálogo para el selector de favoritos (rutas relativas a /pages) */
const CATALOGO = [
    { id: "arrachera", nombre: "Arrachera Premium", precio: 199, img: "../assets/img/image_a871302d.png", desc: "Suave, jugosa, marinada con la receta secreta de la casa." },
    { id: "ribeye", nombre: "Ribeye High Choice", precio: 218, img: "../assets/img/Rib Eye.png", desc: "Excelente marmoleo, grasa perfecto para sellado intenso." },
    { id: "tomahawk", nombre: "Tomahawk", precio: 820, img: "../assets/img/tomahawk.png", desc: "Corte con hueso largo, ideal para compartir en la parrilla." },
    { id: "newyork", nombre: "New York Angus", precio: 620, img: "../assets/img/New york.png", desc: "Firme y con sabor profundo, con una franja de grasa lateral." },
    { id: "vacio", nombre: "Vacío Uruguayo", precio: 249, img: "../assets/img/catalogo/vacio-importado-removebg-preview.png", desc: "Corte jugoso para cocción lenta a fuego medio." },
    { id: "picana", nombre: "Picaña Choice", precio: 380, img: "../assets/img/catalogo/picaña_choice.png", desc: "Capa de grasa que se derrite y aromatiza la carne." }
];

const $ = (id) => document.getElementById(id);
const money = (n) => new Intl.NumberFormat("es-MX", { style: "currency", currency: "MXN" }).format(n);

/* ---------- Helpers de storage ---------- */
function readJSON(key) {
    try { return JSON.parse(localStorage.getItem(key)); } catch { return null; }
}

/* ---------- 1. Protección de ruta ---------- */
const user = readJSON(KEY_USER);
if (!user || localStorage.getItem("usuarioLogueado") !== "true") {
    window.location.href = SIGN_IN_URL;
    throw new Error("Sesión no encontrada: redirigiendo a inicio de sesión.");
}

/* ---------- 2. Datos simulados (solo si faltan) ---------- */
function initMockProfile() {
    if (readJSON(KEY_PROFILE)) return;
    localStorage.setItem(KEY_PROFILE, JSON.stringify({
        direccion: "Av. Vasconcelos 402, San Pedro Garza García, NL, CP 66220",
        miembroDesde: "Nov 2023",
        puntos: 4250,
        pagos: [
            { marca: "Visa", ultimos: "4621", expira: "12/26", predeterminada: true },
            { marca: "Mastercard", ultimos: "9530", expira: "08/27", predeterminada: false }
        ],
        pedidos: [
            { id: "ORD-0642", fecha: "12 de Octubre, 2024", resumen: "2x Arrachera Premium (1.5kg), 1x Ribeye Tomahawk (2.2kg)", total: 1840, estado: "Entregado" },
            { id: "ORD-0711", fecha: "28 de Septiembre, 2024", resumen: "1x Costilla de cerdo (2kg), 1x Chorizo Argentino", total: 945, estado: "Entregado" },
            { id: "ORD-0530", fecha: "04 de Agosto, 2024", resumen: "2x Vacío Uruguayo (1.8kg), 1x Salsa Chimichurri Artesanal", total: 2150, estado: "Entregado" }
        ],
        favoritos: ["arrachera", "ribeye"]
    }));
}
initMockProfile();
let perfil = readJSON(KEY_PROFILE);

const savePerfil = () => localStorage.setItem(KEY_PROFILE, JSON.stringify(perfil));

/* ---------- 3. Render ---------- */
function renderBanner() {
    $("userName").textContent = user.nombreCompleto || user.username || "Usuario";
    $("userSince").textContent = `Miembro desde ${perfil.miembroDesde}`;
    $("userPoints").textContent = `${perfil.puntos} pts`;

    const pct = Math.min(100, Math.round((perfil.puntos / POINTS_GOAL) * 100));
    $("pointsBar").style.width = `${pct}%`;
    document.querySelector(".progress-track").setAttribute("aria-valuenow", pct);
    const faltan = Math.max(0, POINTS_GOAL - perfil.puntos);
    $("pointsNext").textContent = faltan
        ? `Te faltan ${faltan} pts para tu siguiente recompensa (${POINTS_GOAL.toLocaleString("es-MX")} pts)`
        : "¡Ya puedes canjear tu recompensa!";
}

function renderInfo() {
    $("fEmail").value = user.email || "";
    $("fPhone").value = user.telefono || "";
    $("fAddress").value = perfil.direccion || "";
}

function renderCards() {
    const list = $("cardList");
    list.replaceChildren();
    perfil.pagos.forEach((p) => {
        const li = document.createElement("li");
        const brand = document.createElement("span");
        brand.className = `card-brand card-brand--${p.marca.toLowerCase()}`;
        brand.textContent = p.marca;

        const meta = document.createElement("div");
        meta.className = "card-meta";
        meta.innerHTML = "<strong></strong><small></small>";
        meta.querySelector("strong").textContent = `•••• ${p.ultimos}`;
        meta.querySelector("small").textContent = `Expira ${p.expira}`;

        li.append(brand, meta);
        if (p.predeterminada) {
            const tag = document.createElement("span");
            tag.className = "card-default";
            tag.textContent = "Predeterminada";
            li.append(tag);
        }
        list.append(li);
    });
}

function renderOrders() {
    const list = $("orderList");
    list.replaceChildren();
    perfil.pedidos.forEach((o) => {
        const li = document.createElement("li");
        li.innerHTML = `
            <div class="order-top"><strong></strong><time></time><span class="order-status"></span></div>
            <p class="order-items"></p>
            <div class="order-total"><span>Total del pedido</span><strong></strong></div>`;
        li.querySelector("strong").textContent = `#${o.id}`;
        li.querySelector("time").textContent = `• ${o.fecha}`;
        li.querySelector(".order-status").textContent = o.estado;
        li.querySelector(".order-items").textContent = o.resumen;
        li.querySelector(".order-total strong").textContent = money(o.total);
        list.append(li);
    });
}

function renderFavPicker() {
    const box = $("favPicker");
    box.replaceChildren();
    CATALOGO.forEach((c) => {
        const label = document.createElement("label");
        const input = document.createElement("input");
        input.type = "checkbox";
        input.value = c.id;
        input.checked = perfil.favoritos.includes(c.id);
        label.append(input, document.createTextNode(c.nombre));
        box.append(label);
    });
}

function renderFavCards() {
    const grid = $("favGrid");
    grid.replaceChildren();
    const favs = CATALOGO.filter((c) => perfil.favoritos.includes(c.id));

    if (!favs.length) {
        const p = document.createElement("p");
        p.className = "fav-empty";
        p.textContent = "Aún no tienes favoritos. Elige tus cortes en la lista de arriba.";
        grid.append(p);
        return;
    }
    favs.forEach((c) => {
        const art = document.createElement("article");
        art.className = "fav-card";
        art.innerHTML = `<img alt="" loading="lazy"><div class="fav-card__body">
            <h4></h4><span class="fav-card__price"></span><p></p></div>`;
        const img = art.querySelector("img");
        img.src = c.img;
        img.alt = c.nombre;
        img.addEventListener("error", () => { img.removeAttribute("src"); }, { once: true });
        art.querySelector("h4").textContent = c.nombre;
        art.querySelector(".fav-card__price").textContent = `${money(c.precio)}/kg`;
        art.querySelector("p").textContent = c.desc;
        grid.append(art);
    });
}

/* ---------- 4. Favoritos: checkboxes ---------- */
$("favPicker").addEventListener("change", () => {
    perfil.favoritos = [...$("favPicker").querySelectorAll("input:checked")].map((i) => i.value);
    savePerfil();
    renderFavCards();
});

/* ---------- 5. Edición in-situ ---------- */
const fields = ["fEmail", "fPhone", "fAddress"].map($);
const btnEdit = $("btnEdit");
const msg = $("profileMsg");
let editing = false;

function showMsg(text, isError = false) {
    msg.hidden = !text;
    msg.textContent = text;
    msg.classList.toggle("is-error", isError);
}

function validate() {
    fields.forEach((f) => f.classList.remove("is-invalid"));
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test($("fEmail").value.trim())) {
        $("fEmail").classList.add("is-invalid");
        return "Correo inválido. Usa un formato como usuario@dominio.com.";
    }
    if (!/^[0-9]{10}$/.test($("fPhone").value.trim())) {
        $("fPhone").classList.add("is-invalid");
        return "Teléfono inválido. Debe tener exactamente 10 números.";
    }
    if ($("fAddress").value.trim().length < 10) {
        $("fAddress").classList.add("is-invalid");
        return "La dirección debe tener al menos 10 caracteres.";
    }
    return "";
}

btnEdit.addEventListener("click", () => {
    if (!editing) {
        editing = true;
        fields.forEach((f) => (f.readOnly = false));
        btnEdit.textContent = "Guardar cambios";
        btnEdit.classList.add("is-saving");
        showMsg("");
        $("fEmail").focus();
        return;
    }

    const error = validate();
    if (error) { showMsg(error, true); return; }

    user.email = $("fEmail").value.trim();
    user.telefono = $("fPhone").value.trim();
    perfil.direccion = $("fAddress").value.trim();
    localStorage.setItem(KEY_USER, JSON.stringify(user));
    localStorage.setItem("email", user.email); // sign-in.js también lo guarda aparte
    savePerfil();

    editing = false;
    fields.forEach((f) => (f.readOnly = true));
    btnEdit.textContent = "Editar";
    btnEdit.classList.remove("is-saving");
    showMsg("Cambios guardados.");
    setTimeout(() => showMsg(""), 2500);
});

$("fPhone").addEventListener("input", (e) => {
    e.target.value = e.target.value.replace(/\D/g, "").slice(0, 10);
});

/* Agregar tarjeta: pendiente de la pasarela de pago */
$("btnAddCard").addEventListener("click", () => {
    alert("Agregar métodos de pago estará disponible cuando se integre la pasarela de pago.");
});

/* ---------- Inicio ---------- */
renderBanner();
renderInfo();
renderCards();
renderOrders();
renderFavPicker();
renderFavCards();