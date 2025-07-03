package controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.DAOProveedor;
import model.*;
/**
 * Servlet implementation class ServletProveedor
 */
public class ServletProveedor extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DAOProveedor daoProv = new DAOProveedor();
	
	  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletProveedor() {
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
		} else if (operacion.equals("nuevo")) {
			listarTodo(request, response, new EntProveedor()); // Modal vacío
		} else if (operacion.equals("registrar")) {
			registrarProveedor(request, response);
		} else if (operacion.equals("editar")) {
			cargarProveedorParaEditar(request, response);
		} else if (operacion.equals("actualizar")) {
			actualizarProveedor(request, response);
		} else if (operacion.equals("eliminar")) {
			eliminarProveedor(request, response);
		}
	}

	
	private void eliminarProveedor(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			daoProv.eliminarProveedor(id);
			response.sendRedirect("gestionProveedor?operacion=listar");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("gestionProveedor?operacion=listar&error=eliminar");
		}
	}

	private void actualizarProveedor(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		try {
			EntProveedor actualizado = extraerDatosFormulario(request, "actualizar");
			daoProv.actualizarProveedor(actualizado);
			response.sendRedirect("gestionProveedor?operacion=listar");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("gestionProveedor?operacion=listar&error=actualizar");
		}
	}

	private void cargarProveedorParaEditar(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			EntProveedor proveedor = daoProv.BuscaProveedor(id);
			listarTodo(request, response, proveedor);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("gestionProveedor?operacion=listar&error=editar");
		}
	}

	private void registrarProveedor(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		try {
			EntProveedor nuevo = extraerDatosFormulario(request, "registrar");
			daoProv.registrarProveedor(nuevo);
			response.sendRedirect("gestionProveedor?operacion=listar");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("gestionProveedor?operacion=listar&error=registro");
		}
	}

	private void listarTodo(HttpServletRequest request, HttpServletResponse response, EntProveedor proveedorEditar) throws IOException {
		// TODO Auto-generated method stub
		try {
			List<EntProveedor> lista = daoProv.ListarProveedor();
			request.setAttribute("listaProveedores", lista);

			if (proveedorEditar != null) {
				request.setAttribute("proveedorEditar", proveedorEditar);
			}

			request.getRequestDispatcher("MantProveedor.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(500, "Error al listar proveedores");
		}
		
	}
	
	private EntProveedor extraerDatosFormulario(HttpServletRequest request, String operacion) {
		EntProveedor z = new EntProveedor();

		if ("actualizar".equals(operacion)) {
			String id = request.getParameter("codigo");
			if (id != null && !id.isEmpty()) {
				z.setId_prov(Integer.parseInt(id));
			}
		}

		z.setName_prov(request.getParameter("nombre"));
		z.setNom_encargado(request.getParameter("nom_encargado"));
		z.setApe_encargado(request.getParameter("ape_encargado"));
		z.setRuc(request.getParameter("ruc"));
		z.setDireccion(request.getParameter("direccion"));
		z.setTelefono(request.getParameter("telefono"));
		z.setEmail(request.getParameter("email"));
		z.setFec_inicio(request.getParameter("fecha"));


		return z;
	}

}
