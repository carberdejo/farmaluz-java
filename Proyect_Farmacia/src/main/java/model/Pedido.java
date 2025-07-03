package model;

public class Pedido {
	private int idPro,cantidad;
	private String name_pro;
	private double precio,importe;
	
	public Pedido(int idPro, int cantidad, String name_pro, double precio) {
		super();
		this.idPro = idPro;
		this.cantidad = cantidad;
		this.name_pro = name_pro;
		this.precio = precio;
	}
	
	public int getIdPro() {
		return idPro;
	}
	public void setIdPro(int idPro) {
		this.idPro = idPro;
	}
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public String getName_pro() {
		return name_pro;
	}
	public void setName_pro(String name_pro) {
		this.name_pro = name_pro;
	}
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	public double getImporte() {
		return precio*cantidad;
	}
	public void setImporte(double importe) {
		this.importe = importe;
	}
	
	
}
