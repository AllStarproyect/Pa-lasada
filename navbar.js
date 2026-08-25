const userMenu = document.querySelector("#userMenu");
const navbarCollapse = document.querySelector("#navbarNavDropdown");

let usuarioLogueado = false;

function cerrarMenuMovil() {
    if (window.innerWidth <= 991) {
        const collapse = bootstrap.Collapse.getOrCreateInstance(navbarCollapse);
        collapse.hide();
    }
}

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
                            Mi perfil
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="#">
                            Mis pedidos
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li>
                        <button class="dropdown-item" id="logout">
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
            cerrarMenuMovil();
        });

    } else {

        userMenu.innerHTML = `
            <div class="login-buttons">
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
            cerrarMenuMovil();
        });
    }
}

renderNavbar();