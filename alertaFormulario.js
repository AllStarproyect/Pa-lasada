const formulario = document.querySelector("#formContacto");
const alertaFormulario = document.querySelector("#alertaFormulario");

formulario.addEventListener("submit", function (event) {
    event.preventDefault();
    if (!formulario.checkValidity()) {
        event.stopPropagation();
        formulario.classList.add("was-validated");
        alertaFormulario.innerHTML = `
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                Por favor, verifica los campos del formulario.

                <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="alert"
                    aria-label="Cerrar">
                </button>
            </div>
        `;

        return;
    }

    formulario.classList.add("was-validated");
    alertaFormulario.innerHTML = `
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>
            ¡Mensaje enviado correctamente!
            <button
                type="button"
                class="btn-close"
                data-bs-dismiss="alert"
                aria-label="Cerrar">
            </button>
        </div>
    `;

    formulario.reset();
    formulario.classList.remove("was-validated");

});