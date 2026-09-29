/* =========================================================
   AVISO DE COOKIES TÉCNICAS - PA' LA ASADA
   Este archivo SOLO controla el aviso de cookies.
   No modifica el carrito, la sesión ni las direcciones.
   No activa analítica, publicidad ni seguimiento.
   ========================================================= */

(() => {
    'use strict';

    const STORAGE_KEY = 'cookies_notice_accepted';
    const POLICY_VERSION = '1.2';
    const NOTICE_VALIDITY_DAYS = 180;

    const isInsidePages = window.location.pathname.includes('/pages/');
    const policyUrl = isInsidePages ? './cookie-policy.html' : './pages/cookie-policy.html';

    const readAcceptance = () => {
        try {
            const raw = localStorage.getItem(STORAGE_KEY);
            if (!raw) return null;

            if (raw === 'true') {
                return {
                    accepted: true,
                    version: POLICY_VERSION,
                    acceptedAt: Date.now()
                };
            }

            const value = JSON.parse(raw);
            return value && typeof value === 'object' ? value : null;
        } catch {
            return null;
        }
    };

    const shouldShowNotice = () => {
        const saved = readAcceptance();

        if (!saved?.accepted) return true;
        if (saved.version !== POLICY_VERSION) return true;

        const acceptedAt = Number(saved.acceptedAt);
        if (!Number.isFinite(acceptedAt)) return true;

        const validityMs = NOTICE_VALIDITY_DAYS * 24 * 60 * 60 * 1000;
        return Date.now() - acceptedAt > validityMs;
    };

    const saveAcceptance = () => {
        try {
            localStorage.setItem(
                STORAGE_KEY,
                JSON.stringify({
                    accepted: true,
                    version: POLICY_VERSION,
                    acceptedAt: Date.now()
                })
            );
        } catch {
            // Si localStorage está deshabilitado, el aviso se mostrará
            // nuevamente en una visita posterior.
        }
    };

    const createBackdrop = () => {
        const backdrop = document.createElement('div');
        backdrop.className = 'cookie-notice-backdrop';
        backdrop.setAttribute('aria-hidden', 'true');
        return backdrop;
    };

    const createNotice = () => {
        const notice = document.createElement('aside');
        notice.id = 'cookieNotice';
        notice.className = 'cookie-notice';
        notice.setAttribute('role', 'dialog');
        notice.setAttribute('aria-modal', 'true');
        notice.setAttribute('aria-label', 'Aviso sobre el uso de cookies técnicas');

        notice.innerHTML = `
            <div class="cookie-notice__content">
                <p class="cookie-notice__text">
                    Utilizamos únicamente cookies técnicas necesarias para el correcto funcionamiento de nuestra tienda en línea. Estas cookies permiten mantener tu sesión, guardar temporalmente los productos de tu carrito, recordar configuraciones básicas y proteger el proceso de compra.
                </p>

                <div class="cookie-notice__actions">
                    <button class="cookie-notice__button" id="cookieNoticeAccept" type="button">
                        Entendido
                    </button>
                    <a class="cookie-notice__policy-link" href="${policyUrl}">
                        Ver Política de Cookies
                    </a>
                </div>
            </div>
        `;

        return notice;
    };

    const lockPage = (notice) => {
        document.body.classList.add('cookie-notice-open');

        // Impide que el foco del teclado se vaya a controles detrás del aviso.
        Array.from(document.body.children).forEach((child) => {
            if (child !== notice && !child.classList.contains('cookie-notice-backdrop')) {
                child.setAttribute('inert', '');
            }
        });
    };

    const unlockPage = () => {
        document.body.classList.remove('cookie-notice-open');
        Array.from(document.body.children).forEach((child) => {
            child.removeAttribute('inert');
        });
    };

    const init = () => {
        if (!shouldShowNotice()) return;

        const backdrop = createBackdrop();
        const notice = createNotice();

        document.body.appendChild(backdrop);
        document.body.appendChild(notice);
        lockPage(notice);

        const acceptButton = notice.querySelector('#cookieNoticeAccept');
        const focusable = notice.querySelectorAll('button, a[href]');

        notice.addEventListener('keydown', (event) => {
            if (event.key !== 'Tab' || focusable.length === 0) return;

            const first = focusable[0];
            const last = focusable[focusable.length - 1];

            if (event.shiftKey && document.activeElement === first) {
                event.preventDefault();
                last.focus();
            } else if (!event.shiftKey && document.activeElement === last) {
                event.preventDefault();
                first.focus();
            }
        });

        acceptButton?.addEventListener('click', () => {
            saveAcceptance();
            unlockPage();
            backdrop.remove();
            notice.remove();
        });

        acceptButton?.focus();
    };

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init, { once: true });
    } else {
        init();
    }

    // Punto de extensión para un consentimiento por categorías en el futuro.
    window.PaLaAsadaCookieNotice = Object.freeze({
        storageKey: STORAGE_KEY,
        policyVersion: POLICY_VERSION,
        essentialOnly: true
    });
})();
