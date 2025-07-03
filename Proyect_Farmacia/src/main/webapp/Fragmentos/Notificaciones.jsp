
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page isELIgnored="false" %>
<html>
<head>
<!-- Bootstrap y Font Awesome necesarios -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <title>Notificaciones</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
</head>
<body class="container mt-4">
    <div class="dropdown me-3">
    <a class="btn btn-light position-relative" href="#" role="button" data-bs-toggle="dropdown">
        <i class="fa-solid fa-bell"></i>
        <c:if test="${noLeidas > 0}">
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                ${noLeidas}
            </span>
        </c:if>
    </a>
    <ul class="dropdown-menu dropdown-menu-end p-2" style="width: 300px;">
    <c:forEach var="n" items="${notificaciones}" varStatus="st">
        <li class="mb-1">
            <a href="gestionNotificacion?operacion=verNotify&id_noti=${n.id}" class="text-decoration-none text-reset">
                <div class="small ${n.leido ? 'text-muted' : 'fw-bold'}">
                    ${n.titulo} <br/>
                    <small>${ n.fecha}</small>
                </div>
            </a>
            <hr class="my-1" />
        </li>
    </c:forEach>
</ul>
</div>
</body>
</html>