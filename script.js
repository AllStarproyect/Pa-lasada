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