/* =========================================================
   NAVBAR - DOM ELEMENTS
   ========================================================= */

const userMenu = document.querySelector("#userMenu");
const navbarCollapse = document.querySelector("#navbarNavDropdown");


/* =========================================================
   NAVBAR - HELPERS
   ========================================================= */

function isUserLoggedIn() {
    return localStorage.getItem("usuarioLogueado") === "true";
}

function getSignInPath(mode = "signin") {
    const isInsidePages = window.location.pathname.includes("/pages/");
    const basePath = isInsidePages ? "./sign-in.html" : "./pages/sign-in.html";

    return `${basePath}?mode=${mode}`;
}

function closeMobileMenu() {
    if (!navbarCollapse || window.innerWidth > 991 || typeof bootstrap === "undefined") {
        return;
    }

    const collapse = bootstrap.Collapse.getOrCreateInstance(navbarCollapse);
    collapse.hide();
}


/* =========================================================
   NAVBAR - USER MENU
   ========================================================= */

function renderNavbar() {
    if (!userMenu) {
        return;
    }

    if (isUserLoggedIn()) {
        userMenu.innerHTML = `
            <div class="dropdown">
                <button
                    class="btn btn-profile dropdown-toggle"
                    type="button"
                    data-bs-toggle="dropdown"
                    aria-expanded="false"
                    title="Mi cuenta"
                >
                    <i class="bi bi-person-circle"></i>
                </button>

                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="#">Mi perfil</a></li>
                    <li><a class="dropdown-item" href="#">Mis pedidos</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <button class="dropdown-item" id="logout" type="button">
                            Cerrar sesión
                        </button>
                    </li>
                </ul>
            </div>
        `;

        const logoutButton = document.querySelector("#logout");

        logoutButton?.addEventListener("click", () => {
            localStorage.removeItem("usuarioLogueado");
            localStorage.removeItem("username");
            localStorage.removeItem("password");

            renderNavbar();
            closeMobileMenu();
        });

        return;
    }

    userMenu.innerHTML = `
        <div class="login-buttons">
            <button class="btn btn-outline-dark" id="login" type="button">
                Iniciar sesión
            </button>

            <button class="btn btn-primary" id="register" type="button">
                Registrarse
            </button>
        </div>
    `;

    document.querySelector("#login")?.addEventListener("click", () => {
        closeMobileMenu();
        window.location.href = getSignInPath("signin");
    });

    document.querySelector("#register")?.addEventListener("click", () => {
        closeMobileMenu();
        window.location.href = getSignInPath("signup");
    });
}


/* =========================================================
   NAVBAR - AUTH STATE UPDATES
   ========================================================= */

window.addEventListener("authStateChanged", renderNavbar);


/* =========================================================
   NAVBAR - INITIALIZATION
   ========================================================= */

renderNavbar();
