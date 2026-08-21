const team = [
    { name: "Cesar Ruiz Flores", role: "Scrum Master", img: "img/cesar.jpg", imgPosition: "center 10%" },
    { name: "José Manuel Limon Avila", role: "Product Owner", img: "img/limon.jpeg" },
    { name: "Anahi Ortiz Velazquez", role: "Fullstack Development", img: "img/Anahi.jpeg", imgPosition: "center 10%" },
    { name: "Brenda Flores", role: "Fullstack Development", img: "img/brenda.jpg", imgPosition: "center 20%" },
    { name: "Denisse", role: "Fullstack Development", img: "img/Denisse.jpeg", imgPosition: "center 10%"},
    { name: "Diana Cruz", role: "Fullstack Development", img: "img/dianaProductOwner.jpg" },
    { name: "Jose Aldo Napoles Garza", role: "Fullstack Development", img: "img/JoseAldo.jpg", imgPosition: "center 5%" },
    { name: "Roberto Perez Velasco", role: "Fullstack Development", img: "img/robertFurry.jpg" }
];


const container = document.getElementById("cards-container");
 
team.forEach(member => {
  const card = document.createElement("div");
  card.className = "team-card";
  const position = member.imgPosition ? `style="object-position: ${member.imgPosition};"` : "";
  card.innerHTML = `
    <img src="${member.img}" alt="${member.name}" ${position}>
    <h2>${member.name}</h2>
    <p>Desarrollador parte de este e-commerce</p>
    <div class="role">${member.role}</div>
    <div class="socials">
      <a href=""><i class="bi bi-linkedin"></i></a>
    </div>
  `;
  container.appendChild(card);
});