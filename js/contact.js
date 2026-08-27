/* =========================================================
   CONTACT - DOM ELEMENTS
   ========================================================= */

const contactForm = document.querySelector("#formContacto");
const formAlert = document.querySelector("#alertaFormulario");


/* =========================================================
   CONTACT - FORM VALIDATION
   ========================================================= */

if (contactForm && formAlert) {
    contactForm.addEventListener("submit", (event) => {
        event.preventDefault();

        if (!contactForm.checkValidity()) {
            event.stopPropagation();
            contactForm.classList.add("was-validated");

            formAlert.innerHTML = `
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

        contactForm.classList.add("was-validated");

        formAlert.innerHTML = `
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

        contactForm.reset();
        contactForm.classList.remove("was-validated");
    });
}
