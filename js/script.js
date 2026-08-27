const team = [
    { name: "Cesar Ruiz Flores", role: "Fullstack Development", img: "img/cesar.jpg", imgPosition: "center 10%", linkedin:"https://www.linkedin.com/in/cesar-ruiz-f/" },
    { name: "José Manuel Limon Avila", role: "Fullstack Development", img: "img/limon.jpeg", linkedin:"https://www.linkedin.com/in/joselimonav/"},
    { name: "Anai Ortiz Velazquez", role: "Fullstack Development", img: "img/Anahi.jpeg", imgPosition: "center 10%", linkedin:"https://www.linkedin.com/in/anai-ortiz-/" },
    { name: "Brenda Lucrecia Flores Rivera", role: "Fullstack Development", img: "img/brenda.jpg", imgPosition: "center 20%", linkedin:"https://www.linkedin.com/in/brenda-flores-fi/" },
    { name: "Denisse Azucena Garza Ascacio", role: "Fullstack Development", img: "img/Denisse.jpeg", imgPosition: "center 10%", linkedin:"https://www.linkedin.com/in/denissegarzas"},
    { name: "Diana Cruz Delgado", role: "Fullstack Development", img: "img/dianaProductOwner.jpg", linkedin:"https://www.linkedin.com/in/diana-cd/" },
    { name: "Jose Aldo Napoles Garza", role: "Fullstack Development", img: "img/JoseAldo.jpg", imgPosition: "center 5%", linkedin:"www.linkedin.com/in/jose-aldo-nápoles-garza-732106251"},
    { name: "Roberto Perez Velasco", role: "Fullstack Development", img: "img/robertFurry.jpg", linkedin:"https://www.linkedin.com/in/robertopeve/" }
];

const container = document.getElementById("cards-container");

if (container) {
    team.forEach(member => {
        const card = document.createElement("div");
        card.className = "team-card";
        const position = member.imgPosition ? `style="object-position: ${member.imgPosition};"` : "";
        card.innerHTML = `
            <img src="${member.img}" alt="${member.name}" ${position}>
            <h2>${member.name}</h2>
            <p>Desarrollador parte de este e-commerce</p>
            <div class="role">${member.role}</div>
            <div class="socials">
            <a href=""><i class="bi bi-linkedin"></i></a>
            </div>
        `;
        container.appendChild(card);
    });
}

//Parte del carrusel HOME denisse
/* =========================================
   CARRUSEL DE PRODUCTOS DESTACADOS
   (No modificar clases/ids existentes)
========================================= */
document.querySelectorAll(".featured-products__carousel").forEach((carousel) => {
    const track = carousel.querySelector(".featured-products__track");
    const prevBtn = carousel.querySelector(".featured-products__arrow--prev");
    const nextBtn = carousel.querySelector(".featured-products__arrow--next");
    const dotsContainer = carousel.parentElement.querySelector(".featured-products__dots");
    const dots = dotsContainer ? Array.from(dotsContainer.querySelectorAll(".featured-products__dot")) : [];

    if (!track) return;

    function getScrollAmount() {
        const firstCard = track.querySelector(".product-card");
        if (!firstCard) return track.clientWidth;

        const cardStyle = window.getComputedStyle(track);
        const gap = parseFloat(cardStyle.columnGap || cardStyle.gap || 0) || 0;

        return firstCard.getBoundingClientRect().width + gap;
    }

    prevBtn?.addEventListener("click", () => {
        track.scrollBy({ left: -getScrollAmount(), behavior: "smooth" });
    });

    nextBtn?.addEventListener("click", () => {
        track.scrollBy({ left: getScrollAmount(), behavior: "smooth" });
    });

    dots.forEach((dot, index) => {
        dot.addEventListener("click", () => {
            const amount = getScrollAmount();
            track.scrollTo({ left: amount * index, behavior: "smooth" });
        });
    });

    function updateActiveDot() {
        if (dots.length === 0) return;

        const amount = getScrollAmount();
        const currentIndex = Math.round(track.scrollLeft / amount);

        dots.forEach((dot, index) => {
            const isActive = index === currentIndex;
            dot.classList.toggle("featured-products__dot--active", isActive);
            dot.setAttribute("aria-current", isActive ? "true" : "false");
        });
    }

    let scrollTimeout;
    track.addEventListener("scroll", () => {
        clearTimeout(scrollTimeout);
        scrollTimeout = setTimeout(updateActiveDot, 100);
    });

    updateActiveDot();
});