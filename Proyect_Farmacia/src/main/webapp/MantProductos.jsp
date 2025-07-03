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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        :root {
		--primary-gradient: linear-gradient(135deg, #6EE7B7 0%, #3B82F6 100%);
		--secondary-gradient: linear-gradient(135deg, #FBCFE8 0%, #E0E7FF 100%);
		--success-gradient: linear-gradient(135deg, #4ADE80 0%, #3B82F6 100%);
		--warning-gradient: linear-gradient(135deg, #FDE68A 0%, #FCA5A5 100%);
		--danger-gradient: linear-gradient(135deg, #FB7185 0%, #FBCFE8 100%);
        }

        body {
            background: linear-gradient(135deg, #4ADE80 0%, #3B82F6 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            margin: 20px;
            padding: 30px;
        }

        .header-section {
            background: var(--primary-gradient);
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .header-section h2 {
            margin: 0;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .btn-gradient {
            background: var(--success-gradient);
            border: none;
            color: white;
            font-weight: 600;
            padding: 12px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(17, 153, 142, 0.3);
        }

        .btn-gradient:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(17, 153, 142, 0.4);
            color: white;
        }

        .table-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .table {
            margin: 0;
        }

        .table thead th {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 15px 12px;
            font-weight: 600;
            text-align: center;
            font-size: 0.9rem;
        }

        .table tbody td {
            padding: 12px;
            vertical-align: middle;
            border-color: #e9ecef;
            text-align: center;
        }

        .table tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
            transform: scale(1.01);
            transition: all 0.2s ease;
        }

        .btn-action {
            border: none;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            margin: 0 2px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-view {
            background: var(--info-gradient);
            color: #2c3e50;
        }

        .btn-edit {
            background: var(--warning-gradient);
            color: #2c3e50;
        }

        .btn-delete {
            background: var(--danger-gradient);
            color: white;
        }

        .btn-action:hover {
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .modal-content {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 20px 30px;
        }

        .modal-title {
            font-weight: 600;
            font-size: 1.3rem;
        }

        .modal-body {
            padding: 30px;
            background: #f8f9fa;
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
        }

        .modal-footer {
            background: white;
            border: none;
            padding: 20px 30px;
        }

        .btn-save {
            background: var(--success-gradient);
            border: none;
            color: white;
            font-weight: 600;
            padding: 12px 30px;
            border-radius: 25px;
        }

        .btn-cancel {
            background: var(--dark-gradient);
            border: none;
            color: white;
            font-weight: 600;
            padding: 12px 30px;
            border-radius: 25px;
        }

        .modal-eliminar .modal-header {
            background: var(--danger-gradient);
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .stat-icon {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .search-section {
            background: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 768px) {
            .main-container {
                margin: 10px;
                padding: 20px;
            }
            
            .table-responsive {
                font-size: 0.85rem;
            }
            
            .btn-action {
                padding: 6px 10px;
                font-size: 0.75rem;
                margin: 1px;
            }
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <%@ include file="principal/menu.jsp" %>
    
    <div class="main-container">
        <!-- Header Section -->
        <div class="header-section">
            <h2>
                <i class="fas fa-pills"></i>
                Gestión de Productos Farmacéuticos
            </h2>
            <p class="mb-0 mt-2 opacity-75">Sistema integral para el manejo de inventario</p>
        </div>

        <!-- Stats Cards -->
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-icon text-primary">
                    <i class="fas fa-boxes"></i>
                </div>
                <h5>Total Productos</h5>
                <h3 class="text-primary">${listaproductos.size()}</h3>
            </div>
            <div class="stat-card">
                <div class="stat-icon text-success">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h5>En Stock</h5>
                <h3 class="text-success">
                    <c:set var="enStock" value="0"/>
                    <c:forEach var="p" items="${listaproductos}">
                        <c:if test="${p.stock > 0}">
                            <c:set var="enStock" value="${enStock + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${enStock}
                </h3>
            </div>
            <div class="stat-card">
                <div class="stat-icon text-warning">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h5>Stock Bajo</h5>
                <h3 class="text-warning">
                    <c:set var="stockBajo" value="0"/>
                    <c:forEach var="p" items="${listaproductos}">
                        <c:if test="${p.stock < 10 && p.stock > 0}">
                            <c:set var="stockBajo" value="${stockBajo + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${stockBajo}
                </h3>
            </div>
            <div class="stat-card">
                <div class="stat-icon text-danger">
                    <i class="fas fa-times-circle"></i>
                </div>
                <h5>Sin Stock</h5>
                <h3 class="text-danger">
                    <c:set var="sinStock" value="0"/>
                    <c:forEach var="p" items="${listaproductos}">
                        <c:if test="${p.stock == 0}">
                            <c:set var="sinStock" value="${sinStock + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${sinStock}
                </h3>
            </div>
        </div>

        <!-- Search Section -->
        <div class="search-section">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-search"></i>
                        </span>
                        <input type="text" class="form-control" placeholder="Buscar productos..." id="searchInput">
                    </div>
                </div>
                <div class="col-md-4 text-end mt-3 mt-md-0">
                    <button type="button" class="btn btn-gradient" onclick="abrirModalNuevo()">
                        <i class="fas fa-plus me-2"></i>Registrar Nuevo Producto
                    </button>
                </div>
            </div>
        </div>

        <!-- Table Section -->
        <div class="table-container">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th><i class="fas fa-hashtag me-1"></i>Código</th>
                        <th><i class="fas fa-pills me-1"></i>Nombre</th>
                        <th><i class="fas fa-file-alt me-1"></i>Descripción</th>
                        <th><i class="fas fa-calendar-plus me-1"></i>Fecha Creacion</th>
                        <th><i class="fas fa-calendar-check me-1"></i>Fecha Vencimiento</th>
                        <th><i class="fas fa-dollar-sign me-1"></i>Precio</th>
                        <th><i class="fas fa-cubes me-1"></i>Stock</th>
                        <th><i class="fas fa-flask me-1"></i>Laboratorio</th>
                        <th><i class="fas fa-tags me-1"></i>Categoría</th>
                        <th><i class="fas fa-truck me-1"></i>Proveedor</th>
                        <th><i class="fas fa-cogs me-1"></i>Acciones</th>
                    </tr>
                    </thead>
                    <tbody id="productosTable">
                    <c:forEach var="p" items="${listaproductos}">
                        <tr>
                            <td><span class="badge bg-secondary">${p.id_produc}</span></td>
                            <td><strong>${p.name_pro}</strong></td>
                            <td>${p.descripcion}</td>
                            <td><small>${p.fec_entrada}</small></td>
                            <td><small>${p.fec_ultimo}</small></td>
                            <td><span class="text-success fw-bold">S/. ${p.precio}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.stock == 0}">
                                        <span class="badge bg-danger">${p.stock}</span>
                                    </c:when>
                                    <c:when test="${p.stock < 10}">
                                        <span class="badge bg-warning text-dark">${p.stock}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success">${p.stock}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><small class="text-muted">${p.laboratorio.name_lab}</small></td>
                            <td><small class="text-muted">${p.categoria.name_cate}</small></td>
                            <td><small class="text-muted">${p.proveedor.name_prov}</small></td>
                            <td>
                                <a href="gestionProducto?operacion=detail&id=${p.id_produc}" class="btn-action btn-view" title="Ver detalles">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <a href="gestionProducto?operacion=editar&id=${p.id_produc}" class="btn-action btn-edit" title="Editar">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <button type="button" class="btn-action btn-delete btnEliminar" data-bs-toggle="modal" data-bs-target="#modaleliminar" data-id="${p.id_produc}" data-desc="${p.name_pro}" title="Eliminar">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal de Registro/Edición -->
<div class="modal fade" id="modalProducto" tabindex="-1" aria-labelledby="modalProductoLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <form action="gestionProducto" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-pills me-2"></i>
                        Registrar / Editar Producto
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="operacion" value="${productoEditar != null ? 'actualizar' : 'registrar'}"/>

                    <div class="row g-4">
                        <div class="col-md-3">
                            <label class="form-label">
                                <i class="fas fa-hashtag me-1"></i>Código
                            </label>
                            <input type="number" name="codigo" class="form-control" required value="${productoEditar.id_produc}" ${productoEditar != null ? 'readonly' : ''}/>
                        </div>
                        <div class="col-md-9">
                            <label class="form-label">
                                <i class="fas fa-pills me-1"></i>Nombre del Producto
                            </label>
                            <input type="text" name="nombre" class="form-control" required value="${productoEditar != null ? productoEditar.name_pro : '' }"/>
                        </div>
                        <div class="col-md-8">
                            <label class="form-label">
                                <i class="fas fa-file-alt me-1"></i>Descripción
                            </label>
                            <textarea name="descripcion" class="form-control" rows="2" required>${productoEditar != null ? productoEditar.descripcion : ''}</textarea>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">
                                <i class="fas fa-dollar-sign me-1"></i>Precio (S/.)
                            </label>
                            <input type="number" name="precio" step="0.01" class="form-control" required value="${productoEditar != null ? productoEditar.precio : ''}"/>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">
                                <i class="fas fa-cubes me-1"></i>Stock
                            </label>
                            <input type="number" name="stock" class="form-control" required value="${productoEditar != null ? productoEditar.stock : ''}"/>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">
                                <i class="fas fa-tags me-1"></i>Categoría
                            </label>
                            <select name="categoria" class="form-select" required>
                                <option value="">Seleccionar...</option>
                                <c:forEach var="c" items="${listaCategoria}">
                                    <option value="${c.id_cate}" ${productoEditar.categoria.id_cate == c.id_cate? 'selected' : ''}>${c.name_cate}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">
                                <i class="fas fa-flask me-1"></i>Laboratorio
                            </label>
                            <select name="laboratorio" class="form-select" required>
                                <option value="">Seleccionar...</option>
                                <c:forEach var="l" items="${listaLaboratorio}">
                                    <option value="${l.id_lab}" ${productoEditar.laboratorio.id_lab == l.id_lab? 'selected' : ''}>${l.name_lab}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">
                                <i class="fas fa-truck me-1"></i>Proveedor
                            </label>
                            <select name="proveedor" class="form-select" required>
                                <option value="">Seleccionar...</option>
                                <c:forEach var="p" items="${listaProveedor}">
                                    <option value="${p.id_prov}" ${productoEditar.proveedor.id_prov == p.id_prov ? 'selected' : ''}>${p.name_prov}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <c:if test="${productoEditar != null}">
                            <div class="col-md-3">
                                <label class="form-label">
                                    <i class="fas fa-calendar-plus me-1"></i>Fecha Creacion
                                </label>
                                <input type="date" name="fec_inicio" class="form-control" value="${productoEditar.fec_entrada}"/>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">
                                    <i class="fas fa-calendar-check me-1"></i>Fecha Vencimiento
                                </label>
                                <input type="date" name="fec_ultimo" class="form-control" value="${productoEditar.fec_ultimo}"/>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-save">
                        <i class="fas fa-save me-2"></i>Guardar Cambios
                    </button>
                    <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Cancelar
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal Confirmación de Eliminación -->
<div class="modal fade" id="modaleliminar" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-eliminar">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    Confirmar Eliminación
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center py-4">
                <div class="mb-3">
                    <i class="fas fa-trash-alt text-danger" style="font-size: 3rem;"></i>
                </div>
                <h5>¿Estás seguro?</h5>
                <p class="text-muted">¿Deseas eliminar el producto <strong class="text-danger" id="desc-eliminar"></strong>?</p>
                <div class="alert alert-warning mt-3">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    Esta acción no se puede deshacer
                </div>
            </div>
            <div class="modal-footer justify-content-center">
                <form action="gestionProducto" method="post" class="d-flex gap-3">
                    <input type="hidden" name="operacion" value="eliminar"/>
                    <input type="hidden" id="cod-eliminar" name="id"/>
                    <button type="submit" class="btn btn-danger px-4">
                        <i class="fas fa-trash me-2"></i>Sí, Eliminar
                    </button>
                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Cancelar
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<c:if test="${productoEditar != null}">
    <script>
        window.onload = function () {
            const modal = new bootstrap.Modal(document.getElementById('modalProducto'));
            modal.show();
        }
    </script>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function abrirModal() {
        window.location.href = "gestionZapatillas?operacion=listar";
    }

    // JavaScript para eliminar (tu lógica original)
    $('.btnEliminar').on('click', function(){
        const cod = $(this).data('id');
        const desc = $(this).data('desc');
        
        console.log("ID a eliminar:", cod);
        console.log("Descripción:", desc);
        
        $('#cod-eliminar').val(cod);
        $('#desc-eliminar').text(desc);
    });

    // Script para abrir modal vacío (tu lógica original)
    function abrirModalNuevo() {
        const form = document.querySelector('#modalProducto form');

        form.querySelectorAll('input').forEach(input => {
            if (input.name !== 'operacion') {
                input.value = '';
                input.removeAttribute('readonly');
            }
        });

        form.querySelector('input[name="operacion"]').value = "registrar";
        
        const codigoInput = form.querySelector('input[name="codigo"]');
        if (codigoInput) codigoInput.remove();

        const modal = new bootstrap.Modal(document.getElementById('modalProducto'));
        modal.show();
    }

    // Funcionalidad de búsqueda
    document.getElementById('searchInput').addEventListener('keyup', function() {
        const searchTerm = this.value.toLowerCase();
        const tableRows = document.querySelectorAll('#productosTable tr');
        
        tableRows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(searchTerm) ? '' : 'none';
        });
    });

    // Animaciones adicionales
    document.addEventListener('DOMContentLoaded', function() {
        // Agregar efecto de carga
        const tableRows = document.querySelectorAll('#productosTable tr');
        tableRows.forEach((row, index) => {
            row.style.opacity = '0';
            row.style.transform = 'translateY(20px)';
            setTimeout(() => {
                row.style.transition = 'all 0.3s ease';
                row.style.opacity = '1';
                row.style.transform = 'translateY(0)';
            }, index * 50);
        });
    });
</script>
</body>
</html>