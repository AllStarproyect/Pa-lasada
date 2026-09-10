/* =========================================================
   SIGN IN - DOM ELEMENTS
   ========================================================= */

const signInButton = document.querySelector("#SignInBtn");
const signUpButton = document.querySelector("#SignUpBtn");
const authForm = document.querySelector("#authForm");
const authWrapper = document.querySelector("#authWrapper");

if (authForm) {
    // Evita los mensajes predeterminados del navegador.
    // Las validaciones se manejan completamente con JavaScript.
    authForm.noValidate = true;
}


/* =========================================================
   SIGN IN - CUSTOM ALERT CONTAINER
   ========================================================= */

const authAlertContainer = document.createElement("div");
authAlertContainer.id = "authAlertContainer";
authAlertContainer.setAttribute("aria-live", "polite");
document.body.appendChild(authAlertContainer);

let authAlertTimer = null;


/* =========================================================
   SIGN IN - FORM TEMPLATES
   Conserva la interfaz y transición creada por el equipo.
   ========================================================= */

const signInFields = `
    <input
        type="text"
        id="username"
        placeholder="Usuario"
        autocomplete="username"
    >

    <input
        type="password"
        id="password"
        placeholder="Contraseña"
        autocomplete="current-password"
    >

    <button type="submit">Iniciar</button>
`;

const signUpFields = `
    <input
        type="text"
        id="fullName"
        placeholder="Nombre completo"
        autocomplete="name"
    >

    <input
        type="email"
        id="email"
        placeholder="Correo"
        autocomplete="email"
    >

    <input
        type="tel"
        id="phone"
        placeholder="Teléfono (10 dígitos)"
        maxlength="10"
        inputmode="numeric"
        autocomplete="tel"
    >

    <input
        type="text"
        id="username"
        placeholder="Usuario"
        autocomplete="username"
    >

    <input
        type="password"
        id="password"
        placeholder="Contraseña"
        autocomplete="new-password"
    >

    <input
        type="password"
        id="confirmPassword"
        placeholder="Confirmar Contraseña"
        autocomplete="new-password"
    >

    <button type="submit">Registrarse</button>
`;


/* =========================================================
   SIGN IN - ALERTAS
   Negras, redondeadas, texto blanco y temporales.
   ========================================================= */

function mostrarAlerta(
    mensaje,
    {
        icono = "bi-exclamation-circle-fill",
        duracion = 3000,
        mostrarRegistro = false
    } = {}
) {
    limpiarAlerta();

    const alerta = document.createElement("div");
    alerta.className = "auth-toast";
    alerta.setAttribute("role", "alert");

    alerta.innerHTML = `
        <i class="bi ${icono} auth-toast-icon" aria-hidden="true"></i>

        <div class="auth-toast-message">
            ${mensaje}
        </div>

        ${
            mostrarRegistro
                ? `<button type="button" class="auth-toast-action" id="goToSignUp">
                       Registrarse
                   </button>`
                : ""
        }

        <button
            type="button"
            class="auth-toast-close"
            aria-label="Cerrar alerta"
        >
            ×
        </button>
    `;

    authAlertContainer.appendChild(alerta);

    alerta
        .querySelector(".auth-toast-close")
        ?.addEventListener("click", limpiarAlerta);

    alerta
        .querySelector("#goToSignUp")
        ?.addEventListener("click", () => {
            limpiarAlerta();
            showSignUp();
        });

    if (duracion > 0) {
        authAlertTimer = setTimeout(() => {
            cerrarAlertaConAnimacion(alerta);
        }, duracion);
    }
}


function cerrarAlertaConAnimacion(alerta) {
    if (!alerta || !alerta.isConnected) {
        return;
    }

    alerta.style.animation = "authToastOut 0.18s ease forwards";

    setTimeout(() => {
        alerta.remove();
    }, 180);
}


function limpiarAlerta() {
    if (authAlertTimer) {
        clearTimeout(authAlertTimer);
        authAlertTimer = null;
    }

    authAlertContainer.innerHTML = "";
}


/* =========================================================
   SIGN IN - HELPERS DE CAMPOS
   ========================================================= */

function obtenerCampo(id) {
    return document.querySelector(`#${id}`);
}


function limpiarErroresVisuales() {
    authForm
        ?.querySelectorAll(".auth-field-error, .auth-field-shake")
        .forEach((campo) => {
            campo.classList.remove("auth-field-error", "auth-field-shake");
        });
}


function marcarCampoIncorrecto(campo) {
    if (!campo) {
        return;
    }

    limpiarErroresVisuales();

    campo.classList.add("auth-field-error", "auth-field-shake");
    campo.focus();

    setTimeout(() => {
        campo.classList.remove("auth-field-shake");
    }, 250);
}


/* =========================================================
   SIGN IN - VALIDACIONES
   ========================================================= */

function validarNombreCompleto(nombre) {
    const valor = nombre.trim();

    // Letras, espacios, acentos, apóstrofe y guion.
    // Exige al menos dos palabras.
    return /^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ'’-]+(?:\s+[A-Za-zÁÉÍÓÚÜÑáéíóúüñ'’-]+)+$/.test(valor);
}


function validarTelefono(telefono) {
    // Exactamente 10 dígitos.
    return /^[0-9]{10}$/.test(telefono.trim());
}


function validarEmail(email) {
    const valor = email.trim();

    // usuario + @ + dominio + extensión de mínimo 2 caracteres
    return /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(valor);
}


function validarUsername(username) {
    const valor = username.trim();

    // Mínimo 3 caracteres, sin espacios.
    return /^[A-Za-z0-9._-]{3,}$/.test(valor);
}


function validarPassword(password) {
    // Para la práctica se exige únicamente que no esté vacía.
    return password.length > 0;
}


function validarPasswordsIguales(password, confirmPassword) {
    return password === confirmPassword;
}


/* =========================================================
   SIGN IN - TRANSICIÓN AL CAMBIAR innerHTML
   ========================================================= */

function swapFields(html) {
    if (!authForm) {
        return;
    }

    authForm.classList.add("swapping");

    setTimeout(() => {
        authForm.innerHTML = html;
        void authForm.offsetWidth;
        authForm.classList.remove("swapping");
    }, 250);
}


/* =========================================================
   SIGN IN - FORM MODES
   ========================================================= */

function showSignIn() {
    if (!authForm || !signInButton || !signUpButton) {
        return;
    }

    limpiarAlerta();
    limpiarErroresVisuales();

    swapFields(signInFields);

    signInButton.classList.add("active");
    signUpButton.classList.remove("active");
    authWrapper?.classList.remove("signup");
}


function showSignUp() {
    if (!authForm || !signInButton || !signUpButton) {
        return;
    }

    limpiarAlerta();
    limpiarErroresVisuales();

    swapFields(signUpFields);

    signUpButton.classList.add("active");
    signInButton.classList.remove("active");
    authWrapper?.classList.add("signup");
}


/* =========================================================
   SIGN IN - TAB EVENTS
   ========================================================= */

signInButton?.addEventListener("click", showSignIn);
signUpButton?.addEventListener("click", showSignUp);


/* =========================================================
   SIGN IN - TELÉFONO EN TIEMPO REAL
   Si se intenta escribir una letra o símbolo, se elimina.
   ========================================================= */

authForm?.addEventListener("input", (event) => {
    const campo = event.target;

    campo.classList.remove("auth-field-error");

    if (campo.id === "phone") {
        campo.value = campo.value
            .replace(/\D/g, "")
            .slice(0, 10);
    }
});


/* =========================================================
   SIGN IN - LOCAL STORAGE
   ========================================================= */

function obtenerUsuarioRegistrado() {
    const usuarioGuardado = localStorage.getItem("usuario");

    if (!usuarioGuardado) {
        return null;
    }

    try {
        return JSON.parse(usuarioGuardado);
    } catch (error) {
        console.error("No se pudo leer el usuario registrado:", error);
        return null;
    }
}


/* =========================================================
   SIGN IN - PROCESAR INICIO DE SESIÓN
   ========================================================= */

function procesarSignIn() {
    limpiarErroresVisuales();

    const usernameInput = obtenerCampo("username");
    const passwordInput = obtenerCampo("password");

    const username = usernameInput?.value.trim() ?? "";
    const password = passwordInput?.value ?? "";

    if (username === "") {
        marcarCampoIncorrecto(usernameInput);

        mostrarAlerta(
            "<strong>Usuario requerido.</strong> Ingresa tu nombre de usuario."
        );

        return;
    }

    if (!validarUsername(username)) {
        marcarCampoIncorrecto(usernameInput);

        mostrarAlerta(
            "<strong>Usuario inválido.</strong> Usa al menos 3 caracteres y no incluyas espacios."
        );

        return;
    }

    if (password === "") {
        marcarCampoIncorrecto(passwordInput);

        mostrarAlerta(
            "<strong>Contraseña requerida.</strong> Ingresa tu contraseña."
        );

        return;
    }

    const usuario = obtenerUsuarioRegistrado();

    /*
     * Si no hay usuario registrado o el nombre de usuario
     * no corresponde, invitamos a registrarse.
     */
    if (
        !usuario ||
        String(usuario.username).toLowerCase() !== username.toLowerCase()
    ) {
        marcarCampoIncorrecto(usernameInput);

        mostrarAlerta(
            "<strong>Usuario no encontrado.</strong> Regístrate para crear una cuenta.",
            {
                icono: "bi-person-x-fill",
                duracion: 4500,
                mostrarRegistro: true
            }
        );

        return;
    }

    if (usuario.contrasena !== password) {
        marcarCampoIncorrecto(passwordInput);

        mostrarAlerta(
            "<strong>Contraseña incorrecta.</strong> Revisa tu contraseña e inténtalo de nuevo.",
            {
                icono: "bi-lock-fill"
            }
        );

        return;
    }

    localStorage.setItem("usuarioLogueado", "true");
    localStorage.setItem("username", usuario.username);
    localStorage.setItem("email", usuario.email);

    window.dispatchEvent(new Event("authStateChanged"));

    mostrarAlerta(
        "<strong>¡Bienvenido!</strong> Inicio de sesión correcto.",
        {
            icono: "bi-check-circle-fill",
            duracion: 900
        }
    );

    setTimeout(() => {
        window.location.href = "../index.html";
    }, 700);
}


/* =========================================================
   SIGN IN - PROCESAR REGISTRO
   ========================================================= */

function procesarSignUp() {
    limpiarErroresVisuales();

    const fullNameInput = obtenerCampo("fullName");
    const emailInput = obtenerCampo("email");
    const phoneInput = obtenerCampo("phone");
    const usernameInput = obtenerCampo("username");
    const passwordInput = obtenerCampo("password");
    const confirmPasswordInput = obtenerCampo("confirmPassword");

    const fullName = fullNameInput?.value.trim() ?? "";
    const email = emailInput?.value.trim() ?? "";
    const phone = phoneInput?.value.trim() ?? "";
    const username = usernameInput?.value.trim() ?? "";
    const password = passwordInput?.value ?? "";
    const confirmPassword = confirmPasswordInput?.value ?? "";

    /*
     * Validamos uno por uno para que cada campo tenga
     * un mensaje de error específico.
     */

    if (fullName === "") {
        marcarCampoIncorrecto(fullNameInput);

        mostrarAlerta(
            "<strong>Nombre requerido.</strong> Ingresa tu nombre completo."
        );

        return;
    }

    if (!validarNombreCompleto(fullName)) {
        marcarCampoIncorrecto(fullNameInput);

        mostrarAlerta(
            "<strong>Nombre inválido.</strong> Escribe nombre y apellido usando letras."
        );

        return;
    }

    if (email === "") {
        marcarCampoIncorrecto(emailInput);

        mostrarAlerta(
            "<strong>Correo requerido.</strong> Ingresa tu correo electrónico."
        );

        return;
    }

    if (!validarEmail(email)) {
        marcarCampoIncorrecto(emailInput);

        mostrarAlerta(
            "<strong>Correo inválido.</strong> Usa un formato como usuario@dominio.com."
        );

        return;
    }

    if (phone === "") {
        marcarCampoIncorrecto(phoneInput);

        mostrarAlerta(
            "<strong>Teléfono requerido.</strong> Ingresa tu número de teléfono."
        );

        return;
    }

    if (!validarTelefono(phone)) {
        marcarCampoIncorrecto(phoneInput);

        mostrarAlerta(
            "<strong>Teléfono inválido.</strong> Debe contener exactamente 10 números."
        );

        return;
    }

    if (username === "") {
        marcarCampoIncorrecto(usernameInput);

        mostrarAlerta(
            "<strong>Usuario requerido.</strong> Elige un nombre de usuario."
        );

        return;
    }

    if (!validarUsername(username)) {
        marcarCampoIncorrecto(usernameInput);

        mostrarAlerta(
            "<strong>Usuario inválido.</strong> Usa al menos 3 caracteres, sin espacios."
        );

        return;
    }

    if (!validarPassword(password)) {
        marcarCampoIncorrecto(passwordInput);

        mostrarAlerta(
            "<strong>Contraseña requerida.</strong> Crea una contraseña."
        );

        return;
    }

    if (confirmPassword === "") {
        marcarCampoIncorrecto(confirmPasswordInput);

        mostrarAlerta(
            "<strong>Confirma tu contraseña.</strong> Vuelve a escribirla."
        );

        return;
    }

    if (!validarPasswordsIguales(password, confirmPassword)) {
        marcarCampoIncorrecto(confirmPasswordInput);

        mostrarAlerta(
            "<strong>Las contraseñas no coinciden.</strong> Revisa ambos campos."
        );

        return;
    }

    /*
     * Objeto solicitado en la actividad.
     * Se conserva username porque la nueva interfaz del equipo
     * utiliza Usuario para iniciar sesión.
     */
    const usuario = {
        nombreCompleto: fullName,
        telefono: phone,
        email: email,
        username: username,
        contrasena: password
    };

    const usuarioJSON = JSON.stringify(usuario);

    localStorage.setItem("usuario", usuarioJSON);
    localStorage.setItem("usuarioLogueado", "true");
    localStorage.setItem("username", username);
    localStorage.setItem("email", email);

    console.log("Usuario registrado:", usuario);
    console.log("Usuario JSON:", usuarioJSON);

    window.dispatchEvent(new Event("authStateChanged"));

    mostrarAlerta(
        "<strong>¡Registro exitoso!</strong> Tu cuenta fue creada correctamente.",
        {
            icono: "bi-check-circle-fill",
            duracion: 1000
        }
    );

    setTimeout(() => {
        window.location.href = "../index.html";
    }, 800);
}


/* =========================================================
   SIGN IN - SUBMIT
   ========================================================= */

if (authForm) {
    authForm.addEventListener("submit", (event) => {
        event.preventDefault();
        limpiarAlerta();

        const isSignInMode =
            signInButton?.classList.contains("active");

        if (isSignInMode) {
            procesarSignIn();
        } else {
            procesarSignUp();
        }
    });
}


/* =========================================================
   SIGN IN - INITIALIZATION
   ========================================================= */

const initialMode =
    new URLSearchParams(window.location.search).get("mode");

if (initialMode === "signup") {
    showSignUp();
} else {
    showSignIn();
}
