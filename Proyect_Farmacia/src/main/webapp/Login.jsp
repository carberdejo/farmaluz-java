<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Farmacia SaludVida - Ingreso</title>
<link rel="icon" type="image/x-icon" href="img/logo-icon.ico">

<!-- Bootstrap & Animaciones -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
  :root {
    --primary-color: #2C9BA0;
    --secondary-color: #38B2A3;
    --accent-color: #4CCBA3;
    --light-accent: #67DBA5;
    --lighter-accent: #89F8AC;
    --lightest-accent: #B9FFBC;
    --white: #ffffff;
    --text-dark: #2c3e50;
    --text-light: #6c757d;
    --shadow: rgba(44, 155, 160, 0.3);
  }

  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  body {
    min-height: 100vh;
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 25%, var(--accent-color) 50%, var(--light-accent) 75%, var(--lighter-accent) 100%);
    background-size: 400% 400%;
    animation: gradientShift 15s ease infinite;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
  }

  @keyframes gradientShift {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
  }

  /* Elementos decorativos flotantes */
  .floating-shapes {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    z-index: 1;
  }

  .shape {
    position: absolute;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    animation: float 20s infinite linear;
  }

  .shape:nth-child(1) {
    width: 80px;
    height: 80px;
    left: 10%;
    animation-delay: 0s;
  }

  .shape:nth-child(2) {
    width: 60px;
    height: 60px;
    left: 20%;
    animation-delay: 2s;
  }

  .shape:nth-child(3) {
    width: 100px;
    height: 100px;
    left: 70%;
    animation-delay: 4s;
  }

  .shape:nth-child(4) {
    width: 40px;
    height: 40px;
    left: 80%;
    animation-delay: 6s;
  }

  .shape:nth-child(5) {
    width: 120px;
    height: 120px;
    left: 90%;
    animation-delay: 8s;
  }

  @keyframes float {
    0% {
      transform: translateY(100vh) rotate(0deg);
      opacity: 0;
    }
    10% {
      opacity: 1;
    }
    90% {
      opacity: 1;
    }
    100% {
      transform: translateY(-100px) rotate(360deg);
      opacity: 0;
    }
  }

  .login-container {
    position: relative;
    z-index: 10;
    width: 100%;
    max-width: 600px;
    margin: 0 20px;
  }

  .login-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border-radius: 30px;
    box-shadow: 
      0 25px 50px var(--shadow),
      0 0 0 1px rgba(255, 255, 255, 0.2),
      inset 0 1px 0 rgba(255, 255, 255, 0.3);
    padding: 80px 60px;
    position: relative;
    overflow: hidden;
    animation: cardEntrance 1.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  }

  .login-card::after {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 200px;
    height: 200px;
    background: radial-gradient(circle, rgba(44, 155, 160, 0.1) 0%, transparent 70%);
    border-radius: 50%;
    transform: translate(-50%, -50%);
    animation: pulseCenter 4s ease-in-out infinite;
    z-index: 1;
  }

  @keyframes pulseCenter {
    0%, 100% {
      transform: translate(-50%, -50%) scale(1);
      opacity: 0.3;
    }
    50% {
      transform: translate(-50%, -50%) scale(1.5);
      opacity: 0.1;
    }
  }

  @keyframes cardEntrance {
    0% {
      opacity: 0;
      transform: translateY(50px) scale(0.9);
    }
    100% {
      opacity: 1;
      transform: translateY(0) scale(1);
    }
  }

  .login-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, var(--primary-color), var(--accent-color), var(--light-accent));
    animation: shimmer 3s ease-in-out infinite;
  }

  @keyframes shimmer {
    0%, 100% { opacity: 0.5; }
    50% { opacity: 1; }
  }

  .header-image {
    text-align: center;
    margin-bottom: 30px;
    animation: headerFloat 4s ease-in-out infinite;
  }

  @keyframes headerFloat {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-8px); }
  }

  .header-img {
    width: 140px;
    height: 120px;
    object-fit: contain;
    filter: drop-shadow(0 10px 20px rgba(44, 155, 160, 0.3));
    transition: transform 0.3s ease;
  }

  .header-img:hover {
    transform: scale(1.05);
  }

  .logo-container {
    text-align: center;
    margin-bottom: 25px;
    animation: logoFloat 3s ease-in-out infinite;
  }

  @keyframes logoFloat {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
  }

  .login-logo {
    width: 110px;
    height: 110px;
    border-radius: 50%;
    object-fit: cover;
    border: 4px solid var(--primary-color);
    padding: 12px;
    background: white;
    box-shadow: 0 12px 35px var(--shadow);
    transition: transform 0.3s ease;
  }

  .login-logo:hover {
    transform: scale(1.1) rotate(5deg);
  }

  .login-title {
    font-weight: 700;
    font-size: 2.8rem;
    background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    text-align: center;
    margin-bottom: 12px;
    animation: titleGlow 2s ease-in-out infinite alternate;
  }

  @keyframes titleGlow {
    0% { filter: brightness(1); }
    100% { filter: brightness(1.2); }
  }

  .login-subtext {
    font-size: 1.2rem;
    color: var(--text-light);
    text-align: center;
    margin-bottom: 50px;
    font-weight: 300;
    animation: fadeInUp 1s ease 0.3s both;
  }

  @keyframes fadeInUp {
    0% {
      opacity: 0;
      transform: translateY(20px);
    }
    100% {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .form-group {
    position: relative;
    margin-bottom: 30px;
    animation: slideInCenter 0.8s ease both;
    z-index: 10;
  }

  .form-group:nth-child(2) {
    animation-delay: 0.2s;
  }

  .form-group:nth-child(3) {
    animation-delay: 0.4s;
  }

  @keyframes slideInCenter {
    0% {
      opacity: 0;
      transform: translateX(-30px) scale(0.9);
    }
    100% {
      opacity: 1;
      transform: translateX(0) scale(1);
    }
  }

  .form-group.focused {
    transform: scale(1.02);
  }

  .form-group.focused .form-label {
    color: var(--primary-color);
    transform: translateX(5px);
  }

  .form-group.focused .form-label i {
    transform: scale(1.2) rotate(5deg);
    color: var(--accent-color);
  }

  .form-label {
    font-weight: 600;
    font-size: 1.1rem;
    color: var(--text-dark);
    margin-bottom: 10px;
    display: flex;
    align-items: center;
    gap: 10px;
    transition: all 0.3s ease;
    position: relative;
    z-index: 10;
  }

  .form-label i {
    color: var(--primary-color);
    font-size: 1.3rem;
    transition: all 0.3s ease;
  }

  .input-container {
    position: relative;
    overflow: hidden;
  }

  .input-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(44, 155, 160, 0.1), transparent);
    transition: left 0.6s ease;
    border-radius: 20px;
    z-index: 1;
  }

  .input-container:hover::before {
    left: 100%;
  }

  .form-control {
    border: 3px solid #dee2e6;
    border-radius: 20px;
    font-size: 1.15rem;
    padding: 18px 24px;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    background: rgba(255, 255, 255, 0.95);
    font-weight: 400;
    position: relative;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    z-index: 2;
  }

  .form-control:focus {
    border-color: var(--primary-color);
    box-shadow: 
      0 0 0 0.3rem rgba(44, 155, 160, 0.25),
      0 8px 25px rgba(44, 155, 160, 0.15),
      inset 0 1px 0 rgba(255, 255, 255, 0.3);
    background: white;
    transform: translateY(-3px) scale(1.02);
    outline: none;
  }

  .form-control:hover {
    border-color: var(--secondary-color);
    transform: translateY(-1px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
  }

  .form-control::placeholder {
    color: #adb5bd;
    font-weight: 300;
  }

  .btn-login {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    border: 3px solid transparent;
    color: white;
    border-radius: 20px;
    padding: 20px 30px;
    font-size: 1.3rem;
    font-weight: 600;
    position: relative;
    overflow: hidden;
    transition: all 0.4s ease;
    width: 100%;
    margin-top: 25px;
    animation: buttonPulse 0.8s ease 0.6s both;
    z-index: 10;
    box-shadow: 0 6px 20px rgba(44, 155, 160, 0.3);
  }

  .btn-login:hover {
    background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
    transform: translateY(-4px) scale(1.02);
    box-shadow: 0 20px 40px rgba(44, 155, 160, 0.4);
    border-color: var(--light-accent);
  }

  .btn-login:active {
    transform: translateY(-2px) scale(1.01);
    box-shadow: 0 10px 25px rgba(44, 155, 160, 0.35);
  }

  @keyframes buttonPulse {
    0% {
      opacity: 0;
      transform: scale(0.9);
    }
    100% {
      opacity: 1;
      transform: scale(1);
    }
  }

  .btn-login::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
    transition: left 0.5s ease;
  }

  .btn-login:hover {
    background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
    transform: translateY(-3px);
    box-shadow: 0 15px 30px var(--shadow);
  }

  .btn-login:hover::before {
    left: 100%;
  }

  .btn-login:active {
    transform: translateY(-1px);
  }

  .btn-login i {
    margin-right: 12px;
    font-size: 1.4rem;
  }

  /* Responsive */
  @media (max-width: 576px) {
    .login-card {
      padding: 50px 30px;
      margin: 20px 15px;
    }
    
    .login-title {
      font-size: 2.2rem;
    }
    
    .login-subtext {
      font-size: 1rem;
    }

    .form-control {
      font-size: 1rem;
      padding: 15px 20px;
    }

    .btn-login {
      font-size: 1.1rem;
      padding: 16px 24px;
    }

    .header-img {
      width: 100px;
      height: 85px;
    }

    .login-logo {
      width: 90px;
      height: 90px;
    }
  }

  /* Efectos adicionales para inputs */
  .form-control.typing {
    border-color: var(--accent-color);
    box-shadow: 0 0 0 0.2rem rgba(76, 203, 163, 0.25);
  }

  .input-container.active::before {
    animation: shimmerActive 1s ease-in-out;
  }

  @keyframes shimmerActive {
    0% { left: -100%; opacity: 0; }
    50% { left: 50%; opacity: 1; }
    100% { left: 100%; opacity: 0; }
  }

  .login-card.pulse-effect::after {
    animation: centerPulse 0.6s ease-out;
  }

  @keyframes centerPulse {
    0% {
      transform: translate(-50%, -50%) scale(1);
      opacity: 0.5;
    }
    50% {
      transform: translate(-50%, -50%) scale(2);
      opacity: 0.3;
    }
    100% {
      transform: translate(-50%, -50%) scale(1);
      opacity: 0.1;
    }
  }

  /* Efectos adicionales */
  .ripple {
    position: relative;
    overflow: hidden;
  }

  .ripple::after {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0;
    height: 0;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.5);
    transform: translate(-50%, -50%);
    transition: width 0.6s, height 0.6s;
  }

  .ripple:active::after {
    width: 300px;
    height: 300px;
  }
</style>
</head>

<body>
  <!-- Elementos decorativos flotantes -->
  <div class="floating-shapes">
    <div class="shape"></div>
    <div class="shape"></div>
    <div class="shape"></div>
    <div class="shape"></div>
    <div class="shape"></div>
  </div>

  <div class="login-container">
    <div class="login-card">
      

      <div class="logo-container">
        <img src="img/logo.png" alt="Logo Farmacia SaludVida" class="login-logo" />
      </div>

      <h2 class="login-title">Farmaluz</h2>
      <p class="login-subtext">Accede a tu cuenta para continuar</p>

      <form id="frmUsuario" action="gestionAcceder" method="post">
        <div class="form-group">
          <label for="txtUsuario" class="form-label">
            <i class="fas fa-user"></i>
            Usuario
          </label>
          <div class="input-container">
            <input type="text" class="form-control" id="txtUsuario" name="txtUsuario" placeholder="Ingrese su usuario" required>
          </div>
        </div>

        <div class="form-group">
          <label for="txtPassword" class="form-label">
            <i class="fas fa-lock"></i>
            Contraseña
          </label>
          <div class="input-container">
            <input type="password" class="form-control" id="txtPassword" name="txtPassword" placeholder="Ingrese su contraseña" required>
          </div>
        </div>

        <button type="submit" class="btn btn-login ripple" name="operacion" value="ingresar">
          <i class="fas fa-sign-in-alt"></i>
          Ingresar
        </button>
      </form>
    </div>
  </div>

  <!-- Script para animaciones adicionales -->
  <script>
    $(document).ready(function() {
      // Efecto de escritura en el título
      const title = $('.login-title');
      const text = title.text();
      title.text('');
      
      let i = 0;
      const typeWriter = setInterval(() => {
        title.text(text.substring(0, i + 1));
        i++;
        if (i >= text.length) {
          clearInterval(typeWriter);
        }
      }, 100);

      // Efecto de enfoque suave en inputs con animaciones mejoradas
      $('.form-control').on('focus', function() {
        $(this).closest('.form-group').addClass('focused');
        $(this).closest('.input-container').addClass('active');
      }).on('blur', function() {
        $(this).closest('.form-group').removeClass('focused');
        $(this).closest('.input-container').removeClass('active');
      });

      // Animación de pulsación en el centro de la tarjeta al hacer clic en inputs
      $('.form-control').on('click', function() {
        const card = $('.login-card');
        card.addClass('pulse-effect');
        setTimeout(() => {
          card.removeClass('pulse-effect');
        }, 600);
      });

      // Efecto de ondas en los inputs
      $('.form-control').on('input', function() {
        $(this).addClass('typing');
        clearTimeout($(this).data('timeout'));
        $(this).data('timeout', setTimeout(() => {
          $(this).removeClass('typing');
        }, 500));
      });

      // Animación del botón al enviar
      $('#frmUsuario').on('submit', function() {
        $('.btn-login').html('<i class="fas fa-spinner fa-spin"></i> Ingresando...');
      });
    });
  </script>

  <!-- Mantengo la lógica original de SweetAlert -->
  <c:if test="${not empty sessionScope.titulo}">
    <script>
      $(document).ready(function(){
        Swal.fire({
          position: "center",
          icon: "<%=request.getSession().getAttribute("icono")%>",
          title: "<%=request.getSession().getAttribute("titulo")%>",
          text: "<%=request.getSession().getAttribute("mensaje")%>",
          showConfirmButton: true,
          timer: 3000,
          customClass: {
            popup: 'animate__animated animate__zoomIn'
          }
        });
      });
    </script>
    <% session.removeAttribute("titulo"); %>
    <% session.removeAttribute("mensaje"); %>
    <% session.removeAttribute("icono"); %>
  </c:if>

</body>
</html>