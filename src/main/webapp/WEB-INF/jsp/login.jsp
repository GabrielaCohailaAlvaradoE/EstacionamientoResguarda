<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Acceso administrativo</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-1: #0f172a;
            --bg-2: #162447;
            --bg-3: #1f375f;
            --accent-1: #5dd1ff;
            --accent-2: #5b7bfa;
            --accent-3: #8ac4ff;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --card: rgba(255,255,255,0.9);
            --stroke: rgba(255,255,255,0.5);
            --shadow: 0 30px 80px rgba(15, 23, 42, 0.30);
            --tilt-x: 0deg;
            --tilt-y: 0deg;
            --parallax-x: 0px;
            --parallax-y: 0px;
            --pointer-x: 50%;
            --pointer-y: 50%;
            --pointer-rel-x: 50;
            --pointer-rel-y: 50;
        }
        [data-theme="dark"] {
            --bg-1: #0b1224;
            --bg-2: #0f1a38;
            --bg-3: #15264e;
            --text-main: #e5e7eb;
            --text-muted: #cbd5e1;
            --card: rgba(15, 23, 42, 0.9);
            --stroke: rgba(255,255,255,0.15);
            --shadow: 0 30px 80px rgba(0, 0, 0, 0.6);
        }

        * { box-sizing: border-box; }

        body {
            min-height: 100vh;
            margin: 0;
            font-family: 'Outfit', sans-serif;
            background: radial-gradient(circle at 18% 18%, rgba(93,209,255,0.18), transparent 25%),
                        radial-gradient(circle at 82% 20%, rgba(91,123,250,0.25), transparent 30%),
                        linear-gradient(135deg, var(--bg-1), var(--bg-2), var(--bg-3));
            color: var(--text-main);
            display: grid;
            place-items: center;
            overflow: hidden;
            transition: background 0.4s ease;
        }

        .backdrop-orb {
            position: fixed;
            width: 540px;
            height: 540px;
            border-radius: 50%;
            filter: blur(120px);
            opacity: 0.25;
            z-index: 0;
            animation: float 11s ease-in-out infinite alternate;
        }
        .orb-a { background: #5b7bfa; top: -8%; left: 10%; }
        .orb-b { background: #5dd1ff; bottom: -6%; right: 6%; animation-delay: 2s; }
        @keyframes float { from { transform: translateY(0); } to { transform: translateY(-26px); } }

        .login-shell {
            width: min(1050px, 92vw);
            background: linear-gradient(145deg, rgba(255,255,255,0.22), rgba(255,255,255,0.08));
            border: 1px solid var(--stroke);
            border-radius: 30px;
            box-shadow: var(--shadow);
            overflow: hidden;
            position: relative;
            z-index: 1;
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            transform: perspective(1200px) rotateX(var(--tilt-x)) rotateY(var(--tilt-y)) translate3d(var(--parallax-x), var(--parallax-y), 0);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            box-shadow: 0 30px 80px rgba(15, 23, 42, 0.30), 0 0 0 1px rgba(255,255,255,0.05) inset;
        }

        .login-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            align-items: stretch;
        }

        .visual-panel {
            background: radial-gradient(circle at 30% 20%, rgba(93,209,255,0.18), transparent 45%),
                radial-gradient(circle at 80% 70%, rgba(91,123,250,0.22), transparent 42%),
                linear-gradient(160deg, rgba(255,255,255,0.18), rgba(255,255,255,0));
            padding: 3rem 2.5rem;
            position: relative;
            isolation: isolate;
            overflow: hidden;
            border-radius: 12px;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.35);
        }
        .visual-panel h1 {
            color: #fff;
            font-weight: 800;
            letter-spacing: -0.4px;
        }
        .visual-panel p {
            color: rgba(255,255,255,0.78);
        }
        .visual-panel .floating-dot {
            position: absolute;
            width: 120px;
            height: 120px;
            border-radius: 30px;
            background: linear-gradient(135deg, rgba(93,209,255,0.28), rgba(91,123,250,0.32));
            opacity: 0.8;
            filter: blur(1px);
            animation: wander 12s ease-in-out infinite alternate;
            transform: translate3d(calc(var(--parallax-x) * -0.4), calc(var(--parallax-y) * -0.4), 0);
        }
        .floating-dot.dot-1 {
            top: -20px;
            right: 18%;
            animation-delay: 0.4s;
        }
        .floating-dot.dot-2 {
            bottom: -10px;
            left: 12%;
            width: 160px;
            height: 160px;
            border-radius: 40px;
            animation-delay: 1s;
        }
        @keyframes wander {
            from {
                transform: translate3d(0,0,0);
            }
            to {
                transform: translate3d(12px, -14px, 0);
            }
        }

        .logo-mark {
            width: 62px;
            height: 62px;
            border-radius: 18px;
            display: grid;
            place-items: center;
            font-weight: 800;
            letter-spacing: -0.3px;
            background: linear-gradient(160deg, rgba(255,255,255,0.18), rgba(255,255,255,0));
            color: #fff;
            border: 1px solid rgba(255,255,255,0.4);
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.4);
        }

        .form-panel {
            background: var(--card);
            padding: 3rem;
            position: relative;
            color: var(--text-main);
        }
        .form-panel::before {
            content: "";
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 20% 20%, rgba(91,123,250,0.08), transparent 30%),
                        radial-gradient(circle at 80% 80%, rgba(93,209,255,0.08), transparent 32%);
            pointer-events: none;
        }

        .theme-toggle {
            position: absolute;
            top: 18px;
            right: 18px;
            z-index: 2;
            border: 1px solid var(--stroke);
            background: rgba(255,255,255,0.22);
            color: var(--text-main);
            border-radius: 999px;
            padding: 0.45rem 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            cursor: pointer;
            font-weight: 700;
        }
        [data-theme="dark"] .theme-toggle { background: rgba(21,38,78,0.65); color: var(--text-main); }
        .theme-toggle .icon-moon { display: none; }
        [data-theme="dark"] .theme-toggle .icon-sun { display: none; }
        [data-theme="dark"] .theme-toggle .icon-moon { display: inline-flex; }

        .form-floating label { color: var(--text-muted); font-weight: 600; }
        .form-control {
            background: rgba(255,255,255,0.65);
            border: 1px solid var(--stroke);
            border-radius: 14px;
            color: var(--text-main);
            padding: 0.95rem 1rem;
            font-weight: 600;
        }
        [data-theme="dark"] .form-control { background: rgba(21,38,78,0.55); color: var(--text-main); }
        .form-control:focus {
            border-color: rgba(91,123,250,0.7);
            box-shadow: 0 0 0 4px rgba(91,123,250,0.2);
            background: rgba(255,255,255,0.75);
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
            background: linear-gradient(135deg, rgba(91,123,250,0.16), rgba(93,209,255,0.16));
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
            background: linear-gradient(135deg, #5b7bfa, #5dd1ff);
            color: #fff;
            padding: 1rem;
            border-radius: 14px;
            font-weight: 800;
            letter-spacing: 0.6px;
            box-shadow: 0 16px 34px rgba(91,123,250,0.35);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-gradient:hover { transform: translateY(-2px); box-shadow: 0 22px 40px rgba(91,123,250,0.45); }

        .alt-link { color: var(--text-muted); text-decoration: none; font-weight: 700; }
        .alt-link:hover { color: var(--text-main); }

        .form-section { display: block; animation: fadeIn 0.35s ease; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(6px) scale(0.995); } to { opacity: 1; transform: translateY(0) scale(1); } }

        .cursor-glow {
            position: fixed;
            width: 480px;
            height: 480px;
            border-radius: 50%;
            pointer-events: none;
            background: radial-gradient(circle, rgba(93,209,255,0.16), rgba(91,123,250,0.08), transparent 68%);
            mix-blend-mode: screen;
            opacity: 0.9;
            transform: translate3d(calc(var(--pointer-x) - 50%), calc(var(--pointer-y) - 50%), 0);
            transition: transform 0.08s ease-out;
            z-index: 1;
        }

        .pointer-shine {
            position: absolute;
            inset: 0;
            border-radius: 30px;
            background: radial-gradient(circle at calc(var(--pointer-rel-x) * 1%) calc(var(--pointer-rel-y) * 1%), rgba(93,209,255,0.22), rgba(91,123,250,0.12), transparent 45%);
            mix-blend-mode: screen;
            opacity: 0.55;
            pointer-events: none;
            transition: background 0.12s ease-out;
        }

        .backdrop-orb { transform: translate3d(calc(var(--parallax-x) * -0.35), calc(var(--parallax-y) * -0.35), 0); }

        @media (max-width: 900px) { .visual-panel { display: none; } .form-panel { padding: 2.4rem; } }
    </style>
</head>
<body data-theme="light">
    <div class="backdrop-orb orb-a"></div>
    <div class="backdrop-orb orb-b"></div>
    <div class="cursor-glow" aria-hidden="true"></div>

    <section class="login-shell" id="loginShell">
        <span class="pointer-shine" aria-hidden="true"></span>
        <div class="login-grid">
            <div class="visual-panel">
                <span class="floating-dot dot-1" aria-hidden="true"></span>
                <span class="floating-dot dot-2" aria-hidden="true"></span>
                <div class="logo-mark mb-4">ER</div>
                <h1 class="mb-3">Panel administrativo</h1>
                <p class="mb-4">Animación ligera con relieve 3D y brillo que sigue tu cursor.</p>
                <div class="row g-3 text-white fw-semibold">
                    <div class="col-6 d-flex align-items-center gap-2"><i class="bi bi-layers"></i><span>Tarjetas con efecto tilt.</span></div>
                    <div class="col-6 d-flex align-items-center gap-2"><i class="bi bi-brightness-high"></i><span>Modo claro/oscuro legible.</span></div>
                    <div class="col-6 d-flex align-items-center gap-2"><i class="bi bi-cursor"></i><span>Sombras dinámicas.</span></div>
                    <div class="col-6 d-flex align-items-center gap-2"><i class="bi bi-water"></i><span>Fondos en movimiento suave.</span></div>
                </div>
            </div>

            <div class="form-panel position-relative">
                <button class="theme-toggle" id="themeToggle" type="button" aria-label="Cambiar modo de color">
                    <i class="bi bi-sun-fill icon-sun"></i>
                    <i class="bi bi-moon-stars-fill icon-moon"></i>
                    <span class="small fw-bold">Modo</span>
                </button>

                <div class="mb-4">
                    <p class="text-uppercase text-muted fw-bold small mb-2">Acceso</p>
                    <h4 class="fw-bolder mb-0" style="color: var(--text-main);">Administradores</h4>
                </div>
                <div class="form-section" aria-live="polite">
                    <form action="<c:url value='/login' />" method="post">
                        <div class="form-floating mb-3 password-visual-group">
                            <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Usuario" required>
                            <label for="usuario"><i class="bi bi-person-fill me-2"></i>Usuario</label>
                        </div>

                        <div class="form-floating mb-4 password-visual-group">
                            <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Contraseña" required>
                            <label for="contrasena"><i class="bi bi-shield-lock-fill me-2"></i>Contraseña</label>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger border-0 bg-danger bg-opacity-10 text-danger d-flex align-items-center p-3 rounded-3 mb-4 small" role="alert">
                                <i class="bi bi-exclamation-circle-fill me-2"></i> ${error}
                            </div>
                        </c:if>

                        <button class="w-100 btn btn-gradient mb-3" type="submit">Ingresar</button>
                        <div class="text-center small d-flex flex-column flex-md-row gap-3 justify-content-center">
                            <a class="alt-link" href="<c:url value='/cliente/login' />">Ir al acceso de clientes</a>
                            <span class="text-muted">|</span>
                            <a class="alt-link" href="<c:url value='/registro' />">Crear cuenta cliente</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <script>
        (() => {
            const body = document.body;
            const toggle = document.getElementById('themeToggle');
            const saved = localStorage.getItem('resguarda-unified-theme');
            if (saved) body.dataset.theme = saved;
            const sync = () => toggle?.setAttribute('aria-pressed', body.dataset.theme === 'dark');
            sync();
            toggle?.addEventListener('click', () => {
                const next = body.dataset.theme === 'dark' ? 'light' : 'dark';
                body.dataset.theme = next;
                localStorage.setItem('resguarda-unified-theme', next);
                sync();
            });
        })();

        (() => {
            const enhancePasswords = () => {
                document.querySelectorAll('input[type="password"]').forEach((input) => {
                    if (input.dataset.enhanced === 'true') return;
                    input.dataset.enhanced = 'true';
                    const wrapper = input.parentElement;
                    if (wrapper) wrapper.classList.add('password-visual-group');
                    const btn = document.createElement('button');
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
                    btn.addEventListener('click', () => {
                        const isHidden = input.type === 'password';
                        input.type = isHidden ? 'text' : 'password';
                        btn.innerHTML = isHidden ? '<i class="bi bi-eye"></i>' : '<i class="bi bi-eye-slash"></i>';
                    });
                });
            };
            document.addEventListener('DOMContentLoaded', enhancePasswords);
        })();

        (() => {
            const shell = document.getElementById('loginShell');
            const root = document.documentElement;
            const glow = document.querySelector('.cursor-glow');
            if (!shell) return;

            const update = (e) => {
                const rect = shell.getBoundingClientRect();
                const relX = (e.clientX - rect.left) / rect.width - 0.5;
                const relY = (e.clientY - rect.top) / rect.height - 0.5;
                const tilt = 5;
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