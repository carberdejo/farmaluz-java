<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%-- Agregado para formato de moneda --%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Factura</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"> <%-- Font Awesome para iconos --%>
    
	<link rel="stylesheet" href="css/General.css">
    <link rel="stylesheet" href="css/Venta.css">
</head>
<body class="d-flex">

    <%-- INCLUSIÓN DEL MENÚ LATERAL (SIDEBAR) --%>
    <%@ include file="principal/menu.jsp" %>

    <%-- CONTENIDO PRINCIPAL DE LA PÁGINA --%>
    <div class="main-container">
        <div class="header-section">
            <h2>
                <i class="fas fa-file-invoice"></i>
                Registrar Factura
            </h2>
            <p class="mb-0 mt-2 opacity-75 d-none d-md-block">Gestiona y emite nuevas facturas de venta.</p>
        </div>

        <div class="form-section-card">

            <%-- Mensaje de éxito (si existe) --%>
            <c:if test="${not empty requestScope.mensaje}">
                <div class="alert alert-custom-success alert-dismissible fade show" role="alert">
                    ${requestScope.mensaje}
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="mensaje" scope="session"/>
            </c:if>

            <h4 class="mb-4 text-center">Datos del Cliente y Comprobante</h4>

            <%-- Formulario de Búsqueda de Cliente --%>
            <form action="gestionVenta" method="post" class="mb-3 d-flex search-client-form">
                <input type="text" name="nomcliente" class="form-control me-2" placeholder="Buscar cliente por nombre..." value="${param.nomcliente != null ? param.nomcliente : ''}">
                <button type="submit" name="operacion" value="listclientes" class="btn btn-primary-custom">
                    <i class="fas fa-search me-2"></i>Buscar Cliente
                </button>
            </form>
            <button onclick="abrirModalLab()" class="btn btn-info-custom mb-4">
                <i class="fas fa-user-plus me-2"></i>Registrar Nuevo Cliente
            </button>

            <%-- Formulario principal de Registro de Factura --%>
            <form action="gestionVenta" method="post">
                <input type="hidden" name="operacion" value="venta" />

                <div class="row g-3 mb-4">
                    <div class="col-md-6" id="cliente-section">
                        <label for="cliente" class="form-label"><i class="fas fa-user-tie me-2"></i>Cliente</label>
                        <select name="cliente" id="cliente" class="form-select" <c:if test="${empty listaclientes}">disabled</c:if>>
                            <c:if test="${empty listaclientes}">
                                <option value="">No hay clientes disponibles</option>
                            </c:if>
                            <c:forEach var="cli" items="${listaclientes}">
                                <option value="${cli.idCliente}">${cli.nombreClien} ${cli.apellidoClien}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="tipo_comprobante" class="form-label"><i class="fas fa-receipt me-2"></i>Tipo de Comprobante</label>
                        <select name="tipo" class="form-select" id="tipo_comprobante" onchange="mostrarCliente()" required>
                            <option value="BOLETA">BOLETA</option>
                            <option value="BOLETA_SIMPLE">BOLETA SIMPLE</option>
                        </select>
                    </div>
                </div>

                <hr class="my-4">

                <h5 class="mb-3 text-center"><i class="fas fa-boxes me-2"></i>Productos Seleccionados para la Venta</h5>
                <div class="table-responsive">
                    <table class="table table-bordered table-custom">
                        <thead>
                            <tr>
                                <th>Nombre del Producto</th>
                                <th>Cantidad</th>
                                <th>Importe</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prod" items="${listapedidos}">
                                <tr>
                                    <td>${prod.name_pro}</td>
                                    <td>${prod.cantidad}</td>
                                    <td>S/ <fmt:formatNumber value="${prod.importe}" pattern="#,##0.00"/></td>
                                    <td>
                                        <a href="gestionCatalogo?operacion=eliminarPedido&id=${prod.idPro}" class="btn btn-sm btn-danger-custom">
                                            <i class="fas fa-trash-alt"></i> Eliminar
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listapedidos}">
                                <tr>
                                    <td colspan="4" class="text-center text-muted py-4">
                                        <i class="fas fa-shopping-cart me-2"></i>No hay productos en el pedido.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="mt-4 text-end">
                    <button type="submit" class="btn btn-success-custom me-2" ${empty listapedidos ? 'disabled' : ''}> <%-- Deshabilitar si no hay productos --%>
                        <i class="fas fa-save me-2"></i>Guardar Factura
                    </button>
                    <a href="gestionVenta?operacion=cancelar" class="btn btn-secondary-custom">
                        <i class="fas fa-times-circle me-2"></i>Cancelar
                    </a>
                   
                </div>
            </form>
            <c:if test="${idventa !=null }">
             <div class="text-center mt-4">
					<form action="gestionVenta?operacion=exportarpdf&id_ven=${idventa }" method="post" onsubmit="mostrarConfetti()">
						<button type="submit" class="btn btn-outline-danger position-relative px-4 py-2 fw-bold">
							<i class="fas fa-file-pdf me-2"></i>Exportar a PDF
							<img src="${pageContext.request.contextPath}/img/Confetti.gif" id="confettiGif"
								style="display:none; position:absolute; top:50%; left:50%; transform:translate(-50%,-50%);
								width:200px; pointer-events:none; z-index:10;">
						</button>
					</form>
				</div>
				</c:if>

        </div>
    </div>

    <%-- Modal REGISTRAR --%>
    <div class="modal fade" id="modalcrud" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleModalRegistro">
                        <i class="fas fa-user-plus me-2"></i>Registrar Cliente
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="gestionVenta" method="post" class="d-flex flex-column gap-3" id="frmCliente">
                        
                        <input type="hidden" id="operacion" name="operacion" value="registrar">

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3"> <%-- Usar mb-3 para spacing --%>
                                    <label for="nombre" class="form-label"><i class="fas fa-user me-2"></i>Nombre</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese el nombre" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="apellido" class="form-label"><i class="fas fa-user-tag me-2"></i>Apellido</label>
                                    <input type="text" class="form-control" id="apellido" name="apellido" placeholder="Ingrese el apellido" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="dni" class="form-label"><i class="fas fa-id-card me-2"></i>DNI</label>
                                    <input type="text" class="form-control" id="dni" name="dni" placeholder="Ingrese el DNI" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="telefono" class="form-label"><i class="fas fa-phone me-2"></i>Teléfono</label>
                                    <input type="text" class="form-control" id="telefono" name="telefono" placeholder="Ingrese el teléfono">
                                </div>
                            </div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end pt-3">
                            <button type="submit" class="btn btn-gradient" id="btnSubmit">
                                <i class="fas fa-save me-2"></i>Grabar
                            </button>
                            <button type="button" class="btn btn-secondary-custom" data-bs-dismiss="modal">
                                <i class="fas fa-times me-2"></i>Cancelar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <%-- jQuery es útil para manipular el DOM --%>
    
    <%-- Script para abrir modal y lógica de BOLETA SIMPLE --%>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Llama a la función al cargar la página para establecer el estado inicial
            mostrarCliente();
        });

        function abrirModalLab() {
            const modal = new bootstrap.Modal(document.getElementById('modalcrud'));
            document.getElementById('frmCliente').reset(); // Limpiar formulario al abrir modal
            document.getElementById('titleModalRegistro').innerHTML = '<i class="fas fa-user-plus me-2"></i>Registrar Cliente';
            modal.show();
        }
        
        function mostrarCliente() {
            var tipo = document.getElementById("tipo_comprobante").value;
            var clienteSection = document.getElementById("cliente-section");
            var clienteSelect = document.getElementById("cliente");

            if (tipo === "BOLETA") {
                clienteSection.style.display = 'block';
                clienteSelect.setAttribute('required', 'required'); // Hacer el select requerido
                clienteSelect.removeAttribute('disabled'); // Habilitar el select
            } else { // BOLETA_SIMPLE
                clienteSection.style.display = 'none';
                clienteSelect.removeAttribute('required'); // No requerido
                clienteSelect.setAttribute('disabled', 'disabled'); // Deshabilitar el select
                // Opcional: seleccionar una opción predeterminada o vacía si es "BOLETA_SIMPLE"
                // clienteSelect.value = ""; 
            }
        }
        
        function mostrarConfetti() {
			const gif = document.getElementById("confettiGif");
			gif.style.display = "block";
			setTimeout(() => {
				gif.style.display = "none";
			}, 1500);
		}
    </script>
</body>
</html>