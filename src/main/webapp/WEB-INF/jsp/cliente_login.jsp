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
            --bg-1: #0f172a;
            --bg-2: #162447;
            --bg-3: #1f375f;
            --accent-1: #5dd1ff;
            --accent-2: #5b7bfa;
            --text-main: #e5e7eb;
            --text-muted: rgba(255,255,255,0.75);
            --card: rgba(15, 23, 42, 0.9);
            --stroke: rgba(255,255,255,0.15);
            --shadow: 0 30px 80px rgba(0, 0, 0, 0.6);
            --tilt-x: 0deg;
            --tilt-y: 0deg;
            --parallax-x: 0px;
            --parallax-y: 0px;
            --pointer-x: 50%;
            --pointer-y: 50%;
            --pointer-rel-x: 50;
            --pointer-rel-y: 50;
        }
        [data-theme="light"] {
            --bg-1: #f4f7fb;
            --bg-2: #eaf1ff;
            --bg-3: #dbe8ff;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --card: rgba(255,255,255,0.95);
            --stroke: rgba(42,82,152,0.2);
            --shadow: 0 30px 80px rgba(15, 31, 58, 0.28);
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

        .bubble { position: fixed; width: 520px; height: 520px; border-radius: 50%; filter: blur(120px); opacity: 0.25; z-index: 0; animation: float 12s ease-in-out infinite alternate; }
        .bubble-a { background: #5b7bfa; top: -10%; left: 12%; }
        .bubble-b { background: #5dd1ff; bottom: -8%; right: 10%; animation-delay: 2s; }
        @keyframes float { from { transform: translateY(0); } to { transform: translateY(-20px); } }

        .card-shell {
            width: min(780px, 92vw);
            background: linear-gradient(145deg, rgba(255,255,255,0.2), rgba(255,255,255,0.08));
            border: 1px solid var(--stroke);
            border-radius: 28px;
            box-shadow: var(--shadow);
            overflow: hidden;
            position: relative;
            z-index: 1;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            transform: perspective(1200px) rotateX(var(--tilt-x)) rotateY(var(--tilt-y)) translate3d(var(--parallax-x), var(--parallax-y), 0);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.6), 0 0 0 1px rgba(255,255,255,0.04) inset;
        }

        .card-visual {
            padding: 3rem 2.4rem;
            background: radial-gradient(circle at 30% 20%, rgba(93,209,255,0.18), transparent 45%),
                        radial-gradient(circle at 80% 70%, rgba(91,123,250,0.22), transparent 42%),
                        linear-gradient(160deg, rgba(255,255,255,0.12), rgba(255,255,255,0));
            color: #fff;
            position: relative;
            isolation: isolate;
            overflow: hidden;
        }
        .card-visual::after {
            content: "";
            position: absolute;
            inset: 12%;
            border-radius: 22px;
            border: 1px dashed rgba(255,255,255,0.35);
            opacity: 0.6;
            pointer-events: none;
        }
        .logo-mark {
            width: 60px;
            height: 60px;
            border-radius: 16px;
            display: grid;
            place-items: center;
            background: linear-gradient(145deg, rgba(93,209,255,0.3), rgba(91,123,250,0.45));
            color: #fff;
            font-weight: 800;
            border: 1px solid rgba(255,255,255,0.4);
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.4);
        }

        .floating-dot {
            position: absolute;
            width: 110px;
            height: 110px;
            border-radius: 28px;
            background: linear-gradient(135deg, rgba(93,209,255,0.28), rgba(91,123,250,0.3));
            opacity: 0.85;
            filter: blur(1px);
            animation: wander 12s ease-in-out infinite alternate;
            transform: translate3d(calc(var(--parallax-x) * -0.35), calc(var(--parallax-y) * -0.35), 0);
        }
        .floating-dot.dot-1 { top: -14px; right: 14%; animation-delay: 0.6s; }
        .floating-dot.dot-2 { bottom: -6px; left: 10%; width: 150px; height: 150px; border-radius: 36px; animation-delay: 1.1s; }
        @keyframes wander { from { transform: translate3d(0,0,0); } to { transform: translate3d(10px, -12px, 0); } }

        .card-form {
            background: var(--card);
            padding: 3rem;
            position: relative;
            color: var(--text-main);
        }
        .card-form::before {
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
            z-index: 2;
        }
        [data-theme="light"] .theme-toggle { background: rgba(255,255,255,0.95); }
        .theme-toggle .icon-sun { display: none; }
        [data-theme="light"] .theme-toggle .icon-sun { display: inline-flex; }
        [data-theme="light"] .theme-toggle .icon-moon { display: none; }

        .form-floating label { color: var(--text-muted); font-weight: 600; }
        .form-control {
            background: rgba(255,255,255,0.1);
            border: 1px solid var(--stroke);
            border-radius: 14px;
            color: var(--text-main);
            padding: 0.95rem 1rem;
            font-weight: 600;
        }
        [data-theme="light"] .form-control { background: rgba(255,255,255,0.75); }
        .form-control:focus {
            border-color: rgba(91,123,250,0.7);
            box-shadow: 0 0 0 4px rgba(91,123,250,0.2);
            background: rgba(255,255,255,0.9);
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

        @media (max-width: 900px) { .card-visual { display: none; } .card-form { padding: 2.4rem; } }

        .cursor-glow {
            position: fixed;
            width: 420px;
            height: 420px;
            border-radius: 50%;
            pointer-events: none;
            background: radial-gradient(circle, rgba(93,209,255,0.16), rgba(91,123,250,0.08), transparent 68%);
            mix-blend-mode: screen;
            opacity: 0.9;
            transform: translate3d(calc(var(--pointer-x) - 50%), calc(var(--pointer-y) - 50%), 0);
            transition: transform 0.08s ease-out;
            z-index: 1;
        }

        .bubble { transform: translate3d(calc(var(--parallax-x) * -0.35), calc(var(--parallax-y) * -0.35), 0); }

        .pointer-shine {
            position: absolute;
            inset: 0;
            border-radius: 28px;
            background: radial-gradient(circle at calc(var(--pointer-rel-x) * 1%) calc(var(--pointer-rel-y) * 1%), rgba(93,209,255,0.22), rgba(91,123,250,0.12), transparent 45%);
            mix-blend-mode: screen;
            opacity: 0.55;
            pointer-events: none;
            transition: background 0.12s ease-out;
        }
    </style>
</head>
<body data-theme="dark">
    <div class="bubble bubble-a"></div>
    <div class="bubble bubble-b"></div>
    <div class="cursor-glow" aria-hidden="true"></div>

    <section class="card-shell" id="clientCard">
        <span class="pointer-shine" aria-hidden="true"></span>
        <div class="card-visual">
            <span class="floating-dot dot-1" aria-hidden="true"></span>
            <span class="floating-dot dot-2" aria-hidden="true"></span>
            <div class="logo-mark mb-4">ER</div>
            <h2 class="fw-bold">Ingreso de clientes</h2>
            <p class="mb-4">Efecto tilt 3D, brillo suave y trazos que reaccionan al movimiento.</p>
            <div class="d-flex flex-column gap-3 fw-semibold">
                <div><i class="bi bi-mouse3 me-2"></i>Parallax ligero siguiendo tu cursor.</div>
                <div><i class="bi bi-brightness-high me-2"></i>Modo claro y oscuro con buen contraste.</div>
                <div><i class="bi bi-magic me-2"></i>Bordes luminosos y fondo en deriva lenta.</div>
            </div>
        </div>

        <div class="card-form position-relative">
            <button class="theme-toggle" id="clientLoginThemeToggle" type="button" aria-label="Cambiar modo de color">
                <i class="bi bi-moon-stars-fill icon-moon"></i>
                <i class="bi bi-sun-fill icon-sun"></i>
                <span class="small fw-bold">Modo</span>
            </button>

            <div class="mb-4">
                <p class="text-uppercase fw-bold small mb-2" style="color: var(--text-muted);">Portal de cliente</p>
                <h4 class="fw-bolder mb-0" style="color: var(--text-main);">Accede a tus reservas y vehículos</h4>
            </div>

            <form action="<c:url value='/cliente/login' />" method="post">
                <div class="form-floating mb-3 password-visual-group">
                    <input type="text" class="form-control" id="dni" name="dni" placeholder="DNI" required>
                    <label for="dni"><i class="bi bi-person-vcard me-2"></i>DNI / Documento</label>
                </div>

                <div class="form-floating mb-4 password-visual-group">
                    <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Contraseña" required>
                    <label for="contrasena"><i class="bi bi-lock me-2"></i>Contraseña</label>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger border-0 bg-danger bg-opacity-10 text-danger d-flex align-items-center p-3 rounded-3 mb-4 small" role="alert">
                       <i class="bi bi-exclamation-circle-fill me-2"></i> ${error}
                    </div>
                </c:if>

                <button class="w-100 btn btn-gradient mb-4" type="submit">Ingresar</button>

                <div class="text-center d-flex flex-column flex-md-row gap-3 justify-content-center align-items-center small">
                    <a href="<c:url value='/registro' />" class="alt-link">Crear cuenta nueva</a>
                    <span class="text-muted" style="color: var(--text-muted);">|</span>
                    <a href="<c:url value='/' />" class="alt-link">Soy administrativo</a>
                </div>
            </form>
        </div>
    </section>

    <script>
        (() => {
            const body = document.body;
            const toggle = document.getElementById('clientLoginThemeToggle');
            const saved = localStorage.getItem('resguarda-client-login-theme');
            if (saved) body.dataset.theme = saved;
            const sync = () => toggle?.setAttribute('aria-pressed', body.dataset.theme === 'light');
            sync();
            toggle?.addEventListener('click', () => {
                const next = body.dataset.theme === 'light' ? 'dark' : 'light';
                body.dataset.theme = next;
                localStorage.setItem('resguarda-client-login-theme', next);
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
            const shell = document.getElementById('clientCard');
            const root = document.documentElement;
            const glow = document.querySelector('.cursor-glow');
            if (!shell) return;

            const update = (e) => {
                const rect = shell.getBoundingClientRect();
                const relX = (e.clientX - rect.left) / rect.width - 0.5;
                const relY = (e.clientY - rect.top) / rect.height - 0.5;
                const tilt = 4.5;
                const slide = 11;
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