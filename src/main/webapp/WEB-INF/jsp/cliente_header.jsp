<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>${titulo} - Portal de Cliente</title>
    
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

        <style>
            /*
         * Tema moderno para clientes manteniendo los colores corporativos.
         * Reutiliza los mismos tonos azules y agrega modo claro/oscuro.
         */
            :root {
                --client-blue-900: #0f1f3a;
                --client-blue-700: #1e3c72;
                --client-blue-600: #2a5298;
                --client-blue-500: #3a6dbf;
                --neutral-50: #f8fafc;
                --neutral-200: #e2e8f0;
                --neutral-800: #1f2937;
                --surface: #ffffff;
                --surface-2: rgba(255,255,255,0.9);
                --text: #0f172a;
                --muted: #4b5563;
                --shadow-soft: 0 20px 45px rgba(18, 36, 70, 0.16);
                --border-soft: rgba(42, 82, 152, 0.15);
                --hero-overlay: linear-gradient(135deg, rgba(15, 23, 42, 0.9) 0%, rgba(30, 58, 138, 0.8) 100%);
            }
            [data-theme="dark"] {
                --surface: #0f172a;
                --surface-2: rgba(15, 23, 42, 0.92);
                --text: #e5e7eb;
                --muted: #cbd5e1;
                --neutral-50: #0b1220;
                --neutral-200: #131c2d;
                --shadow-soft: 0 18px 40px rgba(0, 0, 0, 0.35);
                --border-soft: rgba(58, 109, 191, 0.2);
                --hero-overlay: linear-gradient(135deg, rgba(18, 32, 56, 0.94) 0%, rgba(42, 82, 152, 0.88) 100%);
            }
        body {
            font-family: 'Outfit', sans-serif;
            background: radial-gradient(circle at 10% 20%, rgba(42,82,152,0.12), transparent 30%),
                radial-gradient(circle at 90% 10%, rgba(16,31,58,0.18), transparent 32%),
                var(--neutral-50);
            color: var(--text);
            transition: background 0.45s ease, color 0.35s ease;
        }

        /* HERO BANNER con glass y burbujas suaves */
        .hero-header {
            background: var(--hero-overlay), url('https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?q=80&w=1920&auto=format&fit=crop');
            background-size: cover;
            background-position: center center;
            background-attachment: fixed;
            padding-bottom: 5rem;
            border-bottom-left-radius: 48px;
            border-bottom-right-radius: 48px;
            box-shadow: 0 25px 50px rgba(15, 23, 42, 0.22);
            margin-bottom: -3rem;
            position: relative;
            overflow: hidden;
        }
        .hero-header::after {
            content: "";
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 20% 30%, rgba(255,255,255,0.08), transparent 40%),
                radial-gradient(circle at 80% 20%, rgba(15,23,42,0.16), transparent 35%);
            pointer-events: none;
        }

        /* NAVBAR GLASSMORPHISM */
        .navbar-glass {
            background: rgba(255, 255, 255, 0.06);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            border: 1px solid rgba(255, 255, 255, 0.16);
            border-radius: 22px;
            box-shadow: 0 15px 45px rgba(0,0,0,0.2);
        }

        .navbar-brand {
            font-weight: 800;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: white !important;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .brand-mark {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: rgba(255,255,255,0.16);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.35);
            font-weight: 800;
            letter-spacing: -0.4px;
        }
        .brand-mark::after {
            content: "ER";
            color: #fff;
        }
        .brand-mark-dark {
            display: none;
            background: linear-gradient(145deg, rgba(33,70,128,0.85), rgba(58,109,191,0.85));
        }
        [data-theme="dark"] .brand-mark {
            display: none;
        }
        [data-theme="dark"] .brand-mark-dark {
            display: inline-flex;
        }
        .nav-link {
            color: rgba(255,255,255,0.9) !important;
            font-weight: 600;
            transition: all 0.28s ease;
            padding: 0.6rem 1.2rem;
            border-radius: 14px;
            margin: 0 2px;
            position: relative;
            overflow: hidden;
        }
        .nav-link::before {
            content: "";
            position: absolute;
            inset: 0;
            background: rgba(255,255,255,0.16);
            opacity: 0;
            transition: opacity 0.25s ease;
        }
        .nav-link:hover::before, .nav-link.active::before {
            opacity: 1;
        }
        .nav-link:hover {
            color: #fff !important;
            transform: translateY(-1px);
        }
        .nav-link.active {
            color: #fff !important;
            font-weight: 700;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.3);
        }

        /* MENÚS DE USUARIO Y NOTIFICACIONES */
        .user-pill {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.25);
            border-radius: 999px;
            padding: 6px 20px;
            transition: all 0.3s;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.3);
        }
        .user-pill:hover {
            background: rgba(255,255,255,0.18);
            transform: translateY(-1px);
        }
        
        .dropdown-menu-animate {
            animation: fadeInDown 0.35s cubic-bezier(0.68, -0.55, 0.27, 1.55);
            border: 1px solid var(--border-soft);
            box-shadow: var(--shadow-soft);
            border-radius: 16px;
            overflow: hidden;
            margin-top: 15px;
            background: var(--surface);
        }
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-18px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .page-title-large {
            font-size: 3rem;
            font-weight: 800;
            color: white;
            text-shadow: 0 4px 20px rgba(0,0,0,0.5);
            margin-top: 3rem;
            letter-spacing: -1px;
        }
        .page-subtitle { color: rgba(255,255,255,0.7); }
        main.container-fluid { position: relative; z-index: 10; max-width: 1400px; }
        /* Tarjetas y tablas con look limpio en ambos modos */
        .card, .table {
            background: var(--surface);
            border: 1px solid var(--border-soft);
            border-radius: 18px;
            box-shadow: var(--shadow-soft);
        }
        .card:hover {
            transform: translateY(-3px);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            box-shadow: 0 18px 40px rgba(42, 82, 152, 0.25);
        }
        .table thead th {
            border: none;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .table tbody tr {
            border: none;
        }

        .theme-toggle {
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.25);
            color: #fff;
            border-radius: 999px;
            padding: 0.35rem 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            cursor: pointer;
            transition: all 0.25s ease;
        }
        .theme-toggle:hover {
            background: rgba(255,255,255,0.22);
            transform: translateY(-1px);
        }
        .icon-moon {
            display: none;
        }
        [data-theme="dark"] .icon-sun {
            display: none;
        }
        [data-theme="dark"] .icon-moon {
            display: inline-flex;
        }

        input[type="text"], input[type="password"], input[type="email"], input[type="number"], select, textarea {
            border-radius: 14px !important;
            border: 1px solid var(--border-soft) !important;
            background: var(--surface) !important;
            color: var(--text) !important;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }
        input:focus, select:focus, textarea:focus {
            border-color: var(--client-blue-500) !important;
            box-shadow: 0 0 0 4px rgba(58,109,191,0.18);
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
            background: linear-gradient(135deg, rgba(58,109,191,0.14), rgba(58,109,191,0.08));
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
            box-shadow: 0 10px 20px rgba(58,109,191,0.22);
        }
        [data-theme="dark"] .password-visual-toggle {
            background: linear-gradient(135deg, rgba(58,109,191,0.25), rgba(15,23,42,0.55));
        }
    </style>
</head>
<body data-theme="light">

    <header class="hero-header">
        <nav class="navbar navbar-expand-lg navbar-dark navbar-glass py-3">
            <div class="container-fluid px-4">
                <a class="navbar-brand d-flex align-items-center" href="<c:url value='/cliente/reservas' />">
                    <span class="brand-mark"></span>
                    <span class="brand-mark brand-mark-dark"></span>
                    RESGUARDA <span class="fw-light ms-2 opacity-75 border-start ps-2 border-light" style="font-size: 0.9rem;">CLIENTE</span>
                </a>
                
                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCliente">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="navbarCliente">
                    <ul class="navbar-nav mx-auto mb-2 mb-lg-0 gap-2">
                        <li class="nav-item">
                            <a class="nav-link ${titulo == 'Mis Reservas' ? 'active' : ''}" href="<c:url value='/cliente/reservas' />">
                                <i class="bi bi-calendar2-check me-1"></i> Reservas
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link ${titulo == 'Mapa en Vivo' ? 'active' : ''}" href="<c:url value='/cliente/mapa' />">
                                <i class="bi bi-geo-alt-fill me-1"></i> Mapa
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link ${titulo == 'Mis Vehículos' ? 'active' : ''}" href="<c:url value='/cliente/vehiculos' />">
                                <i class="bi bi-car-front me-1"></i> Vehículos
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${titulo == 'Seguridad y Pagos' ? 'active' : ''}" href="<c:url value='/cliente/seguridad' />">
                                <i class="bi bi-wallet2 me-1"></i> Pagos
                            </a>
                        </li>
                    </ul>
                    
                    <ul class="navbar-nav align-items-center gap-2">
                        
                        <li class="nav-item">
                            <button class="theme-toggle" id="clientThemeToggle" type="button" aria-label="Cambiar modo de color">
                                <i class="bi bi-sun-fill icon-sun"></i>
                                <i class="bi bi-moon-stars-fill icon-moon"></i>
                            </button>
                        </li>
                        
                        <li class="nav-item dropdown">
                            <a class="nav-link position-relative me-2" href="#" id="notifDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-bell-fill fs-5"></i>
                                <c:if test="${alertasNoLeidas > 0}">
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger border border-light p-1" style="font-size: 0.5rem;">
                                        ${alertasNoLeidas}
                                    </span>
                                </c:if>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-animate shadow-lg" aria-labelledby="notifDropdown" style="width: 320px; max-height: 400px; overflow-y: auto;">
                                <li class="px-3 py-2 fw-bold text-muted small border-bottom bg-light">NOTIFICACIONES</li>
                                <c:choose>
                                    <c:when test="${not empty alertas}">
                                        <c:forEach var="alerta" items="${alertas}">
                                            <li><a class="dropdown-item py-3 border-bottom" href="#">
                                                <div class="d-flex align-items-start">
                                                    <div class="me-3 mt-1">
                                                        <c:choose>
                                                            <c:when test="${alerta.tipo == 'ADVERTENCIA'}"><i class="bi bi-exclamation-circle-fill text-warning fs-5"></i></c:when>
                                                            <c:when test="${alerta.tipo == 'EXITO'}"><i class="bi bi-check-circle-fill text-success fs-5"></i></c:when>
                                                            <c:otherwise><i class="bi bi-info-circle-fill text-primary fs-5"></i></c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-1 fs-6 fw-bold ${alerta.leida ? 'text-muted' : 'text-dark'}">${alerta.titulo}</h6>
                                                        <p class="mb-1 small text-muted text-wrap" style="line-height: 1.3;">${alerta.mensaje}</p>
                                                        <small class="text-secondary" style="font-size: 0.7rem;">Reciente</small>
                                                    </div>
                                                </div>
                                            </a></li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise><li class="text-center py-4 text-muted small">Sin notificaciones nuevas.</li></c:otherwise>
                                </c:choose>
                            </ul>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle user-pill d-flex align-items-center" href="#" id="navbarUserMenu" role="button" data-bs-toggle="dropdown">
                                <img src="https://ui-avatars.com/api/?name=${clienteLogueado.nombres}&background=0d6efd&color=fff&bold=true" class="rounded-circle me-2 shadow-sm" width="32" height="32">
                                <span class="fw-bold text-white small text-uppercase">${clienteLogueado.nombres}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-animate" aria-labelledby="navbarUserMenu">
                                <li class="px-3 py-2 text-muted small border-bottom fw-bold bg-light">MI CUENTA</li>
                                <li><a class="dropdown-item mt-1" href="<c:url value='/cliente/perfil' />"><i class="bi bi-person-gear me-2 text-primary"></i> Editar Perfil</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger fw-bold" href="<c:url value='/logout' />"><i class="bi bi-power me-2"></i> Cerrar Sesión</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid px-4 text-start">
            <div class="row">
                <div class="col-lg-8">
                    <h1 class="page-title-large">${titulo}</h1>
                    <p class="page-subtitle text-white-50 fs-5">Bienvenido al sistema de gestión inteligente.</p>
                </div>
            </div>
        </div>
    </header>

                    <main class="container-fluid mt-5 px-4">

                        <script>
                            // Alternancia de tema con persistencia y animación suave entre azul claro y oscuro equilibrado
                            (() => {
                                const body = document.body;
                                const toggle = document.getElementById('clientThemeToggle');
                                const saved = localStorage.getItem('resguarda-client-theme');
                                if (saved) body.dataset.theme = saved;
                                const sync = () => toggle?.setAttribute('aria-pressed', body.dataset.theme === 'dark');
                                sync();
                                toggle?.addEventListener('click', () => {
                                    const next = body.dataset.theme === 'dark' ? 'light' : 'dark';
                                    body.dataset.theme = next;
                                    localStorage.setItem('resguarda-client-theme', next);
                                    sync();
                                });
                            })();

                            // Toggle de contraseñas reutilizable sin cambiar flujos existentes
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