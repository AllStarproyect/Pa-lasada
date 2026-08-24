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

        const position = member.imgPosition
            ? `style="object-position: ${member.imgPosition};"`
            : "";

        card.innerHTML = `
            <img src="${member.img}" alt="${member.name}" ${position}>
            <h3>${member.name}</h3>
            <h4>Desarrollador parte de este e-commerce</h4>
            <div class="role">${member.role}</div>
            <div class="socials">
                <a href="${member.linkedin || '#'}" target="_blank" rel="noopener noreferrer">
                    <i class="bi bi-linkedin"></i>
                </a>
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

//Carrito

const openCart = document.getElementById("openCart");
const closeCart = document.getElementById("closeCart");
const cartSidebar = document.getElementById("cartSidebar");
const cartOverlay = document.getElementById("cartOverlay");

if (openCart && closeCart && cartSidebar && cartOverlay) {

    openCart.addEventListener("click", () => {
        cartSidebar.classList.add("active");
        cartOverlay.classList.add("active");
    });

    closeCart.addEventListener("click", () => {
        cartSidebar.classList.remove("active");
        cartOverlay.classList.remove("active");
    });

    cartOverlay.addEventListener("click", () => {
        cartSidebar.classList.remove("active");
        cartOverlay.classList.remove("active");
    });

}