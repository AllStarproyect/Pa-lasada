document.querySelectorAll(".featured-products__carousel").forEach((carousel) => {
    const track = carousel.querySelector(".featured-products__track");
    const prevButton = carousel.querySelector(".featured-products__arrow--prev");
    const nextButton = carousel.querySelector(".featured-products__arrow--next");
    const dots = [...carousel.parentElement.querySelectorAll(".featured-products__dot")];
    const originals = [...track.querySelectorAll(".product-card")];
    if (!track || !originals.length) return;

    let cloneCount = 0, currentIndex = 0, scrollTimer, resizeTimer;

    const getConfig = () => {
        const width = window.innerWidth;
        if (width <= 800) return { slots: 1, main: 1 };
        if (width <= 1040) return { slots: 3, main: 1 };
        return { slots: 4, main: 2 };
    };

    const getStep = () => {
        const card = track.querySelector(".product-card");
        if (!card) return 0;
        const styles = getComputedStyle(track);
        const gap = parseFloat(styles.columnGap || styles.gap) || 0;
        return card.offsetWidth + gap;
    };

    const buildClones = () => {
        track.querySelectorAll(".is-clone").forEach(card => card.remove());
        cloneCount = Math.min(originals.length, getConfig().slots);
        const before = originals.slice(-cloneCount).map(card => {
            const clone = card.cloneNode(true);
            clone.classList.add("is-clone");
            return clone;
        });
        const after = originals.slice(0, cloneCount).map(card => {
            const clone = card.cloneNode(true);
            clone.classList.add("is-clone");
            return clone;
        });
        before.forEach(card => track.insertBefore(card, track.firstChild));
        after.forEach(card => track.appendChild(card));
    };

    const updateVisualState = () => {
        const config = getConfig();
        const cards = [...track.querySelectorAll(".product-card")];
        const area = carousel.getBoundingClientRect();
        const center = area.left + area.width / 2;

        cards.forEach(card => card.classList.remove("is-main"));

        cards.map(card => {
            const rect = card.getBoundingClientRect();
            return { card, distance: Math.abs(rect.left + rect.width / 2 - center) };
        }).sort((a, b) => a.distance - b.distance).slice(0, config.main).forEach(item => {
            item.card.classList.add("is-main");
        });

        if (dots.length) {
            const dotIndex = originals.length > 1
                ? Math.round(currentIndex * (dots.length - 1) / (originals.length - 1))
                : 0;

            dots.forEach((dot, index) => {
                const active = index === dotIndex;
                dot.classList.toggle("featured-products__dot--active", active);
                if (active) dot.setAttribute("aria-current", "true");
                else dot.removeAttribute("aria-current");
            });
        }
    };

    const normalizePosition = () => {
        const step = getStep();
        if (!step) return;

        let position = Math.round(track.scrollLeft / step);

        if (position < cloneCount) {
            track.scrollLeft += originals.length * step;
            position += originals.length;
        }

        if (position >= cloneCount + originals.length) {
            track.scrollLeft -= originals.length * step;
            position -= originals.length;
        }

        currentIndex = (position - cloneCount + originals.length) % originals.length;
        updateVisualState();
    };

    const goTo = (direction) => {
        const step = getStep();
        if (!step) return;

        const position = Math.round(track.scrollLeft / step);
        track.scrollTo({
            left: (position + direction) * step,
            behavior: "smooth"
        });
    };

    const settleScroll = () => {
        clearTimeout(scrollTimer);
        scrollTimer = setTimeout(normalizePosition, 120);
    };

    const initialize = () => {
        buildClones();
        requestAnimationFrame(() => {
            const step = getStep();
            track.scrollLeft = step * cloneCount;
            currentIndex = 0;
            updateVisualState();
        });
    };

    prevButton?.addEventListener("click", () => goTo(-1));
    nextButton?.addEventListener("click", () => goTo(1));

    dots.forEach((dot, index) => {
        dot.addEventListener("click", () => {
            const target = originals.length > 1
                ? Math.round(index * (originals.length - 1) / (dots.length - 1))
                : 0;
            track.scrollTo({
                left: (cloneCount + target) * getStep(),
                behavior: "smooth"
            });
        });
    });

    track.addEventListener("scroll", () => {
        updateVisualState();
        settleScroll();
    });

    window.addEventListener("resize", () => {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(initialize, 200);
    });

    initialize();
});