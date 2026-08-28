/* =========================================================
   SIGN IN - DOM ELEMENTS
   ========================================================= */

const signInButton = document.querySelector("#SignInBtn");
const signUpButton = document.querySelector("#SignUpBtn");
const authForm = document.querySelector("#authForm");


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

    <button type="submit">Entrar</button>
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

    <button type="submit">Registrarse</button>
`;


/* =========================================================
   SIGN IN - FORM MODES
   ========================================================= */

function showSignIn() {
    if (!authForm || !signInButton || !signUpButton) {
        return;
    }

    authForm.innerHTML = signInFields;
    signInButton.classList.add("active");
    signUpButton.classList.remove("active");
}

function showSignUp() {
    if (!authForm || !signInButton || !signUpButton) {
        return;
    }

    authForm.innerHTML = signUpFields;
    signUpButton.classList.add("active");
    signInButton.classList.remove("active");
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
        } else {
            const email = document.querySelector("#email")?.value ?? "";
            const password = document.querySelector("#password")?.value ?? "";

            localStorage.setItem("email", email);
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
