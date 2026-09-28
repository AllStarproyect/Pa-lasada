/* =========================================================
   PERFIL STORAGE (compartido por user.js y pedido.js)
   Clave "usuarioPerfil":
   { direcciones:[{id,nombre,texto,referencias,predeterminada}],
     pagos:[{id,marca,ultimos,expira,titular,predeterminada}], ... }
   Nunca se guarda el número completo ni el CVV de una tarjeta.
   ========================================================= */

const PERFIL_KEY = "usuarioPerfil";
const MAX_DIRECCIONES = 3; // regla de negocio (02-Cliente-proceso-de-compra.md)

function leerPerfil() {
    let p = null;
    try { p = JSON.parse(localStorage.getItem(PERFIL_KEY)); } catch { p = null; }
    p = p && typeof p === "object" ? p : {};

    p.direcciones = Array.isArray(p.direcciones) ? p.direcciones : [];
    p.pagos = Array.isArray(p.pagos) ? p.pagos : [];

    // Migración: versión anterior guardaba una sola dirección como texto
    if (!p.direcciones.length && p.direccion) {
        p.direcciones.push({ id: "dir-1", nombre: "Casa", texto: p.direccion, referencias: "", predeterminada: true });
    }
    delete p.direccion;

    p.pagos.forEach((x) => { x.id = x.id || `pago-${x.marca}-${x.ultimos}`; });
    return p;
}

function guardarPerfil(p) {
    localStorage.setItem(PERFIL_KEY, JSON.stringify(p));
}

function direccionPrincipal(p) {
    return p.direcciones.find((d) => d.predeterminada) || p.direcciones[0] || null;
}

function pagoPredeterminado(p) {
    return p.pagos.find((x) => x.predeterminada) || p.pagos[0] || null;
}