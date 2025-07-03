package model;

public class DTOProducto {

	private int id_produc;
	private String name_pro,descripcion,laboratorio,categoria;
	private double precio;
	private int stock;
	
	public DTOProducto(int id_produc, String name_pro, String descripcion, String laboratorio, String categoria,
			double precio, int stock) {
		super();
		this.id_produc = id_produc;
		this.name_pro = name_pro;
		this.descripcion = descripcion;
		this.laboratorio = laboratorio;
		this.categoria = categoria;
		this.precio = precio;
		this.stock = stock;
	}

	public int getId_produc() {
		return id_produc;
	}

	public void setId_produc(int id_produc) {
		this.id_produc = id_produc;
	}

	public String getName_pro() {
		return name_pro;
	}

	public void setName_pro(String name_pro) {
		this.name_pro = name_pro;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getLaboratorio() {
		return laboratorio;
	}

	public void setLaboratorio(String laboratorio) {
		this.laboratorio = laboratorio;
	}

	public String getCategoria() {
		return categoria;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}

	public double getPrecio() {
		return precio;
	}

	public void setPrecio(double precio) {
		this.precio = precio;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}
	
	
}

