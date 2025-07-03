<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>

<c:if test="${empty sessionScope.empleado}">
	<jsp:forward page="/Login.jsp"/>
</c:if>

<style>
/* Variables de colores para consistencia */
:root {
    --sidebar-bg-start: #4ADE80; /* Verde claro */
    --sidebar-bg-end: #3B82F6; /* Azul */
    --link-color: rgba(255, 255, 255, 0.85);
    --link-hover-bg: rgba(255, 255, 255, 0.15);
    --link-active-bg: rgba(255, 255, 255, 0.25);
    --link-active-border: #FFFFFF; /* Borde blanco para activo */
    --submenu-bg: rgba(0, 0, 0, 0.15);
    --submenu-link-color: rgba(255, 255, 255, 0.7);
    --submenu-link-hover-bg: rgba(255, 255, 255, 0.1);
    --user-section-bg: rgba(0, 0, 0, 0.1);
    --user-info-hover-bg: rgba(255, 255, 255, 0.1);
    --user-avatar-bg: rgba(255, 255, 255, 0.2);
    --user-avatar-border: rgba(255, 255, 255, 0.3);
    --dropdown-bg: white;
    --dropdown-item-color: #495057;
    --dropdown-item-hover-bg: #f0f2f5; /* Un gris muy claro */
    --dropdown-item-logout-color: #dc3545;
    --dropdown-item-logout-hover-bg: #dc3545;
    --dropdown-item-logout-hover-color: white;
    --notification-badge-bg: #dc3545;
    --toggle-btn-color: rgba(255, 255, 255, 0.8);
    --toggle-btn-hover-bg: rgba(255, 255, 255, 0.1);
}

/* Sidebar moderno */
.modern-sidebar {
    background: linear-gradient(135deg, var(--sidebar-bg-start) 0%, var(--sidebar-bg-end) 100%);
    width: 280px;
    height: 100vh;
    position: fixed;
    left: 0;
    top: 0;
    z-index: 1000;
    transition: all 0.3s ease;
    box-shadow: 2px 0 15px rgba(0,0,0,0.15); /* Sombra un poco más fuerte */
    overflow-y: auto;
    display: flex; /* Usar flex para el layout interno */
    flex-direction: column;
}

.modern-sidebar.collapsed {
    width: 70px;
}

/* Header del sidebar */
.sidebar-header {
    padding: 1.5rem;
    text-align: center;
    border-bottom: 1px solid rgba(255,255,255,0.15); /* Borde más visible */
    display: flex; /* Para alinear el título y el botón */
    justify-content: space-between;
    align-items: center;
    position: relative; /* Para posicionar el toggle-btn */
}

.sidebar-header h3 {
    color: white;
    font-weight: bold;
    margin: 0;
    font-size: 1.6rem; /* Un poco más grande */
    transition: opacity 0.3s ease;
    white-space: nowrap; /* Evita que el texto se rompa */
    overflow: hidden;
    text-overflow: clip; /* Recorta si no cabe */
    flex-grow: 1; /* Permite que el título ocupe espacio */
}

.collapsed .sidebar-header h3 {
    opacity: 0;
    width: 0; /* Oculta completamente el texto */
    padding: 0;
    margin: 0;
}

.toggle-btn {
    background: none;
    border: none;
    color: var(--toggle-btn-color);
    font-size: 1.3rem; /* Icono un poco más grande */
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 5px;
    transition: all 0.3s ease;
    flex-shrink: 0; /* Evita que se encoja */
    margin-left: 10px; /* Espacio entre titulo y boton */
}

.toggle-btn:hover {
    background: var(--toggle-btn-hover-bg);
    color: white;
}

/* Menu items */
.sidebar-nav {
    padding: 1rem 0;
    flex-grow: 1; /* Permite que el menú ocupe el espacio restante */
    overflow-y: auto; /* Para desplazamiento si hay muchos elementos */
}

.nav-item {
    margin: 0.25rem 0;
}

.nav-link-custom {
    display: flex;
    align-items: center;
    padding: 1rem 1.5rem;
    color: var(--link-color);
    text-decoration: none;
    transition: all 0.3s ease;
    position: relative;
    border: none;
    background: none;
    width: 100%;
    text-align: left;
    white-space: nowrap; /* Evita que el texto se rompa */
}

.nav-link-custom:hover {
    background: var(--link-hover-bg);
    color: white;
    text-decoration: none;
}

.nav-link-custom.active {
    background: var(--link-active-bg);
    color: white;
}

.nav-link-custom.active::before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    height: 100%;
    width: 4px;
    background: var(--link-active-border);
    border-radius: 0 5px 5px 0; /* Borde redondeado solo en el lado derecho */
}

.nav-icon {
    width: 24px; /* Iconos un poco más grandes */
    height: 24px;
    font-size: 1.15rem; /* Tamaño de la fuente del icono */
    margin-right: 1.2rem; /* Más espacio */
    flex-shrink: 0;
    text-align: center;
}

.nav-text {
    flex: 1;
    font-weight: 500;
    transition: opacity 0.3s ease, width 0.3s ease; /* Transición para el ancho también */
    overflow: hidden;
}

.collapsed .nav-text {
    opacity: 0;
    width: 0; /* Colapsa el ancho del texto */
    pointer-events: none;
}

.dropdown-arrow {
    margin-left: auto;
    transition: transform 0.3s ease, opacity 0.3s ease;
    font-size: 0.9rem;
    flex-shrink: 0;
}

.dropdown-arrow.rotated {
    transform: rotate(180deg);
}

.collapsed .dropdown-arrow {
    opacity: 0;
    width: 0; /* Colapsa el ancho de la flecha */
}

/* Submenus */
.submenu {
    background: var(--submenu-bg);
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.3s ease;
    padding: 0; /* Asegura padding cero al inicio */
}

.submenu.show {
    max-height: 300px; /* Suficientemente grande para contener submenús */
    padding: 0.5rem 0; /* Añadir padding cuando está abierto */
}

.submenu-link {
    display: flex; /* Para alinear icono y texto */
    align-items: center;
    padding: 0.75rem 1.5rem 0.75rem 3.5rem; /* Ajuste para indentación */
    color: var(--submenu-link-color);
    text-decoration: none;
    transition: all 0.3s ease;
    font-size: 0.95rem; /* Ligeramente más grande */
}

.submenu-link:hover {
    background: var(--submenu-link-hover-bg);
    color: white;
    text-decoration: none;
}

/* User section */
.user-section {
    position: relative; /* Permite posicionar el dropdown relativo a esta sección */
    padding: 1rem;
    margin-top: auto; /* Empuja la sección de usuario al final */
    border-top: 1px solid rgba(255,255,255,0.15); /* Borde superior más visible */
    background: var(--user-section-bg);
    z-index: 100; /* Asegura que esté por encima de otros elementos del sidebar */
}

.user-info {
    display: flex;
    align-items: center;
    color: white;
    cursor: pointer;
    padding: 0.75rem;
    border-radius: 10px;
    transition: all 0.3s ease;
}

.user-info:hover {
    background: var(--user-info-hover-bg);
}

.user-avatar {
    width: 45px; /* Avatar un poco más grande */
    height: 45px;
    border-radius: 50%;
    background: var(--user-avatar-bg);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
    margin-right: 1rem;
    border: 2px solid var(--user-avatar-border);
    flex-shrink: 0;
    font-size: 1.1rem;
}

.user-details {
    flex: 1;
    transition: opacity 0.3s ease;
    overflow: hidden; /* Oculta el desbordamiento del texto */
    white-space: nowrap; /* Evita que el texto se rompa */
    text-overflow: ellipsis; /* Añade puntos suspensivos si el texto es muy largo */
}

.collapsed .user-details {
    opacity: 0;
    width: 0;
}

.user-name {
    font-weight: bold;
    font-size: 1rem; /* Un poco más grande */
    margin-bottom: 2px;
}

.user-role {
    font-size: 0.85rem; /* Un poco más grande */
    opacity: 0.8;
}

/* Dropdown menu for user */
.user-dropdown {
    position: absolute;
    bottom: calc(100% + 10px); /* Ajuste para espacio entre user-info y dropdown */
    left: 1rem;
    right: 1rem;
    background: var(--dropdown-bg);
    border-radius: 10px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.25); /* Sombra más fuerte */
    padding: 0.5rem 0;
    opacity: 0;
    visibility: hidden;
    transform: translateY(10px);
    transition: all 0.3s ease;
    z-index: 1001;
}

.user-dropdown.show {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.dropdown-item-custom {
    display: flex; /* Para alinear icono y texto */
    align-items: center;
    padding: 0.75rem 1rem;
    color: var(--dropdown-item-color);
    text-decoration: none;
    transition: all 0.3s ease;
    border: none;
    background: none;
    width: 100%;
    text-align: left;
    font-size: 0.95rem; /* Tamaño de fuente consistente */
}

.dropdown-item-custom i {
    margin-right: 0.75rem; /* Espacio para el icono */
    width: 20px; /* Ancho fijo para iconos */
    text-align: center;
}

.dropdown-item-custom:hover {
    background: var(--dropdown-item-hover-bg);
    color: var(--dropdown-item-color);
}

.dropdown-item-custom.logout {
    color: var(--dropdown-item-logout-color);
}

.dropdown-item-custom.logout:hover {
    background: var(--dropdown-item-logout-hover-bg);
    color: var(--dropdown-item-logout-hover-color);
}

/* Main content area */
body {
    margin-left: 280px;
    transition: margin-left 0.3s ease;
}

body.sidebar-collapsed {
    margin-left: 70px;
}

/* Notification badge */
.notification-badge {
    position: absolute;
    top: 5px; /* Posición ajustada */
    right: 5px; /* Posición ajustada */
    background: var(--notification-badge-bg);
    color: white;
    border-radius: 50%;
    width: 20px; /* Un poco más grande */
    height: 20px;
    font-size: 0.75rem; /* Tamaño de fuente un poco más grande */
    display: flex;
    align-items: center;
    justify-content: center;
    border: 2px solid rgba(255,255,255,0.4); /* Borde más definido */
    font-weight: bold;
    transform: translate(50%, -50%); /* Ajuste fino de posición */
}

/* Mobile responsive */
@media (max-width: 768px) {
    .modern-sidebar {
        transform: translateX(-100%);
        box-shadow: 5px 0 15px rgba(0,0,0,0.2); /* Sombra más pronunciada en móvil */
    }
    
    .modern-sidebar.mobile-open {
        transform: translateX(0);
    }
    
    body {
        margin-left: 0;
    }
    
    body.sidebar-collapsed {
        margin-left: 0;
    }

    .toggle-btn {
        display: none; /* Ocultar el botón de colapsar en móvil, usar el de abrir */
    }

    .sidebar-header {
        justify-content: center; /* Centrar el logo en móvil */
    }
    .sidebar-header h3 {
        opacity: 1; /* Siempre visible en móvil cuando el sidebar está abierto */
        width: auto;
        padding: 0;
        margin: 0;
    }
}

/* Overlay for mobile */
.sidebar-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.5);
    z-index: 999;
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
}

.sidebar-overlay.show {
    opacity: 1;
    visibility: visible;
}
</style>

<div class="sidebar-overlay" id="sidebarOverlay" onclick="closeMobileSidebar()"></div>

<nav class="modern-sidebar" id="sidebar">
    <div class="sidebar-header">
        <h3><i class="fas fa-pills me-2"></i>Farmaluz</h3>
        <button class="toggle-btn" onclick="toggleSidebar()" aria-label="Toggle Sidebar">
            <i class="fas fa-bars"></i>
        </button>
    </div>
    
    <div class="sidebar-nav">
        <div class="nav-item">
            <a href="${pageContext.servletContext.contextPath}/Inicio.jsp" class="nav-link-custom">
                <i class="fas fa-home nav-icon"></i>
                <span class="nav-text">Home</span>
            </a>
        </div>
        
        <div class="nav-item">
            <a href="${pageContext.servletContext.contextPath}/gestionCatalogo?operacion=listar" class="nav-link-custom">
                <i class="fas fa-box nav-icon"></i>
                <span class="nav-text">Productos</span>
            </a>
        </div>
        
        <div class="nav-item">
            <a href="${pageContext.servletContext.contextPath}/Venta.jsp" class="nav-link-custom">
                <i class="fas fa-shopping-cart nav-icon"></i>
                <span class="nav-text">Ventas</span>
            </a>
        </div>
        
        <c:if test="${empleado.rol == 'ADMIN'}">
            <div class="nav-item">
                <button class="nav-link-custom" onclick="toggleSubmenu(this)" aria-expanded="false">
                    <i class="fas fa-chart-bar nav-icon"></i>
                    <span class="nav-text">Reportes</span>
                    <i class="fas fa-chevron-down dropdown-arrow"></i>
                </button>
                <div class="submenu">
                    <a href="${pageContext.servletContext.contextPath}/gestionReports?operacion=Report1" class="submenu-link">
                        <i class="fas fa-tags me-2"></i>Por Categoría
                    </a>
                    <a href="${pageContext.servletContext.contextPath}/gestionReports?operacion=Report2" class="submenu-link">
                        <i class="fas fa-flask me-2"></i>Por Laboratorio
                    </a>
                    
                </div>
            </div>
            
            <div class="nav-item">
                <button class="nav-link-custom" onclick="toggleSubmenu(this)" aria-expanded="false">
                    <i class="fas fa-cog nav-icon"></i>
                    <span class="nav-text">Administración</span>
                    <i class="fas fa-chevron-down dropdown-arrow"></i>
                </button>
                <div class="submenu">
                    <a href="${pageContext.servletContext.contextPath}/gestionUsuario?operacion=listar" class="submenu-link">
                        <i class="fas fa-users me-2"></i>Empleados
                    </a>
                    <a href="${pageContext.servletContext.contextPath}/gestionCliente?operacion=listar" class="submenu-link">
                        <i class="fas fa-user-friends me-2"></i>Clientes
                    </a>
                    <a href="${pageContext.servletContext.contextPath}/gestionProveedor?operacion=listar" class="submenu-link">
                        <i class="fas fa-truck me-2"></i>Proveedor
                    </a>
                    <a href="${pageContext.servletContext.contextPath}/gestionProducto?operacion=listar" class="submenu-link">
                        <i class="fas fa-pills me-2"></i>Producto
                    </a>
                </div>
            </div>
        </c:if>
        
    </div>
    
    <div class="user-section">
        <div class="user-info" onclick="toggleUserDropdown()">
            <div class="user-avatar">
                ${empleado.nombreUsu.substring(0,1).toUpperCase()}
            </div>
            <div class="user-details">
                <div class="user-name">${empleado.nombreUsu}</div>
                <div class="user-role">${empleado.apellidoUsu}</div>
            </div>
        </div>
        
        <div class="user-dropdown" id="userDropdown">
            <button class="dropdown-item-custom" onclick="editProfile()">
                <i class="fas fa-user me-2"></i>Mi Perfil
            </button>
            <button class="dropdown-item-custom" onclick="settings()">
                <i class="fas fa-cog me-2"></i>Configuración
            </button>
            <hr style="margin: 0.5rem 0; border-color: #eee;">
            <form action="gestionAcceder" method="post" style="margin: 0;">
                <button class="dropdown-item-custom logout" type="submit" name="operacion" value="salir">
                    <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión
                </button>
            </form>
        </div>
    </div>
</nav>

<%@ include file="../Fragmentos/Notificaciones.jsp" %>

<script>
// Toggle sidebar collapse
function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const body = document.body;
    
    sidebar.classList.toggle('collapsed');
    body.classList.toggle('sidebar-collapsed');
    
    // Si se colapsa, cerrar cualquier menú desplegable abierto
    if (sidebar.classList.contains('collapsed')) {
        document.querySelectorAll('.submenu').forEach(menu => {
            menu.classList.remove('show');
        });
        document.querySelectorAll('.dropdown-arrow').forEach(arr => {
            arr.classList.remove('rotated');
        });
        document.getElementById('userDropdown').classList.remove('show'); // Cerrar dropdown de usuario
    }
}

// Toggle submenu
function toggleSubmenu(button) {
    const submenu = button.nextElementSibling;
    const arrow = button.querySelector('.dropdown-arrow');
    const isOpen = submenu.classList.contains('show');
    
    // Si el sidebar está colapsado, no abrir submenús
    if (document.getElementById('sidebar').classList.contains('collapsed') && !isOpen) {
        return;
    }

    // Cerrar todos los demás submenús (excepto el actual si ya está abierto)
    document.querySelectorAll('.submenu').forEach(menu => {
        if (menu !== submenu) {
            menu.classList.remove('show');
            const parentButton = menu.previousElementSibling;
            if (parentButton) {
                parentButton.querySelector('.dropdown-arrow').classList.remove('rotated');
            }
        }
    });
    
    // Alternar el subménu actual
    if (!isOpen) {
        submenu.classList.add('show');
        arrow.classList.add('rotated');
    } else {
        submenu.classList.remove('show');
        arrow.classList.remove('rotated');
    }
}

// Toggle user dropdown
function toggleUserDropdown() {
    const dropdown = document.getElementById('userDropdown');
    dropdown.classList.toggle('show');
}

// Close user dropdown when clicking outside
document.addEventListener('click', function(event) {
    const userSection = document.querySelector('.user-section');
    const dropdown = document.getElementById('userDropdown');
    
    // Si el clic no fue dentro de la sección de usuario y el dropdown está abierto, ciérralo
    if (!userSection.contains(event.target) && dropdown.classList.contains('show')) {
        dropdown.classList.remove('show');
    }
});

// Mobile sidebar functions
function openMobileSidebar() {
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('sidebarOverlay');
    
    sidebar.classList.add('mobile-open');
    overlay.classList.add('show');
}

function closeMobileSidebar() {
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('sidebarOverlay');
    
    sidebar.classList.remove('mobile-open');
    overlay.classList.remove('show');
}

// Set active menu item based on current page
document.addEventListener('DOMContentLoaded', function() {
    const currentPath = window.location.pathname;
    const contextPath = '${pageContext.servletContext.contextPath}';
    
    const menuLinks = document.querySelectorAll('.nav-link-custom[href], .submenu-link');
    
    menuLinks.forEach(link => {
        let linkHref = link.getAttribute('href');
        if (linkHref) {
            // Normalizar el linkHref para que coincida con el currentPath después del contextPath
            if (linkHref.startsWith(contextPath)) {
                linkHref = linkHref.substring(contextPath.length);
            }
            
            if (currentPath.endsWith(linkHref) || (currentPath.includes(linkHref) && linkHref !== '/')) {
                link.classList.add('active');
                
                // Si es un enlace de submenú, abre su menú padre
                const parentSubmenu = link.closest('.submenu');
                if (parentSubmenu) {
                    parentSubmenu.classList.add('show');
                    const parentButton = parentSubmenu.previousElementSibling;
                    if (parentButton) {
                         parentButton.querySelector('.dropdown-arrow').classList.add('rotated');
                         // También marca el botón padre del submenú como activo si es necesario
                         parentButton.classList.add('active'); 
                    }
                }
            }
        }
    });

    // Asegurarse de que el sidebar está correctamente colapsado/expandido en carga inicial
    // si el body ya tiene la clase .sidebar-collapsed (por ejemplo, si se guarda el estado)
    const sidebar = document.getElementById('sidebar');
    const body = document.body;
    if (body.classList.contains('sidebar-collapsed')) {
        sidebar.classList.add('collapsed');
    }
});


// Placeholder functions for user actions
function editProfile() {
    console.log('Edit profile clicked');
    // Implementar lógica para editar perfil
    toggleUserDropdown();
}

function settings() {
    console.log('Settings clicked');
    // Implementar lógica para configuración
    toggleUserDropdown();
}


</script>

<button class="btn btn-primary-custom d-md-none" onclick="openMobileSidebar()" style="position: fixed; top: 1rem; left: 1rem; z-index: 1002;">
    <i class="fas fa-bars"></i>
</button>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">