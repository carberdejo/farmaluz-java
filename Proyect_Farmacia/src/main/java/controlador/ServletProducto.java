package controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAOListado;
import dao.DAOProductos;
import model.*;

/**
 * Servlet implementation class ServletProducto
 */
public class ServletProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private DAOListado daoListado = new DAOListado();
    private DAOProductos daoPro = new DAOProductos();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletProducto() {
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
			System.out.println("spy null o listart");
		} 
		else if (operacion.equals("nueva")) {
		listarTodo(request, response, new EntProducto()); // Modal vacío
				}
		else if (operacion.equals("registrar")) {
					registrarProducto(request, response);
		} else if (operacion.equals("editar")) {
					cargarProductoParaEditar(request, response,null);
		} else if (operacion.equals("actualizar")) {
					actualizarProducto(request, response);
		} else if (operacion.equals("eliminar")) {
					eliminarProducto(request, response);
		}else if (operacion.equals("detail")) {
			cargarProductoParaEditar(request, response,"detail");
		}else if (operacion.equals("agregarStock")) {
			ActualizarStock(request, response);
		}
		
	}
	
	private void ActualizarStock(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = request.getParameter("id");
		String cant = request.getParameter("cantidad");
		
		try {
			if(id!=null && cant != null && !cant.isEmpty()) {
				int cantidad = Integer.parseInt(cant);
				int idPro = Integer.parseInt(id);
				
				int stock = daoPro.ActualizarStock(idPro, cantidad);
				
				if(stock > 0) {
					cargarProductoParaEditar(request, response,"detail");
				}
				
			}else {
				response.sendRedirect("gestionProducto?operacion=listar&error=null");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("gestionProducto?operacion=listar&error=agregarStock");
		}
		
	}

	private void eliminarProducto(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			daoPro.EliminarProducto(id);
			response.sendRedirect("gestionProducto?operacion=listar");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("gestionProducto?operacion=listar&error=eliminar");
		}
		
	}

	private void actualizarProducto(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			EntProducto z = extraerDatosFormulario(request,"actualizar");
			daoPro.actualizarProducto(z);
			response.sendRedirect("gestionProducto?operacion=listar");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("gestionProducto?operacion=listar&error=actualizar");
		}
		
	}

	private void cargarProductoParaEditar(HttpServletRequest request, HttpServletResponse response,String Details) throws IOException {
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			EntProducto zap = daoPro.BuscaProducto(id);
			if(Details != null) {
				request.setAttribute("producto",zap );
				request.getRequestDispatcher("DetalleProducto.jsp").forward(request, response);
				return;
			}
			listarTodo(request, response, zap); // con datos de edición
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("gestionProducto?operacion=listar&error=buscar");
		}
		
		
	}

	private void registrarProducto(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//Metodo para registrar

		try {
					EntProducto z = extraerDatosFormulario(request,"registrar");
					daoPro.registrarProducto(z);
					response.sendRedirect("gestionProducto?operacion=listar");
				} catch (Exception e) {
					e.printStackTrace();
					response.sendRedirect("gestionProducto?operacion=listar&error=registro");
				}
		
	}

	private void listarTodo(HttpServletRequest request, HttpServletResponse response, EntProducto productoEditar) throws IOException {
		try {
			List<EntProducto> lista = daoPro.ListarProductos();
			List<EntCategoria> cate = daoListado.listaCategoria();
			List<EntLaboratorio> lab = daoListado.listaLaboratorio();
			List<EntProveedor> prov = daoListado.listaProveedor();


			request.setAttribute("listaproductos", lista);
			request.setAttribute("listaCategoria", cate);
			request.setAttribute("listaLaboratorio", lab);
			request.setAttribute("listaProveedor", prov);

			if (productoEditar != null) {
				request.setAttribute("productoEditar", productoEditar);
			}

			request.getRequestDispatcher("MantProductos.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(500, "Error al cargar datos");
		}
		
	}
	
	private EntProducto extraerDatosFormulario(HttpServletRequest request, String operacion) {
		EntProducto z = new EntProducto();
	
		// Solo incluir el código si estamos actualizando
		if ("actualizar".equals(operacion)) {
	        String codigo = request.getParameter("codigo");
	        if (codigo != null && !codigo.isEmpty()) {
	            z.setId_produc(Integer.parseInt(codigo));
	        }
	        z.setFec_entrada(request.getParameter("fec_inicio"));
	        z.setFec_ultimo(request.getParameter("fec_ultimo"));
	    }
		z.setName_pro(request.getParameter("nombre"));
		z.setDescripcion(request.getParameter("descripcion"));
		z.setPrecio(Double.parseDouble(request.getParameter("precio")));
		z.setStock(Integer.parseInt(request.getParameter("stock")));

		z.setCategoria(new EntCategoria(Integer.parseInt(request.getParameter("categoria"))));
		z.setLaboratorio(new EntLaboratorio(Integer.parseInt(request.getParameter("laboratorio"))));
		z.setProveedor(new EntProveedor(Integer.parseInt(request.getParameter("proveedor"))));

		return z;
	}

}
