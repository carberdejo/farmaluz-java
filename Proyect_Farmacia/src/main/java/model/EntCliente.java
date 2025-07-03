package model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.PrePersist;
import javax.persistence.Table;

@Entity
@Table(name = "tb_cliente")
@NamedQuery(name = "EntCliente.findAll",query = "Select c from EntCliente c")
public class EntCliente {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_clien")
    private String idCliente;
    
    @Column(name = "nombre_clien")
	private String nombreClien;
	
	@Column(name = "apellido_clien")
	private String apellidoClien;
	
	@Column(name = "dni_clien")
	private String dniClien;
	
	@Column(name = "telefono_clien")
	private String telefonoClien;
	
	


	public EntCliente() {
		super();
	}
	

	public EntCliente(String idCliente) {
		super();
		this.idCliente = idCliente;
	}

	public String getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(String cod) {
		this.idCliente = cod;
	}

	public String getNombreClien() {
		return nombreClien;
	}

	public void setNombreClien(String nombreClien) {
		this.nombreClien = nombreClien;
	}

	public String getApellidoClien() {
		return apellidoClien;
	}

	public void setApellidoClien(String apellidoClien) {
		this.apellidoClien = apellidoClien;
	}

	public String getDniClien() {
		return dniClien;
	}

	public void setDniClien(String dniClien) {
		this.dniClien = dniClien;
	}

	public String getTelefonoClien() {
		return telefonoClien;
	}

	public void setTelefonoClien(String telefonoClien) {
		this.telefonoClien = telefonoClien;
	}

	


	

}
