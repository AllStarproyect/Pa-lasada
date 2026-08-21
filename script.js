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
const userMenu = document.querySelector("#userMenu");

let usuarioLogueado = false;

function renderNavbar() {
    if (usuarioLogueado) {
        userMenu.innerHTML = `
            <div class="dropdown">
                <button
                    class="btn btn-profile dropdown-toggle"
                    data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                        <a class="dropdown-item" href="#">
                            <i class="bi bi-person me-2"></i>
                            Mi perfil
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="#">
                            <i class="bi bi-bag me-2"></i>
                            Mis pedidos
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li>
                        <button class="dropdown-item" id="logout">
                            <i class="bi bi-box-arrow-right me-2"></i>
                            Cerrar sesión
                        </button>
                    </li>
                </ul>
            </div>
        `;

        const logout = document.querySelector("#logout");

        logout.addEventListener("click", function () {
            usuarioLogueado = false;
            renderNavbar();
        });


    } else {

        userMenu.innerHTML = `
            <div class="d-flex gap-2 login-buttons">
                <button
                    class="btn btn-outline-dark"
                    id="login">
                    Iniciar sesión
                </button>
                <button class="btn btn-primary">
                    Registrarse
                </button>
            </div>
        `;

        const login = document.querySelector("#login");

        login.addEventListener("click", function () {
            usuarioLogueado = true;
            renderNavbar();
        });
    }
}

renderNavbar();

//Parte del carrusel HOME denisse
document.addEventListener('DOMContentLoaded', () => {
    // CORRECCIÓN: Nos aseguramos de buscarlo correctamente. 
    // Si usas ID en tu HTML ponle id="TrackCarrusel"
    const track = document.getElementById('TrackCarrusel') || document.querySelector('.carruselTrack');
    const items = document.querySelectorAll('.carruselItem');
    const dots = document.querySelectorAll('.dot');
    const leftBtn = document.getElementById('leftBtn');
    const rightBtn = document.getElementById('rightBtn');
    
    let currentIndex = 1; // Tarjeta central por defecto
    let scrollTimeout;

    if (!track || items.length === 0) {
        console.warn("No se encontraron los elementos del carrusel en el DOM.");
        return;
    }

    // Función unificada para encender la tarjeta y el indicador correcto
    function updateActiveState(index) {
        items.forEach((item, i) => {
            if(i === index) {
                item.classList.add('active');
            } else {
                item.classList.remove('active');
            }
        });

        dots.forEach((dot, i) => {
            if(i === index) {
                dot.classList.add('active');
            } else {
                dot.classList.remove('active');
            }
        });

        currentIndex = index;
    }

    // Función inteligente para mover el carrusel y permitir la selección de tarjetas
    function ejecutarMovimiento(index) {
        const esDispositivoMovil = window.innerWidth <= 900;
        
        if (esDispositivoMovil) {
            // EN CELULARES: Desplazamiento por hardware nativo
            if (items[index]) {
                items[index].scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'center' });
            }
            updateActiveState(index);
        } else {
            // EN COMPUTADORAS: Calcula el desplazamiento exacto para centrar la tarjeta seleccionada
            updateActiveState(index);
            
            const contenedorCarrusel = track.parentElement;
            if (contenedorCarrusel) {
                const anchoContenedor = contenedorCarrusel.offsetWidth;
                const anchoItem = items[index].offsetWidth;
                
                // Calculamos la posición del elemento con respecto al inicio del track
                const itemOffsetLeft = items[index].offsetLeft;
                
                // Fórmula matemática para centrar perfectamente cualquier tarjeta cliqueada
                const posicionDestino = itemOffsetLeft - (anchoContenedor / 2) + (anchoItem / 2);
                
                // Movemos el track de forma fluida mediante CSS Transforms
                track.style.transform = `translateX(${-posicionDestino}px)`;
            }
        }
    }

    // Navegación asistida por el Botón Izquierdo
    if (leftBtn) {
        leftBtn.addEventListener('click', (e) => {
            e.preventDefault();
            let prevIndex = (currentIndex - 1 + items.length) % items.length;
            ejecutarMovimiento(prevIndex);
        });
    }

    // Navegación asistida por el Botón Derecho
    if (rightBtn) {
        rightBtn.addEventListener('click', (e) => {
            e.preventDefault();
            let nextIndex = (currentIndex + 1) % items.length;
            ejecutarMovimiento(nextIndex);
        });
    }

    // Evento de clic en los círculos inferiores (Dots)
    dots.forEach((dot, index) => {
        dot.addEventListener('click', (e) => {
            e.preventDefault();
            if(index < items.length) {
                ejecutarMovimiento(index);
            }
        });
    });

    // ¡SOLUCIÓN PRINCIPAL! Permitir hacer clic directo en cualquier tarjeta para seleccionarla y centrarla
    items.forEach((item, index) => {
        item.addEventListener('click', (e) => {
            // Si hacen clic en el botón "+" de agregar, no queremos que se mueva el carrusel
            if (e.target.closest('.add-btn')) return; 
            
            ejecutarMovimiento(index);
        });
    });

    // ESCUCHA DE SCROLL (Exclusiva para celulares)
    track.addEventListener('scroll', () => {
        if (window.innerWidth > 900) return;

        window.clearTimeout(scrollTimeout);
        scrollTimeout = setTimeout(() => {
            const trackCenter = track.getBoundingClientRect().left + (track.offsetWidth / 2);
            let closestIndex = currentIndex;
            let minDistance = Infinity;

            items.forEach((item, index) => {
                const itemCenter = item.getBoundingClientRect().left + (item.offsetWidth / 2);
                const distance = Math.abs(trackCenter - itemCenter);
                
                if (distance < minDistance) {
                    minDistance = distance;
                    closestIndex = index;
                }
            });

            if (closestIndex !== currentIndex) {
                updateActiveState(closestIndex);
            }
        }, 120);
    });

    // Inicialización del estado: centra la tarjeta activa inicial por defecto
    setTimeout(() => {
        ejecutarMovimiento(currentIndex);
    }, 200);
});

