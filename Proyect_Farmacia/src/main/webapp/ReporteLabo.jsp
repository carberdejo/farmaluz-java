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
    <title>Reporte por Laboratorio</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 <link rel="stylesheet" href="css/General.css">
  
    <style>
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

        /* Estilos específicos para la página de reporte */
        .report-header {
            background: var(--primary-gradient);
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .report-title {
            margin: 0;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .export-btn-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .btn-export-excel {
            background: linear-gradient(45deg, #28a745, #218838); /* Verde más vibrante */
            border: none;
            color: white;
            font-weight: 600;
            padding: 12px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }

        .btn-export-excel:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
            color: white;
        }
        
        #confettiGif {
            display:none; 
            position:absolute; 
            top:50%; 
            left:50%; 
            transform:translate(-50%, -50%);
            width:220px; 
            pointer-events:none; 
            z-index:10;
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
        }
    </style>
</head>
<body class="d-flex">

    <%-- INCLUSIÓN DEL MENÚ LATERAL (SIDEBAR) --%>
    <%@ include file="principal/menu.jsp" %>
    
    <%-- CONTENIDO PRINCIPAL DE LA PÁGINA --%>
    <div class="main-container">
        <div class="report-header">
            <h2 class="report-title">
                <i class="fas fa-flask"></i>
                Reporte por Laboratorio
            </h2>
            <p class="mb-0 mt-2 opacity-75 d-none d-md-block">Análisis detallado de productos por laboratorio.</p>
        </div>

        <div class="table-container">
            <h4 class="mt-4 text-center">Resultados del Reporte</h4>
            
            <div class="export-btn-container">
                <form action="gestionReports?operacion=excel2" method="post" onsubmit="mostrarConfetti()">
                    <button type="submit" class="btn btn-export-excel position-relative" id="exportBtn">
                        <i class="fas fa-file-excel me-2"></i>Exportar Excel
                        <img src="${pageContext.request.contextPath}/img/Confetti.gif"
                             id="confettiGif">
                    </button>
                </form>
            </div>
            
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><i class="fas fa-barcode me-1"></i>Código Laboratorio</th>
                            <th><i class="fas fa-building me-1"></i>Laboratorio</th>
                            <th><i class="fas fa-cubes me-1"></i>Stock Total</th>
                            <th><i class="fas fa-boxes me-1"></i>Cant. Productos Diferentes</th>
                            <th><i class="fas fa-calendar-alt me-1"></i>Última Fecha Entrada</th>
                            <th><i class="fas fa-dollar-sign me-1"></i>Producto Más Caro</th>
                            <th><i class="fas fa-money-bill-wave me-1"></i>Precio Promedio</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${Reporte2Listo}">
                            <tr>
                                <td><span class="badge bg-secondary">${r.id_lab}</span></td>
                                <td><strong>${r.nom_lab}</strong></td>
                                <td>${r.stockTot}</td>
                                <td>${r.cantProd}</td>
                                <td>${r.fEnt}</td>
                                <td>${r.prodCaro}</td>
                                <td>S/ <fmt:formatNumber value="${r.prePromedio}" pattern="#,##0.00"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty Reporte2Listo}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
                                    <i class="fas fa-box-open me-2"></i>No hay datos de reporte disponibles para laboratorios.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function mostrarConfetti() {
            const gif = document.getElementById("confettiGif");
            gif.style.display = "block";

            // Ocultar luego de 1.5 segundos
            setTimeout(() => {
                gif.style.display = "none";
            }, 1500);
        }

        // Animaciones adicionales para la tabla
        document.addEventListener('DOMContentLoaded', function() {
            const tableRows = document.querySelectorAll('.table tbody tr');
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