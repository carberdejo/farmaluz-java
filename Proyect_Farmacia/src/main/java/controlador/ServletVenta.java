package controlador;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.lowagie.text.Rectangle;

import dao.DAOVenta;
import model.EntCliente;
import model.EntComprobante;
import model.EntDetalleCDP;
import model.EntNotificacion;
import model.EntUsuario;
import model.Pedido;

/**
 * Servlet implementation class ServletVenta
 */
public class ServletVenta extends HttpServlet {
	private static final long serialVersionUID = 1L;
    DAOVenta daoVenta = new DAOVenta(); 
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletVenta() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String accion = request.getParameter("operacion");
		
		if (accion == null || accion.equals("listclientes")) {
			System.out.println("soy null o listar");
			listarClientes(request, response, null);
			
		}else if(accion.equalsIgnoreCase("venta")) {
			RegistrarVenta(request,response);
		}
		else if(accion.equalsIgnoreCase("registrar")) {
			System.out.println("estoy registrando");
			RegistrarClienteVenta(request,response);
		}else if(accion.equalsIgnoreCase("cancelar")) {
			CancelarVenta(request,response);
		}
		else if(accion.equalsIgnoreCase("exportarpdf")) {
			ExportarPDF(request,response);
		}
	}

	private void CancelarVenta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("listapedidos");
		session.removeAttribute("listaclientes");
		request.getRequestDispatcher("gestionCatalogo?operacion=listar").forward(request, response);
		
	}

	private void RegistrarClienteVenta(HttpServletRequest request, HttpServletResponse response) {
		try {
			String nombre=request.getParameter("nombre");
			String apellido=request.getParameter("apellido");
			String dni=request.getParameter("dni");
			String telefono=request.getParameter("telefono");
			
			System.out.println("nombre "+nombre+" apellido "+apellido+" dni "+dni+" telefono "+telefono);
			EntCliente cli = new EntCliente();
			cli.setNombreClien(nombre);
			cli.setApellidoClien(apellido);
			cli.setDniClien(dni);
			cli.setTelefonoClien(telefono);
			EntCliente cliente = daoVenta.registrarClienteVenta(cli);
			List<EntCliente> listaClientes = new ArrayList<EntCliente>();
			listaClientes.add(cliente);
			request.getSession().setAttribute("listaclientes", listaClientes);
			System.out.println("Cliente listo para comprar");
			request.getRequestDispatcher("Venta.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	private void RegistrarVenta(HttpServletRequest request, HttpServletResponse response) {
		try {
			String idcliente = request.getParameter("cliente");
			String tipo = request.getParameter("tipo");
			
			if(tipo != null) {
					
				HttpSession session = request.getSession();
				EntUsuario usuario = (EntUsuario) session.getAttribute("empleado");
				List<Pedido>lista = (List<Pedido>) session.getAttribute("listapedidos");
				
				EntComprobante com = new EntComprobante();
				com.setTipo(tipo);
				if(tipo.equals("BOLETA")) {
					if ( idcliente != null && !idcliente.isEmpty() ) {
						com.setCliente(new EntCliente(idcliente));
					}else {
						System.out.println("Ingrese cliente");
						request.getRequestDispatcher("Venta.jsp").forward(request, response);
						return;
					}
					
				}
				com.setUsuario(usuario);
				//formato fecha
				Date todayDate = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String fechaActual = sdf.format(todayDate);
				com.setFecha(fechaActual);
				
				int cdp = daoVenta.registrarCompra(com, lista,usuario);
				System.out.println("Compra realizada");
				
				session.removeAttribute("listapedidos");
				request.setAttribute("mensaje", "Compra realizada");
				request.setAttribute("idventa",cdp);
				request.getRequestDispatcher("Venta.jsp").forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

	private void listarClientes(HttpServletRequest request, HttpServletResponse response, Object object) throws ServletException, IOException {
		String name = request.getParameter("nomcliente");
		if( name !=null ) {
			List<EntCliente>lista = daoVenta.buscarClienteName(name);
			HttpSession sesion = request.getSession();
			sesion.setAttribute("listaclientes", lista);
			request.getRequestDispatcher("Venta.jsp").forward(request, response);
		}
		
	}
	
	private void ExportarPDF(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment;filename=CDP.pdf");
		try {
	        String id = request.getParameter("id_ven");
	        if (id != null) {
	            int notiId = Integer.parseInt(id);
	            EntComprobante com = daoVenta.buscarComprobante(notiId);

	            if (com != null) {
	                List<EntDetalleCDP> detalles = daoVenta.buscarDetalleComprobante(notiId);

	                Document doc = new Document(PageSize.A4, 40, 40, 40, 40);
	                PdfWriter.getInstance(doc, response.getOutputStream());
	                doc.open();

	                BaseColor azul = new BaseColor(173, 216, 230); // Azul suave

	                Font titleFont = new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD, BaseColor.BLACK);
	                Font labelFont = new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD);
	                Font valueFont = new Font(Font.FontFamily.HELVETICA, 11);
	                Font tableHeaderFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.WHITE);
	                Font tableCellFont = new Font(Font.FontFamily.HELVETICA, 10);

	                // Título y número factura
	                PdfPTable headerTable = new PdfPTable(2);
	                headerTable.setWidthPercentage(100);
	                headerTable.setWidths(new int[]{60, 40});

	                PdfPCell logoCell = new PdfPCell(new Phrase("FARMALUZ", titleFont));
	                logoCell.setBorder(Rectangle.NO_BORDER);
	                logoCell.setVerticalAlignment(Element.ALIGN_TOP);

	                PdfPCell facturaCell = new PdfPCell();
	                facturaCell.addElement(new Paragraph(com.getTipo(), titleFont));
	                facturaCell.addElement(new Paragraph("N° " + com.getId_cdp(), valueFont));
	                facturaCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	                facturaCell.setBorder(Rectangle.NO_BORDER);
	                facturaCell.setVerticalAlignment(Element.ALIGN_TOP);

	                headerTable.addCell(logoCell);
	                headerTable.addCell(facturaCell);
	                doc.add(headerTable);
	                doc.add(Chunk.NEWLINE);

	                // Información de contacto
	                PdfPTable infoTable = new PdfPTable(2);
	                infoTable.setWidthPercentage(100);
	                infoTable.setSpacingBefore(10f);
	                infoTable.setSpacingAfter(10f);
	                infoTable.setWidths(new float[]{30, 70});

	                // Cabecera de info
	                PdfPCell infoHeader = new PdfPCell(new Phrase("INFORMACIÓN DE CONTACTO", labelFont));
	                infoHeader.setColspan(2);
	                infoHeader.setBackgroundColor(azul);
	                infoHeader.setPadding(6f);
	                infoTable.addCell(infoHeader);

	                // Datos del cliente
	                String nombre = (com.getCliente() != null) ? com.getCliente().getNombreClien() + " " + com.getCliente().getApellidoClien() : "Boleta Simple";
	                String telefono = (com.getCliente() != null) ? com.getCliente().getTelefonoClien() : "N/A";
	                
	                infoTable.addCell(new Phrase("Fecha:", labelFont));
	                infoTable.addCell(new Phrase(com.getFecha(), valueFont));
	                
	                infoTable.addCell(new Phrase("Empleado:", labelFont));
	                infoTable.addCell(new Phrase(com.getUsuario().getNombreUsu()+" "+com.getUsuario().getApellidoUsu(), valueFont));
	                
	                infoTable.addCell(new Phrase("Cliente:", labelFont));
	                infoTable.addCell(new Phrase(nombre, valueFont));

	                infoTable.addCell(new Phrase("Teléfono:", labelFont));
	                infoTable.addCell(new Phrase(telefono, valueFont));

	                doc.add(infoTable);

	                // Tabla de productos
	                PdfPTable tabla = new PdfPTable(4);
	                tabla.setWidthPercentage(100);
	                tabla.setWidths(new float[]{5f, 2f, 2f, 2f});

	                String[] headers = {"DESCRIPCIÓN", "CANTIDAD", "PRECIO","IMPORTE"};
	                for (String header : headers) {
	                    PdfPCell cell = new PdfPCell(new Phrase(header, tableHeaderFont));
	                    cell.setBackgroundColor(azul.darker());
	                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	                    cell.setPadding(5f);
	                    tabla.addCell(cell);
	                }

	                double total = 0;
	                for (EntDetalleCDP det : detalles) {
	                    tabla.addCell(new PdfPCell(new Phrase(det.getProducto().getName_pro(), tableCellFont)));
	                    tabla.addCell(new PdfPCell(new Phrase(String.valueOf(det.getCantidad()), tableCellFont)));
	                    tabla.addCell(new PdfPCell(new Phrase("S/ " + String.format("%.2f", det.getProducto().getPrecio(), tableCellFont))));
	                    tabla.addCell(new PdfPCell(new Phrase("S/ " + String.format("%.2f", det.getImporte()), tableCellFont)));
	                    total += det.getImporte();
	                }

	                doc.add(tabla);

	                // Total final
	                PdfPTable totalTable = new PdfPTable(2);
	                totalTable.setWidthPercentage(100);
	                totalTable.setWidths(new float[]{80, 20});
	                PdfPCell empty = new PdfPCell(new Phrase(""));
	                empty.setBorder(Rectangle.NO_BORDER);
	                totalTable.addCell(empty);

	                PdfPCell totalCell = new PdfPCell(new Phrase("TOTAL: S/ " + String.format("%.2f", total), labelFont));
	                totalCell.setBackgroundColor(azul);
	                totalCell.setHorizontalAlignment(Element.ALIGN_CENTER);
	                totalCell.setPadding(10f);
	                totalTable.addCell(totalCell);

	                doc.add(totalTable);

	                // Footer con datos ficticios
	                doc.add(Chunk.NEWLINE);
	                Paragraph footer = new Paragraph("1234-5678\nhola@sFarmaluz.com\nLos Postes 241, SJL\nwww.Farmaluz.com", new Font(Font.FontFamily.HELVETICA, 9, Font.ITALIC));
	                footer.setAlignment(Element.ALIGN_CENTER);
	                doc.add(footer);

	                doc.close();
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }		

		
	}

}
