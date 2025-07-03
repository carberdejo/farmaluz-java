<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%-- Agregado para formatear el precio --%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${producto.name_pro} - Detalle de Gestión</title> <%-- Título más específico para gestión --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/General.css">
    <style>
       
        /* Estilos específicos para la tarjeta de detalle del producto */
        .product-detail-card {
            background: white;
            border: none; /* Eliminar borde por defecto de card */
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .card-header-custom {
            background: var(--primary-gradient); /* Usar gradiente para el header */
            color: white;
            padding: 20px 30px;
            border-bottom: none;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .card-header-custom h4 {
            margin: 0;
            font-weight: 600;
            font-size: 1.5rem;
        }

        .card-body-custom {
            padding: 30px;
        }

        .product-image {
            max-width: 100%;
            height: auto;
            border-radius: 15px; /* Bordes más suaves para la imagen */
            object-fit: cover;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .product-image:hover {
            transform: scale(1.02); /* Efecto zoom suave */
        }

        .product-info p {
            font-size: 1.05rem;
            margin-bottom: 8px;
            color: #495057;
        }

        .product-info strong {
            color: #2c3e50;
        }

        .price-display {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--danger-gradient); /* Usar gradiente para el precio */
        }
        
        .stock-display {
            font-size: 1.1rem;
            font-weight: 600;
        }

        .card-footer-custom {
            background: #f8f9fa; /* Color de fondo suave para el footer */
            padding: 20px 30px;
            border-top: 1px solid #e9ecef; /* Borde sutil */
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
            display: flex;
            flex-wrap: wrap; /* Para responsividad */
            align-items: center;
            justify-content: space-between; /* Alineación para elementos */
            gap: 15px;
        }
        
        .card-footer-custom .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 0; /* Eliminar margen inferior */
        }

        .stock-input {
            width: 120px;
            height: 45px; /* Altura consistente */
            font-size: 1.1rem;
            text-align: center;
            border-radius: 10px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }
        .stock-input:focus {
            border-color: var(--primary-gradient);
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        }

        .btn-update-stock {
            background: var(--success-gradient);
            border: none;
            color: white;
            font-weight: 600;
            padding: 12px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(17, 153, 142, 0.3);
        }

        .btn-update-stock:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(17, 153, 142, 0.4);
            color: white;
        }

        .btn-back-to-maintenance {
            background: var(--dark-gradient);
            border: none;
            color: white;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 20px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-back-to-maintenance:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            color: white;
        }

        @media (max-width: 768px) {
            .main-container {
                margin: 10px;
                padding: 20px;
                margin-left: 0;
            }
            .product-detail-card .card-body-custom {
                flex-direction: column;
                gap: 20px;
            }
            .product-detail-card .col-md-4,
            .product-detail-card .col-md-8 {
                width: 100%;
                text-align: center;
            }
            .product-info p {
                font-size: 0.95rem;
            }
            .price-display {
                font-size: 1.2rem;
            }
            .card-footer-custom {
                flex-direction: column;
                align-items: center;
            }
            .card-footer-custom .col-auto {
                width: 100%;
                text-align: center;
            }
            .stock-input {
                width: 100%;
            }
            .btn-update-stock {
                width: 100%;
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
                <i class="fas fa-box-open"></i>
                Detalle y Gestión de Stock de Producto
            </h2>
            <p class="mb-0 mt-2 opacity-75 d-none d-md-block">Información detallada y actualización de inventario para ${producto.name_pro}</p>
        </div>

        <div class="product-detail-card">
            <div class="card-header-custom">
                <h4><i class="fas fa-info-circle"></i> Información del Producto</h4>
            </div>
            
            <div class="card-body-custom row g-4 align-items-center">
                <div class="col-md-4 text-center">
                    <img src="${pageContext.request.contextPath}/img/${producto.id_produc}.jpg" 
                         alt="Imagen del producto" class="product-image">
                </div>

                <div class="col-md-8 product-info">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Nombre:</strong> ${producto.name_pro}</p>
                            <p><strong>Descripción:</strong> ${producto.descripcion}</p>
                            <p><strong>Precio:</strong> <span class="price-display">S/ <fmt:formatNumber value="${producto.precio}" pattern="#,##0.00"/></span></p>
                            <p><strong>Stock actual:</strong> <span class="stock-display badge bg-success">${producto.stock}</span> unidades</p>
                        </div>

                        <div class="col-md-6">
                            <p><strong>Fecha de ingreso:</strong> ${producto.fec_entrada}</p>
                            <p><strong>Última actualización:</strong> ${producto.fec_ultimo}</p>
                            <p><strong>Laboratorio:</strong> ${producto.laboratorio.name_lab}</p>
                            <p><strong>Categoría:</strong> ${producto.categoria.name_cate}</p>
                            <p><strong>Proveedor:</strong> ${producto.proveedor.name_prov}</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card-footer-custom">
                <form action="gestionProducto" method="post" class="row g-3 align-items-center mb-0">
                    <input type="hidden" name="id" value="${producto.id_produc}">
                    <div class="col-auto">
                        <label for="cantidad" class="form-label">Agregar Stock:</label>
                    </div>
                    <div class="col-auto">
                        <input type="number" class="form-control stock-input" name="cantidad" id="cantidad" min="1" value="1" required>
                    </div>
                    <div class="col-auto">
                        <button type="submit" name="operacion" value="agregarStock" class="btn btn-update-stock">
                            <i class="fas fa-plus-circle me-2"></i>Actualizar Stock
                        </button>
                    </div>
                </form>
                <div class="col-auto mt-md-0 mt-3"> <%-- Ajuste de margen para mobile --%>
                    <a href="gestionProducto?operacion=listar" class="btn btn-back-to-maintenance">
                        <i class="fas fa-undo-alt"></i> Volver al Mantenimiento
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>