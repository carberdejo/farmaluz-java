<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>

<c:if test="${empty sessionScope.empleado}">
    <jsp:forward page="/Login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="css/General.css">
    <link rel="stylesheet" href="css/Catalogo.css">
    
</head>
<body class="d-flex">

    <%-- INCLUSIÓN DEL MENÚ LATERAL (SIDEBAR) --%>
    <%@ include file="principal/menu.jsp" %>

    <%-- CONTENIDO PRINCIPAL DE LA PÁGINA --%>
    <div class="main-container">
        <div class="header-section">
            <h2>
                <i class="fas fa-prescription-bottle-alt"></i>
                Catálogo de Productos
            </h2>
            <p class="mb-0 mt-2 opacity-75 d-none d-md-block">Explora nuestra amplia gama de productos farmacéuticos.</p>
        </div>

        <%-- Mensaje de éxito (si existe) --%>
        <c:if test="${not empty sessionScope.mensaje}">
            <div class="alert alert-custom-success alert-dismissible fade show" role="alert">
                ${sessionScope.mensaje}
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="mensaje" scope="session"/>
        </c:if>

        <div class="row">
            <div class="col-md-3">
                <div class="filter-section">
                    <h4 class="mb-3">
                        <a class="text-decoration-none text-dark" data-bs-toggle="collapse" href="#filtros" role="button" aria-expanded="true" aria-controls="filtros">
                            <i class="fas fa-filter me-2"></i>Filtros <i class="bi bi-chevron-down ms-1"></i>
                        </a>
                    </h4>

                    <div class="collapse show" id="filtros">
                        <form action="gestionCatalogo" method="post">
                            <div class="mb-3">
                                <label for="id_cate" class="form-label">Categoría</label>
                                <select class="form-select" name="id_cate" id="id_cate">
                                    <option value="">-- Todas --</option>
                                    <c:forEach var="c" items="${listaCategoria}">
                                        <option value="${c.id_cate}">${c.name_cate}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="id_lab" class="form-label">Laboratorio</label>
                                <select class="form-select" name="id_lab" id="id_lab">
                                    <option value="">-- Todos --</option>
                                    <c:forEach var="l" items="${listaLaboratorio}">
                                        <option value="${l.id_lab}">${l.name_lab}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <button type="submit" name="operacion" value="listar" class="btn btn-filter w-100 mt-2">
                                <i class="fas fa-check-circle me-2"></i>Aplicar Filtros
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-9">
                <div class="filter-section mb-4">
                    <form action="gestionCatalogo" method="post" class="d-flex">
                        <input type="text" name="nom_pro" class="form-control me-2" placeholder="Buscar producto por nombre...">
                        <button type="submit" name="operacion" value="listar" class="btn btn-search">
                            <i class="fas fa-search me-2"></i>Buscar
                        </button>

                    </form>
                </div>

                <div class="row">
                    <c:forEach var="p" items="${listaproductos}">
                        <div class="col-md-4 col-sm-6 mb-4">
                            <div class="product-card">
                                <a href="gestionCatalogo?operacion=detalle&iddetalle=${p.id_produc}" class="text-decoration-none text-dark d-block">
                                    <div>
                                        <img src="img/${p.id_produc}.jpg" alt="Producto" class="img-fluid">
                                        <h5 class="mt-2">${p.name_pro}</h5>
                                        <p class="mb-1">**${p.laboratorio}**</p>
                                        <p class="text-muted small">${p.categoria}</p>
                                        
                                        <p class="price">S/ ${p.precio}</p>
                                    </div>
                                </a>
                                <a class="btn btn-add-to-cart" href="gestionCatalogo?operacion=agregarPedido&id=${p.id_produc}&cantidad=1">
                                    <i class="fas fa-cart-plus me-2"></i>Agregar al Pedido
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty listaproductos}">
                        <div class="col-12">
                            <div class="alert alert-info text-center py-4">
                                <i class="fas fa-info-circle me-2"></i>No se encontraron productos con los criterios de búsqueda o filtro.
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>


            // Animación de carga para las tarjetas
            const productCards = document.querySelectorAll('.product-card');
            productCards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.transition = 'all 0.4s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 80); // Retraso escalonado
            });
        });
    </script>
</body>
</html>