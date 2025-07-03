<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <title>Mantenimiento de Proveedores</title>

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
            --info-gradient: linear-gradient(135deg, #A7F3D0 0%, #BFDBFE 100%);
            --dark-gradient: linear-gradient(135deg, #6B7280 0%, #4B5563 100%);
        }

        body {
            background: linear-gradient(135deg, #4ADE80 0%, #3B82F6 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
        }

        .main-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            margin: 20px;
            padding: 30px;
            flex-grow: 1;
            margin-left: 280px;
            transition: margin-left 0.3s ease-in-out;
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
            color: #495057;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .form-control::placeholder {
            color: #6c757d;
            opacity: 0.8;
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
                margin-left: 0;
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
<body class="d-flex">

    <%-- INCLUSIÓN DEL MENÚ LATERAL (SIDEBAR) --%>
    <%@ include file="principal/menu.jsp" %>
    
    <%-- CONTENIDO PRINCIPAL DE LA PÁGINA --%>
    <div class="main-container">
        <div class="header-section">
            <h2>
                <i class="fas fa-truck"></i>
                Gestión de Proveedores
            </h2>
            <p class="mb-0 mt-2 opacity-75">Sistema integral para el manejo de proveedores</p>
        </div>

        <div class="search-section">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-search"></i>
                        </span>
                        <input type="text" class="form-control" placeholder="Buscar proveedores..." id="searchInput">
                    </div>
                </div>
                <div class="col-md-4 text-end mt-3 mt-md-0">
                    <button type="button" class="btn btn-gradient" onclick="abrirModalNuevo()">
                        <i class="fas fa-plus me-2"></i>Registrar Nuevo Proveedor
                    </button>
                </div>
            </div>
        </div>

        <div class="table-container">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th><i class="fas fa-hashtag me-1"></i>Código</th>
                        <th><i class="fas fa-building me-1"></i>Nombre</th>
                        <th><i class="fas fa-user-tie me-1"></i>Nom. Encargado</th>
                        <th><i class="fas fa-user-tie me-1"></i>Ape. Encargado</th>
                        <th><i class="fas fa-id-card me-1"></i>RUC</th>
                        <th><i class="fas fa-map-marker-alt me-1"></i>Dirección</th>
                        <th><i class="fas fa-phone me-1"></i>Teléfono</th>
                        <th><i class="fas fa-envelope me-1"></i>Email</th>
                        <th><i class="fas fa-calendar-alt me-1"></i>Fec. Inicio</th>
                        <th><i class="fas fa-cogs me-1"></i>Acciones</th>
                    </tr>
                    </thead>
                    <tbody id="proveedoresTable">
                    <c:forEach var="p" items="${listaProveedores}">
                        <tr>
                            <td><span class="badge bg-secondary">${p.id_prov}</span></td>
                            <td><strong>${p.name_prov}</strong></td>
                            <td>${p.nom_encargado}</td>
                            <td>${p.ape_encargado}</td>
                            <td>${p.ruc}</td>
                            <td>${p.direccion}</td>
                            <td>${p.telefono}</td>
                            <td>${p.email}</td>
                            <td><small>${p.fec_inicio}</small></td>
                            <td>
                                <a href="gestionProveedor?operacion=editar&id=${p.id_prov}" class="btn-action btn-edit" title="Editar">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <button type="button" class="btn-action btn-delete btnEliminar" data-bs-toggle="modal" data-bs-target="#modaleliminar" data-id="${p.id_prov}" data-desc="${p.name_prov}" title="Eliminar">
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

    <%-- MODAL DE REGISTRO/EDICIÓN --%>
    <div class="modal fade" id="modalProveedor" tabindex="-1" aria-labelledby="modalProveedorLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <form action="gestionProveedor" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-truck-ramp-box me-2"></i>
                            Registrar / Editar Proveedor
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="operacion" value="${proveedorEditar != null ? 'actualizar' : 'registrar'}"/>
                        <div class="row g-4">
                            <%-- Campo Código: SOLO VISIBLE EN MODO EDICIÓN --%>
                            <c:if test="${proveedorEditar != null}">
                                <div class="col-md-3">
                                    <label class="form-label">
                                        <i class="fas fa-hashtag me-1"></i>Código
                                    </label>
                                    <input type="number" name="codigo" class="form-control" required value="${proveedorEditar.id_prov}" readonly/>
                                </div>
                            </c:if>
                            
                            <%-- Ajuste del tamaño de columna para Nombre del Proveedor --%>
                            <div class="col-md-${proveedorEditar != null ? '9' : '12'}">
                                <label class="form-label">
                                    <i class="fas fa-building me-1"></i>Nombre del Proveedor
                                </label>
                                <input type="text" name="nombre" class="form-control" required value="${proveedorEditar != null ? proveedorEditar.name_prov : '' }"/>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="fas fa-user-tie me-1"></i>Nombre del Encargado
                                </label>
                                <input type="text" name="nom_encargado" class="form-control" required value="${proveedorEditar != null ? proveedorEditar.nom_encargado : '' }"/>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="fas fa-user-tie me-1"></i>Apellido del Encargado
                                </label>
                                <input type="text" name="ape_encargado" class="form-control" required value="${proveedorEditar != null ? proveedorEditar.ape_encargado : ''}"/>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">
                                    <i class="fas fa-id-card me-1"></i>RUC
                                </label>
                                <input type="text" name="ruc" class="form-control" required value="${proveedorEditar != null ? proveedorEditar.ruc : ''}"/>
                            </div>
                            <div class="col-md-8">
                                <label class="form-label">
                                    <i class="fas fa-map-marker-alt me-1"></i>Dirección
                                </label>
                                <input type="text" name="direccion" class="form-control" required value="${proveedorEditar != null ? proveedorEditar.direccion : ''}"/>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">
                                    <i class="fas fa-phone me-1"></i>Teléfono
                                </label>
                                <input type="text" name="telefono" class="form-control" required value="${proveedorEditar != null ? proveedorEditar.telefono : ''}"/>
                            </div>
                            <div class="col-md-8">
                                <label class="form-label">
                                    <i class="fas fa-envelope me-1"></i>Email
                                </label>
                                <input type="email" name="email" class="form-control" required value="${proveedorEditar != null ? proveedorEditar.email : ''}"/>
                            </div>
                            
                            <%-- Campo Fecha Inicio: CONDICIONALMENTE VISIBLE --%>
                            <div class="col-md-4">
                                <label class="form-label">
                                    <i class="fas fa-calendar-plus me-1"></i>Fecha Inicio
                                </label>
                                <input type="date" name="fecha" class="form-control" id="fecha" required 
                                       value="${proveedorEditar != null ? proveedorEditar.fec_inicio : '' }"/>
                            </div>
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

    <%-- MODAL DE ELIMINACIÓN --%>
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
                    <p class="text-muted">¿Deseas eliminar el proveedor <strong class="text-danger" id="desc-eliminar"></strong>?</p>
                    <div class="alert alert-warning mt-3">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Esta acción no se puede deshacer
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                    <form action="gestionProveedor" method="post" class="d-flex gap-3">
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

    <%-- SCRIPTS JS (SIN MODIFICAR LÓGICA) --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <%-- Script para abrir el modal de edición si proveedorEditar no es nulo --%>
    <c:if test="${proveedorEditar != null}">
        <script>
            window.onload = function () {
                const modal = new bootstrap.Modal(document.getElementById('modalProveedor'));
                modal.show();
            }
        </script>
    </c:if>
    
    <%-- Script para el modal de eliminar --%>
    <script>
        $('.btnEliminar').on('click', function(){
            const cod = $(this).data('id');
            const desc = $(this).data('desc');
            
            console.log("ID a eliminar:", cod);
            console.log("Descripción:", desc);
            
            $('#cod-eliminar').val(cod);
            $('#desc-eliminar').text(desc);
        });
    </script>
    
    <%-- Script para abrir el modal de registro nuevo --%>
    <script>
        function abrirModalNuevo() {
            const modalElement = document.getElementById('modalProveedor');
            const form = modalElement.querySelector('form');
            const modal = new bootstrap.Modal(modalElement);
            
            // Limpiar todos los campos del formulario
            form.querySelectorAll('input, textarea').forEach(input => {
                if (input.name !== 'operacion') {
                    input.value = '';
                    input.removeAttribute('readonly'); // Asegurar que no queden campos readonly
                }
            });

            // Establecer la operación a "registrar"
            form.querySelector('input[name="operacion"]').value = "registrar";
            
            // Si el campo 'codigo' no está oculto por JSTL, asegúrate de que no tenga readonly
            // Si está oculto por JSTL, esta línea no es estrictamente necesaria para la visibilidad
            const codigoInput = form.querySelector('input[name="codigo"]');
            if (codigoInput) codigoInput.removeAttribute('readonly');

            // Mostrar modal vacío
            modal.show();
        }
    </script>

    <%-- Funcionalidad de búsqueda --%>
    <script>
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const searchTerm = this.value.toLowerCase();
            const tableRows = document.querySelectorAll('#proveedoresTable tr');
            
            tableRows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });

        // Animaciones adicionales
        document.addEventListener('DOMContentLoaded', function() {
            const tableRows = document.querySelectorAll('#proveedoresTable tr');
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