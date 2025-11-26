<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registro - Portal de Cliente</title>

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
            --text-muted: rgba(232,236,247,0.78);
            --card: rgba(10, 15, 30, 0.9);
            --stroke: rgba(255,255,255,0.14);
            --shadow: 0 32px 90px rgba(0, 0, 0, 0.55);
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
            --bg-1: #f6f9ff;
            --bg-2: #e9f1ff;
            --bg-3: #d8e5ff;
            --text-main: #0f172a;
            --text-muted: #586070;
            --card: rgba(255, 255, 255, 0.94);
            --stroke: rgba(35, 73, 135, 0.16);
            --shadow: 0 28px 70px rgba(12, 32, 76, 0.18);
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
            padding: clamp(1rem, 4vw, 2rem);
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

        .register-shell {
            position: relative;
            width: min(1100px, 96vw);
            padding: 2px;
            border-radius: 32px;
            background: linear-gradient(135deg, rgba(124,231,255,0.7), rgba(108,123,255,0.85), rgba(124,231,255,0.7));
            box-shadow: var(--shadow);
            transform: perspective(1200px) rotateX(var(--tilt-x)) rotateY(var(--tilt-y)) translate3d(var(--parallax-x), var(--parallax-y), 0);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            z-index: 1;
            overflow: hidden;
        }

        .register-surface {
            position: relative;
            background: var(--card);
            padding: clamp(2rem, 4vw, 3rem);
            border-radius: 30px;
            border: 1px solid var(--stroke);
            overflow: hidden;
            isolation: isolate;
        }

        .card-glow {
            position: absolute;
            inset: -30%;
            background: radial-gradient(circle at 30% 30%, rgba(124,231,255,0.24), transparent 50%),
                        radial-gradient(circle at 70% 70%, rgba(108,123,255,0.20), transparent 52%);
            filter: blur(20px);
            opacity: 0.72;
            transform: translate3d(calc(var(--parallax-x) * -0.2), calc(var(--parallax-y) * -0.2), 0);
            pointer-events: none;
        }

        .theme-toggle {
            position: absolute;
            top: 16px;
            right: 16px;
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
            width: 62px;
            height: 62px;
            border-radius: 18px;
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
            font-size: clamp(1.8rem, 3vw, 2.2rem);
            font-weight: 800;
            color: var(--text-main);
            margin-bottom: 0.35rem;
        }
        .subtitle { color: var(--text-muted); margin-bottom: 0; }

        .pill-note {
            padding: 0.7rem 1rem;
            border-radius: 14px;
            background: rgba(255,255,255,0.08);
            border: 1px solid var(--stroke);
            color: var(--text-main);
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.08);
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .input-block {
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--stroke);
            border-radius: 16px;
            padding: 1rem;
            position: relative;
            overflow: hidden;
        }
        [data-theme="light"] .input-block { background: rgba(255,255,255,0.72); }

        .label-chip {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.35rem 0.7rem;
            border-radius: 999px;
            background: rgba(255,255,255,0.1);
            border: 1px solid var(--stroke);
            color: var(--text-main);
            font-weight: 800;
            letter-spacing: 0.03em;
            margin-bottom: 0.8rem;
            font-size: 0.9rem;
        }

        .input-group.elevated .form-control {
            border-top-left-radius: 12px;
            border-bottom-left-radius: 12px;
        }
        .input-group.elevated .btn-search {
            border-top-right-radius: 12px;
            border-bottom-right-radius: 12px;
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
        [data-theme="light"] .form-control { background: rgba(255,255,255,0.85); }
        .form-control:focus {
            border-color: rgba(108,123,255,0.7);
            box-shadow: 0 0 0 4px rgba(108,123,255,0.14);
            background: rgba(255,255,255,0.95);
            color: var(--text-main);
        }
        .form-control::placeholder { color: var(--text-muted); }

        .btn-search {
            background: linear-gradient(135deg, rgba(108,123,255,0.2), rgba(124,231,255,0.2));
            border: 1px solid var(--stroke);
            color: var(--text-main);
            font-weight: 800;
        }
        .btn-search:hover {
            background: linear-gradient(135deg, rgba(108,123,255,0.3), rgba(124,231,255,0.28));
        }

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
        .btn-gradient:disabled { opacity: 0.6; cursor: not-allowed; box-shadow: none; }

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
            background: radial-gradient(circle at calc(var(--pointer-rel-x) * 1%) calc(var(--pointer-rel-y) * 1%), rgba(124,231,255,0.18), rgba(108,123,255,0.12), transparent 45%);
            mix-blend-mode: screen;
            opacity: 0.6;
            pointer-events: none;
            transition: background 0.12s ease-out;
            z-index: 2;
        }

        .helper-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            margin-top: 1.5rem;
            color: var(--text-muted);
            font-weight: 700;
        }
        .helper-row a { color: var(--text-main); font-weight: 800; text-decoration: none; }
        .helper-row a:hover { text-decoration: underline; }

        .small-muted { color: var(--text-muted); }

        @media (max-width: 900px) {
            .register-shell { width: 100%; }
            .helper-row { flex-direction: column; align-items: flex-start; }
        }
    </style>
</head>
<body data-theme="dark">
    <div class="grid-overlay" aria-hidden="true"></div>
    <div class="orb orb-a" aria-hidden="true"></div>
    <div class="orb orb-b" aria-hidden="true"></div>
    <div class="cursor-glow" aria-hidden="true"></div>

    <section class="register-shell" id="registerShell">
        <div class="register-surface">
            <span class="card-glow" aria-hidden="true"></span>
            <span class="pointer-shine" aria-hidden="true"></span>
            <button class="theme-toggle" id="registerThemeToggle" type="button" aria-label="Cambiar modo de color">
                <i class="bi bi-moon-stars-fill icon-moon"></i>
                <i class="bi bi-sun-fill icon-sun"></i>
                <span class="small fw-bold">Modo</span>
            </button>

            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
                <div class="d-flex align-items-center gap-3">
                    <div class="logo-mark">ER</div>
                    <div>
                        <p class="eyebrow mb-1">Cliente Resguarda</p>
                        <h1 class="title-main mb-1">Crear cuenta</h1>
                        <p class="subtitle">Activa tu acceso con versión clara u oscura.</p>
                    </div>
                </div>
                <div class="pill-note"><i class="bi bi-stars"></i> Efecto 3D reactivo</div>
            </div>

            <form id="registroForm" action="<c:url value='/registroCliente' />" method="post">
                <div class="form-grid">
                    <div class="input-block">
                        <span class="label-chip"><i class="bi bi-person-vcard"></i> Identidad</span>
                        <div class="input-group elevated mb-2">
                            <input type="text" class="form-control" id="dni" name="dni" placeholder="Ingresa tu DNI" required>
                            <button class="btn btn-search" type="button" id="btnConsultarDni">
                                <i class="bi bi-search me-2"></i>Validar DNI
                            </button>
                        </div>
                        <div id="dniError" class="text-danger mt-2 small" style="display:none;"></div>
                    </div>

                    <div class="input-block">
                        <span class="label-chip"><i class="bi bi-person"></i> Datos personales</span>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="nombres" name="nombres" placeholder="Nombres" readonly required>
                            <label for="nombres">Nombres</label>
                        </div>
                        <div class="form-floating">
                            <input type="text" class="form-control" id="apellidos" name="apellidos" placeholder="Apellidos" readonly required>
                            <label for="apellidos">Apellidos</label>
                        </div>
                    </div>

                    <div class="input-block">
                        <span class="label-chip"><i class="bi bi-shield-lock"></i> Credenciales</span>
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" id="email" name="email" placeholder="Correo Electrónico" required>
                            <label for="email">Correo electrónico</label>
                        </div>
                        <div class="form-floating password-visual-group">
                            <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Crear Contraseña" required>
                            <label for="contrasena">Crear contraseña</label>
                        </div>
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger border-0 bg-danger bg-opacity-10 text-danger d-flex align-items-center p-3 rounded-3 mb-4 small" role="alert">
                       <i class="bi bi-exclamation-circle-fill me-2"></i> ${error}
                    </div>
                </c:if>

                <div class="mt-4 d-grid">
                    <button type="submit" class="btn btn-gradient w-100" id="btnRegistrar" disabled>
                        Completar registro <i class="bi bi-arrow-right-short ms-1"></i>
                    </button>
                </div>

                <div class="helper-row">
                    <span class="small-muted d-flex align-items-center gap-2"><i class="bi bi-activity"></i> Movimiento reactivo y fondo dinámico</span>
                    <a href="<c:url value='/cliente/login' />">¿Ya tienes cuenta? Inicia sesión</a>
                </div>
            </form>
        </div>
    </section>

    <script>
        (() => {
            const body = document.body;
            const toggle = document.getElementById('registerThemeToggle');
            const saved = localStorage.getItem('resguarda-client-register-theme');
            if (saved) body.dataset.theme = saved;
            const sync = () => toggle?.setAttribute('aria-pressed', body.dataset.theme === 'light');
            sync();
            toggle?.addEventListener('click', () => {
                const next = body.dataset.theme === 'light' ? 'dark' : 'light';
                body.dataset.theme = next;
                localStorage.setItem('resguarda-client-register-theme', next);
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
            const shell = document.getElementById('registerShell');
            const root = document.documentElement;
            const glow = document.querySelector('.cursor-glow');
            if (!shell) return;

            const update = (e) => {
                const rect = shell.getBoundingClientRect();
                const relX = (e.clientX - rect.left) / rect.width - 0.5;
                const relY = (e.clientY - rect.top) / rect.height - 0.5;
                const tilt = 5.2;
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

        document.getElementById('btnConsultarDni').addEventListener('click', function() {
            const dni = document.getElementById('dni').value;
            const btnConsultar = this;
            const dniError = document.getElementById('dniError');
            const btnRegistrar = document.getElementById('btnRegistrar');

            btnConsultar.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> Validando...';
            btnConsultar.disabled = true;
            dniError.style.display = 'none';
            btnRegistrar.disabled = true;

            fetch('<c:url value="/api/consultarDni" />?dni=' + dni)
                .then(response => {
                    if (response.ok) return response.json();
                    throw new Error('DNI no encontrado o API falló.');
                })
                .then(data => {
                    document.getElementById('nombres').value = data.nombres;
                    document.getElementById('apellidos').value = data.apellidos;
                    btnRegistrar.disabled = false;
                    btnConsultar.innerHTML = '<i class="bi bi-check-lg me-2"></i>Validado';
                    btnConsultar.classList.replace('btn-search', 'btn-success');
                })
                .catch(error => {
                    dniError.textContent = 'Error: DNI no válido o no encontrado en RENIEC.';
                    dniError.style.display = 'block';
                    document.getElementById('nombres').value = '';
                    document.getElementById('apellidos').value = '';
                    btnConsultar.innerHTML = '<i class="bi bi-search me-2"></i>Validar DNI';
                })
                .finally(() => {
                    if(document.getElementById('nombres').value === '') btnConsultar.disabled = false;
                });
        });
    </script>
</body>
</html>