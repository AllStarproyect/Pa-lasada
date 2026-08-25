const team = [
    { name: "Cesar Ruiz Flores", role: "Scrum Master", img: "img/cesar.jpg", imgPosition: "center 10%" },
    { name: "José Manuel Limon Avila", role: "Product Owner", img: "img/limon.jpeg" },
    { name: "Anahi Ortiz Velazquez", role: "Fullstack Development", img: "img/Anahi.jpeg", imgPosition: "center 10%" },
    { name: "Brenda Flores", role: "Fullstack Development", img: "img/brenda.jpg", imgPosition: "center 20%" },
    { name: "Denisse", role: "Fullstack Development", img: "img/Denisse.jpeg", imgPosition: "center 10%"},
    { name: "Diana Cruz", role: "Fullstack Development", img: "img/dianaProductOwner.jpg" },
    { name: "Jose Aldo Napoles Garza", role: "Fullstack Development", img: "img/JoseAldo.jpg", imgPosition: "center 5%" },
    { name: "Roberto Perez Velasco", role: "Fullstack Development", img: "img/robertFurry.jpg" }
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
const userMenu = document.querySelector("#userMenu");

let usuarioLogueado = false;

function renderNavbar() {
    if (usuarioLogueado) {
        userMenu.innerHTML = `
            <div class="dropdown">
                <button
                    class="btn btn-profile dropdown-toggle"
                    data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                        <a class="dropdown-item" href="#">
                            <i class="bi bi-person me-2"></i>
                            Mi perfil
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="#">
                            <i class="bi bi-bag me-2"></i>
                            Mis pedidos
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li>
                        <button class="dropdown-item" id="logout">
                            <i class="bi bi-box-arrow-right me-2"></i>
                            Cerrar sesión
                        </button>
                    </li>
                </ul>
            </div>
        `;

        const logout = document.querySelector("#logout");

        logout.addEventListener("click", function () {
            usuarioLogueado = false;
            renderNavbar();
        });


    } else {

        userMenu.innerHTML = `
            <div class="d-flex gap-2 login-buttons">
                <button
                    class="btn btn-outline-dark"
                    id="login">
                    Iniciar sesión
                </button>
                <button class="btn btn-primary">
                    Registrarse
                </button>
            </div>
        `;

        const login = document.querySelector("#login");

        login.addEventListener("click", function () {
            usuarioLogueado = true;
            renderNavbar();
        });
    }
}

renderNavbar();

//Parte del carrusel HOME denisse
/* =========================================
   CARRUSEL DE PRODUCTOS DESTACADOS
   (No modifica clases/ids existentes)
========================================= */
document.querySelectorAll(".featured-products__carousel").forEach((carousel) => {
    const track = carousel.querySelector(".featured-products__track");
    const prevBtn = carousel.querySelector(".featured-products__arrow--prev");
    const nextBtn = carousel.querySelector(".featured-products__arrow--next");
    const dotsContainer = carousel.parentElement.querySelector(".featured-products__dots");
    const dots = dotsContainer ? Array.from(dotsContainer.querySelectorAll(".featured-products__dot")) : [];

    if (!track) return;

    // Calcula cuánto hay que desplazar (ancho de una tarjeta + gap)
    function getScrollAmount() {
        const firstCard = track.querySelector(".product-card");
        if (!firstCard) return track.clientWidth;

        const cardStyle = window.getComputedStyle(track);
        const gap = parseFloat(cardStyle.columnGap || cardStyle.gap || 0) || 0;

        return firstCard.getBoundingClientRect().width + gap;
    }

    // Mueve el carrusel hacia atrás
    prevBtn?.addEventListener("click", () => {
        track.scrollBy({ left: -getScrollAmount(), behavior: "smooth" });
    });

    // Mueve el carrusel hacia adelante
    nextBtn?.addEventListener("click", () => {
        track.scrollBy({ left: getScrollAmount(), behavior: "smooth" });
    });

    // Navegación mediante los dots
    dots.forEach((dot, index) => {
        dot.addEventListener("click", () => {
            const amount = getScrollAmount();
            track.scrollTo({ left: amount * index, behavior: "smooth" });
        });
    });

    // Actualiza el dot activo según la posición del scroll
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

    // Escucha el scroll para sincronizar los dots (con debounce simple)
    let scrollTimeout;
    track.addEventListener("scroll", () => {
        clearTimeout(scrollTimeout);
        scrollTimeout = setTimeout(updateActiveDot, 100);
    });

    // Estado inicial
    updateActiveDot();
});

