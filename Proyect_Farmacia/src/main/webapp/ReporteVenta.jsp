<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>

<c:if test="${empty sessionScope.empleado}">
    <jsp:forward page="/Login.jsp"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mantenimiento de Productos</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
</head>
<body>
<div class="container">
<%@ include file="principal/menu.jsp" %>
<div class="container mt-5">
    <h2 class="mb-4">Listado de Productos</h2>
   <button type="button" class="btn btn-primary mb-3" onclick="abrirModalNuevo()">Registrar Nueva</button>

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>Código</th>
            <th>Nombre</th>
            <th>Entrada</th>
            <th>Ultimo</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Laboratorio</th>
            <th>Categoria</th>
            <th>Proveedor</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="p" items="${listaproductos}">
            <tr>
                <td>${p.id_produc}</td>
                <td>${p.name_pro}</td>
                <td>${p.fec_entrada}</td>
                <td>${p.fec_ultimo}</td>
                <td>${p.precio}</td>
                <td>${p.stock}</td>
                <td>${p.laboratorio.name_lab}</td>
                <td>${p.categoria.name_cate}</td>
                <td>${p.proveedor.name_prov}</td>
                
                <td>
                	<a href="gestionProducto?operacion=detail&id=${p.id_produc }" class="btn btn-warning btn-sm">Ver</a>
                    <a href="gestionProducto?operacion=editar&id=${p.id_produc }" class="btn btn-warning btn-sm">Editar</a>
                    <button type="button" class="btn btn-danger btn-sm btnEliminar"  data-bs-toggle="modal" data-bs-target="#modaleliminar" data-id="${p.id_produc}" data-desc="${p.name_pro}">Eliminar</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</div>