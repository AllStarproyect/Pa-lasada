/* =========================================================
   CARRITO - COMPONENTE COMPARTIDO ENTRE INDEX Y CATÁLOGO
   ========================================================= */

(() => {

    const STORAGE_KEY = 'paLaAsadaCart';
    const pedidoUrl = new URL('../pages/pedido.html', document.currentScript.src);

    // =====================================================
    // LÍMITE DE PESO DEL PEDIDO
    // =====================================================

    const MAX_WEIGHT_KG = 10;     // peso máximo permitido por pedido (inicio y catálogo)
    const DEFAULT_WEIGHT_KG = 1;  // se usa si un producto no indica su peso

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
    // CONVERTIR PESO DE TEXTO A KILOS
    // "350 g aprox." -> 0.35   |   "1 kg" -> 1   |   "1,5 kg" -> 1.5
    // =====================================================

    const parseWeightKg = (text) => {
        const match = String(text || '')
            .toLowerCase()
            .replace(',', '.')
            .match(/(\d+(?:\.\d+)?)\s*(kg|kilo|kilos|g|gr|grs|gramos)\b/);

        if (!match) {
            return null;
        }

        const value = Number(match[1]);
        const unit = match[2];

        return unit.startsWith('k') ? value : value / 1000;
    };

    // Kilos con máximo 2 decimales: 4.35 kg
    const formatKg = (value) => {
        return `${Number(value.toFixed(2))} kg`;
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

        const weightElement = card.querySelector(
            '.product-card__weight'
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

        // Peso de una pieza (si la tarjeta no lo indica, se usa el valor por defecto)
        const weightKg =
            parseWeightKg(weightElement?.textContent) ?? DEFAULT_WEIGHT_KG;

        return {
            id: `${slugify(name)}-${price}`,
            name,
            price,
            priceText,
            image: imageElement?.src || '',
            weightKg,
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
    // PESO DEL CARRITO
    // =====================================================

    // Peso de una pieza (carritos guardados antes de este cambio no traen weightKg)
    const getItemWeight = (item) => {
        return Number(item.weightKg) > 0 ? Number(item.weightKg) : DEFAULT_WEIGHT_KG;
    };

    const getTotalWeight = () => {
        return cart.reduce(
            (total, item) => total + (getItemWeight(item) * item.quantity),
            0
        );
    };

    // ¿Cabe este peso extra sin pasar del máximo? (el 0.0001 evita errores de decimales)
    const fitsInLimit = (extraKg) => {
        return getTotalWeight() + extraKg <= MAX_WEIGHT_KG + 0.0001;
    };

    const showWeightLimitMessage = () => {
        const available = Math.max(0, MAX_WEIGHT_KG - getTotalWeight());

        showToast(
            `Tu pedido no puede superar ${MAX_WEIGHT_KG} kg. ` +
            `Te quedan ${formatKg(available)} disponibles.`,
            'error'
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

    const showToast = (message, type = 'info') => {

        const toast = document.querySelector('.cart-toast');

        if (!toast) {
            return;
        }

        toast.textContent = message;
        toast.classList.toggle('is-error', type === 'error');
        toast.classList.add('is-visible');

        clearTimeout(showToast.timer);

        showToast.timer = setTimeout(() => {
            toast.classList.remove('is-visible');
        }, type === 'error' ? 3200 : 1800);
    };

    // =====================================================
    // AGREGAR PRODUCTO
    // =====================================================

    // Agrega "quantity" piezas de un producto validando el límite de peso.
    // La usan el botón "+" de las tarjetas y el modal del catálogo.
    const addToCart = (product, quantity = 1) => {

        const qty = Math.max(1, Math.floor(Number(quantity) || 1));
        const totalKg = product.weightKg * qty;

        // Validar el límite de peso ANTES de agregar
        if (!fitsInLimit(totalKg)) {

            const available = Math.max(0, MAX_WEIGHT_KG - getTotalWeight());
            const piecesThatFit = Math.floor((available + 0.0001) / product.weightKg);

            if (qty > 1 && piecesThatFit > 0) {
                showToast(
                    `Solo ${piecesThatFit === 1 ? 'cabe' : 'caben'} ${piecesThatFit} pieza${piecesThatFit === 1 ? '' : 's'} más ` +
                    `de ${product.name} (máximo ${MAX_WEIGHT_KG} kg por pedido).`,
                    'error'
                );
            } else {
                showWeightLimitMessage();
            }

            return { ok: false, piecesThatFit };
        }

        const existing = cart.find(
            (item) => item.id === product.id
        );

        if (existing) {

            existing.quantity += qty;

        } else {

            cart.push({ ...product, quantity: qty });

        }

        saveCart();

        showToast(
            qty > 1
                ? `${qty} × ${product.name} agregados al carrito`
                : `${product.name} agregado al carrito`
        );

        return { ok: true, added: qty };
    };

    const addProduct = (card) => {

        const product = getProductFromCard(card);

        if (!product) {
            return;
        }

        addToCart(product, 1);
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

        // Solo se valida al AUMENTAR; disminuir siempre está permitido
        if (delta > 0 && !fitsInLimit(getItemWeight(item) * delta)) {
            showWeightLimitMessage();
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

        const weightElement = document.querySelector(
            '.cart-drawer__weight'
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

        // Indicador de peso: "4.35 kg de 10 kg"
        const totalWeight = getTotalWeight();
        const overLimit = totalWeight > MAX_WEIGHT_KG + 0.0001;

        // Carrito "lleno": llegó al máximo o ya no cabe otra pieza de ningún producto
        const isFull = cart.length > 0 && (
            totalWeight >= MAX_WEIGHT_KG - 0.0001 ||
            cart.every((item) => !fitsInLimit(getItemWeight(item)))
        );

        if (weightElement) {
            const percent = Math.min(100, (totalWeight / MAX_WEIGHT_KG) * 100);

            weightElement.hidden = cart.length === 0;
            weightElement.classList.toggle('is-near', percent >= 80);        // ámbar desde 8 kg
            weightElement.classList.toggle('is-full', isFull || overLimit);  // rojo al llegar al máximo

            let note = '';

            if (overLimit) {
                note = `<small>Reduce tu pedido a ${MAX_WEIGHT_KG} kg o menos para continuar.</small>`;
            } else if (isFull) {
                note = `<small>Llegaste al máximo de ${MAX_WEIGHT_KG} kg por pedido.</small>`;
            }

            weightElement.innerHTML = `
                <div class="cart-drawer__weight-row">
                    <span>Peso del pedido</span>
                    <span>${formatKg(totalWeight)} de ${MAX_WEIGHT_KG} kg</span>
                </div>
                <div class="cart-drawer__weight-bar">
                    <span style="width:${percent}%"></span>
                </div>
                ${note}
            `;
        }

        if (checkoutButton) {
            checkoutButton.disabled = cart.length === 0 || overLimit;
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
                        · ${formatKg(getItemWeight(item))} c/u
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
                            ${fitsInLimit(getItemWeight(item)) ? '' : `disabled title="Llegaste al límite de ${MAX_WEIGHT_KG} kg"`}
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

                    <div class="cart-drawer__weight" hidden></div>

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

            if (addButton.dataset.agotado === 'true') {

                const nombre = addButton.closest('.product-card')
                    ?.querySelector('.product-card__title, .product-card__name')
                    ?.textContent.trim() || 'Este producto';

                showToast(`${nombre} está agotado`);

                return;
            }

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

            // No permitir continuar si el pedido pasa del máximo
            if (getTotalWeight() > MAX_WEIGHT_KG + 0.0001) {
                showWeightLimitMessage();
                return;
            }

            window.location.href = pedidoUrl.href;
            return;
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
    // API PÚBLICA (la usa js/productModal.js)
    // =====================================================

    window.PaLaAsadaCart = {

        MAX_WEIGHT_KG,

        // Kilos que todavía caben en el pedido
        getRemainingKg: () => Math.max(0, MAX_WEIGHT_KG - getTotalWeight()),

        // "350 g aprox." -> 0.35 | "1 kg" -> 1 | sin peso -> 1 (valor por defecto)
        parseWeightKg: (text) => parseWeightKg(text) ?? DEFAULT_WEIGHT_KG,

        showToast,

        /**
         * Agrega un producto desde fuera del carrito (por ejemplo, el modal).
         * data: { name, priceText, image, weightText }
         * Usa el mismo id que el botón "+" de las tarjetas, así que ambos
         * caminos suman sobre el mismo renglón del carrito.
         */
        addItem: (data, quantity = 1) => {

            const name = String(data?.name || '').replace(/\s+/g, ' ').trim();
            const priceText = String(data?.priceText || '').replace(/\s+/g, ' ').trim();
            const price = parsePrice(priceText);

            if (!name || !price) {
                console.error('PaLaAsadaCart.addItem: faltan nombre o precio', data);
                return { ok: false };
            }

            return addToCart({
                id: `${slugify(name)}-${price}`,
                name,
                price,
                priceText,
                image: data.image || '',
                weightKg: parseWeightKg(data.weightText) ?? DEFAULT_WEIGHT_KG,
                quantity: 1
            }, quantity);
        }
    };

    // =====================================================
    // INICIALIZAR
    // =====================================================

    document.addEventListener('DOMContentLoaded', () => {

        injectCart();

        updateBadges();

    });

})();