<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Detalle Notificación</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-light">
	<%@ include file="principal/menu.jsp" %>

	<div class="container mt-5">
		<div class="card shadow-lg border-0 rounded-4">
			<div class="card-header bg-primary text-white d-flex justify-content-between align-items-center rounded-top-4">
				<h4 class="mb-0">
					<i class="fas fa-bell me-2"></i>Notificación: ${noti.titulo}
				</h4>
				<a href="Inicio.jsp" class="btn btn-sm btn-light">
					<i class="fas fa-arrow-left me-1"></i>Volver
				</a>
			</div>

			<div class="card-body">
				<ul class="list-group list-group-flush">
					<li class="list-group-item">
						<strong><i class="fas fa-envelope me-2"></i>Mensaje:</strong> ${noti.mensaje}
					</li>
					<li class="list-group-item">
						<strong><i class="fas fa-calendar-day me-2"></i>Fecha:</strong> ${noti.fecha}
					</li>
					<li class="list-group-item">
						<strong><i class="fas fa-tag me-2"></i>Tipo:</strong> ${noti.tipo}
					</li>
					<li class="list-group-item">
						<strong><i class="fas fa-link me-2"></i>Relacionado con ID:</strong> ${noti.objetoId}
					</li>
				</ul>
				
				<c:if test="${empleado.rol == 'ADMIN'}">
				<div class="text-center mt-4">
					<form action="gestionNotificacion?operacion=exportpdf&id_noti=${noti.id_noti}" method="post" onsubmit="mostrarConfetti()">
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
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
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