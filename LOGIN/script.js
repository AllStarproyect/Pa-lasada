// JavaScript
const signInBtn = document.getElementById('SignInBtn');
const signUpBtn = document.getElementById('SignUpBtn');
const authForm = document.getElementById('authForm');

const signInFields = `
    <input type="text" id="username" placeholder="Usuario" required>
    <input type="password" id="password" placeholder="Contraseña" required>
    <button type="submit">Entrar</button>
`;


const signUpFields = `
    <input type="email" id="email" placeholder="Correo" required>
    <input type="password" id="password" placeholder="Contraseña" required>
    <button type="submit">Registrarse</button>
`;

function ShowSignIn() {
    authForm.innerHTML = signInFields;
    signInBtn.classList.add('active');
    signUpBtn.classList.remove('active');
}

function ShowSignUp() {
    authForm.innerHTML = signUpFields;
    signUpBtn.classList.add('active');
    signInBtn.classList.remove('active');
}

SignInBtn.addEventListener('click', ShowSignIn);
SignUpBtn.addEventListener('click', ShowSignUp);

authForm.addEventListener('submit', (e) => {
    e.preventDefault();

    if (SignInBtn.classList.contains('active')) {
        // Sign in
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;
        localStorage.setItem('username', username);
        localStorage.setItem('password', password);
        alert('Sign in guardado en localStorage');
    } else {
        // Sign up
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;
        localStorage.setItem('email', email);
        localStorage.setItem('password', password);
        alert('Sign up guardado en localStorage');
    }
});


ShowSignIn();



