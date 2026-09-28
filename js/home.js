document.querySelectorAll(".featured-products__carousel").forEach((carousel) => {
    const track = carousel.querySelector(".featured-products__track");
    const prevButton = carousel.querySelector(".featured-products__arrow--prev");
    const nextButton = carousel.querySelector(".featured-products__arrow--next");
    const dots = [...carousel.parentElement.querySelectorAll(".featured-products__dot")];
    const originals = [...track.querySelectorAll(".product-card")];
    if (!track || !originals.length) return;

    let cloneCount = 0, currentIndex = 0, targetPosition = 0, mainOffset = 0, mainPosition = null, scrollTimer, resizeTimer;

    const jumpTo = (scrollLeft) => {
        track.style.scrollBehavior = "auto";
        track.scrollLeft = scrollLeft;
        void track.offsetHeight;
        track.style.scrollBehavior = "";
    };

    const withoutCardTransitions = (callback) => {
        const cards = track.querySelectorAll(".product-card");
        cards.forEach(card => { card.style.transition = "none"; });
        callback();
        void track.offsetHeight;
        requestAnimationFrame(() => {
            cards.forEach(card => { card.style.transition = ""; });
        });
    };

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

    const measureMainOffset = () => {
        const step = getStep();
        if (!step) return;
        const cards = [...track.querySelectorAll(".product-card")];
        const area = carousel.getBoundingClientRect();
        const center = area.left + area.width / 2;

        const firstMain = Math.min(...cards.map((card, index) => {
            const rect = card.getBoundingClientRect();
            return { index, distance: Math.abs(rect.left + rect.width / 2 - center) };
        }).sort((a, b) => a.distance - b.distance).slice(0, getConfig().main).map(item => item.index));

        mainOffset = firstMain - Math.round(track.scrollLeft / step);
        mainPosition = null;
    };

    const updateVisualState = () => {
        const step = getStep();
        if (!step) return;
        const position = Math.round(track.scrollLeft / step);

        if (position !== mainPosition) {
            mainPosition = position;
            const first = position + mainOffset;
            const last = first + getConfig().main;
            track.querySelectorAll(".product-card").forEach((card, index) => {
                card.classList.toggle("is-main", index >= first && index < last);
            });
        }

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
        let wrapped = false;

        if (position < cloneCount) {
            jumpTo(track.scrollLeft + originals.length * step);
            position += originals.length;
            wrapped = true;
        }

        if (position >= cloneCount + originals.length) {
            jumpTo(track.scrollLeft - originals.length * step);
            position -= originals.length;
            wrapped = true;
        }

        targetPosition = position;
        currentIndex = (position - cloneCount + originals.length) % originals.length;

        if (wrapped) {
            withoutCardTransitions(updateVisualState);
        } else {
            updateVisualState();
        }
    };

    const goTo = (direction) => {
        const step = getStep();
        if (!step) return;

        targetPosition += direction;
        track.scrollTo({
            left: targetPosition * step,
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
            jumpTo(step * cloneCount);
            targetPosition = cloneCount;
            currentIndex = 0;
            measureMainOffset();
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
            targetPosition = cloneCount + target;
            track.scrollTo({
                left: targetPosition * getStep(),
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