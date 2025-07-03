package controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAOListado;
import dao.DAOReporte;
import model.EntCategoria;
import model.EntLaboratorio;
import model.EntProveedor;
import model.VentaXCategoriaDTO;
import model.AnalisisLabDTO;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


/**
 * Servlet implementation class ServletReporte
 */
public class ServletReporte extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DAOReporte daoR= new DAOReporte();
	DAOListado daoL=new DAOListado(); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletReporte() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String accion = request.getParameter("operacion");
	
		if(accion.equals("Report1")) {
			System.out.println("Listo para Reporte 1");
			Reporte1(request, response, null);
		}else if(accion.equals("Report2")) {
			System.out.println("Listo para Reporte 2");
			Reporte2(request, response, null);
		}
		if("excel1".equalsIgnoreCase(accion)) {
			List<VentaXCategoriaDTO>lista =daoR.ReporteXCategoria();
			generarExcel1(lista, response);
			return;
		}else if("excel2".equalsIgnoreCase(accion)) {
			List<AnalisisLabDTO>lista =daoR.AnalisisLab();
			generarExcel2(lista, response);
			return;
		}

	}
    

   
	private void Reporte2(HttpServletRequest request, HttpServletResponse response, Object object) throws IOException {
		try {
			List<AnalisisLabDTO> lista = daoR.AnalisisLab();
			request.setAttribute("Reporte2Listo", lista);
			
			request.getRequestDispatcher("ReporteLabo.jsp").forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
			response.sendError(500, "No pudimos generar el reporte");
		}
	}

	private void Reporte1(HttpServletRequest request, HttpServletResponse response, Object object) throws IOException{
		// TODO Auto-generated method stub
		try {
			List<VentaXCategoriaDTO> lista = daoR.ReporteXCategoria();
			request.setAttribute("ReporteListo", lista);
			
			request.getRequestDispatcher("ReporteCate.jsp").forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
			response.sendError(500, "No pudimos generar el reporte");
	}
		}
	

	private void generarExcel1(List<VentaXCategoriaDTO> lista, HttpServletResponse response) throws IOException {
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=Reporte de Ventas por Categoria.xlsx");
		
		//Crear un objeto para el libro
		Workbook libro = new XSSFWorkbook();
		// CREANDO LA HOJA
		Sheet hoja = libro.createSheet("Reportes de Venta de Categoria");
	    CellStyle estiloEncabezado = libro.createCellStyle();
	    Font fontNegrita = libro.createFont();
	    fontNegrita.setBold(true);
	    estiloEncabezado.setFont(fontNegrita);
	    estiloEncabezado.setAlignment(HorizontalAlignment.CENTER);
	    estiloEncabezado.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
	    estiloEncabezado.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    estiloEncabezado.setBorderTop(BorderStyle.THIN);
	    estiloEncabezado.setBorderBottom(BorderStyle.THIN);
	    estiloEncabezado.setBorderLeft(BorderStyle.THIN);
	    estiloEncabezado.setBorderRight(BorderStyle.THIN);
	    
		CellStyle borderedStyle = libro.createCellStyle();
		
		borderedStyle.setBorderTop(BorderStyle.THIN);
		borderedStyle.setBorderBottom(BorderStyle.THIN);
		borderedStyle.setBorderLeft(BorderStyle.THIN);
		borderedStyle.setBorderRight(BorderStyle.THIN);
		
		//declarar un objeto fila
		org.apache.poi.ss.usermodel.Row encabezado= hoja.createRow(0);
			//crear las columnas
		String columnas[]= {"Codigo","Nombre","Cant.Total Vendida","Importe","Producto Mas Vendido"};
		  Row filaEncabezado = hoja.createRow(0);
		//mediante un recorrido vamos a contar la cantidad de columnas
		  for (int i = 0; i < columnas.length; i++) {
		        Cell celda = filaEncabezado.createCell(i);
		        celda.setCellValue(columnas[i]);
		        celda.setCellStyle(estiloEncabezado);
		    }
		//declarar una vavariable para sumar las filas
		int numfila = 1;
		//hacer uso del for each
		for (VentaXCategoriaDTO v : lista) {
			//declarando un objeto para la fila
			org.apache.poi.ss.usermodel.Row filita = hoja.createRow(numfila++);
			//asignar los datos a filita
	        Cell celda0 = filita.createCell(0);
	        celda0.setCellValue(v.getId_cat());
	        celda0.setCellStyle(borderedStyle);

	        Cell celda1 = filita.createCell(1);
	        celda1.setCellValue(v.getName_cate());
	        celda1.setCellStyle(borderedStyle);

	        Cell celda2 = filita.createCell(2);
	        celda2.setCellValue(v.getTotal());
	        celda2.setCellStyle(borderedStyle);

	        Cell celda3 = filita.createCell(3);
	        celda3.setCellValue(v.getImporte());
	        celda3.setCellStyle(borderedStyle);

	        Cell celda4 = filita.createCell(4);
	        celda4.setCellValue(v.getVendido());
	        celda4.setCellStyle(borderedStyle);
		}
	    for (int i = 0; i < columnas.length; i++) {
	        hoja.autoSizeColumn(i);
	    }
		//vamos a escribir el libro
		libro.write(response.getOutputStream());
		//cerrar el libro
		libro.close();
	}
    private void generarExcel2(List<AnalisisLabDTO> lista, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=Reporte de Analisis de Laboratorio.xlsx");
		
		//Crear un objeto para el libro
		Workbook libro = new XSSFWorkbook();
		// CREANDO LA HOJA
		Sheet hoja = libro.createSheet("Analisis Laboratorio");
	    CellStyle estiloEncabezado = libro.createCellStyle();
	    Font fontNegrita = libro.createFont();
	    fontNegrita.setBold(true);
	    estiloEncabezado.setFont(fontNegrita);
	    estiloEncabezado.setAlignment(HorizontalAlignment.CENTER);
	    estiloEncabezado.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
	    estiloEncabezado.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    estiloEncabezado.setBorderTop(BorderStyle.THIN);
	    estiloEncabezado.setBorderBottom(BorderStyle.THIN);
	    estiloEncabezado.setBorderLeft(BorderStyle.THIN);
	    estiloEncabezado.setBorderRight(BorderStyle.THIN);
	    
		CellStyle borderedStyle = libro.createCellStyle();
		
		borderedStyle.setBorderTop(BorderStyle.THIN);
		borderedStyle.setBorderBottom(BorderStyle.THIN);
		borderedStyle.setBorderLeft(BorderStyle.THIN);
		borderedStyle.setBorderRight(BorderStyle.THIN);
		
		//declarar un objeto fila
		org.apache.poi.ss.usermodel.Row encabezado= hoja.createRow(0);
			//crear las columnas
		String columnas[]= {"Codigo Laboratorio","Laboratorio","Stock Total","Cant.Productos Unicos","Ultima fecha ingresada","Producto mas caro","Precio promedio"};
		  Row filaEncabezado = hoja.createRow(0);
		//mediante un recorrido vamos a contar la cantidad de columnas
		  for (int i = 0; i < columnas.length; i++) {
		        Cell celda = filaEncabezado.createCell(i);
		        celda.setCellValue(columnas[i]);
		        celda.setCellStyle(estiloEncabezado);
		    }
		//declarar una vavariable para sumar las filas
		int numfila = 1;
		//hacer uso del for each
		for (AnalisisLabDTO v : lista) {
			//declarando un objeto para la fila
			org.apache.poi.ss.usermodel.Row filita = hoja.createRow(numfila++);
			//asignar los datos a filita
	        Cell celda0 = filita.createCell(0);
	        celda0.setCellValue(v.getId_lab());
	        celda0.setCellStyle(borderedStyle);

	        Cell celda1 = filita.createCell(1);
	        celda1.setCellValue(v.getNom_lab());
	        celda1.setCellStyle(borderedStyle);

	        Cell celda2 = filita.createCell(2);
	        celda2.setCellValue(v.getStockTot());
	        celda2.setCellStyle(borderedStyle);

	        Cell celda3 = filita.createCell(3);
	        celda3.setCellValue(v.getCantProd());
	        celda3.setCellStyle(borderedStyle);

	        Cell celda4 = filita.createCell(4);
	        celda4.setCellValue(v.getfEnt());
	        celda4.setCellStyle(borderedStyle);
	        
	        Cell celda5 = filita.createCell(5);
	        celda5.setCellValue(v.getProdCaro());
	        celda5.setCellStyle(borderedStyle);
	        
	        Cell celda6 = filita.createCell(6);
	        celda6.setCellValue(v.getPrePromedio());
	        celda6.setCellStyle(borderedStyle);
		}
	    for (int i = 0; i < columnas.length; i++) {
	        hoja.autoSizeColumn(i);
	    }
		//vamos a escribir el libro
		libro.write(response.getOutputStream());
		//cerrar el libro
		libro.close();
	}

	
}
