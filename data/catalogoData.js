const producto = {
    id: 1,
  nombre: "Juan",
  edad: 30,
  ciudad: "Madrid",
  activo: true,
  hobbies: ["fútbol", "leer", "programar"]
};

// Convertir el objeto a una cadena JSON
const jsonString = JSON.stringify(producto);
console.log(jsonString);
// formato legible
const jsonFormateado = JSON.stringify(producto, null, 2);
console.log(jsonFormateado);