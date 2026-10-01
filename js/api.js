// =====================================================
// API.JS
// Conexión con el backend (Spring Boot). Cambia API_URL si el
// back corre en otro host/puerto.
// =====================================================

(function () {
    const API_URL = "http://localhost:8080";

    // Convierte un Producto del back al formato que usan catalog.js,
    // productModal.js y cart.js (el mismo de data/productos.json).
    function adaptarProducto(p) {
        const precio = p.precio ?? {};
        const inventario = p.inventario ?? {};
        const info = p.informacionAdicional ?? {};
        const imagen = p.imagen ?? {};

        const infoAdicional = {};
        if (info.peso) infoAdicional["Peso"] = info.peso;
        if (info.lugarOrigen) infoAdicional["Lugar de orígen"] = info.lugarOrigen;
        if (info.nivelMarmoleado) infoAdicional["Nivel de Marmoleado"] = info.nivelMarmoleado;
        if (info.maridaje) infoAdicional["Maridaje"] = info.maridaje;

        const monto = precio.monto != null ? Number(precio.monto) : null;

        return {
            id: p.id,
            sku: p.sku,
            nombre: p.nombre,
            // Todos son carne; la categoría principal añade el tipo (Res, Picaña...)
            categoria: p.categoriaPrincipal?.nombre && p.categoriaPrincipal.nombre !== "Carne"
                ? ["Carne", p.categoriaPrincipal.nombre]
                : ["Carne"],
            precio: {
                monto,
                moneda: precio.moneda || "MXN",
                texto: precio.texto || (monto != null ? `$${monto.toFixed(2)}` : ""),
                nota: precio.nota ?? null,
            },
            inventario: {
                estado: inventario.estado || "disponible",
                cantidad: inventario.cantidad ?? 0,
                sku: p.sku,
            },
            tieneVariantes: !!p.tieneVariantes,
            descripcion: p.descripcion || "",
            infoAdicional,
            imagenes: {
                url: imagen.url || null,
                remota: imagen.remota || null,
                local: imagen.local || imagen.remota || null,
            },
        };
    }

    // El back solo expone la categoría principal; las demás etiquetas
    // (Res, Nacional, USA...) se toman de productos.json por id para que
    // los filtros del catálogo sigan funcionando.
    async function completarCategorias(productos, rutaJson) {
        try {
            const res = await fetch(rutaJson);
            if (!res.ok) return;
            const data = await res.json();
            const porId = new Map((data?.productos ?? []).map((p) => [p.id, p.categoria]));
            productos.forEach((p) => {
                const categorias = porId.get(p.id);
                if (Array.isArray(categorias) && categorias.length) p.categoria = categorias;
            });
        } catch { /* sin respaldo: se queda la categoría principal */ }
    }

    // Productos desde el back; si no responde, cae en data/productos.json.
    // rutaJson: ruta a productos.json relativa a la página actual.
    async function obtenerProductos(rutaJson) {
        try {
            const res = await fetch(`${API_URL}/productos`);
            if (!res.ok) throw new Error(`status ${res.status}`);
            const data = await res.json();
            const productos = data.map(adaptarProducto);
            await completarCategorias(productos, rutaJson);
            return productos;
        } catch (error) {
            console.warn("API: no se pudo leer /productos, se usa productos.json", error);
            const res = await fetch(rutaJson);
            if (!res.ok) throw new Error(`No se pudo cargar productos.json (status ${res.status})`);
            const data = await res.json();
            return Array.isArray(data?.productos) ? data.productos : [];
        }
    }

    // POST a /auth/*. Devuelve { ok, status, data } sin lanzar por 4xx.
    async function postAuth(ruta, cuerpo) {
        try {
            const res = await fetch(`${API_URL}/auth/${ruta}`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(cuerpo),
            });
            const texto = await res.text();
            let data = texto;
            try { data = JSON.parse(texto); } catch { /* respuesta de texto plano */ }
            return { ok: res.ok, status: res.status, data };
        } catch (error) {
            return { ok: false, status: 0, data: "No se pudo conectar con el servidor" };
        }
    }

    // Las imágenes locales del catálogo existen también en WebP (≈8 veces
    // más ligeras). Devuelve la ruta .webp; si falla, usa el PNG original.
    function rutaOptimizada(ruta) {
        return /^assets\/img\/catalogo\/.+\.png$/i.test(ruta || "")
            ? ruta.replace(/\.png$/i, ".webp")
            : ruta;
    }

    // Petición autenticada (token JWT del admin). Devuelve { ok, status, data }.
    async function peticion(metodo, ruta, cuerpo) {
        const headers = { "Content-Type": "application/json" };
        const token = localStorage.getItem("token");
        if (token) headers["Authorization"] = `Bearer ${token}`;
        try {
            const res = await fetch(`${API_URL}${ruta}`, {
                method: metodo,
                headers,
                body: cuerpo ? JSON.stringify(cuerpo) : undefined,
            });
            const texto = await res.text();
            let data = texto;
            try { data = JSON.parse(texto); } catch { /* texto plano o vacío */ }
            return { ok: res.ok, status: res.status, data };
        } catch {
            return { ok: false, status: 0, data: "No se pudo conectar con el servidor" };
        }
    }

    window.PaLaAsadaAPI = {
        rutaOptimizada,
        adaptarProducto,
        peticion,
        API_URL,
        obtenerProductos,
        login: (correo, password) => postAuth("login", { correo, password }),
        registrar: (nombre, correo, telefono, password) =>
            postAuth("register", { nombre, correo, telefono, password }),
        token: () => localStorage.getItem("token"),
    };
})();
