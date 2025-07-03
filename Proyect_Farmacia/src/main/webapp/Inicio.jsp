<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>

<c:if test="${empty sessionScope.empleado}">
	<jsp:forward page="/Login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Notificaciones - Farmaluz</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

	<link rel="stylesheet" href="css/General.css">
    <link rel="stylesheet" href="css/Inicio.css">

</head>
<body>

<%-- INCLUSIÓN DEL MENÚ LATERAL (SIDEBAR) --%>
<%@ include file="principal/menu.jsp" %>

<%-- CONTENIDO PRINCIPAL DE LA PÁGINA --%>
<div class="main-content-area">

    <div class="header-section">
        <h2>
            <i class="fas fa-bell"></i>
            Notificaciones y Anuncios
        </h2>
        <p class="mb-0 mt-2 opacity-75 d-none d-md-block">Mantente informado sobre las últimas novedades y recordatorios.</p>
    </div>

    <div class="content-card carousel-container">
        <h4 class="section-title"><i class="fas fa-bullhorn"></i> Anuncios y Promociones</h4>
        
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/img/banner1.jpg" class="d-block w-100" alt="Promoción 1">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>¡Grandes descuentos en vitaminas!</h5>
                        <p>Aprovecha nuestras ofertas especiales de este mes.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/banner2.jpg" class="d-block w-100" alt="Promoción 2">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Nuevos productos en stock</h5>
                        <p>Descubre las últimas incorporaciones a nuestro catálogo.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/banner3.jpg" class="d-block w-100" alt="Promoción 3">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>¡Precios especiales para clientes frecuentes!</h5>
                        <p>Registrate y obtén beneficios exclusivos.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/banner4.jpg" class="d-block w-100" alt="Promoción 4">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>¡Precios especiales para clientes frecuentes!</h5>
                        <p>Registrate y obtén beneficios exclusivos.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/banner5.jpg" class="d-block w-100" alt="Promoción 5">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>¡Precios especiales para clientes frecuentes!</h5>
                        <p>Registrate y obtén beneficios exclusivos.</p>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
<c:if test="${empleado.rol == 'ADMIN'}">
    <div class="content-card">
        <h4 class="section-title"><i class="fas fa-chart-pie"></i> Accesos Rápidos a Reportes</h4>
        <div class="row">
            <div class="col-md-4 col-sm-6 mb-4">
                <div class="report-card">
       
                    <h5>Reporte de Laboratorio</h5>
                    <p>Visualiza el rendimiento de tus ventas por período, producto y Laboratorio.</p>
                    <a href="${pageContext.servletContext.contextPath}/gestionReports?operacion=Report2" class="btn-report">
                        <i class="fas fa-chart-line me-2"></i>Ver Reporte
                    </a>
                </div>
            </div>
            
            <div class="col-md-4 col-sm-6 mb-4">
                <div class="report-card">
                    
                    <h5>Reporte de Categoria</h5>
                    <p>Monitorea los niveles de Categoria, productos con bajo stock y movimientos.</p>
                    <a href="${pageContext.servletContext.contextPath}/gestionReports?operacion=Report1" class="btn-report">
                        <i class="fas fa-boxes me-2"></i>Ver Reporte
                    </a>
                </div>
            </div>
            
           

    </div>

</div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>