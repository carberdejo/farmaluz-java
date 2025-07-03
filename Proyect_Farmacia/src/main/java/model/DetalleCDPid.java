package model;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
public class DetalleCDPid implements Serializable {
	
	private int comprobante;
	private int producto;
	
	public DetalleCDPid() {
		super();
	}

	public DetalleCDPid(int comprobante, int producto) {
		super();
		this.comprobante = comprobante;
		this.producto = producto;
	}

	public int getComprobante() {
		return comprobante;
	}

	public void setComprobante(int comprobante) {
		this.comprobante = comprobante;
	}

	public int getProducto() {
		return producto;
	}

	public void setProducto(int producto) {
		this.producto = producto;
	}
	
	 @Override
	    public boolean equals(Object o) {
	        if (this == o) return true;
	        if (!(o instanceof DetalleCDPid)) return false;
	        DetalleCDPid that = (DetalleCDPid) o;
	        return comprobante == that.comprobante &&
	               producto == that.producto;
	    }

	    @Override
	    public int hashCode() {
	        return java.util.Objects.hash(comprobante, producto);
	    }
	
}
