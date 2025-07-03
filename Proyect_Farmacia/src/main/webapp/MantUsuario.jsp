<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>

<c:if test="${empty sessionScope.empleado}">
    <jsp:forward page="/Login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mantenimiento de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #6EE7B7 0%, #3B82F6 100%);
            --success-gradient: linear-gradient(135deg, #4ADE80 0%, #3B82F6 100%);
            --warning-gradient: linear-gradient(135deg, #FDE68A 0%, #FCA5A5 100%);
            --danger-gradient: linear-gradient(135deg, #FB7185 0%, #FBCFE8 100%);
        }

        body {
            background: linear-gradient(135deg, #4ADE80 0%, #3B82F6 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            overflow-x: hidden;
        }

        .page-content {
            margin-left: 280px; /* Ajustar al ancho de tu menu.jsp */
            transition: margin-left 0.3s ease-in-out;
            flex-grow: 1;
            padding: 20px;
        }

        .main-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
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
            border: none; color: white;
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

        .table thead th {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 15px 12px;
            font-weight: 600;
            text-align: center;
        }

        .table tbody td {
            padding: 12px;
            vertical-align: middle;
            border-color: #e9ecef;
            text-align: center;
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
        .btn-edit { background: var(--warning-gradient); color: #2c3e50; }
        .btn-delete { background: var(--danger-gradient); color: white; }
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
        .modal-title { font-weight: 600; font-size: 1.3rem; }
        .modal-body { padding: 30px; background: #f8f9fa; }
        .modal-footer { background: white; border: none; padding: 20px 30px; }

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
        .form-label { font-weight: 600; color: #2c3e50; margin-bottom: 8px; }

        .btn-save, .btn-cancel {
            border: none;
            color: white;
            font-weight: 600;
            padding: 12px 30px;
            border-radius: 25px;
        }
        .btn-save { background: var(--success-gradient); }
        .btn-cancel { background: linear-gradient(135deg, #6c757d 0%, #343a40 100%); }
        .modal-eliminar .modal-header { background: var(--danger-gradient); }
        
        .search-section {
            background: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="d-flex">

    <%@ include file="principal/menu.jsp" %>

    <main class="page-content">
        <div class="main-container">
            <div class="header-section">
                <h2>
                    <i class="fas fa-users-cog"></i>
                    Gestión de Usuarios
                </h2>
                <p class="mb-0 mt-2 opacity-75">Administra, registra y edita los usuarios del sistema.</p>
            </div>

            <div class="search-section">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-search"></i></span>
                            <input type="text" class="form-control" placeholder="Buscar por nombre, DNI, rol..." id="searchInput">
                        </div>
                    </div>
                    <div class="col-md-4 text-end mt-3 mt-md-0">
                        <button type="button" class="btn btn-gradient" onclick="abrirModalNuevo()">
                            <i class="fas fa-plus me-2"></i>Registrar Nuevo Usuario
                        </button>
                    </div>
                </div>
            </div>

            <div class="table-container">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th><i class="fas fa-id-card me-1"></i>Código</th>
                            <th><i class="fas fa-user me-1"></i>Nombre</th>
                            <th><i class="fas fa-user-friends me-1"></i>Apellido</th>
                            <th><i class="fas fa-address-card me-1"></i>DNI</th>
                            <th><i class="fas fa-user-tag me-1"></i>Rol</th>
                            <th><i class="fas fa-at me-1"></i>Usuario</th>
                            <th><i class="fas fa-at me-1"></i>Password</th>
                            <th><i class="fas fa-cogs me-1"></i>Acciones</th>
                        </tr>
                        </thead>
                        <tbody id="usersTable">
                        <c:forEach var="u" items="${listausuarios}">
                            <tr>
                                <td><span class="badge bg-secondary">${u.idUsuario}</span></td>
                                <td><strong>${u.nombreUsu}</strong></td>
                                <td>${u.apellidoUsu}</td>
                                <td>${u.dni}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.rol == 'Vendedor'}">
                                            <span class="badge bg-info text-dark">Vendedor</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-primary">${u.rol}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${u.nickUsu}</td>
                                <td>${u.passwordUsu}</td>
                                <td>
                                    <a href="gestionUsuario?operacion=editar&id=${u.idUsuario}" class="btn-action btn-edit" title="Editar">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <button type="button" class="btn-action btn-delete btnEliminar" data-bs-toggle="modal" data-bs-target="#modaleliminar" data-id="${u.idUsuario}" data-desc="${u.nombreUsu}" title="Eliminar">
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
    </main>

    <div class="modal fade" id="modalUsuario" tabindex="-1" aria-labelledby="modalUsuarioLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="gestionUsuario" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-user-plus me-2"></i>
                            <c:choose>
                                <c:when test="${usuEditar != null}">Editar Usuario</c:when>
                                <c:otherwise>Registrar Usuario</c:otherwise>
                            </c:choose>
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        
                        <input type="hidden" name="operacion" value="${usuEditar != null ? 'Actualizar' : 'registrar'}"/>

                        <div class="row g-4">
                            
                            <%-- =============================================================== --%>
                            <%-- == CAMBIO: El campo Código solo aparece si se está editando. == --%>
                            <%-- =============================================================== --%>
                            <c:if test="${usuEditar != null}">
                                <div class="col-md-4">
                                    <label class="form-label"><i class="fas fa-id-card me-1"></i>Código</label>
                                    <input type="number" name="codigo" class="form-control" value="${usuEditar.idUsuario}" readonly/>
                                </div>
                            </c:if>
                            
                            <%-- Se ajusta el ancho del campo Nombre si el campo código no está presente --%>
                            <div class="${usuEditar != null ? 'col-md-8' : 'col-md-12'}">
                                <label class="form-label"><i class="fas fa-user me-1"></i>Nombre</label>
                                <input type="text" name="nombre" class="form-control" required value="${usuEditar != null ? usuEditar.nombreUsu : ''}"/>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="fas fa-user-friends me-1"></i>Apellido</label>
                                <input type="text" name="apellido" class="form-control" required value="${usuEditar != null ? usuEditar.apellidoUsu : ''}"/>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="fas fa-address-card me-1"></i>DNI</label>
                                <input type="text" name="dni" class="form-control" required value="${usuEditar != null ? usuEditar.dni : ''}"/>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="fas fa-phone me-1"></i>Teléfono</label>
                                <input type="text" name="telefono" class="form-control" required value="${usuEditar != null ? usuEditar.telefono : ''}"/>
                            </div>
                             <div class="col-md-6">
                                <label class="form-label"><i class="fas fa-map-marker-alt me-1"></i>Dirección</label>
                                <input type="text" name="direccion" class="form-control" required value="${usuEditar != null ? usuEditar.direccionUsu : ''}"/>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="fas fa-at me-1"></i>Nickname</label>
                                <input type="text" name="nickUsu" class="form-control" required value="${usuEditar != null ? usuEditar.nickUsu : ''}"/>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="fas fa-key me-1"></i>Contraseña</label>
                                <input type="password" name="password" class="form-control" required value="${usuEditar != null ? usuEditar.passwordUsu : ''}"/>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label"><i class="fas fa-user-tag me-1"></i>Rol</label>
                                <select name="rol" class="form-select" required>
                                    <option value="" disabled selected>Seleccione un Rol</option>
                                    <option value="Vendedor" ${usuEditar.rol == 'Vendedor' ? 'selected' : ''}>Vendedor</option>
                                </select>
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

    <div class="modal fade" id="modaleliminar" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modal-eliminar">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-exclamation-triangle me-2"></i>Confirmar Eliminación</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center py-4">
                    <i class="fas fa-trash-alt text-danger" style="font-size: 3rem;"></i>
                    <h5 class="mt-3">¿Estás seguro?</h5>
                    <p class="text-muted">¿Deseas eliminar al usuario <strong class="text-danger" id="desc-eliminar"></strong>?</p>
                </div>
                <div class="modal-footer justify-content-center">
                    <form action="gestionUsuario" method="post" class="d-flex gap-3">
                        <input type="hidden" name="operacion" value="eliminar"/>
                        <input type="hidden" id="cod-eliminar" name="id"/>
                        <button type="submit" class="btn btn-danger px-4"><i class="fas fa-trash me-2"></i>Sí, Eliminar</button>
                        <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal"><i class="fas fa-times me-2"></i>Cancelar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <c:if test="${usuEditar != null}">
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const modal = new bootstrap.Modal(document.getElementById('modalUsuario'));
                modal.show();
            });
        </script>
    </c:if>

    <script>
        $('.btnEliminar').on('click', function(){
            const cod = $(this).data('id');
            const desc = $(this).data('desc');
            $('#cod-eliminar').val(cod);
            $('#desc-eliminar').text(desc);
        });

        function abrirModalNuevo() {
            const form = document.querySelector('#modalUsuario form');
            form.reset(); 
            form.querySelector('input[name="operacion"]').value = "registrar";
            
            // Ya no es necesario manipular el input de código aquí, porque no existirá al registrar.
            
            const modal = new bootstrap.Modal(document.getElementById('modalUsuario'));
            modal.show();
        }

        document.getElementById('searchInput').addEventListener('keyup', function() {
            const searchTerm = this.value.toLowerCase();
            const tableRows = document.querySelectorAll('#usersTable tr');
            
            tableRows.forEach(row => {
                row.style.display = row.textContent.toLowerCase().includes(searchTerm) ? '' : 'none';
            });
        });
    </script>

</body>
</html>