<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="${titulo}" />
</jsp:include>

<div class="container-fluid">
    <div class="mb-4">
        <h1 class="h3">Dashboard Gerencial</h1>
        <p class="text-muted">Bienvenido, ${empleadoLogueado.nombres}. Resumen de su sede.</p>
    </div>

    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card text-white bg-primary shadow h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="display-4 fw-bold">${kpi_total_empleados}</div>
                            <div class="h5">Empleados Activos</div>
                        </div>
                        <i class="bi bi-people-fill" style="font-size: 4rem; opacity: 0.5;"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card text-white bg-info shadow h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="display-4 fw-bold">${kpi_vehiculos_ahora}</div>
                            <div class="h5">Vehículos Estacionados</div>
                        </div>
                        <i class="bi bi-car-front-fill" style="font-size: 4rem; opacity: 0.5;"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card text-white bg-secondary shadow h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="display-4 fw-bold">${kpi_total_espacios}</div>
                            <div class="h5">Espacios Totales</div>
                        </div>
                        <i class="bi bi-grid-3x3" style="font-size: 4rem; opacity: 0.5;"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <hr class="my-4">
    <h2 class="h4">Acciones de Gestión</h2>
    <div class="row">
        <div class="col-md-6 mb-4">
            <div class="card shadow h-100">
                <div class="card-body d-flex flex-column justify-content-between">
                    <div>
                        <i class="bi bi-person-lines-fill text-primary" style="font-size: 2rem;"></i>
                        <h5 class="card-title mt-2">Gestionar Empleados</h5>
                        <p class="card-text">Añadir, editar o desactivar las cuentas del personal de recepción y vigilancia de su sede.</p>
                    </div>
                    <a href="<c:url value='/gerente/empleados' />" class="btn btn-primary mt-3">
                        Ir a Gestión de Empleados
                    </a>
                </div>
            </div>
        </div>

        <div class.="col-md-6 mb-4">
            <div class="card shadow h-100">
                <div class="card-body d-flex flex-column justify-content-between">
                    <div>
                        <i class="bi bi-p-square-fill text-secondary" style="font-size: 2rem;"></i>
                        <h5 class="card-title mt-2">Gestionar Pisos y Espacios</h5>
                        <p class="card-text">Crear nuevos pisos, añadir espacios o marcar espacios existentes como "Mantenimiento".</p>
                    </div>

                    <a href="<c:url value='/gerente/espacios' />" class="btn btn-secondary mt-3">
                        Ir a Gestión de Espacios
                    </a>

                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />