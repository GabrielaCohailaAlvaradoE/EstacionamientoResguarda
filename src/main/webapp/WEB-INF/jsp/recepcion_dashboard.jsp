<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- <%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> --%>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Control de Operaciones" />
</jsp:include>

<style>
    .dashboard-card {
        border: none;
        border-radius: 1rem;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .dashboard-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
    }
    .slot-card {
        border-radius: 12px;
        border: 1px solid rgba(0,0,0,0.05);
        background: white;
        transition: all 0.3s;
    }
    .slot-card.free { border-bottom: 4px solid #198754; }
    .slot-card.occupied { border-bottom: 4px solid #dc3545; }
    .slot-card.maintenance { border-bottom: 4px solid #ffc107; }
    
    .slot-card:hover {
        transform: scale(1.02);
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    }
    .bg-gradient-primary-dark {
        background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
    }
    .bg-gradient-dark {
        background: linear-gradient(135deg, #212529 0%, #343a40 100%);
    }
</style>

<div class="container-fluid px-4 py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-0">Panel de Operaciones</h2>
            <p class="text-muted mb-0">Gestión de flujo vehicular en tiempo real</p>
        </div>
        <div class="badge bg-light text-dark border p-2 shadow-sm">
            <i class="bi bi-clock me-1"></i> <span id="reloj">--:--</span>
        </div>
    </div>

    <c:if test="${not empty exito}">
        <div class="alert alert-success border-0 shadow-sm d-flex align-items-center mb-4" role="alert">
            <i class="bi bi-check-circle-fill fs-4 me-3"></i>
            <div>${exito}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger border-0 shadow-sm d-flex align-items-center mb-4" role="alert">
            <i class="bi bi-exclamation-octagon-fill fs-4 me-3"></i>
            <div>${error}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-4 mb-5">
        
        <div class="col-lg-7">
            <div class="card dashboard-card shadow h-100">
                <div class="card-header bg-white border-0 pt-4 ps-4 pe-4 pb-0 d-flex align-items-center">
                    <div class="bg-primary bg-opacity-10 p-3 rounded-circle me-3 text-primary">
                        <i class="bi bi-car-front-fill fs-4"></i>
                    </div>
                    <div>
                        <h5 class="fw-bold mb-0">Registrar Ingreso</h5>
                        <small class="text-muted">Asignar espacio y generar ticket</small>
                    </div>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/recepcion/registrarEntrada' />" method="POST" class="row g-3">
                        
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" class="form-control fw-bold" id="placa" name="placa" placeholder="ABC-123" required style="text-transform: uppercase; letter-spacing: 1px;">
                                <label for="placa"><i class="bi bi-upc-scan me-1"></i> Placa del Vehículo</label>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-floating">
                                <select id="espacio" name="idEspacio" class="form-select" required>
                                    <option value="" selected disabled>Seleccione ubicación</option>
                                    <c:forEach var="piso" items="${pisos}">
                                        <optgroup label="${piso.nombrePiso}">
                                            <c:forEach var="espacio" items="${piso.espacios}">
                                                <c:if test="${espacio.estado == 'LIBRE'}">
                                                    <option value="${espacio.idEspacio}">${espacio.numeroEspacio}</option>
                                                </c:if>
                                            </c:forEach>
                                        </optgroup>
                                    </c:forEach>
                                </select>
                                <label for="espacio"><i class="bi bi-p-square me-1"></i> Espacio Disponible</label>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="dni" name="dni" placeholder="DNI">
                                <label for="dni"><i class="bi bi-person-badge me-1"></i> DNI Conductor (Opcional - Si no es propietario)</label>
                            </div>
                        </div>

                        <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-primary w-100 py-3 rounded-3 fw-bold shadow-sm">
                                <i class="bi bi-ticket-perforated-fill me-2"></i> GENERAR TICKET DE INGRESO
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="card dashboard-card shadow h-100 border-0" style="background: #f8f9fa;">
                <div class="card-header bg-transparent border-0 pt-4 ps-4 pe-4 pb-0 d-flex align-items-center">
                    <div class="bg-dark bg-opacity-10 p-3 rounded-circle me-3 text-dark">
                        <i class="bi bi-wallet2 fs-4"></i>
                    </div>
                    <div>
                        <h5 class="fw-bold mb-0 text-dark">Salida y Cobro</h5>
                        <small class="text-muted">Procesar pago y liberar espacio</small>
                    </div>
                </div>
                <div class="card-body p-4">
                    
                    <form action="<c:url value='/recepcion/buscarSalida' />" method="POST">
                        <div class="input-group input-group-lg mb-3 shadow-sm">
                            <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                            <input type="text" class="form-control border-start-0" id="placaOpin" name="placaOpin" 
                                   value="${registroEncontrado.vehiculo.placa}" placeholder="Buscar Placa o PIN" required>
                            <button class="btn btn-dark" type="submit">Buscar</button>
                        </div>
                    </form>

                    <c:if test="${not empty errorSalida}">
                        <div class="alert alert-warning border-0 shadow-sm p-2 text-center small mb-3">
                            <i class="bi bi-exclamation-circle me-1"></i> ${errorSalida}
                        </div>
                    </c:if>

                    <c:if test="${not empty registroEncontrado}">
                        <div class="bg-white p-3 rounded-3 shadow-sm border">
                            <div class="d-flex justify-content-between mb-2 border-bottom pb-2">
                                <span class="fw-bold">Vehículo:</span>
                                <span class="text-primary">${registroEncontrado.vehiculo.placa}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Tiempo:</span>
                                <span>${minutosTranscurridos} min</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3 align-items-center bg-light p-2 rounded">
                                <span class="fw-bold text-dark">TOTAL A PAGAR:</span>
                                <span class="fs-4 fw-bold text-success">S/ ${registroEncontrado.montoTotal}</span>
                            </div>

                            <form action="<c:url value='/recepcion/registrarPago' />" method="POST">
                                <input type="hidden" name="idRegistro" value="${registroEncontrado.idRegistro}">
                                <input type="hidden" name="montoTotal" value="${registroEncontrado.montoTotal}">
                                
                                <div class="row g-2 mb-3">
                                    <div class="col-6">
                                        <select id="metodoPago" name="metodoPago" class="form-select form-select-sm">
                                            <option value="EFECTIVO">💵 Efectivo</option>
                                            <option value="TARJETA">💳 Tarjeta</option>
                                            <option value="YAPE">📱 Yape</option>
                                            <option value="PLIN">📱 Plin</option>
                                        </select>
                                    </div>
                                    <div class="col-6">
                                        <input type="number" step="0.10" class="form-control form-control-sm" 
                                               id="montoRecibido" name="montoRecibido" placeholder="Recibido S/" required>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-success w-100 btn-sm fw-bold shadow-sm">
                                    <i class="bi bi-cash-coin me-1"></i> COBRAR Y SALIR
                                </button>
                            </form>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>
    </div>

    <div class="d-flex align-items-center mb-3">
        <h4 class="fw-bold mb-0 me-3"><i class="bi bi-grid-3x3-gap-fill text-primary"></i> Mapa de Espacios</h4>
        <div class="d-flex gap-3 ms-auto small">
            <span class="d-flex align-items-center"><span class="badge bg-success rounded-circle p-1 me-1"> </span> Libre</span>
            <span class="d-flex align-items-center"><span class="badge bg-danger rounded-circle p-1 me-1"> </span> Ocupado</span>
            <span class="d-flex align-items-center"><span class="badge bg-warning rounded-circle p-1 me-1"> </span> Reservado/Mant.</span>
        </div>
    </div>
    <hr class="mb-4">

    <c:forEach var="piso" items="${pisos}">
        <div class="card mb-4 border-0 shadow-sm">
            <div class="card-body bg-light rounded-3">
                <h6 class="text-muted fw-bold text-uppercase mb-3 small ls-1">${piso.nombrePiso}</h6>
                
                <div class="row row-cols-2 row-cols-md-4 row-cols-lg-6 g-3">
                    <c:forEach var="espacio" items="${piso.espacios}">
                        
                        <c:choose>
                            <c:when test="${espacio.estado == 'LIBRE'}">
                                <c:set var="statusClass" value="free" />
                                <c:set var="bgHeader" value="bg-success" />
                                <c:set var="icon" value="bi-check-lg" />
                                <c:set var="btnColor" value="btn-outline-success" />
                                <c:set var="btnText" value="Ocupar" />
                            </c:when>
                            <c:when test="${espacio.estado == 'OCUPADO'}">
                                <c:set var="statusClass" value="occupied" />
                                <c:set var="bgHeader" value="bg-danger" />
                                <c:set var="icon" value="bi-car-front-fill" />
                                <c:set var="btnColor" value="btn-outline-danger" />
                                <c:set var="btnText" value="Liberar" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="statusClass" value="maintenance" />
                                <c:set var="bgHeader" value="bg-warning text-dark" />
                                <c:set var="icon" value="bi-cone-striped" />
                                <c:set var="btnColor" value="btn-outline-warning disabled" />
                                <c:set var="btnText" value="Reservado" />
                            </c:otherwise>
                        </c:choose>

                        <div class="col">
                            <div class="card h-100 shadow-sm slot-card ${statusClass}">
                                <div class="card-header ${bgHeader} py-1 px-2 text-center border-0">
                                    <small class="fw-bold text-white small">${espacio.numeroEspacio}</small>
                                </div>
                                <div class="card-body d-flex flex-column align-items-center justify-content-center py-3">
                                    <i class="bi ${icon} fs-3 mb-1 opacity-75"></i>
                                    <span class="badge bg-light text-dark border fw-normal small mb-2">
                                        ${espacio.estado}
                                    </span>
                                    
                                    <c:if test="${espacio.estado == 'LIBRE'}">
                                        <button class="btn btn-sm rounded-pill px-3 ${btnColor}" style="font-size: 0.75rem;">
                                            ${btnText}
                                        </button>
                                    </c:if>
                                     <c:if test="${espacio.estado == 'OCUPADO'}">
                                        <small class="text-muted" style="font-size: 0.7rem;">Ver Salida</small>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                    </c:forEach>
                    
                    <c:if test="${empty piso.espacios}">
                        <div class="col-12 text-center text-muted py-4">
                            <i class="bi bi-info-circle me-2"></i> No hay espacios configurados en este piso.
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </c:forEach>

</div>

<script>
    // Script simple para el reloj del dashboard
    function updateClock() {
        const now = new Date();
        document.getElementById('reloj').innerText = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    }
    setInterval(updateClock, 1000);
    updateClock();
</script>

<jsp:include page="footer.jsp" />