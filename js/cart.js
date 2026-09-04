/* =========================================================
   CARRITO - COMPONENTE COMPARTIDO ENTRE INDEX Y CATÁLOGO
   ========================================================= */

(() => {

    const STORAGE_KEY = 'paLaAsadaCart';

    // =====================================================
    // LEER CARRITO DESDE LOCALSTORAGE
    // =====================================================

    const readCart = () => {
        try {
            const stored = JSON.parse(localStorage.getItem(STORAGE_KEY));
            return Array.isArray(stored) ? stored : [];
        } catch {
            return [];
        }
    };

    let cart = readCart();

    // =====================================================
    // GUARDAR CARRITO
    // =====================================================

    const saveCart = () => {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(cart));

        updateBadges();
        renderCart();
    };

    // =====================================================
    // FORMATO DE DINERO
    // =====================================================

    const formatMoney = (value) => {
        return new Intl.NumberFormat('es-MX', {
            style: 'currency',
            currency: 'MXN',
            minimumFractionDigits: 2
        }).format(value);
    };

    // =====================================================
    // CONVERTIR PRECIO DE TEXTO A NÚMERO
    // =====================================================

    const parsePrice = (text) => {
        const match = String(text)
            .replace(/,/g, '')
            .match(/\d+(?:\.\d+)?/);

        return match ? Number(match[0]) : 0;
    };

    // =====================================================
    // CREAR ID A PARTIR DEL NOMBRE
    // =====================================================

    const slugify = (text) => {
        return String(text)
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .toLowerCase()
            .replace(/[^a-z0-9]+/g, '-')
            .replace(/^-|-$/g, '');
    };

    // =====================================================
    // OBTENER PRODUCTO DESDE LA TARJETA HTML
    // =====================================================

    const getProductFromCard = (card) => {

        const nameElement = card.querySelector(
            '.product-card__title, .product-card__name'
        );

        const priceElement = card.querySelector(
            '.product-card__price'
        );

        const imageElement = card.querySelector(
            '.product-card__image img'
        );

        const name = nameElement?.textContent
            .replace(/\s+/g, ' ')
            .trim();

        const priceText = priceElement?.textContent
            .replace(/\s+/g, ' ')
            .trim();

        if (!name || !priceText) {
            return null;
        }

        const price = parsePrice(priceText);

        if (!price) {
            return null;
        }

        return {
            id: `${slugify(name)}-${price}`,
            name,
            price,
            priceText,
            image: imageElement?.src || '',
            quantity: 1
        };
    };

    // =====================================================
    // CANTIDAD TOTAL DE PRODUCTOS
    // =====================================================

    const getQuantity = () => {
        return cart.reduce(
            (total, item) => total + item.quantity,
            0
        );
    };

    // =====================================================
    // TOTAL DEL CARRITO
    // =====================================================

    const getTotal = () => {
        return cart.reduce(
            (total, item) => total + (item.price * item.quantity),
            0
        );
    };

    // =====================================================
    // ACTUALIZAR CONTADORES DEL CARRITO
    // =====================================================

    const updateBadges = () => {

        const count = getQuantity();

        document.querySelectorAll('.cart-badge').forEach((badge) => {

            badge.textContent = count;

            badge.setAttribute(
                'aria-label',
                `${count} producto${count === 1 ? '' : 's'} en el carrito`
            );

        });
    };

    // =====================================================
    // ABRIR CARRITO
    // =====================================================

    const openCart = () => {

        const drawer = document.querySelector('.cart-drawer');
        const backdrop = document.querySelector('.cart-drawer-backdrop');
        const closeButton = document.querySelector('.cart-drawer__close');

        drawer?.classList.add('is-open');
        backdrop?.classList.add('is-open');

        document.body.classList.add('cart-is-open');

        drawer?.setAttribute('aria-hidden', 'false');

        closeButton?.focus();
    };

    // =====================================================
    // CERRAR CARRITO
    // =====================================================

    const closeCart = () => {

        const drawer = document.querySelector('.cart-drawer');
        const backdrop = document.querySelector('.cart-drawer-backdrop');

        drawer?.classList.remove('is-open');
        backdrop?.classList.remove('is-open');

        document.body.classList.remove('cart-is-open');

        drawer?.setAttribute('aria-hidden', 'true');
    };

    // =====================================================
    // MENSAJE TEMPORAL
    // =====================================================

    const showToast = (message) => {

        const toast = document.querySelector('.cart-toast');

        if (!toast) {
            return;
        }

        toast.textContent = message;
        toast.classList.add('is-visible');

        clearTimeout(showToast.timer);

        showToast.timer = setTimeout(() => {
            toast.classList.remove('is-visible');
        }, 1800);
    };

    // =====================================================
    // AGREGAR PRODUCTO
    // =====================================================

    const addProduct = (card) => {

        const product = getProductFromCard(card);

        if (!product) {
            return;
        }

        const existing = cart.find(
            (item) => item.id === product.id
        );

        if (existing) {

            existing.quantity += 1;

        } else {

            cart.push(product);

        }

        saveCart();

        showToast(
            `${product.name} agregado al carrito`
        );
    };

    // =====================================================
    // CAMBIAR CANTIDAD
    // =====================================================

    const changeQuantity = (id, delta) => {

        const item = cart.find(
            (product) => product.id === id
        );

        if (!item) {
            return;
        }

        item.quantity += delta;

        if (item.quantity <= 0) {

            cart = cart.filter(
                (product) => product.id !== id
            );

        }

        saveCart();
    };

    // =====================================================
    // ELIMINAR PRODUCTO
    // =====================================================

    const removeProduct = (id) => {

        cart = cart.filter(
            (item) => item.id !== id
        );

        saveCart();
    };

    // =====================================================
    // VACIAR CARRITO
    // =====================================================

    const clearCart = () => {

        if (!cart.length) {
            return;
        }

        cart = [];

        saveCart();

        showToast('Carrito vaciado');
    };

    // =====================================================
    // MOSTRAR CARRITO
    // =====================================================

    const renderCart = () => {

        const body = document.querySelector(
            '.cart-drawer__body'
        );

        const totalElement = document.querySelector(
            '.cart-drawer__total'
        );

        const checkoutButton = document.querySelector(
            '.cart-drawer__checkout'
        );

        const clearButton = document.querySelector(
            '.cart-drawer__clear'
        );

        const countElement = document.querySelector(
            '.cart-drawer__count'
        );

        if (!body) {
            return;
        }

        const count = getQuantity();

        if (countElement) {
            countElement.textContent =
                `${count} producto${count === 1 ? '' : 's'}`;
        }

        if (totalElement) {
            totalElement.textContent =
                formatMoney(getTotal());
        }

        if (checkoutButton) {
            checkoutButton.disabled = cart.length === 0;
        }

        if (clearButton) {
            clearButton.disabled = cart.length === 0;
        }

        // =================================================
        // CARRITO VACÍO
        // =================================================

        if (!cart.length) {

            body.innerHTML = `
                <div class="cart-drawer__empty">
                    <div>
                        <i class="bi bi-cart-x" aria-hidden="true"></i>

                        <p>Tu carrito está vacío.</p>

                        <p>
                            Agrega tus cortes favoritos para comenzar.
                        </p>
                    </div>
                </div>
            `;

            return;
        }

        // =================================================
        // PRODUCTOS DEL CARRITO
        // =================================================

        body.innerHTML = cart.map((item) => `

            <article class="cart-item">

                <div class="cart-item__image">

                    <img
                        src="${escapeHtml(item.image)}"
                        alt="${escapeHtml(item.name)}"
                        loading="lazy"
                    >

                </div>

                <div>

                    <h3 class="cart-item__name">
                        ${escapeHtml(item.name)}
                    </h3>

                    <p class="cart-item__price">
                        ${escapeHtml(item.priceText)}
                    </p>

                    <div
                        class="cart-item__controls"
                        aria-label="Cantidad de ${escapeHtml(item.name)}"
                    >

                        <button
                            class="cart-item__quantity-btn"
                            type="button"
                            data-cart-action="decrease"
                            data-cart-id="${escapeHtml(item.id)}"
                            aria-label="Disminuir cantidad"
                        >
                            −
                        </button>

                        <span class="cart-item__quantity">
                            ${item.quantity}
                        </span>

                        <button
                            class="cart-item__quantity-btn"
                            type="button"
                            data-cart-action="increase"
                            data-cart-id="${escapeHtml(item.id)}"
                            aria-label="Aumentar cantidad"
                        >
                            +
                        </button>

                    </div>

                    <button
                        class="cart-item__remove"
                        type="button"
                        data-cart-action="remove"
                        data-cart-id="${escapeHtml(item.id)}"
                    >
                        Eliminar
                    </button>

                </div>

                <span class="cart-item__subtotal">
                    ${formatMoney(item.price * item.quantity)}
                </span>

            </article>

        `).join('');
    };

    // =====================================================
    // PROTEGER HTML
    // =====================================================

    const escapeHtml = (value) => {

        return String(value)
            .replaceAll('&', '&amp;')
            .replaceAll('<', '&lt;')
            .replaceAll('>', '&gt;')
            .replaceAll('"', '&quot;')
            .replaceAll("'", '&#039;');

    };

    // =====================================================
    // CREAR ESTRUCTURA DEL CARRITO
    // =====================================================

    const injectCart = () => {

        if (document.querySelector('.cart-drawer')) {
            return;
        }

        document.body.insertAdjacentHTML('beforeend', `

            <div
                class="cart-drawer-backdrop"
                aria-hidden="true"
            ></div>

            <aside
                class="cart-drawer"
                aria-label="Carrito de compras"
                aria-hidden="true"
            >

                <header class="cart-drawer__header">

                    <div>

                        <h2 class="cart-drawer__title">
                            Tu carrito
                        </h2>

                        <small class="cart-drawer__count">
                            0 productos
                        </small>

                    </div>

                    <button
                        class="cart-drawer__close"
                        type="button"
                        aria-label="Cerrar carrito"
                    >

                        <i
                            class="bi bi-x-lg"
                            aria-hidden="true"
                        ></i>

                    </button>

                </header>

                <div class="cart-drawer__body"></div>

                <footer class="cart-drawer__footer">

                    <div class="cart-drawer__summary">

                        <span>Total</span>

                        <span class="cart-drawer__total">
                            $0.00
                        </span>

                    </div>

                    <button
                        class="cart-drawer__checkout"
                        type="button"
                        disabled
                    >
                        Continuar con el pedido
                    </button>

                    <button
                        class="cart-drawer__clear"
                        type="button"
                        disabled
                    >
                        Vaciar carrito
                    </button>

                </footer>

            </aside>

            <div
                class="cart-toast"
                role="status"
                aria-live="polite"
            ></div>

        `);

        renderCart();
    };

    // =====================================================
    // EVENTOS DE CLICK
    // =====================================================

    document.addEventListener('click', (event) => {

        // Abrir carrito
        const cartTrigger = event.target.closest(
            '.icon-btn[aria-label="Ver carrito"]'
        );

        if (cartTrigger) {

            event.preventDefault();

            openCart();

            return;
        }

        // Agregar producto
        const addButton = event.target.closest(
            '.product-card__add'
        );

        if (addButton) {

            const card = addButton.closest(
                '.product-card'
            );

            if (card) {
                addProduct(card);
            }

            return;
        }

        // Acciones dentro del carrito
        const actionButton = event.target.closest(
            '[data-cart-action]'
        );

        if (actionButton) {

            const {
                cartAction,
                cartId
            } = actionButton.dataset;

            if (cartAction === 'increase') {
                changeQuantity(cartId, 1);
            }

            if (cartAction === 'decrease') {
                changeQuantity(cartId, -1);
            }

            if (cartAction === 'remove') {
                removeProduct(cartId);
            }

            return;
        }

        // Cerrar carrito
        if (
            event.target.closest(
                '.cart-drawer__close, .cart-drawer-backdrop'
            )
        ) {

            closeCart();

            return;
        }

        // Vaciar carrito
        if (
            event.target.closest('.cart-drawer__clear')
        ) {

            clearCart();

            return;
        }

        // Checkout
        if (
            event.target.closest('.cart-drawer__checkout')
        ) {

            if (!cart.length) {
                return;
            }

            showToast(
                'El checkout se conectará en la siguiente etapa'
            );
        }

    });

    // =====================================================
    // CERRAR CON ESC
    // =====================================================

    document.addEventListener('keydown', (event) => {

        if (event.key === 'Escape') {
            closeCart();
        }

    });

    // =====================================================
    // SINCRONIZAR ENTRE PESTAÑAS
    // =====================================================

    window.addEventListener('storage', (event) => {

        if (event.key !== STORAGE_KEY) {
            return;
        }

        cart = readCart();

        updateBadges();

        renderCart();
    });

    // =====================================================
    // INICIALIZAR
    // =====================================================

    document.addEventListener('DOMContentLoaded', () => {

        injectCart();

        updateBadges();

    });

})();