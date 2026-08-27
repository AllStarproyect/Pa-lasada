/* =========================================================
   HOME - FEATURED PRODUCTS CAROUSEL
   ========================================================= */

document.querySelectorAll(".featured-products__carousel").forEach((carousel) => {
    const track = carousel.querySelector(".featured-products__track");
    const prevButton = carousel.querySelector(".featured-products__arrow--prev");
    const nextButton = carousel.querySelector(".featured-products__arrow--next");
    const dotsContainer = carousel.parentElement?.querySelector(".featured-products__dots");
    const dots = dotsContainer
        ? Array.from(dotsContainer.querySelectorAll(".featured-products__dot"))
        : [];

    if (!track) {
        return;
    }

    function getScrollAmount() {
        const firstCard = track.querySelector(".product-card");

        if (!firstCard) {
            return track.clientWidth;
        }

        const trackStyles = window.getComputedStyle(track);
        const gap = parseFloat(trackStyles.columnGap || trackStyles.gap || 0) || 0;

        return firstCard.getBoundingClientRect().width + gap;
    }

    function updateActiveDot() {
        if (dots.length === 0) {
            return;
        }

        const scrollAmount = getScrollAmount();
        const currentIndex = Math.round(track.scrollLeft / scrollAmount);

        dots.forEach((dot, index) => {
            const isActive = index === currentIndex;

            dot.classList.toggle("featured-products__dot--active", isActive);
            dot.setAttribute("aria-current", isActive ? "true" : "false");
        });
    }

    prevButton?.addEventListener("click", () => {
        track.scrollBy({ left: -getScrollAmount(), behavior: "smooth" });
    });

    nextButton?.addEventListener("click", () => {
        track.scrollBy({ left: getScrollAmount(), behavior: "smooth" });
    });

    dots.forEach((dot, index) => {
        dot.addEventListener("click", () => {
            track.scrollTo({
                left: getScrollAmount() * index,
                behavior: "smooth"
            });
        });
    });

    let scrollTimeout;

    track.addEventListener("scroll", () => {
        clearTimeout(scrollTimeout);
        scrollTimeout = setTimeout(updateActiveDot, 100);
    });

    updateActiveDot();
});
