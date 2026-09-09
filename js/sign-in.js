/* =========================================================
   SIGN IN - DOM ELEMENTS
   ========================================================= */

const signInButton = document.querySelector("#SignInBtn");
const signUpButton = document.querySelector("#SignUpBtn");
const authForm = document.querySelector("#authForm");
const authWrapper = document.querySelector("#authWrapper");


/* =========================================================
   SIGN IN - FORM TEMPLATES
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

    <button type="submit">Iniciar</button>
`;

const signUpFields = `
    <input
        type="email"
        id="email"
        placeholder="Correo"
        required
    >

    <input
        type="tel"
        id="phone"
        placeholder="Teléfono"
        pattern="[0-9]{10}"
        maxlength="10"
        required
    >

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

    <input
        type="password"
        id="confirmPassword"
        placeholder="Confirmar Contraseña"
        required
    >

    <button type="submit">Registrarse</button>
`;


/* =========================================================
   SIGN IN - TRANSICIÓN AL CAMBIAR innerHTML
   ========================================================= */

function swapFields(html) {
    authForm.classList.add("swapping");

    setTimeout(() => {
        authForm.innerHTML = html;
        void authForm.offsetWidth; // fuerza reflow para que la transición de entrada se vea
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

    swapFields(signInFields);
    signInButton.classList.add("active");
    signUpButton.classList.remove("active");
    authWrapper?.classList.remove("signup");
}

function showSignUp() {
    if (!authForm || !signInButton || !signUpButton) {
        return;
    }

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
   SIGN IN - AUTH SIMULATION
   ========================================================= */

if (authForm) {
    authForm.addEventListener("submit", (event) => {
        event.preventDefault();

        const isSignInMode = signInButton?.classList.contains("active");

        if (isSignInMode) {
            const username = document.querySelector("#username")?.value ?? "";
            const password = document.querySelector("#password")?.value ?? "";

            localStorage.setItem("username", username);
            localStorage.setItem("password", password);

            console.log(password);
        } else {
            const email = document.querySelector("#email")?.value ?? "";
            const phone = document.querySelector("#phone")?.value ?? "";
            const password = document.querySelector("#password")?.value ?? "";

            localStorage.setItem("email", email);
            localStorage.setItem("phone", phone);
            localStorage.setItem("password", password);
        }

        localStorage.setItem("usuarioLogueado", "true");
        window.dispatchEvent(new Event("authStateChanged"));

        alert(isSignInMode
            ? "Sign in guardado en localStorage"
            : "Sign up guardado en localStorage");
    });
}


/* =========================================================
   SIGN IN - INITIALIZATION
   ========================================================= */

const initialMode = new URLSearchParams(window.location.search).get("mode");

if (initialMode === "signup") {
    showSignUp();
} else {
    showSignIn();
}