package controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DAONotificacion;
import dao.DAOVenta;
import model.EntComprobante;
import model.EntDetalleCDP;
import model.EntNotificacion;
import model.EntUsuario;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.PageSize;

//Librerias para PDF
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
//Libreria para excel
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * Servlet implementation class ServletNotificacion
 */
public class ServletNotificacion extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DAONotificacion daoNotify = new DAONotificacion();
	DAOVenta daoVenta = new DAOVenta();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletNotificacion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("operacion");
		
		if(accion.equals("verNotify")) {
			System.out.println("VerNotificacion");
			VerNotificacion(request, response);
		}else if(accion.equals("exportpdf")){
			System.out.println("exportar pdf");
			ExportarPDF(request,response);
		}
	
	}

	private void ExportarPDF(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment;filename=CDP.pdf");
		try {
	        String id = request.getParameter("id_noti");
	        if (id != null) {
	            int notiId = Integer.parseInt(id);
	            EntNotificacion noti = daoNotify.buscarPorId(notiId);

	            if (noti != null) {
	                int idComprobante = noti.getObjetoId();
	                EntComprobante com = daoVenta.buscarComprobante(idComprobante);
	                List<EntDetalleCDP> detalles = daoVenta.buscarDetalleComprobante(idComprobante);

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

	private void VerNotificacion(HttpServletRequest request, HttpServletResponse response) {

		try {
			String id = request.getParameter("id_noti");
			
			if(id != null) {
				int idnoti = Integer.parseInt(id);
				EntNotificacion noti = daoNotify.buscarPorId(idnoti);
				if(noti != null) {
					if(noti.isLeido() != true) {
						daoNotify.marcarComoLeidasPorUsuario(idnoti);
						noti.setLeido(true);
						HttpSession session = request.getSession();
						EntUsuario usu = (EntUsuario)session.getAttribute("empleado");
						List<EntNotificacion>listaNoti = daoNotify.listarPorUsuario(usu.getIdUsuario());
						int cantinoti = daoNotify.contarNoLeidasPorUsuario(usu.getIdUsuario());
						
						session.setAttribute("noLeidas",cantinoti);
						session.setAttribute("notificaciones", listaNoti);
					}
					request.setAttribute("noti", noti);
		            request.getRequestDispatcher("VerNotificacion.jsp").forward(request, response);
				}
			}else {
				System.out.println("notificacion no existe");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
