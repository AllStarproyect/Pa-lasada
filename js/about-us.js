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
