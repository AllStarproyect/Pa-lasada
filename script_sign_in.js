/* =========================================================
   ELEMENTOS DEL LOGIN
   ========================================================= */

const signInBtn = document.getElementById("SignInBtn");
const signUpBtn = document.getElementById("SignUpBtn");
const authForm = document.getElementById("authForm");


/* =========================================================
   ELEMENTOS DEL NAVBAR
   ========================================================= */

const userMenu = document.querySelector("#userMenu");
const navbarCollapse = document.querySelector("#navbarNavDropdown");


/* =========================================================
   CAMPOS DEL LOGIN
   ========================================================= */

const signInFields = `
    <input
        type="text"
        id="username"
        placeholder="Usuario"
        required
    >

    <input
        type="password"
        id="password"
        placeholder="Contraseña"
        required
    >

    <button type="submit">
        Entrar
    </button>
`;


const signUpFields = `
    <input
        type="email"
        id="email"
        placeholder="Correo"
        required
    >

    <input
        type="password"
        id="password"
        placeholder="Contraseña"
        required
    >

    <button type="submit">
        Registrarse
    </button>
`;


/* =========================================================
   ESTADO DEL USUARIO
   ========================================================= */

let usuarioLogueado =
    localStorage.getItem("usuarioLogueado") === "true";


/* =========================================================
   FUNCIONES DEL LOGIN
   ========================================================= */

function ShowSignIn() {

    authForm.innerHTML = signInFields;

    signInBtn.classList.add("active");

    signUpBtn.classList.remove("active");
}


function ShowSignUp() {

    authForm.innerHTML = signUpFields;

    signUpBtn.classList.add("active");

    signInBtn.classList.remove("active");
}


/* =========================================================
   EVENTOS DE LOS TABS
   ========================================================= */

signInBtn.addEventListener("click", function () {

    ShowSignIn();

});


signUpBtn.addEventListener("click", function () {

    ShowSignUp();

});


/* =========================================================
   CERRAR MENÚ MOBILE
   ========================================================= */

function cerrarMenuMovil() {

    if (
        window.innerWidth <= 991 &&
        navbarCollapse
    ) {

        const collapse =
            bootstrap.Collapse.getOrCreateInstance(
                navbarCollapse
            );

        collapse.hide();
    }
}


/* =========================================================
   IR AL LOGIN
   ========================================================= */

function irAlLogin() {

    cerrarMenuMovil();

    /*
       Buscamos el formulario.
       No necesitamos modificar el HTML original.
    */

    const loginBox =
        document.querySelector(".login-box");

    if (loginBox) {

        loginBox.scrollIntoView({
            behavior: "smooth",
            block: "center"
        });

    }

}


/* =========================================================
   RENDERIZAR NAVBAR
   ========================================================= */

function renderNavbar() {

    if (usuarioLogueado) {

        /*
         * USUARIO LOGUEADO
         */

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

                    <li>

                        <a
                            class="dropdown-item"
                            href="#"
                        >
                            Mi perfil
                        </a>

                    </li>


                    <li>

                        <a
                            class="dropdown-item"
                            href="#"
                        >
                            Mis pedidos
                        </a>

                    </li>


                    <li>

                        <hr class="dropdown-divider">

                    </li>


                    <li>

                        <button
                            class="dropdown-item"
                            id="logout"
                            type="button"
                        >
                            Cerrar sesión
                        </button>

                    </li>

                </ul>

            </div>
        `;


        /* -----------------------------------------
           LOGOUT
           ----------------------------------------- */

        const logout =
            document.querySelector("#logout");


        logout.addEventListener("click", function () {

            usuarioLogueado = false;

            localStorage.removeItem("usuarioLogueado");

            renderNavbar();

            cerrarMenuMovil();

        });


    } else {

        /*
         * USUARIO NO LOGUEADO
         */

        userMenu.innerHTML = `

            <div class="login-buttons">

                <button
                    class="btn btn-outline-dark"
                    id="login"
                    type="button"
                >
                    Iniciar sesión
                </button>


                <button
                    class="btn btn-primary"
                    id="register"
                    type="button"
                >
                    Registrarse
                </button>

            </div>
        `;


        /* -----------------------------------------
           BOTÓN INICIAR SESIÓN
           ----------------------------------------- */

        const login =
            document.querySelector("#login");


        login.addEventListener("click", function () {

            ShowSignIn();

            irAlLogin();

        });


        /* -----------------------------------------
           BOTÓN REGISTRARSE
           ----------------------------------------- */

        const register =
            document.querySelector("#register");


        register.addEventListener("click", function () {

            ShowSignUp();

            irAlLogin();

        });

    }
}


/* =========================================================
   SUBMIT DEL FORMULARIO
   ========================================================= */

authForm.addEventListener("submit", function (e) {

    e.preventDefault();


    /* -----------------------------------------
       SIGN IN
       ----------------------------------------- */

    if (
        signInBtn.classList.contains("active")
    ) {

        const username =
            document.getElementById("username").value;

        const password =
            document.getElementById("password").value;


        /*
         * Guardamos los datos como hacía
         * tu código original.
         */

        localStorage.setItem(
            "username",
            username
        );

        localStorage.setItem(
            "password",
            password
        );


        /*
         * Marcamos al usuario como logueado.
         */

        usuarioLogueado = true;

        localStorage.setItem(
            "usuarioLogueado",
            "true"
        );


        /*
         * Actualizamos navbar.
         */

        renderNavbar();


        alert(
            "Sign in guardado en localStorage"
        );

    }


    /* -----------------------------------------
       SIGN UP
       ----------------------------------------- */

    else {

        const email =
            document.getElementById("email").value;

        const password =
            document.getElementById("password").value;


        localStorage.setItem(
            "email",
            email
        );

        localStorage.setItem(
            "password",
            password
        );


        /*
         * Marcamos al usuario como logueado.
         */

        usuarioLogueado = true;

        localStorage.setItem(
            "usuarioLogueado",
            "true"
        );


        /*
         * Actualizamos navbar.
         */

        renderNavbar();


        alert(
            "Sign up guardado en localStorage"
        );

    }

});


/* =========================================================
   INICIALIZACIÓN
   ========================================================= */

/*
 * Mostrar Sign In al cargar.
 */

ShowSignIn();


/*
 * Dibujar navbar.
 */

renderNavbar();