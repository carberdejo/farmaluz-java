package controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAONotificacion;
import dao.DAOUsuario;
import model.EntNotificacion;
import model.EntUsuario;

/**
 * Servlet implementation class ServletAcceder
 */
public class ServletAcceder extends HttpServlet {
	private static final long serialVersionUID = 1L;
    DAOUsuario daoUsu = new DAOUsuario();
    EntUsuario objU = new EntUsuario();
    DAONotificacion daoNoti = new DAONotificacion();	
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletAcceder() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("operacion");
		String login,password;
		
		if(accion == null) {
			request.setAttribute("error", "Accion incorrecta");
			request.getRequestDispatcher("Login.jsp").forward(request, response);
			return;
		}if(accion.equalsIgnoreCase("ingresar")) {
			
			login = request.getParameter("txtUsuario");
			password = request.getParameter("txtPassword");
			System.out.println("---"+login+password);	
			if(login == null || password == null) {
				request.getSession().setAttribute("error", "Ingresa tus datos");
				request.getRequestDispatcher("Login.jsp").forward(request, response);
				return;
			}
			
			objU= daoUsu.accediendoAlSistema(login, password);

			if(objU != null) {
				request.getSession().setAttribute("empleado", objU);
				 // SI ES ADMIN, cargamos notificaciones
	            
	                List<EntNotificacion> notificaciones = daoNoti.listarPorUsuario(objU.getIdUsuario());
	                int cantidadNoLeidas = daoNoti.contarNoLeidasPorUsuario(objU.getIdUsuario());
	                request.getSession().setAttribute("notificaciones", notificaciones);
	                request.getSession().setAttribute("noLeidas", cantidadNoLeidas);
	                
	            
	            
				request.getRequestDispatcher("Inicio.jsp").forward(request, response);
			}else {
				
				request.getSession().setAttribute("titulo", "Error");
				request.getSession().setAttribute("mensaje", "usuario o contraseña incorrecta");
				request.getSession().setAttribute("icono", "error");
				System.out.println("Error");
				request.getRequestDispatcher("Login.jsp").forward(request, response);
			}
		}
		else {
			request.getSession().removeAttribute("empleado");
			request.getSession().removeAttribute("notificaciones");
			request.getSession().removeAttribute("noLeidas");
			request.getRequestDispatcher("Login.jsp").forward(request, response);
		}
	
	
	
	
	}

}
