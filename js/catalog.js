// =====================================================
// CATALOG.JS
// El carrusel/carrito compartido se gestiona desde js/cart.js.
// Este archivo queda reservado para lógica exclusiva del catálogo.
// =====================================================

document.addEventListener('DOMContentLoaded', () => {
    // Punto de entrada para futuras funcionalidades exclusivas del catálogo.
    const productGrid = document.querySelector('main .catalog-section .product-grid');
    if (!productGrid) return;

    const template = productGrid.querySelector('template');
    if (!template) return;

    // Productos desde el back (con respaldo en data/productos.json)
    window.PaLaAsadaAPI.obtenerProductos('../data/productos.json')
        .then((productos) => {
            const listaProductos = [...productos, ...leerProductosNuevos()];
            listaProductos.forEach((producto) => {
                const card = crearProductCard(producto, template);
                if (card) {
                    productGrid.appendChild(card);
                }
            });
            // Una vez que ya existen las cards en el DOM, aplica el
            // filtro del botón que esté activo en ese momento
            // (por defecto "CARNE", que trae todo el catálogo).
            aplicarFiltroActivo();
        })
        .catch((error) => {
            console.error('Catálogo: error al cargar productos', error);
        });

    // Productos creados desde /admin (guardados en localStorage)
    function leerProductosNuevos() {
        try {
            const guardados = JSON.parse(localStorage.getItem('productosNuevos'));
            return Array.isArray(guardados) ? guardados : [];
        } catch {
            return [];
        }
    }

    /**
     * Clona el <template> de .product-card y lo rellena con los datos
     * de un producto del JSON.
     */
    function crearProductCard(producto, template) {
        if (!producto) return null;

        const fragment = template.content.cloneNode(true);
        const article = fragment.querySelector('.product-card');
        if (!article) return null;

        const nombre = producto.nombre ?? '';
        const categorias = Array.isArray(producto.categoria) ? producto.categoria : [];
        const infoAdicional = producto.infoAdicional ?? {};
        const inventario = producto.inventario ?? {};
        const precio = producto.precio ?? {};
        const imagenes = producto.imagenes ?? {};
        const agotado = inventario.estado === 'agotado' || Number(inventario.cantidad) <= 0;

        // Identificadores del producto en el propio article, útiles para
        // integrarlo después con el carrito (cart.js) sin tocar clases.
        if (producto.id) article.dataset.productId = producto.id;
        if (producto.sku) article.dataset.sku = producto.sku;
        article.dataset.stock = agotado ? 0 : Number(inventario.cantidad) || 0;

        // Texto normalizado (sin acentos, minúsculas) con nombre + categorías
        // + tags, usado por el filtrado de .category-button para saber si esta
        // card coincide con la categoría o tag elegido (ej. "NUEVO", "HOT SALE").
        article.dataset.search = normalizarTexto(
            [...categorias, ...(producto.tags || []), nombre].join(' '));

        // --- Imagen ---
        const img = article.querySelector('.product-card__image img');
        if (img) {
            const rutaPlaceholder = '../assets/img/catalogo/placeholder.png';
            const rutaLocal = imagenes.local || 'assets/img/catalogo/placeholder.png';
            const prefijo = /^(https?:\/\/|data:)/i.test(rutaLocal) ? '' : '../';
            img.src = prefijo + window.PaLaAsadaAPI.rutaOptimizada(rutaLocal);
            img.alt = nombre;
            // Carga diferida: solo las primeras tarjetas se piden de inmediato,
            // el resto cuando el usuario se acerca al hacer scroll.
            const primeras = productGrid.querySelectorAll('.product-card').length < 4;
            img.loading = primeras ? 'eager' : 'lazy';
            img.decoding = 'async';
            img.width = 500;
            img.height = 500;
            // Si el WebP no existe se prueba el PNG original y, en último caso,
            // el placeholder, en vez de mostrar el ícono roto.
            img.addEventListener('error', () => {
                if (img.src.endsWith('.webp')) {
                    img.addEventListener('error', () => {
                        img.src = rutaPlaceholder;
                    }, { once: true });
                    img.src = prefijo + rutaLocal;
                } else {
                    img.src = rutaPlaceholder;
                }
            }, { once: true });
        }

        // --- Badge ---
        const badge = article.querySelector('.product-card__badge');
        if (badge) {
            let textoBadge = '';
            if (agotado) {
                textoBadge = 'AGOTADO';
            } else if (producto.tags?.length) {
                // Tag asignado desde /admin (tabla producto_tag)
                textoBadge = producto.tags[0].toUpperCase();
            } else if (categorias.includes('Ultra Premium')) {
                textoBadge = 'PREMIUM';
            }
            if (textoBadge) {
                badge.textContent = textoBadge;
                badge.style.display = '';
            } else {
                badge.style.display = 'none';
            }
        }

        // --- Categoría ---
        const categoryEl = article.querySelector('.product-card__category');
        if (categoryEl) {
            const etiquetas = categorias.length > 1 ? categorias.slice(1) : categorias;
            categoryEl.textContent = etiquetas.join(' · ').toUpperCase();
        }

        // --- Título ---
        const titleEl = article.querySelector('.product-card__title');
        if (titleEl) {
            titleEl.textContent = nombre;
        }

        // --- Peso / presentación ---
        const weightEl = article.querySelector('.product-card__weight');
        if (weightEl) {
            const peso = infoAdicional['Peso'];
            if (peso) {
                weightEl.textContent = peso;
                weightEl.style.display = '';
            } else {
                weightEl.style.display = 'none';
            }
        }

        // --- Precio ---
        const priceEl = article.querySelector('.product-card__price');
        if (priceEl) {
            priceEl.textContent = precio.texto || (precio.monto != null ? `$${precio.monto}` : '');
        }

        // --- Botón agregar ---
        const addBtn = article.querySelector('.product-card__add');
        if (addBtn) {
            addBtn.setAttribute('aria-label', agotado
                ? `${nombre} agotado`
                : `Agregar ${nombre} al carrito`);
            if (producto.id) addBtn.dataset.id = producto.id;
            if (producto.sku) addBtn.dataset.sku = producto.sku;
            addBtn.dataset.agotado = agotado ? 'true' : 'false';
            addBtn.setAttribute('aria-disabled', agotado ? 'true' : 'false');
            addBtn.classList.toggle('product-card__add--agotado', agotado);
        }

        return article;
    }

    // =====================================================
    // SECCIÓN: FILTRADO POR CATEGORÍA
    // Botones en <section class="category-section"> → .category-list > .category-button
    // =====================================================

    const categoryList = document.querySelector('.category-section .category-list');

    if (categoryList) {
        // Delegación de eventos: un solo listener en el contenedor sirve
        // para todos los .category-button actuales y para los que se
        // agreguen o eliminen a futuro (no hace falta volver a engancharlos).
        categoryList.addEventListener('click', (event) => {
            const boton = event.target.closest('.category-button');
            if (!boton || !categoryList.contains(boton)) return;

            categoryList
                .querySelectorAll('.category-button')
                .forEach((btn) => btn.classList.remove('category-button--active'));
            boton.classList.add('category-button--active');

            aplicarFiltro(boton.textContent);
        });
    }

    // =====================================================
    // SECCIÓN: BARRA DE BÚSQUEDA
    // Filtra en vivo al escribir, con Enter o con el botón "Buscar".
    // =====================================================

    const searchInput = document.querySelector('.search-box__input');
    const searchButton = document.querySelector('.search-box__button');

    if (searchInput) {
        searchInput.addEventListener('input', aplicarFiltroActivo);
        searchInput.addEventListener('keydown', (event) => {
            if (event.key === 'Enter') {
                event.preventDefault();
                aplicarFiltroActivo();
            }
        });
    }
    if (searchButton) {
        searchButton.addEventListener('click', aplicarFiltroActivo);
    }

    /**
     * Aplica el filtro correspondiente al botón .category-button--active
     * actual (o muestra todo si no hay ninguno activo). Se llama otra vez
     * después de cargar los productos por si el usuario hizo clic en un
     * botón antes de que terminara el fetch.
     */
    function aplicarFiltroActivo() {
        const botonActivo = categoryList?.querySelector('.category-button--active');
        aplicarFiltro(botonActivo ? botonActivo.textContent : '');
    }

    /**
     * Muestra u oculta las .product-card ya renderizadas según si su
     * data-search contiene el texto del botón de categoría clickeado.
     */
    function aplicarFiltro(textoBoton) {
        const filtro = normalizarTexto(textoBoton);
        const busqueda = normalizarTexto(searchInput?.value);
        const palabras = busqueda.split(/\s+/).filter((palabra) => palabra && !PALABRAS_VACIAS.has(palabra));
        const cards = productGrid.querySelectorAll('.product-card');
        let visibles = 0;

        cards.forEach((card) => {
            const texto = card.dataset.search || '';
            const coincide = (!filtro || texto.includes(filtro))
                && palabras.every((palabra) => texto.includes(palabra));
            card.style.display = coincide ? '' : 'none';
            if (coincide) visibles += 1;
        });

        const mensajeVacio = document.querySelector('.product-grid__empty');
        if (mensajeVacio) {
            mensajeVacio.hidden = visibles > 0;
        }
    }

    /**
     * Quita acentos, pasa a minúsculas y recorta espacios, para poder
     * comparar el texto de un botón (ej. "NACIONAL") contra las
     * categorías del producto (ej. "Nacional") sin importar mayúsculas
     * o tildes.
     */
    function normalizarTexto(texto) {
        return (texto || '')
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .toLowerCase()
            .trim();
    }

    // Palabras sin valor para la b\u00fasqueda (ej. "corte de res" -> "corte res"),
    // para que una frase natural no falle por incluir un art\u00edculo o preposici\u00f3n.
    const PALABRAS_VACIAS = new Set([
        'de', 'del', 'la', 'las', 'el', 'los', 'un', 'una', 'unos', 'unas',
        'para', 'con', 'sin', 'y', 'o', 'en', 'a', 'al', 'que',
    ]);
});
 

/*NOTA IMPORTANTE, POR FAVOR LEER ANTES DE REALIZAR OTRA ACCION
Botones sin datos correspondientes en el JSON todavía 
(NUEVO, DESCUENTO, MÁS VENDIDO, HOT SALE) 
simplemente no van a mostrar ninguna card por ahora,
En cuanto se agreguen al JSON bastaría con incluirlos en el 
data-search para que SE empiecen a filtrar solos.

En el responsive design checar la seccion de categorias, ya que en pantallas
chicas web, este no funciona adecuadamente
*/ 