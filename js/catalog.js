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
});
