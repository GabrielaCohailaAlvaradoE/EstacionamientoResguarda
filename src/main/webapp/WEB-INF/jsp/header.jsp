<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${titulo} - Estación Resguarda</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        /*
         * Paleta 2024-2025 basada en los azules y neutros existentes.
         * Se usa con CSS vars para alternar entre modo claro y oscuro sin cambiar rutas o lógica.
         */
        :root {
            --brand-blue-900: #0f1f3a;
            --brand-blue-800: #1c3460;
            --brand-blue-700: #214680;
            --brand-blue-600: #2a5298;
            --brand-blue-500: #3a6dbf;
            --brand-blue-200: #dbeafe;
            --neutral-100: #f7f9fc;
            --neutral-200: #edf1f7;
            --neutral-300: #d9deea;
            --neutral-700: #1f2937;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffb703;
            --card-shadow: 0 18px 45px rgba(10, 31, 68, 0.12);
            --soft-border: rgba(34, 69, 126, 0.12);
            --surface: #ffffff;
            --surface-2: rgba(255, 255, 255, 0.85);
            --text-color: #0f172a;
            --muted-text: #4b5563;
            --glow: 0 10px 35px rgba(58, 109, 191, 0.25);
            --nav-gradient: linear-gradient(120deg, #1e3c72 0%, #2a5298 50%, #3a6dbf 100%);
            --backdrop: radial-gradient(circle at 10% 10%, rgba(58, 109, 191, 0.14), transparent 25%),
                        radial-gradient(circle at 90% 20%, rgba(15, 31, 58, 0.16), transparent 30%),
                        radial-gradient(circle at 50% 80%, rgba(33, 70, 128, 0.12), transparent 30%);
        }

        /* Modo oscuro refinado sin negros puros, mantiene la misma estructura visual. */
        [data-theme="dark"] {
            --surface: #101826;
            --surface-2: rgba(21, 28, 41, 0.9);
            --text-color: #e5e7eb;
            --muted-text: #cbd5e1;
            --neutral-100: #0b1220;
            --neutral-200: #131c2d;
            --neutral-300: #1f2b3f;
            --card-shadow: 0 15px 40px rgba(0, 0, 0, 0.35);
            --soft-border: rgba(74, 126, 196, 0.18);
            --nav-gradient: linear-gradient(120deg, rgba(30, 60, 114, 0.92) 0%, rgba(42, 82, 152, 0.9) 50%, rgba(58, 109, 191, 0.95) 100%);
            --backdrop: radial-gradient(circle at 15% 20%, rgba(58, 109, 191, 0.16), transparent 30%),
                        radial-gradient(circle at 80% 10%, rgba(34, 69, 126, 0.24), transparent 35%),
                        radial-gradient(circle at 55% 90%, rgba(12, 22, 40, 0.55), transparent 40%);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--backdrop), var(--neutral-100);
            color: var(--text-color);
            transition: background 0.5s ease, color 0.4s ease;
            min-height: 100vh;
        }

        /* Decoración suave de fondo */
        .ambient-bubble {
            position: fixed;
            width: 220px;
            height: 220px;
            border-radius: 50%;
            filter: blur(60px);
            opacity: 0.18;
            z-index: 0;
            pointer-events: none;
            animation: floatBubble 12s ease-in-out infinite alternate;
        }
        .bubble-1 { background: #2a5298; top: 5%; left: 12%; }
        .bubble-2 { background: #3a6dbf; bottom: 10%; right: 6%; animation-delay: 2s; }
        @keyframes floatBubble {
            from { transform: translateY(0) scale(1); }
            to { transform: translateY(-18px) scale(1.05); }
        }

        /* Navbar con glassmorphism controlado y botón de modo */
        .navbar-pro {
            background: var(--nav-gradient);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
            padding: 0.9rem 1.2rem;
            border-radius: 18px;
            margin: 1rem 1rem 0;
            position: sticky;
            top: 0.8rem;
            z-index: 1030;
            border: 1px solid rgba(255, 255, 255, 0.08);
        }

        .brand-mark {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            letter-spacing: -0.5px;
            background: linear-gradient(140deg, rgba(255,255,255,0.15), rgba(255,255,255,0.04));
            border: 1px solid rgba(255,255,255,0.15);
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.2);
            margin-right: 10px;
            transition: transform 0.3s ease;
        }
        .brand-mark::after { content: "ER"; color: #fff; font-size: 0.9rem; }
        .brand-mark-dark { display: none; background: linear-gradient(150deg, rgba(33,70,128,0.8), rgba(58,109,191,0.85)); }
        [data-theme="dark"] .brand-mark { display: none; }
        [data-theme="dark"] .brand-mark-dark { display: inline-flex; }

        .navbar-brand {
            font-weight: 800;
            letter-spacing: 0.6px;
            font-size: 1.1rem;
            text-transform: uppercase;
            color: #fff !important;
            display: flex;
            align-items: center;
            gap: 0.35rem;
        }

        .nav-link {
            font-weight: 600;
            color: rgba(255,255,255,0.86) !important;
            transition: all 0.25s ease;
            border-radius: 12px;
            padding: 0.55rem 1rem !important;
            margin: 0 0.15rem;
            position: relative;
            overflow: hidden;
        }
        .nav-link::before {
            content: "";
            position: absolute;
            inset: 0;
            background: rgba(255,255,255,0.12);
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .nav-link:hover::before, .nav-link.active::before { opacity: 1; }
        .nav-link:hover { transform: translateY(-1px); color: #fff !important; }
        .nav-link.active { color: #fff !important; box-shadow: inset 0 1px 0 rgba(255,255,255,0.2); }
        .nav-link i { margin-right: 6px; }

        /* Perfil de Usuario */
        .user-profile-btn {
            background: rgba(255, 255, 255, 0.12);
            border: 1px solid rgba(255, 255, 255, 0.25);
            color: white !important;
            border-radius: 999px;
            padding: 0.45rem 1.2rem !important;
            font-size: 0.92rem;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.25);
            transition: all 0.25s ease;
        }
        .user-profile-btn:hover { background: rgba(255, 255, 255, 0.2); transform: translateY(-1px); }

        .dropdown-menu {
            border: 1px solid var(--soft-border);
            box-shadow: var(--card-shadow);
            border-radius: 14px;
            margin-top: 12px;
            background: var(--surface);
        }
        .dropdown-item {
            padding: 0.75rem 1.2rem;
            font-size: 0.95rem;
            color: var(--text-color);
            transition: background 0.2s ease, color 0.2s ease;
        }
        .dropdown-item:hover { background-color: rgba(58,109,191,0.08); color: var(--brand-blue-800); }
        [data-theme="dark"] .dropdown-item:hover { background-color: rgba(58,109,191,0.16); color: #e5e7eb; }

        /* Utilidad para el contenido principal y tarjetas */
        main.main-content {
            min-height: 82vh;
            padding-bottom: 3rem;
            position: relative;
            z-index: 1;
        }
        .card {
            background: var(--surface);
            border: 1px solid var(--soft-border);
            border-radius: 18px;
            box-shadow: var(--card-shadow);
            transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
        }
        .card:hover { transform: translateY(-4px); box-shadow: var(--glow); border-color: rgba(58,109,191,0.25); }
        [data-theme="dark"] .card { background: var(--surface-2); }

        .card-title, .card-body, p, h1, h2, h3, h4, h5, h6 { color: var(--text-color); }
        .text-muted { color: var(--muted-text) !important; }

        /* Tablas y botones adoptan los colores existentes con microinteracciones. */
        .table { border-collapse: separate; border-spacing: 0 8px; }
        .table thead th { color: var(--muted-text); font-weight: 700; border: none; text-transform: uppercase; letter-spacing: 0.5px; }
        .table tbody tr { background: var(--surface); border: 1px solid var(--soft-border); box-shadow: var(--card-shadow); border-radius: 14px; overflow: hidden; }
        .table tbody td { border: none; vertical-align: middle; }
        [data-theme="dark"] .table tbody tr { background: var(--surface-2); }

        .btn-primary, .btn-secondary, .btn-success, .btn-danger {
            border-radius: 12px;
            font-weight: 700;
            border: none;
            padding: 0.65rem 1.1rem;
            letter-spacing: 0.3px;
            transition: transform 0.2s ease, box-shadow 0.2s ease, filter 0.2s ease;
        }
        .btn-primary { background: linear-gradient(135deg, var(--brand-blue-700), var(--brand-blue-500)); box-shadow: 0 12px 30px rgba(58,109,191,0.35); }
        .btn-secondary { background: linear-gradient(135deg, var(--brand-blue-800), var(--brand-blue-600)); box-shadow: 0 12px 30px rgba(33,70,128,0.3); }
        .btn-success { background: linear-gradient(135deg, #1f9254, #28a745); box-shadow: 0 12px 30px rgba(40,167,69,0.3); }
        .btn-danger { background: linear-gradient(135deg, #c53030, #dc3545); box-shadow: 0 12px 30px rgba(220,53,69,0.28); }
        .btn:hover { transform: translateY(-1.5px); filter: brightness(1.02); }
        .btn:active { transform: translateY(0); box-shadow: none; }

        /* Interruptor de tema con microinteracción */
        .theme-toggle {
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.25);
            color: #fff;
            border-radius: 999px;
            padding: 0.4rem 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            cursor: pointer;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.25);
            transition: all 0.25s ease;
        }
        .theme-toggle:hover { background: rgba(255,255,255,0.22); transform: translateY(-1px); }
        .theme-toggle .icon-moon { display: none; }
        [data-theme="dark"] .theme-toggle .icon-sun { display: none; }
        [data-theme="dark"] .theme-toggle .icon-moon { display: inline-flex; }

        /* Inputs con enfoque premium y soporte para toggle de contraseña */
        input[type="text"], input[type="password"], input[type="email"], input[type="number"], select, textarea {
            border-radius: 14px !important;
            border: 1px solid var(--soft-border) !important;
            background: var(--surface) !important;
            color: var(--text-color) !important;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.4);
            transition: border-color 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
        }
        input:focus, select:focus, textarea:focus {
            border-color: var(--brand-blue-500) !important;
            box-shadow: 0 0 0 4px rgba(58,109,191,0.15);
            outline: none;
        }
        .password-visual-group { position: relative; }
        .password-visual-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            background: linear-gradient(135deg, rgba(58,109,191,0.12), rgba(58,109,191,0.08));
            color: var(--brand-blue-700);
            border-radius: 50%;
            width: 38px; height: 38px;
            display: grid;
            place-items: center;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
        }
        .password-visual-toggle:hover { transform: translateY(-50%) scale(1.05); box-shadow: 0 10px 20px rgba(58,109,191,0.18); }
        [data-theme="dark"] .password-visual-toggle { color: #e5e7eb; background: linear-gradient(135deg, rgba(58,109,191,0.25), rgba(16,24,38,0.6)); }

        footer.container-fluid {
            background: linear-gradient(135deg, rgba(58,109,191,0.05), rgba(33,70,128,0.08));
            border-radius: 20px;
            border: 1px solid var(--soft-border);
            box-shadow: var(--card-shadow);
        }
    </style>
</head>
<body data-theme="light">
    <div class="ambient-bubble bubble-1"></div>
    <div class="ambient-bubble bubble-2"></div>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-pro">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <span class="brand-mark"></span>
                <span class="brand-mark brand-mark-dark"></span>
                <span>ESTACIÓN RESGUARDA</span>
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                    <c:if test="${empleadoLogueado.idRol == 3}"> <li class="nav-item">
                            <a class="nav-link ${titulo == 'Control de Operaciones' ? 'active' : ''}" href="<c:url value='/recepcion/dashboard' />">
                                <i class="bi bi-speedometer2"></i> Operaciones
                            </a>
                        </li>
                    </c:if>

                    <c:if test="${empleadoLogueado.idRol == 2}"> <li class="nav-item">
                            <a class="nav-link ${titulo == 'Dashboard Gerente' ? 'active' : ''}" href="<c:url value='/gerente/dashboard' />">
                                <i class="bi bi-graph-up-arrow"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${titulo == 'Gestión de Empleados' ? 'active' : ''}" href="<c:url value='/gerente/empleados' />">
                                <i class="bi bi-people"></i> Empleados
                            </a>
                        </li>
                         <li class="nav-item">
                            <a class="nav-link ${titulo == 'Gestión de Pisos y Espacios' ? 'active' : ''}" href="<c:url value='/gerente/espacios' />">
                                <i class="bi bi-grid"></i> Espacios
                            </a>
                        </li>
                    </c:if>
                </ul>

                <ul class="navbar-nav">
                    <li class="nav-item me-2">
                        <button class="theme-toggle" type="button" id="themeToggle" aria-label="Cambiar modo de color">
                            <i class="bi bi-sun-fill icon-sun"></i>
                            <i class="bi bi-moon-stars-fill icon-moon"></i>
                        </button>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle user-profile-btn d-flex align-items-center" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-2"></i>
                            <span>${empleadoLogueado.nombres}</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end animate slideIn" aria-labelledby="userDropdown">
                            <li><span class="dropdown-header text-uppercase small fw-bold">Mi Cuenta</span></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i> Configuración</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger fw-bold" href="<c:url value='/logout' />">
                                    <i class="bi bi-box-arrow-right me-2"></i> Cerrar Sesión
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="container-fluid mt-4 main-content">

    <script>
        // Tema claro / oscuro con persistencia local y animación suave
        (() => {
            const body = document.body;
            const toggle = document.getElementById('themeToggle');
            const savedTheme = localStorage.getItem('resguarda-theme');
            if (savedTheme) {
                body.dataset.theme = savedTheme;
            }
            const applyIcon = () => {
                if (!toggle) return;
                toggle.setAttribute('aria-pressed', body.dataset.theme === 'dark');
            };
            applyIcon();
            toggle?.addEventListener('click', () => {
                const next = body.dataset.theme === 'dark' ? 'light' : 'dark';
                body.dataset.theme = next;
                localStorage.setItem('resguarda-theme', next);
                applyIcon();
            });
        })();

        // Mejora de inputs de contraseña con icono de ojo animado sin alterar la lógica de formularios
        (() => {
            const enhancePasswords = () => {
                document.querySelectorAll('input[type="password"]').forEach((input) => {
                    if (input.dataset.enhanced === 'true') return;
                    input.dataset.enhanced = 'true';
                    input.classList.add('password-visual-input');
                    const wrapper = input.parentElement;
                    if (wrapper) {
                        wrapper.classList.add('password-visual-group');
                    }
                    const toggleBtn = document.createElement('button');
                    toggleBtn.type = 'button';
                    toggleBtn.className = 'password-visual-toggle';
                    toggleBtn.innerHTML = '<i class="bi bi-eye-slash"></i>';
                    toggleBtn.setAttribute('aria-label', 'Mostrar u ocultar contraseña');
                    const label = input.nextElementSibling && input.nextElementSibling.tagName === 'LABEL' ? input.nextElementSibling : null;
                    if (label) {
                        label.insertAdjacentElement('afterend', toggleBtn);
                    } else {
                        input.insertAdjacentElement('afterend', toggleBtn);
                    }
                    toggleBtn.addEventListener('click', () => {
                        const isHidden = input.type === 'password';
                        input.type = isHidden ? 'text' : 'password';
                        toggleBtn.innerHTML = isHidden ? '<i class="bi bi-eye"></i>' : '<i class="bi bi-eye-slash"></i>';
                    });
                });
            };
            document.addEventListener('DOMContentLoaded', enhancePasswords);
        })();
    </script>