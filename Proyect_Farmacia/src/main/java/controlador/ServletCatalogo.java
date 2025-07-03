package controlador;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.DAOFiltros;
import dao.DAOListado;
import dao.DAOProductos;
import model.DTOProducto;
import model.EntCategoria;
import model.EntLaboratorio;
import model.EntProducto;
import model.Pedido;


/**
 * Servlet implementation class ServletCatalogo
 */
public class ServletCatalogo extends HttpServlet {
	private static final long serialVersionUID = 1L;
     DAOListado daoListado = new DAOListado();
     DAOProductos daoPro = new DAOProductos();
     DAOFiltros daoFiltros = new DAOFiltros();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletCatalogo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("operacion");
		
		if (accion == null || accion.equals("listar")) {
			System.out.println("soy null o listar");
			listarTodo(request, response, null);
			
		}else if(accion.equalsIgnoreCase("agregarPedido")) {
			AgregarPedido(request,response);
		}else if(accion.equalsIgnoreCase("eliminarPedido")) {
			EliminarPedido(request,response);
		}else if(accion.equalsIgnoreCase("detalle")) {
			DetalleStock(request,response);
		}
	}
	
	private void DetalleStock(HttpServletRequest request, HttpServletResponse response) {
		try {
			String id = request.getParameter("iddetalle");
			if(id!= null) {
				int idpro = Integer.parseInt(id);
				EntProducto producto = daoPro.BuscaProducto(idpro);
				if(producto != null) {
					request.setAttribute("producto", producto);
					request.getRequestDispatcher("DetalleCatalogo.jsp").forward(request, response);
				}			
			}else {
				response.sendRedirect("gestionCatalogo?operacion=listar&error=buscar");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	private void EliminarPedido(HttpServletRequest request, HttpServletResponse response) {
		try {
			String idString = request.getParameter("id");
			if(idString != null) {
				int idPro = Integer.parseInt(idString);
				HttpSession session = request.getSession();
				List<Pedido> lista = (List<Pedido>) session.getAttribute("listapedidos");
				if(lista != null) {
					Iterator<Pedido> iter = lista.iterator();
					while (iter.hasNext()) {
						Pedido p = iter.next();
					    if (p.getIdPro() == idPro) {
					        iter.remove();
					    }
					}
					session.setAttribute("mensaje", "Producto eliminado del pedido.");
				}
				response.sendRedirect("Venta.jsp");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

	private void AgregarPedido(HttpServletRequest request, HttpServletResponse response) {
		try {
			String id = request.getParameter("id");
			String cant = request.getParameter("cantidad");
			System.out.println("Estoy agregando pedido "+id+" "+cant);
			
			if(id != null && cant != null) {
				int idPro = Integer.valueOf(id);
				int cantidad = Integer.valueOf(cant);
				
				HttpSession sesion = request.getSession();
				List<Pedido>lista = (List<Pedido>) sesion.getAttribute("listapedidos");
				
				if(lista == null) {
					lista = new ArrayList<Pedido>();
				}
				int cantNueva = cantidad;
						
				for (Pedido p : lista) {
						if(p.getIdPro() == idPro) {
							cantNueva += p.getCantidad();
							break;
						}
				}
				Pedido pro = daoFiltros.crearPedido(idPro, cantNueva);
				
				if(pro == null) {
					response.sendRedirect("gestionCatalogo?operacion=listar&error=pedido");
				}
				
				
				//validar
				boolean validar = false;
				for (Pedido p : lista) {
					if(p.getIdPro() == pro.getIdPro()) {
						p.setCantidad(pro.getCantidad());
						validar = true;
						break;					
					}
				}
				
				if(!validar) {
					lista.add(pro);
					sesion.setAttribute("mensaje", "Producto agregado correctamente.");
				}else {
					sesion.setAttribute("mensaje", "Cantidad agregada al producto existente");
				}
				
				sesion.setAttribute("listapedidos", lista);
				response.sendRedirect("gestionCatalogo?operacion=listar");
				
			}else {
				response.sendRedirect("gestionCatalogo?operacion=listar&error=buscar");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		
	}

	private void listarTodo(HttpServletRequest request, HttpServletResponse response, EntProducto productoEditar) throws IOException {
		try {
			String idCat = request.getParameter("id_cate");
			String id_lab = request.getParameter("id_lab");
			String nom_pro = request.getParameter("nom_pro");
			System.out.println("idCat: "+idCat+" id_lab: "+id_lab+" nom_pro: "+nom_pro);
			
			List<EntCategoria> cate = daoListado.listaCategoria();
			List<EntLaboratorio> lab = daoListado.listaLaboratorio();
			
			request.setAttribute("listaCategoria", cate);
			request.setAttribute("listaLaboratorio", lab);
			

			Integer cat = (idCat != null && !idCat.isEmpty()) ? Integer.parseInt(idCat) : null;
			Integer idlab = (id_lab != null && !id_lab.isEmpty()) ? Integer.parseInt(id_lab) : null;
			System.out.println("cat: "+cat+" idlab: "+idlab+" nom_pro: "+nom_pro);
			
			List<DTOProducto>listaproductos = daoFiltros.listaFiltros(cat, idlab, nom_pro);
			request.setAttribute("listaproductos", listaproductos);
			
			request.getRequestDispatcher("CatalogoProducto.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(500, "Error al cargar datos");
		}
		
	}

}
