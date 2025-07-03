<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>


<c:if test="${empty sessionScope.empleado}">
	<jsp:forward page="/Login.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mantenimiento de Clientes</title>
	<link rel="icon" type="image/x-icon" href="img/logo-icon.ico">

	<!-- Bootstrap v5.3.3 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Jquery v3.7.1 -->
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

	<!-- Bootstrap-Select -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/css/bootstrap-select.min.css">
	<script src="js/bootstrap-select(v1.14.0-gamma1).js"></script>

	<!-- SweetAlert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<!-- BootstrapValidator -->
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.1/css/bootstrapValidator.min.css"/>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.1/js/bootstrapValidator.min.js"></script>

	<!-- DataTable -->
	<link href="https://cdn.datatables.net/2.0.3/css/dataTables.bootstrap5.min.css" rel="stylesheet">
	<link href="https://cdn.datatables.net/responsive/3.0.1/css/responsive.bootstrap5.css" rel="stylesheet">
	<link href="https://cdn.datatables.net/buttons/3.0.1/css/buttons.dataTables.css" rel="stylesheet">
	<script src="https://cdn.datatables.net/2.0.3/js/dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/2.0.3/js/dataTables.bootstrap5.min.js"></script>
	<script src="https://cdn.datatables.net/responsive/3.0.1/js/dataTables.responsive.js"></script>
	<script src="https://cdn.datatables.net/responsive/3.0.1/js/responsive.bootstrap5.js"></script>
	<script src="https://cdn.datatables.net/buttons/3.0.1/js/dataTables.buttons.js"></script>
	<script src="https://cdn.datatables.net/buttons/3.0.1/js/buttons.dataTables.js"></script>
	<script src="https://cdn.datatables.net/buttons/3.0.1/js/buttons.colVis.min.js"></script>

	<!-- Moment.js -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
 <link rel="stylesheet" href="css/General.css">
<style>
	

	@keyframes slideInUp {
		from {
			opacity: 0;
			transform: translateY(50px);
		}
		to {
			opacity: 1;
			transform: translateY(0);
		}
	}

	.header-section {
		background: var(--primary-gradient);
		color: white;
		padding: 25px;
		border-radius: 15px;
		margin-bottom: 30px;
		position: relative;
		overflow: hidden;
	}

	.header-section::before {
		content: '';
		position: absolute;
		top: -50%;
		left: -50%;
		width: 200%;
		height: 200%;
		background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
		animation: rotate 20s linear infinite;
	}

	@keyframes rotate {
		0% { transform: rotate(0deg); }
		100% { transform: rotate(360deg); }
	}

	.header-content {
		position: relative;
		z-index: 2;
	}

	.gradient-title {
		background: linear-gradient(45deg, #fff, #e0e0e0);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
		font-weight: bold;
		font-size: 2.5rem;
		margin: 0;
		animation: glow 2s ease-in-out infinite alternate;
	}

	@keyframes glow {
		from { text-shadow: 0 0 20px rgba(255,255,255,0.5); }
		to { text-shadow: 0 0 30px rgba(255,255,255,0.8); }
	}

	.btn-gradient {
		background: var(--success-gradient);
		border: none;
		color: white;
		padding: 12px 25px;
		border-radius: 50px;
		font-weight: 600;
		text-transform: uppercase;
		letter-spacing: 1px;
		transition: all 0.3s ease;
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
		position: relative;
		overflow: hidden;
	}

	.btn-gradient:hover {
		transform: translateY(-2px);
		box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
		color: white;
	}

	.btn-gradient::before {
		content: '';
		position: absolute;
		top: 0;
		left: -100%;
		width: 100%;
		height: 100%;
		background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
		transition: left 0.5s;
	}

	.btn-gradient:hover::before {
		left: 100%;
	}

	.btn-edit {
		background: var(--warning-gradient);
		border: none;
		color: white;
		padding: 8px 15px;
		border-radius: 25px;
		font-size: 0.9rem;
		font-weight: 600;
		transition: all 0.3s ease;
		box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
	}

	.btn-edit:hover {
		transform: translateY(-2px);
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
		color: white;
	}

	.btn-delete {
		background: var(--danger-gradient);
		border: none;
		color: white;
		padding: 8px 15px;
		border-radius: 25px;
		font-size: 0.9rem;
		font-weight: 600;
		transition: all 0.3s ease;
		box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
	}

	.btn-delete:hover {
		transform: translateY(-2px);
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
		color: white;
	}

	.table-container {
		background: white;
		border-radius: 15px;
		padding: 20px;
		box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
		animation: fadeIn 1s ease-out 0.3s both;
	}

	@keyframes fadeIn {
		from { opacity: 0; }
		to { opacity: 1; }
	}

	.table thead th {
		background: var(--primary-gradient);
		color: white;
		border: none;
		padding: 15px;
		font-weight: 600;
		text-transform: uppercase;
		letter-spacing: 1px;
		font-size: 0.9rem;
	}

	.table tbody tr {
		transition: all 0.3s ease;
	}

	.table tbody tr:hover {
		background: linear-gradient(90deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
		transform: translateX(5px);
	}

	.table tbody td {
		padding: 15px;
		vertical-align: middle;
		border-color: rgba(0, 0, 0, 0.05);
	}

	.modal-content {
		border: none;
		border-radius: 20px;
		box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
		overflow: hidden;
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
		background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
	}

	.form-control {
		border: 2px solid transparent;
		border-radius: 10px;
		padding: 12px 15px;
		font-size: 1rem;
		transition: all 0.3s ease;
		background: rgba(255, 255, 255, 0.9);
		backdrop-filter: blur(10px);
	}

	.form-control:focus {
		border-color: #667eea;
		box-shadow: 0 0 20px rgba(102, 126, 234, 0.3);
		background: white;
	}

	.form-label {
		font-weight: 600;
		color: #333;
		margin-bottom: 8px;
	}

	.icon-ns {
		width: 20px;
		height: 20px;
		margin-right: 8px;
	}

	.pulse-animation {
		animation: pulse 2s infinite;
	}

	@keyframes pulse {
		0% { transform: scale(1); }
		50% { transform: scale(1.05); }
		100% { transform: scale(1); }
	}

	.floating-icons {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		pointer-events: none;
		z-index: -1;
	}

	.floating-icon {
		position: absolute;
		opacity: 0.1;
		animation: float 15s infinite linear;
	}

	@keyframes float {
		0% {
			transform: translateY(100vh) rotate(0deg);
		}
		100% {
			transform: translateY(-100px) rotate(360deg);
		}
	}

	.stats-card {
		background: var(--success-gradient);
		color: white;
		padding: 20px;
		border-radius: 15px;
		text-align: center;
		margin-bottom: 20px;
		animation: slideInLeft 0.8s ease-out;
	}

	@keyframes slideInLeft {
		from {
			opacity: 0;
			transform: translateX(-50px);
		}
		to {
			opacity: 1;
			transform: translateX(0);
		}
	}
</style>
</head>
<body>
	<div class="floating-icons">
		<i class="fas fa-users floating-icon" style="left: 10%; animation-delay: 0s; font-size: 2rem;"></i>
		<i class="fas fa-chart-line floating-icon" style="left: 20%; animation-delay: 2s; font-size: 1.5rem;"></i>
		<i class="fas fa-star floating-icon" style="left: 30%; animation-delay: 4s; font-size: 2.5rem;"></i>
		<i class="fas fa-heart floating-icon" style="left: 40%; animation-delay: 6s; font-size: 1.8rem;"></i>
		<i class="fas fa-thumbs-up floating-icon" style="left: 50%; animation-delay: 8s; font-size: 2rem;"></i>
		<i class="fas fa-gem floating-icon" style="left: 60%; animation-delay: 10s; font-size: 1.6rem;"></i>
		<i class="fas fa-crown floating-icon" style="left: 70%; animation-delay: 12s; font-size: 2.2rem;"></i>
		<i class="fas fa-rocket floating-icon" style="left: 80%; animation-delay: 14s; font-size: 1.9rem;"></i>
		<i class="fas fa-magic floating-icon" style="left: 90%; animation-delay: 16s; font-size: 2.1rem;"></i>
	</div>

	<div class="container">
	<%@ include file="principal/menu.jsp" %>
		
		<div class="main-container">
			<div class="header-section">
				<div class="header-content">
					<div class="row align-items-center">
						<div class="col-md-8">
							<h1 class="gradient-title">
								<i class="fas fa-users me-3"></i>
								Gestión de Clientes
							</h1>
							<h2 class="mb-0 fs-5">FARMACIA FARMALUZ</h2> 
						</div>
						<div class="col-md-4 text-end">
							<button id="btnAgregar" type="button" class="btn btn-gradient pulse-animation" data-bs-toggle="modal" data-bs-target="#modalcrud">
								<i class="fas fa-plus me-2"></i>Nuevo Cliente
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="stats-card">
				<div class="row">
					<div class="col-md-12">
						<h4><i class="fas fa-chart-bar me-2"></i>Total de Clientes: <span class="fw-bold">${listaCli.size()}</span></h4>
					</div>
				</div>
			</div>
			
			<div class="table-container">
				<table class="table table-hover" id="mydatatable" style="width:100%">
					<thead>
						<tr>
							<th><i class="fas fa-hashtag me-2"></i>Código</th>
							<th><i class="fas fa-user me-2"></i>Nombre</th>
							<th><i class="fas fa-user-tag me-2"></i>Apellido</th>
							<th><i class="fas fa-id-card me-2"></i>DNI</th>
							<th><i class="fas fa-phone me-2"></i>Teléfono</th>
							<th><i class="fas fa-cogs me-2"></i>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="cli" items="${listaCli}">
							<tr>
								<td><span class="badge bg-primary fs-6">${cli.getIdCliente()}</span></td>
								<td>${cli.getNombreClien()}</td>
								<td>${cli.getApellidoClien()}</td>
								<td>${cli.getDniClien()}</td>
								<td>${cli.getTelefonoClien()}</td>
								<td>
									<button type="button" class="btn btn-edit btnEditar me-2" data-bs-toggle="modal" data-bs-target="#modalcrud">
										<i class="fas fa-edit me-1"></i>Editar
									</button>
									<button type="button" class="btn btn-delete btnEliminar" data-bs-toggle="modal" data-bs-target="#eliminame">
										<i class="fas fa-trash-alt me-1"></i>Eliminar
									</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- Modal REGISTRAR-->
	<div class="modal fade" id="modalcrud" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="titleModalRegistro">
						<i class="fas fa-user-plus me-2"></i>Registrar/Editar Cliente
					</h5>
					<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="${pageContext.servletContext.contextPath}/gestionCliente" method="post" class="d-flex flex-column gap-4" id="frmCliente">
						
						<input type="hidden" id="idCliente" name="codigo">
						<input type="hidden" id="operacion" name="operacion" value="Agregar">

						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label class="form-label"><i class="fas fa-user me-2"></i>Nombre</label>
									<input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese el nombre" required>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="form-label"><i class="fas fa-user-tag me-2"></i>Apellido</label>
									<input type="text" class="form-control" id="apellido" name="apellido" placeholder="Ingrese el apellido" required>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label class="form-label"><i class="fas fa-id-card me-2"></i>DNI</label>
									<input type="text" class="form-control" id="dni" name="dni" placeholder="Ingrese el DNI" required>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="form-label"><i class="fas fa-phone me-2"></i>Teléfono</label>
									<input type="text" class="form-control" id="telefono" name="telefono" placeholder="Ingrese el teléfono">
								</div>
							</div>
						</div>

						<div class="row">
							<div class="d-grid gap-2 d-md-flex justify-content-md-end">
								<button type="submit" class="btn btn-gradient" id="btnSubmit" onclick="debugForm()">
									<i class="fas fa-save me-2"></i>Guardar Cambios
								</button>
								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
									<i class="fas fa-times me-2"></i>Cancelar
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Eliminar-->
	<div class="modal fade" id="eliminame" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">
						<i class="fas fa-exclamation-triangle me-2"></i>CONFIRMACIÓN
					</h5>
					<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<div class="modal-body">
					<form id="frmEliminarCliente" action="gestionCliente" method="post">
						<input type="hidden" class="form-control" name="codigo" id="cod-eliminar">
						<div class="text-center">
							<i class="fas fa-user-times text-danger" style="font-size: 4rem; margin-bottom: 20px;"></i>
							<h3 class="text-danger">¿Está seguro de eliminar este cliente?</h3>
							<p class="text-muted">Esta acción no se puede deshacer</p>
						</div>
						<div class="d-md-flex justify-content-md-center gap-3 mt-4">
							<button type="submit" class="btn btn-danger" name="operacion" value="Eliminar">
								<i class="fas fa-check me-2"></i>Sí, Eliminar
							</button>
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
								<i class="fas fa-times me-2"></i>Cancelar
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	$(document).ready(function () {
		
		// Función para debug - ver qué se envía
		window.debugForm = function() {
			console.log("=== DEBUG FORM ===");
			console.log("Operación:", $('#operacion').val());
			console.log("ID Cliente:", $('#idCliente').val());
			console.log("Nombre:", $('#nombre').val());
			console.log("==================");
		};
		
		// Botón Editar
$(document).on('click', '.btnEditar', function () {
	const fila = $(this).closest("tr");
	$('#idCliente').val(fila.find("td").eq(0).text());
	$('#nombre').val(fila.find("td").eq(1).text());
	$('#apellido').val(fila.find("td").eq(2).text());
	$('#dni').val(fila.find("td").eq(3).text());
	$('#telefono').val(fila.find("td").eq(4).text());
	$('#operacion').val('Actualizar');
	$('#titleModalRegistro').html('<i class="fas fa-user-edit me-2"></i>Modificar Cliente');

});

		// Botón Agregar
$('#btnAgregar').on('click', function () {
	$('#frmCliente')[0].reset();
	$('#idCliente').val('');
	$('#operacion').val('Agregar');
	$('#titleModalRegistro').html('<i class="fas fa-user-plus me-2"></i>Registrar Cliente');
	
});


		// Botón Eliminar
		$(document).on('click', '.btnEliminar', function () {
			const cod = $(this).closest("tr").find("td").eq(0).text();
			$("#cod-eliminar").val(cod);
		});

		// Inicializar DataTable
		$('#mydatatable').DataTable({
			responsive: true,
			language: {
				url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json'
			}
		});

	});
	</script>

</body>
</html>
