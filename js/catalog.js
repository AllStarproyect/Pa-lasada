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

    // Ruta relativa a data/productos.json desde pages/catalog.html
    fetch('../data/productos.json')
        .then((response) => {
            if (!response.ok) {
                throw new Error(`No se pudo cargar productos.json (status ${response.status})`);
            }
            return response.json();
        })
        .then((data) => {
            const listaProductos = Array.isArray(data?.productos) ? data.productos : [];
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
            console.error('Catálogo: error al cargar productos.json', error);
        });

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
        const agotado = inventario.estado === 'agotado';

        // Identificadores del producto en el propio article, útiles para
        // integrarlo después con el carrito (cart.js) sin tocar clases.
        if (producto.id) article.dataset.productId = producto.id;
        if (producto.sku) article.dataset.sku = producto.sku;

        // Texto normalizado (sin acentos, minúsculas) con nombre + categorías,
        // usado por el filtrado de .category-button para saber si esta card
        // coincide con la categoría elegida.
        article.dataset.search = normalizarTexto([...categorias, nombre].join(' '));

        // --- Imagen ---
        const img = article.querySelector('.product-card__image img');
        if (img) {
            const rutaLocal = imagenes.local || 'assets/img/catalogo/placeholder.png';
            const esUrlAbsoluta = /^https?:\/\//i.test(rutaLocal);
            img.src = esUrlAbsoluta ? rutaLocal : `../${rutaLocal}`;
            img.alt = nombre;
        }

        // --- Badge ---
        const badge = article.querySelector('.product-card__badge');
        if (badge) {
            let textoBadge = '';
            if (agotado) {
                textoBadge = 'AGOTADO';
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
            addBtn.disabled = agotado;
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
        const cards = productGrid.querySelectorAll('.product-card');

        cards.forEach((card) => {
            const coincide = !filtro || (card.dataset.search || '').includes(filtro);
            card.style.display = coincide ? '' : 'none';
        });
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