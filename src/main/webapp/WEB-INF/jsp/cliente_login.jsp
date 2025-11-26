<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - Portal de Cliente</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --blue-900: #0f172a;
            --blue-700: #1e3c72;
            --blue-600: #2a5298;
            --blue-500: #3a6dbf;
            --surface: rgba(255,255,255,0.1);
            --text: #e5e7eb;
            --muted: rgba(255,255,255,0.7);
            --border: rgba(255,255,255,0.2);
            --shadow: 0 25px 60px rgba(0,0,0,0.5);
        }
        [data-theme="light"] {
            --surface: rgba(255, 255, 255, 0.94);
            --text: #0f172a;
            --muted: #64748b;
            --border: rgba(42,82,152,0.2);
            --shadow: 0 25px 60px rgba(15,31,58,0.28);
        }

        
        body {
            font-family: 'Outfit', sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: radial-gradient(circle at 20% 20%, rgba(58,109,191,0.22), transparent 32%),
                radial-gradient(circle at 80% 10%, rgba(15,23,42,0.2), transparent 35%),
                linear-gradient(135deg, rgba(15,23,42,0.9), rgba(30,58,138,0.82));
            transition: background 0.4s ease;
        }

        .login-card {
            background: var(--surface);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 30px;
            box-shadow: var(--shadow);
            padding: 3rem;
            width: 100%;
            max-width: 470px;
            color: var(--text);
            position: relative;
            overflow: hidden;
        }
        .login-card::before {
            content: "";
            position: absolute;
            inset: -40% -30% auto auto;
            background: radial-gradient(circle, rgba(58,109,191,0.25), transparent 60%);
            width: 260px;
            height: 260px;
            filter: blur(10px);
            opacity: 0.6;
        }
        .login-card::after {
            content: "";
            position: absolute;
            inset: auto auto -35% -25%;
            background: radial-gradient(circle, rgba(58,109,191,0.18), transparent 60%);
            width: 240px;
            height: 240px;
            filter: blur(10px);
            opacity: 0.6;
        }
        .form-control {
            background: rgba(255, 255, 255, 0.12);
            border: 1px solid var(--border);
            color: var(--text) !important;
            padding: 0.9rem 1rem;
            border-radius: 14px;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            border-color: #4facfe;
            box-shadow: 0 0 0 4px rgba(79, 172, 254, 0.2);
            color: var(--text);
        }

        .form-control::placeholder {
            color: var(--muted);
        }
        
        .btn-primary-theme {
            background: linear-gradient(135deg, #00c6ff 0%, #0072ff 100%);
            border: none;
            padding: 1rem;
            font-weight: 700;
            letter-spacing: 1px;
            border-radius: 50px;
            transition: all 0.3s;
            box-shadow: 0 15px 30px rgba(0, 114, 255, 0.35);
        }

        .btn-primary-theme:hover {
            transform: translateY(-3px);
            box-shadow: 0 18px 40px rgba(0, 114, 255, 0.45);
            background: linear-gradient(135deg, #0072ff 0%, #00c6ff 100%);
        }

        .link-light-opacity {
            color: var(--muted);
            text-decoration: none;
            transition: color 0.2s;
        }
        .link-light-opacity:hover {
            color: var(--text);
        }

        .logo-mark {
            width: 60px;
            height: 60px;
            border-radius: 16px;
            display: grid;
            place-items: center;
            background: linear-gradient(145deg, rgba(255,255,255,0.18), rgba(255,255,255,0.28));
            color: #fff;
            font-weight: 800;
            letter-spacing: -0.4px;
            border: 1px solid rgba(255,255,255,0.25);
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.35);
        }
        [data-theme="light"] .logo-mark {
            color: #1e3c72;
            background: linear-gradient(145deg, rgba(58,109,191,0.18), rgba(255,255,255,0.5));
            border-color: rgba(42,82,152,0.3);
        }

        .theme-toggle {
            position: absolute;
            top: 18px;
            right: 18px;
            border: 1px solid var(--border);
            border-radius: 999px;
            background: rgba(255,255,255,0.2);
            color: var(--text);
            padding: 0.4rem 0.75rem;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            cursor: pointer;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.3);
        }
        .theme-toggle:hover {
            transform: translateY(-1px);
        }
        .theme-toggle .icon-sun {
            display: none;
        }
        [data-theme="light"] .theme-toggle .icon-sun {
            display: inline-flex;
        }
        [data-theme="light"] .theme-toggle .icon-moon {
            display: none;
        }

        .password-visual-group {
            position: relative;
        }
        .password-visual-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            background: linear-gradient(135deg, rgba(255,255,255,0.18), rgba(58,109,191,0.12));
            color: #fff;
            border-radius: 50%;
            width: 38px;
            height: 38px;
            display: grid;
            place-items: center;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .password-visual-toggle:hover {
            transform: translateY(-50%) scale(1.04);
            box-shadow: 0 10px 20px rgba(255,255,255,0.2);
        }
        [data-theme="light"] .password-visual-toggle {
            color: #1e3c72;
            background: linear-gradient(135deg, rgba(58,109,191,0.18), rgba(255,255,255,0.18));
        }
    </style>
</head>
<body data-theme="dark">

    <div class="login-card animate__animated animate__fadeInUp">
        <button class="theme-toggle" id="clientLoginThemeToggle" type="button" aria-label="Cambiar modo de color">
            <i class="bi bi-moon-stars-fill icon-moon"></i>
            <i class="bi bi-sun-fill icon-sun"></i>
        </button>
        <div class="text-center mb-5">
            <div class="logo-mark mb-3">ER</div>
            <h2 class="fw-bold mb-1" style="color: var(--text);">Bienvenido</h2>
            <p class="text-white-50" style="color: var(--muted);">Accede a tu portal de cliente</p>

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
                <div class="alert alert-danger border-0 bg-danger bg-opacity-25 text-white d-flex align-items-center p-3 rounded-3 mb-4" role="alert">
                   <i class="bi bi-exclamation-circle-fill me-3 flex-shrink-0 fs-5"></i>
                   <div class="small">${error}</div>
                </div>
            </c:if>
            
            <button class="w-100 btn btn-primary-theme text-white mb-4" type="submit">
                INGRESAR
            </button>
            
            <div class="text-center d-flex flex-column flex-md-row gap-3 justify-content-center align-items-center">
             <a href="<c:url value='/registro' />" class="link-light-opacity small fw-bold">
                    Crear Cuenta Nueva
                </a>
                    <span class="text-white-50 mx-2" style="color: var(--muted);">|</span>
                <a href="<c:url value='/' />" class="link-light-opacity small">
                    Soy Administrativo
                </a>
            </div>
            
        </form>
    </div>
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
                    </script>

</body>
</html>