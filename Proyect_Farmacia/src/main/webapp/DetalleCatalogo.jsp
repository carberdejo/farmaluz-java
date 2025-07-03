<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%-- Agregado para formatear el precio --%>
<%@ page isELIgnored="false" %>

<c:if test="${empty sessionScope.empleado}">
    <jsp:forward page="/Login.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${producto.name_pro} - Detalles</title> <%-- Título más descriptivo --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"> <%-- Font Awesome para iconos --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
     <link rel="stylesheet" href="css/General.css">
    <link rel="stylesheet" href="css/DetalleCatalogo.css">
</head>
<body class="d-flex">

    <%-- INCLUSIÓN DEL MENÚ LATERAL (SIDEBAR) --%>
    <%@ include file="principal/menu.jsp" %>

    <%-- CONTENIDO PRINCIPAL DE LA PÁGINA --%>
    <div class="main-container">
        <div class="header-section">
            <h2>
                <i class="fas fa-search-plus"></i>
                Detalles del Producto
            </h2>
            <p class="mb-0 mt-2 opacity-75 d-none d-md-block">Información completa sobre ${producto.name_pro}</p>
        </div>

        <div class="container-fluid p-0"> <%-- Contenedor fluido para centrar y aplicar padding --%>
            <a href="gestionCatalogo?operacion=listar" class="btn btn-back-to-catalog">
                <i class="fas fa-arrow-left"></i> Volver al Catálogo
            </a>

            <div class="product-detail-container">
                <div class="product-detail-image">
                    <img src="img/${producto.id_produc }.jpg" alt="${producto.name_pro}">
                </div>

                <div class="product-detail-info">
                    <h2>${producto.name_pro}</h2>
                    <span class="product-price">S/. <fmt:formatNumber value="${producto.precio}" pattern="#,##0.00"/></span>
                    
                    <p><strong>Stock disponible:</strong> <span class="badge bg-info">${producto.stock}</span> unidades</p>
                    <p><strong>Laboratorio:</strong> ${producto.laboratorio.name_lab}</p>
                    <p><strong>Categoría:</strong> ${producto.categoria.name_cate}</p>
                    <p><strong>Proveedor:</strong> ${producto.proveedor.name_prov}</p>
                    <p><strong>Fecha Vencimiento:</strong> ${producto.fec_ultimo}</p>

                    <form action="gestionCatalogo?operacion=agregarPedido" method="post" class="quantity-form">
                        <label for="cantidad" class="form-label mb-0">Cantidad:</label>
                        <input type="hidden" name="id" value="${producto.id_produc}">
                        <input type="number" min="1" max="${producto.stock}" name="cantidad" id="cantidad" class="form-control quantity-input" value="1" required>
                        <button type="submit" class="btn btn-add-to-order">
                            <i class="fas fa-cart-plus me-2"></i>Agregar al pedido
                        </button>
                    </form>

                    <div class="components-section">
                        <h5>
                            <i class="fas fa-vial"></i> Componentes:
                        </h5>
                        <div class="table-responsive">
                            <table class="table table-hover component-table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Componente</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty producto.descripcion && fn:length(fn:trim(producto.descripcion)) > 0}">
                                            <c:forEach var="componente" items="${fn:split(producto.descripcion, ',')}" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${fn:trim(componente)}</td> <%-- fn:trim para limpiar espacios --%>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="2" class="text-center text-muted py-3">
                                                    <i class="fas fa-exclamation-circle me-2"></i>No se han especificado componentes para este producto.
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        // Animación de carga para el contenedor principal
        document.addEventListener('DOMContentLoaded', function() {
            const productDetailContainer = document.querySelector('.product-detail-container');
            if (productDetailContainer) {
                productDetailContainer.style.opacity = '0';
                productDetailContainer.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    productDetailContainer.style.transition = 'all 0.5s ease-out';
                    productDetailContainer.style.opacity = '1';
                    productDetailContainer.style.transform = 'translateY(0)';
                }, 100); // Pequeño retraso para que el fondo ya esté cargado
            }
        });
    </script>
</body>
</html>