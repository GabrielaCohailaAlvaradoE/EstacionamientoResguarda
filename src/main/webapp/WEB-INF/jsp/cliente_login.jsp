<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Portal de Cliente - Resguarda</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-1: #0b1224;
            --bg-2: #0f1c36;
            --bg-3: #16294d;
            --accent-1: #7ce7ff;
            --accent-2: #6c7bff;
            --accent-3: #7ad6ff;
            --text-main: #e8ecf7;
            --text-muted: rgba(232,236,247,0.75);
            --card: rgba(10, 15, 30, 0.86);
            --stroke: rgba(255,255,255,0.12);
            --shadow: 0 30px 80px rgba(0, 0, 0, 0.55);
            --tilt-x: 0deg;
            --tilt-y: 0deg;
            --parallax-x: 0px;
            --parallax-y: 0px;
            --pointer-x: 50%;
            --pointer-y: 50%;
            --pointer-rel-x: 50;
            --pointer-rel-y: 50;
        }
        :root[data-theme="light"],
        body[data-theme="light"] {
            --bg-1: #f7f9fc;
            --bg-2: #eaf0ff;
            --bg-3: #dbe7ff;
            --text-main: #0f172a;
            --text-muted: #5f6b7c;
            --card: rgba(255, 255, 255, 0.9);
            --stroke: rgba(35, 73, 135, 0.15);
            --shadow: 0 30px 70px rgba(12, 32, 76, 0.22);
        }

        * { box-sizing: border-box; }

        body {
            min-height: 100vh;
            margin: 0;
            font-family: 'Outfit', sans-serif;
            background: radial-gradient(circle at 14% 16%, rgba(124,231,255,0.18), transparent 30%),
                        radial-gradient(circle at 80% 22%, rgba(108,123,255,0.22), transparent 32%),
                        linear-gradient(135deg, var(--bg-1), var(--bg-2), var(--bg-3));
            background-size: 120% 120%;
            color: var(--text-main);
            display: grid;
            place-items: center;
            overflow: hidden;
            animation: drift 16s ease-in-out infinite alternate;
            transition: background 0.5s ease;
        }
        @keyframes drift {
            from { background-position: 0 0; }
            to { background-position: 6% 6%; }
        }

        .grid-overlay {
            position: fixed;
            inset: 0;
            background: repeating-linear-gradient(90deg, rgba(255,255,255,0.035), rgba(255,255,255,0.035) 1px, transparent 1px, transparent 80px),
                        repeating-linear-gradient(0deg, rgba(255,255,255,0.035), rgba(255,255,255,0.035) 1px, transparent 1px, transparent 80px);
            mask-image: radial-gradient(circle at 50% 50%, rgba(0,0,0,0.65), transparent 60%);
            pointer-events: none;
            z-index: 0;
        }

        .orb {
            position: fixed;
            width: 520px;
            height: 520px;
            border-radius: 50%;
            filter: blur(140px);
            opacity: 0.26;
            z-index: 0;
            transform: translate3d(calc(var(--parallax-x) * -0.4), calc(var(--parallax-y) * -0.4), 0);
        }
        .orb-a { background: #6c7bff; top: -18%; left: 10%; animation: float 11s ease-in-out infinite alternate; }
        .orb-b { background: #7ce7ff; bottom: -16%; right: 14%; animation: float 13s ease-in-out infinite alternate; }
        @keyframes float { from { transform: translate3d(0,0,0); } to { transform: translate3d(12px,-16px,0); } }

        .card-shell {
            position: relative;
            width: min(520px, 92vw);
            padding: 2px;
            border-radius: 28px;
            background: linear-gradient(135deg, rgba(124,231,255,0.7), rgba(108,123,255,0.8), rgba(124,231,255,0.65));
            box-shadow: var(--shadow);
            transform: perspective(1200px) rotateX(var(--tilt-x)) rotateY(var(--tilt-y)) translate3d(var(--parallax-x), var(--parallax-y), 0);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            z-index: 1;
            overflow: hidden;
        }

        .card-surface {
            position: relative;
            background: var(--card);
            padding: clamp(2.2rem, 3vw, 2.8rem);
            border-radius: 26px;
            border: 1px solid var(--stroke);
            overflow: hidden;
            isolation: isolate;
        }
        /* Se eliminan líneas internas punteadas para un acabado más limpio */

        .card-glow {
            position: absolute;
            inset: -30%;
            background: radial-gradient(circle at 30% 30%, rgba(124,231,255,0.24), transparent 50%),
                        radial-gradient(circle at 70% 70%, rgba(108,123,255,0.20), transparent 52%);
            filter: blur(20px);
            opacity: 0.7;
            transform: translate3d(calc(var(--parallax-x) * -0.2), calc(var(--parallax-y) * -0.2), 0);
            pointer-events: none;
        }

        .theme-toggle {
            position: absolute;
            top: 14px;
            right: 14px;
            border: 1px solid var(--stroke);
            background: rgba(255,255,255,0.12);
            color: var(--text-main);
            border-radius: 999px;
            padding: 0.5rem 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.45rem;
            cursor: pointer;
            font-weight: 800;
            z-index: 3;
            backdrop-filter: blur(8px);
        }
        [data-theme="light"] .theme-toggle { background: rgba(255,255,255,0.9); }
        .theme-toggle .icon-sun { display: none; }
        [data-theme="light"] .theme-toggle .icon-sun { display: inline-flex; }
        [data-theme="light"] .theme-toggle .icon-moon { display: none; }

        .logo-mark {
            width: 58px;
            height: 58px;
            border-radius: 16px;
            display: grid;
            place-items: center;
            background: linear-gradient(150deg, rgba(124,231,255,0.25), rgba(108,123,255,0.35));
            color: #fff;
            font-weight: 800;
            border: 1px solid rgba(255,255,255,0.35);
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.4);
        }

        .eyebrow {
            text-transform: uppercase;
            letter-spacing: 0.22em;
            font-weight: 800;
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .title-main {
            font-size: clamp(1.6rem, 3vw, 2.1rem);
            font-weight: 800;
            color: var(--text-main);
            margin-bottom: 0.35rem;
        }
        .subtitle { color: var(--text-muted); margin-bottom: 1.4rem; }

        .detail-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 0.85rem;
            margin-bottom: 1.4rem;
        }
        .detail-chip {
            padding: 0.75rem 0.85rem;
            border-radius: 12px;
            background: rgba(255,255,255,0.06);
            border: 1px solid var(--stroke);
            color: var(--text-main);
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.55rem;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.08);
        }

        .form-floating label { color: var(--text-muted); font-weight: 600; }
        .form-control {
            background: rgba(255,255,255,0.08);
            border: 1px solid var(--stroke);
            border-radius: 14px;
            color: var(--text-main);
            padding: 0.95rem 1rem;
            font-weight: 600;
            backdrop-filter: blur(4px);
        }
        [data-theme="light"] .form-control { background: rgba(255,255,255,0.8); }
        .form-control:focus {
            border-color: rgba(108,123,255,0.7);
            box-shadow: 0 0 0 4px rgba(108,123,255,0.16);
            background: rgba(255,255,255,0.95);
            color: var(--text-main);
        }
        .form-control::placeholder { color: var(--text-muted); }

        .password-visual-group { position: relative; }
        .password-visual-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            background: linear-gradient(135deg, rgba(108,123,255,0.18), rgba(124,231,255,0.18));
            color: var(--text-main);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: grid;
            place-items: center;
            cursor: pointer;
        }

        .btn-gradient {
            border: none;
            background: linear-gradient(135deg, #6c7bff, #7ce7ff);
            color: #0b1224;
            padding: 1rem;
            border-radius: 14px;
            font-weight: 800;
            letter-spacing: 0.5px;
            box-shadow: 0 18px 36px rgba(108,123,255,0.36);
            transition: transform 0.18s ease, box-shadow 0.18s ease;
        }
        .btn-gradient:hover { transform: translateY(-2px); box-shadow: 0 24px 48px rgba(108,123,255,0.45); }

        .alt-link { color: var(--text-muted); text-decoration: none; font-weight: 700; }
        .alt-link:hover { color: var(--text-main); }

        .cursor-glow {
            position: fixed;
            width: 440px;
            height: 440px;
            border-radius: 50%;
            pointer-events: none;
            background: radial-gradient(circle, rgba(124,231,255,0.16), rgba(108,123,255,0.10), transparent 68%);
            mix-blend-mode: screen;
            opacity: 0.85;
            transform: translate3d(calc(var(--pointer-x) - 50%), calc(var(--pointer-y) - 50%), 0);
            transition: transform 0.08s ease-out;
            z-index: 1;
        }

        .pointer-shine {
            position: absolute;
            inset: 0;
            border-radius: 24px;
            background: radial-gradient(circle at calc(var(--pointer-rel-x) * 1%) calc(var(--pointer-rel-y) * 1%), rgba(124,231,255,0.2), rgba(108,123,255,0.12), transparent 45%);
            mix-blend-mode: screen;
            opacity: 0.6;
            pointer-events: none;
            transition: background 0.12s ease-out;
            z-index: 2;
        }

        .status-row {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            align-items: center;
            margin-top: 1.2rem;
            color: var(--text-muted);
            font-weight: 700;
            font-size: 0.95rem;
        }
        .soft-pill {
            padding: 0.55rem 0.9rem;
            border-radius: 999px;
            background: rgba(255,255,255,0.06);
            border: 1px solid var(--stroke);
            display: inline-flex;
            align-items: center;
            gap: 0.45rem;
            color: var(--text-main);
        }

        @media (max-width: 600px) {
            .detail-row { grid-template-columns: 1fr; }
            .status-row { flex-direction: column; align-items: flex-start; }
        }
    </style>
</head>
<body data-theme="dark">
    <div class="grid-overlay" aria-hidden="true"></div>
    <div class="orb orb-a" aria-hidden="true"></div>
    <div class="orb orb-b" aria-hidden="true"></div>
    <div class="cursor-glow" aria-hidden="true"></div>

    <section class="card-shell" id="clientCard">
        <div class="card-surface">
            <span class="card-glow" aria-hidden="true"></span>
            <span class="pointer-shine" aria-hidden="true"></span>
            <button class="theme-toggle" id="clientLoginThemeToggle" type="button" aria-label="Cambiar modo de color">
                <i class="bi bi-moon-stars-fill icon-moon"></i>
                <i class="bi bi-sun-fill icon-sun"></i>
                <span class="small fw-bold">Modo</span>
            </button>

            <div class="d-flex align-items-center gap-3 mb-3">
                <div class="logo-mark">ER</div>
                <div>
                    <p class="eyebrow mb-1">Cliente Resguarda</p>
                    <h1 class="title-main mb-0">Acceso cliente</h1>
                </div>
            </div>

            <form action="<c:url value='/cliente/login' />" method="post">
                <div class="form-floating mb-3 password-visual-group">
                    <input type="text" class="form-control" id="dni" name="dni" placeholder="DNI" required>
                    <label for="dni"><i class="bi bi-person-vcard me-2"></i>DNI / Documento</label>
                </div>

                <div class="form-floating mb-4 password-visual-group">
                    <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Contraseña" required>
                    <label for="contrasena"><i class="bi bi-lock me-2"></i>Contraseña</label>
                    <button class="password-visual-toggle" type="button" aria-label="Mostrar u ocultar contraseña" data-target="contrasena">
                        <i class="bi bi-eye-slash"></i>
                    </button>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger border-0 bg-danger bg-opacity-10 text-danger d-flex align-items-center p-3 rounded-3 mb-4 small" role="alert">
                       <i class="bi bi-exclamation-circle-fill me-2"></i> ${error}
                    </div>
                </c:if>

                <button class="w-100 btn btn-gradient mb-3" type="submit">Ingresar</button>

                <div class="status-row">
                    <span class="soft-pill"><i class="bi bi-activity"></i>Movimiento reactivo</span>
                    <div class="d-flex gap-3">
                        <a href="<c:url value='/registro' />" class="alt-link">Crear cuenta nueva</a>
                        <span class="text-muted" style="color: var(--text-muted);">|</span>
                        <a href="<c:url value='/' />" class="alt-link">Soy administrativo</a>
                    </div>
                </div>
            </form>
        </div>
    </section>

    <script>
        (() => {
            const root = document.documentElement;
            const body = document.body;
            const toggle = document.getElementById('clientLoginThemeToggle');
            const saved = localStorage.getItem('resguarda-client-login-theme');
            const applyTheme = (theme) => {
                body.dataset.theme = theme;
                root.dataset.theme = theme;
            };
            applyTheme(saved || 'dark');
            const sync = () => toggle?.setAttribute('aria-pressed', body.dataset.theme === 'light');
            sync();
            toggle?.addEventListener('click', () => {
                const next = body.dataset.theme === 'light' ? 'dark' : 'light';
                applyTheme(next);
                localStorage.setItem('resguarda-client-login-theme', next);
                sync();
            });
        })();

        (() => {
            const bindToggle = (btn, input) => {
                const sync = () => {
                    const isHidden = input.type === 'password';
                    btn.innerHTML = isHidden ? '<i class="bi bi-eye-slash"></i>' : '<i class="bi bi-eye"></i>';
                };
                btn.addEventListener('click', () => {
                    input.type = input.type === 'password' ? 'text' : 'password';
                    sync();
                });
                sync();
            };

            const enhancePasswords = () => {
                document.querySelectorAll('input[type="password"]').forEach((input) => {
                    if (input.dataset.enhanced === 'true') return;
                    input.dataset.enhanced = 'true';
                    const wrapper = input.closest('.password-visual-group') || input.parentElement;
                    let btn = wrapper?.querySelector('.password-visual-toggle');
                    if (!btn) {
                        if (wrapper) wrapper.classList.add('password-visual-group');
                        btn = document.createElement('button');
                        btn.type = 'button';
                        btn.className = 'password-visual-toggle';
                        btn.innerHTML = '<i class="bi bi-eye-slash"></i>';
                        btn.setAttribute('aria-label', 'Mostrar u ocultar contraseña');
                        const label = input.nextElementSibling && input.nextElementSibling.tagName === 'LABEL' ? input.nextElementSibling : null;
                        if (label) {
                            label.insertAdjacentElement('afterend', btn);
                        } else {
                            input.insertAdjacentElement('afterend', btn);
                        }
                    }
                    bindToggle(btn, input);
                });
            };
            document.addEventListener('DOMContentLoaded', enhancePasswords);
        })();

        (() => {
            const shell = document.getElementById('clientCard');
            const root = document.documentElement;
            const glow = document.querySelector('.cursor-glow');
            if (!shell) return;

            const update = (e) => {
                const rect = shell.getBoundingClientRect();
                const relX = (e.clientX - rect.left) / rect.width - 0.5;
                const relY = (e.clientY - rect.top) / rect.height - 0.5;
                const tilt = 5.5;
                const slide = 12;
                root.style.setProperty('--tilt-y', `${relX * tilt}deg`);
                root.style.setProperty('--tilt-x', `${-relY * tilt}deg`);
                root.style.setProperty('--parallax-x', `${relX * slide}px`);
                root.style.setProperty('--parallax-y', `${relY * slide}px`);
                root.style.setProperty('--pointer-rel-x', `${(relX + 0.5) * 100}`);
                root.style.setProperty('--pointer-rel-y', `${(relY + 0.5) * 100}`);
                root.style.setProperty('--pointer-x', `${e.clientX}px`);
                root.style.setProperty('--pointer-y', `${e.clientY}px`);
                glow?.classList.add('visible');
            };

            shell.addEventListener('mousemove', update);
            document.addEventListener('mousemove', (e) => {
                root.style.setProperty('--pointer-x', `${e.clientX}px`);
                root.style.setProperty('--pointer-y', `${e.clientY}px`);
            });
            shell.addEventListener('mouseleave', () => {
                root.style.setProperty('--tilt-y', '0deg');
                root.style.setProperty('--tilt-x', '0deg');
                root.style.setProperty('--parallax-x', '0px');
                root.style.setProperty('--parallax-y', '0px');
            });
        })();
    </script>
</body>
</html>