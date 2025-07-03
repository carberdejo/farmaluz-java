package controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAOUsuario;
import model.EntUsuario;

/**
 * Servlet implementation class ServletUsuario
 */
public class ServletUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
     DAOUsuario daoUsu = new DAOUsuario();
     EntUsuario entUsu = new EntUsuario();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String operacion = request.getParameter("operacion");
		

		if (operacion == null || operacion.equals("listar")) {
			listarTodo(request, response, null);
		} 
		else if (operacion.equals("nueva")) {
		listarTodo(request, response, new EntUsuario()); // Modal vacio
				}
		else if (operacion.equals("registrar")) {
					registrarUsuario(request, response);
		} else if (operacion.equals("editar")) {
					cargarUsuarioParaEditar(request, response);
		} else if (operacion.equals("Actualizar")) {
					actualizarUsuario(request, response);
		} else if (operacion.equalsIgnoreCase("Eliminar")) {
					EliminarUsuario(request, response);
		}
        // TODO Auto-generated constructor stub
    }
		
		private void EliminarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
			try {
				int id = Integer.parseInt(request.getParameter("id"));
				daoUsu.EliminarUsuario(id);
				response.sendRedirect("gestionUsuario?operacion=listar");
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("gestionUsuario?operacion=listar&error=Eliminar");
			}
			
		}
		
		private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
			try {
				EntUsuario z = extraerDatosFormulario(request,"Actualizar");
				daoUsu.actualizarUsuario(z);
				response.sendRedirect("gestionUsuario?operacion=listar");
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("gestionUsuario?operacion=listar&error=Actualizar");
			}
			
		}
		
		private void cargarUsuarioParaEditar(HttpServletRequest request, HttpServletResponse response) throws IOException {
			try {
				int id = Integer.parseInt(request.getParameter("id"));
				EntUsuario zap = daoUsu.BuscaUsuario(id);
				listarTodo(request, response, zap); // con datos de edicion
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("gestionUsuario?operacion=listar&error=buscar");
			}
			
		}
		
		private void registrarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
			//Metodo para registrar

			try {
						EntUsuario z = extraerDatosFormulario(request,"registrar");
						daoUsu.registrarUsuario(z);
						response.sendRedirect("gestionUsuario?operacion=listar");
					} catch (Exception e) {
						e.printStackTrace();
						response.sendRedirect("gestionUsuario?operacion=listar&error=registro");
					}
			
		}
		
		private void listarTodo(HttpServletRequest request, HttpServletResponse response, EntUsuario usuEditar) throws IOException {
			try {
				List<EntUsuario> lista = daoUsu.ListarUsuarios();

				request.setAttribute("listausuarios", lista);


				if (usuEditar != null) {
					request.setAttribute("usuEditar", usuEditar);
				}

				request.getRequestDispatcher("MantUsuario.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendError(500, "Error al cargar datos");
			}
			
		}
		
		private EntUsuario extraerDatosFormulario(HttpServletRequest request, String operacion) {
			EntUsuario z = new EntUsuario();
		
			
			if ("Actualizar".equals(operacion)) {
		        String id = request.getParameter("codigo");
		        if (id != null && !id.isEmpty()) {
		            z.setIdUsuario(Integer.parseInt(id));
		        }
		    }
			z.setNombreUsu(request.getParameter("nombre"));
			z.setApellidoUsu(request.getParameter("apellido"));
			z.setDni(request.getParameter("dni"));
			z.setTelefono(request.getParameter("telefono"));
			z.setDireccionUsu(request.getParameter("direccion"));
			z.setNickUsu(request.getParameter("nickUsu"));
			z.setPasswordUsu(request.getParameter("password"));
			z.setRol("EMP");

			return z;
		}

}
