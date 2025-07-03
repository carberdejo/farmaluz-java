package controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAOCliente;
import model.EntCliente;

/**
 * Servlet implementation class ServletCliente
 */
public class ServletCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
	EntCliente cli=new EntCliente();
	DAOCliente dao=new DAOCliente();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletCliente() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		//crud registrar, actualizar, eliminar
		//listado...jsp
	String accion=request.getParameter("operacion");
	//Declarar variables para obtener los datos de cada caja de texto
	String cod=request.getParameter("codigo");
	String nombre=request.getParameter("nombre");
	String apellido=request.getParameter("apellido");
	String dni=request.getParameter("dni");
	String telefono=request.getParameter("telefono");
	
		String title="OHH....",
			text="Ocurrio error",
	        icon="error";
	try {
	if(accion!=null && accion.equalsIgnoreCase("Agregar")) {
		//setear 
		cli.setNombreClien(nombre);
		cli.setApellidoClien(apellido);
		cli.setDniClien(dni);
		cli.setTelefonoClien(telefono);
		
		//INVOCAR AL METODO CRUD
		dao.registrarCliente(cli);

		       title="!aviso¡";
				text="Cliente registrado correctamente";
		        icon="success";
		        ListarTodo(request,response);
				return;
	}else if(accion!=null && accion.equalsIgnoreCase("listar")) {
		
	    ListarTodo(request,response);
		return;
		
	}
	else if(accion!=null && accion.equalsIgnoreCase("Actualizar")) {
		cli.setIdCliente(cod);
		cli.setNombreClien(nombre);
		cli.setApellidoClien(apellido);
		cli.setDniClien(dni);
		cli.setTelefonoClien(telefono);
		//INVOCAR AL METODO CRUD
		dao.actualizarCliente(cli);
		       title="!aviso¡";
				text="Cliente actualizado correctamente";
		        icon="success";
		        ListarTodo(request,response);
				return;
	}else if(accion!=null && accion.equalsIgnoreCase("Eliminar")) {
		cli.setIdCliente(cod);
		dao.EliminarCliente(cli);
		title="!aviso¡";
		text="Cliente eliminado correctamente";
        icon="success";
        ListarTodo(request,response);
		return;
	}
	else
	{
		throw new IllegalArgumentException("Accion no valida...."+accion);
	}
	
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	//creando atributos de tipo sesion
	request.getSession().setAttribute("title", title);
	request.getSession().setAttribute("text", text);
	request.getSession().setAttribute("icon", icon);
	response.sendRedirect("MantClientes.jsp");
	
	
		 
	}

	private void ListarTodo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			List<EntCliente>lista = dao.ListarClientes();
			request.setAttribute("listaCli", lista);
			request.getRequestDispatcher("MantClientes.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
    

}
