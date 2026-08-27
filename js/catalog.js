// =====================================================
// CATALOG.JS
// Lógica simple para el botón "agregar al carrito"
// =====================================================

document.addEventListener('DOMContentLoaded', () => {
    const addButtons = document.querySelectorAll('.product-card__add');
    const cartBadges = document.querySelectorAll('.cart-badge');

    let cartCount = cartBadges.length ? parseInt(cartBadges[0].textContent, 10) || 0 : 0;

    const updateCartBadges = () => {
        cartBadges.forEach((badge) => {
            badge.textContent = cartCount;
        });
    };

    addButtons.forEach((button) => {
        button.addEventListener('click', () => {
            cartCount += 1;
            updateCartBadges();

            // Pequeño feedback visual al agregar el producto
            button.classList.add('product-card__add--added');
            setTimeout(() => {
                button.classList.remove('product-card__add--added');
            }, 200);
        });
    });
});