<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Acceso Administrativo - Resguarda</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --blue-900: #0f172a;
            --blue-700: #1e3c72;
            --blue-600: #2a5298;
            --blue-500: #3a6dbf;
            --surface: rgba(255, 255, 255, 0.9);
            --text: #0f172a;
            --muted: #6b7280;
            --border: rgba(42, 82, 152, 0.2);
            --shadow: 0 25px 60px rgba(15, 31, 58, 0.25);
        }
        [data-theme="dark"] {
            --surface: rgba(15, 23, 42, 0.88);
            --text: #e5e7eb;
            --muted: #cbd5e1;
            --border: rgba(58, 109, 191, 0.35);
            --shadow: 0 25px 60px rgba(0,0,0,0.45);
        }

        body {
            font-family: 'Outfit', sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: radial-gradient(circle at 10% 20%, rgba(58,109,191,0.14), transparent 30%),
                        radial-gradient(circle at 80% 10%, rgba(15,23,42,0.2), transparent 32%),
                        linear-gradient(135deg, rgba(15,23,42,0.88), rgba(30,58,138,0.82));
            transition: background 0.4s ease;
        }

        .floating-bubble {
            position: fixed;
            width: 280px;
            height: 280px;
            border-radius: 50%;
            filter: blur(60px);
            opacity: 0.18;
            z-index: 0;
            animation: float 12s ease-in-out infinite alternate;
        }
        .bubble-a { background: #2a5298; top: 6%; left: 10%; }
        .bubble-b { background: #3a6dbf; bottom: 10%; right: 8%; animation-delay: 2.5s; }
        @keyframes float { from { transform: translateY(0) scale(1); } to { transform: translateY(-16px) scale(1.04); } }

        .login-card {
            position: relative;
            background: var(--surface);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 26px;
            box-shadow: var(--shadow);
            padding: 3rem;
            width: 100%;
            max-width: 460px;
            animation: fadeInUp 0.6s ease-out;
            z-index: 1;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-control {
            background-color: rgba(255, 255, 255, 0.25);
            border: 1px solid var(--border);
            padding: 0.9rem 1rem;
            font-weight: 600;
            color: var(--text);
            border-radius: 14px;
        }

        .form-control:focus {
            background-color: rgba(255, 255, 255, 0.5);
            border-color: var(--blue-500);
            box-shadow: 0 0 0 4px rgba(58, 109, 191, 0.18);
            color: var(--text);
        }

        .btn-primary-corp {
            background: linear-gradient(135deg, var(--blue-700), var(--blue-500));
            color: white;
            border: none;
            padding: 0.9rem;
            font-weight: 700;
            letter-spacing: 0.6px;
            border-radius: 14px;
            transition: all 0.3s;
            box-shadow: 0 15px 35px rgba(58,109,191,0.35);
        }

        .btn-primary-corp:hover { transform: translateY(-2px); box-shadow: 0 18px 40px rgba(58,109,191,0.4); }

        .client-link { text-decoration: none; color: var(--muted); font-size: 0.95rem; transition: color 0.2s; }
        .client-link:hover { color: var(--blue-500); }

        .logo-mark { width: 52px; height: 52px; border-radius: 14px; background: linear-gradient(145deg, rgba(58,109,191,0.2), rgba(255,255,255,0.4)); display: grid; place-items: center; font-weight: 800; color: var(--blue-700); border: 1px solid var(--border); box-shadow: inset 0 1px 0 rgba(255,255,255,0.4); }
        [data-theme="dark"] .logo-mark { color: #e5e7eb; background: linear-gradient(145deg, rgba(33,70,128,0.55), rgba(58,109,191,0.55)); }

        .theme-toggle { position: absolute; top: 18px; right: 18px; border: 1px solid var(--border); border-radius: 999px; background: rgba(255,255,255,0.2); color: var(--text); padding: 0.4rem 0.75rem; display: inline-flex; align-items: center; gap: 0.35rem; cursor: pointer; box-shadow: inset 0 1px 0 rgba(255,255,255,0.3); }
        .theme-toggle:hover { transform: translateY(-1px); }
        .theme-toggle .icon-moon { display: none; }
        [data-theme="dark"] .theme-toggle .icon-sun { display: none; }
        [data-theme="dark"] .theme-toggle .icon-moon { display: inline-flex; }

        .password-visual-group { position: relative; }
        .password-visual-toggle { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); border: none; background: linear-gradient(135deg, rgba(58,109,191,0.14), rgba(58,109,191,0.08)); color: var(--blue-700); border-radius: 50%; width: 38px; height: 38px; display: grid; place-items: center; cursor: pointer; transition: transform 0.2s ease, box-shadow 0.2s ease; }
        .password-visual-toggle:hover { transform: translateY(-50%) scale(1.05); box-shadow: 0 10px 20px rgba(58,109,191,0.2); }
        [data-theme="dark"] .password-visual-toggle { color: #e5e7eb; background: linear-gradient(135deg, rgba(58,109,191,0.25), rgba(15,23,42,0.55)); }
    </style>
</head>
<body data-theme="light">
    <div class="floating-bubble bubble-a"></div>
    <div class="floating-bubble bubble-b"></div>

    <main class="login-card">
        <button class="theme-toggle" id="adminThemeToggle" type="button" aria-label="Cambiar modo de color">
            <i class="bi bi-sun-fill icon-sun"></i>
            <i class="bi bi-moon-stars-fill icon-moon"></i>
        </button>
        <div class="text-center mb-4">
            <div class="d-inline-flex align-items-center justify-content-center logo-mark mb-3 shadow-sm">
                ER
            </div>
            <h4 class="fw-bold text-dark mb-1" style="color: var(--text);">Estación Resguarda</h4>
            <p class="text-muted small text-uppercase fw-bold" style="letter-spacing: 1px;">Acceso Corporativo</p>
        </div>

        <form action="<c:url value='/login' />" method="post">

            <div class="form-floating mb-3 password-visual-group">
                <input type="text" class="form-control rounded-3" id="usuario" name="usuario" placeholder="Usuario" required>
                <label for="usuario"><i class="bi bi-person-fill me-2 text-muted"></i>Usuario</label>
            </div>

            <div class="form-floating mb-4 password-visual-group">
                <input type="password" class="form-control rounded-3" id="contrasena" name="contrasena" placeholder="Contraseña" required>
                <label for="contrasena"><i class="bi bi-shield-lock-fill me-2 text-muted"></i>Contraseña</label>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger border-0 bg-danger bg-opacity-10 text-danger d-flex align-items-center p-2 rounded-3 mb-3 small" role="alert">
                   <i class="bi bi-exclamation-circle-fill me-2"></i> ${error}
                </div>
            </c:if>

            <button class="w-100 btn btn-primary-corp mb-4" type="submit">
                INICIAR SESIÓN
            </button>

            <div class="text-center border-top pt-3">
                <p class="small text-muted mb-2">¿Eres usuario del estacionamiento?</p>
                <a href="<c:url value='/cliente/login' />" class="btn btn-outline-primary w-100 rounded-3 fw-bold btn-sm py-2">
                    <i class="bi bi-arrow-right-circle me-2"></i> Ir al Portal de Clientes
                </a>
            </div>
        </form>
    </main>

    <script>
        (() => {
            const body = document.body;
            const toggle = document.getElementById('adminThemeToggle');
            const saved = localStorage.getItem('resguarda-admin-theme');
            if (saved) body.dataset.theme = saved;
            const sync = () => toggle?.setAttribute('aria-pressed', body.dataset.theme === 'dark');
            sync();
            toggle?.addEventListener('click', () => {
                const next = body.dataset.theme === 'dark' ? 'light' : 'dark';
                body.dataset.theme = next;
                localStorage.setItem('resguarda-admin-theme', next);
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
    </script>
</body>
</html>