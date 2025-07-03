package model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "tb_comprobante")
@NamedQuery(name = "EntComprobante.findAll",query = "Select p from EntComprobante p")
public class EntComprobante {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_cdp;
	
	@ManyToOne
	@JoinColumn(name = "id_cli")
	private EntCliente cliente;
	
	@JoinColumn(name = "id_ven")
	private EntUsuario usuario;
	
	private String tipo,fecha;
	
	

	public EntComprobante() {
		super();
	}

	public EntComprobante(int id_cdp) {
		super();
		this.id_cdp = id_cdp;
	}

	public int getId_cdp() {
		return id_cdp;
	}

	public void setId_cdp(int id_cdp) {
		this.id_cdp = id_cdp;
	}

	public EntCliente getCliente() {
		return cliente;
	}

	public void setCliente(EntCliente cliente) {
		this.cliente = cliente;
	}

	public EntUsuario getUsuario() {
		return usuario;
	}

	public void setUsuario(EntUsuario usuario) {
		this.usuario = usuario;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	
	
}
