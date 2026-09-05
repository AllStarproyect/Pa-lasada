
/* =====================================================
   CATEGORÍAS
   ===================================================== */

const categoryButtons = document.querySelectorAll(
    '.category-button'
);

categoryButtons.forEach((button) => {

    button.addEventListener('click', () => {

        // Quitar selección anterior
        categoryButtons.forEach((item) => {
            item.classList.remove('category-button--active');
        });

        // Activar categoría seleccionada
        button.classList.add('category-button--active');

    });

});

