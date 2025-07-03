package model;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "tb_Detallecomprobante")
@NamedQuery(name = "EntDetalleCDP.findAll",query = "Select u from EntDetalleCDP u")
public class EntDetalleCDP {

	@EmbeddedId
	private DetalleCDPid id;
	
	@ManyToOne
	@MapsId("comprobante")
	@JoinColumn(name = "id_cdp")
	private EntComprobante comprobante;
	
	@ManyToOne
	@MapsId("producto")
	@JoinColumn(name = "id_pro")
	private EntProducto producto;
	
	private int cantidad;
	private double importe;
	
	public EntDetalleCDP() {
		super();
	}
	public EntDetalleCDP(DetalleCDPid id, EntComprobante comprobante, EntProducto producto, int cantidad, 
			double importe) {
		super();
		this.id = id;
		this.comprobante = comprobante;
		this.producto = producto;
		this.cantidad = cantidad;
		this.importe = importe;
	}
	public DetalleCDPid getId() {
		return id;
	}
	public void setId(DetalleCDPid id) {
		this.id = id;
	}
	public EntComprobante getComprobante() {
		return comprobante;
	}
	public void setComprobante(EntComprobante comprobante) {
		this.comprobante = comprobante;
	}
	public EntProducto getProducto() {
		return producto;
	}
	public void setProducto(EntProducto producto) {
		this.producto = producto;
	}
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public double getImporte() {
		return importe;
	}
	public void setImporte(double importe) {
		this.importe = importe;
	}
	
	
	
}
