<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="${titulo}" />
</jsp:include>

<c:if test="${not empty exito}"><div class="alert alert-success">${exito}</div></c:if>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h3><i class="bi bi-p-square-fill"></i> Gestión de Pisos y Espacios</h3>
    <a href="<c:url value='/gerente/pisos/nuevo' />" class="btn btn-success">
        <i class="bi bi-plus-circle-fill"></i> Nuevo Piso
    </a>
</div>

<p>Desde aquí puede gestionar los pisos de su sede y los espacios dentro de cada uno.</p>

<div class="accordion" id="accordionPisos">

    <c:forEach var="piso" items="${pisos}" varStatus="loop">
        <div class="accordion-item">
            <h2 class="accordion-header" id="heading-${loop.index}">
                <button class="accordion-button ${loop.first ? '' : 'collapsed'}" type="button" data-bs-toggle="collapse" 
                        data-bs-target="#collapse-${loop.index}" aria-expanded="${loop.first ? 'true' : 'false'}">
                    <strong>${piso.nombrePiso} (Piso ${piso.numeroPiso})</strong>
                    <span class="badge bg-secondary ms-2">${piso.espacios.size()} / ${piso.capacidadTotal} Espacios</span>
                </button>
            </h2>
            <div id="collapse-${loop.index}" class="accordion-collapse collapse ${loop.first ? 'show' : ''}" data-bs-parent="#accordionPisos">
                <div class="accordion-body">
                    
                    <div class="d-flex justify-content-end mb-3">
                         <a href="#" class="btn btn-sm btn-primary">
                            <i class="bi bi-plus-lg"></i> Añadir Espacio
                        </a>
                    </div>

                    <table class="table table-sm table-striped">
                        <thead>
                            <tr>
                                <th>N° Espacio</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="esp" items="${piso.espacios}">
                                <tr>
                                    <td>${esp.numeroEspacio}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${esp.estado == 'LIBRE'}"><span class="badge bg-success">LIBRE</span></c:when>
                                            <c:when test="${esp.estado == 'OCUPADO'}"><span class="badge bg-danger">OCUPADO</span></c:when>
                                            <c:otherwise><span class="badge bg-warning">MANTENIMIENTO</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="#" class="btn btn-sm btn-warning">
                                            <i class="bi bi-pencil-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty piso.espacios}">
                                <tr><td colspan="3" class="text-center">No hay espacios en este piso.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:forEach>

</div>

<jsp:include page="footer.jsp" />
