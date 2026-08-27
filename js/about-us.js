/* =========================================================
   ABOUT US - TEAM DATA
   ========================================================= */

const team = [
    {
        name: "Cesar Ruiz Flores",
        role: "Fullstack Development",
        img: "../assets/img/cesar.jpg",
        imgPosition: "center 10%",
        linkedin: "https://www.linkedin.com/in/cesar-ruiz-f/"
    },
    {
        name: "José Manuel Limon Avila",
        role: "Fullstack Development",
        img: "../assets/img/limon.jpeg",
        linkedin: "https://www.linkedin.com/in/joselimonav/"
    },
    {
        name: "Anai Ortiz Velazquez",
        role: "Fullstack Development",
        img: "../assets/img/Anahi.jpeg",
        imgPosition: "center 10%",
        linkedin: "https://www.linkedin.com/in/anai-ortiz-/"
    },
    {
        name: "Brenda Lucrecia Flores Rivera",
        role: "Fullstack Development",
        img: "../assets/img/brenda.jpg",
        imgPosition: "center 20%",
        linkedin: "https://www.linkedin.com/in/brenda-flores-fi/"
    },
    {
        name: "Denisse Azucena Garza Ascacio",
        role: "Fullstack Development",
        img: "../assets/img/Denisse.jpeg",
        imgPosition: "center 10%",
        linkedin: "https://www.linkedin.com/in/denissegarzas"
    },
    {
        name: "Diana Cruz Delgado",
        role: "Fullstack Development",
        img: "../assets/img/dianaProductOwner.jpg",
        linkedin: "https://www.linkedin.com/in/diana-cd/"
    },
    {
        name: "Jose Aldo Napoles Garza",
        role: "Fullstack Development",
        img: "../assets/img/JoseAldo.jpg",
        imgPosition: "center 5%",
        linkedin: "https://www.linkedin.com/in/jose-aldo-n%C3%A1poles-garza-732106251"
    },
    {
        name: "Roberto Perez Velasco",
        role: "Fullstack Development",
        img: "../assets/img/robertFurry.jpg",
        linkedin: "https://www.linkedin.com/in/robertopeve/"
    }
];

/* =========================================================
   ABOUT US - TEAM CARDS
   ========================================================= */

const teamContainer = document.querySelector("#cards-container");

if (teamContainer) {
    team.forEach((member) => {
        const card = document.createElement("div");
        const imagePosition = member.imgPosition
            ? `style="object-position: ${member.imgPosition};"`
            : "";

        card.className = "team-card";
        card.innerHTML = `
            <img src="${member.img}" alt="${member.name}" ${imagePosition}>
            <h2>${member.name}</h2>
            <p>Desarrollador parte de este e-commerce</p>
            <div class="role">${member.role}</div>
            <div class="socials">
                <a
                    href="${member.linkedin}"
                    target="_blank"
                    rel="noopener noreferrer"
                    aria-label="LinkedIn de ${member.name}"
                >
                    <i class="bi bi-linkedin"></i>
                </a>
            </div>
        `;

        teamContainer.appendChild(card);
    });
}


// animacion parrafos
function animarTodasLasSecciones() {
  const secciones = document.querySelectorAll('.section-history, .mision-vision');

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const seccion = entry.target;
        const indexSeccion = Array.from(secciones).indexOf(seccion);
        const contenedores = seccion.querySelectorAll('.text-infoMV');

        contenedores.forEach((contenedor, indexContenedor) => {
          const parrafos = contenedor.querySelectorAll('.parrafo-animado');

          // ¿Este contenedor es el de Misión?
          const esMision = contenedor.querySelector('.tituloMision') !== null;

          // Si es Misión, entra desde la izquierda (-300px). Si no, desde la derecha (300px)
          const desdeX = esMision ? -300 : 300;

          parrafos.forEach((parrafo) => {
            parrafo.animate(
              [
                { transform: `translateX(${desdeX}px)`, opacity: 0 },
                { transform: 'translateX(0)', opacity: 1 }
              ],
              {
                duration: 600,
                delay: (indexSeccion * 700) + (indexContenedor * 500),
                easing: 'ease-out',
                fill: 'forwards'
              }
            );
          });
        });

        observer.unobserve(seccion);
      }
    });
  }, { threshold: 0.2 });

  secciones.forEach(seccion => observer.observe(seccion));
}

animarTodasLasSecciones();






