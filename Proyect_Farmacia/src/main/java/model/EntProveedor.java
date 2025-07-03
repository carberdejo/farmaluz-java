package model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "tb_proveedor")
@NamedQuery(name = "EntProveedor.findAll",query = "Select p from EntProveedor p")
public class EntProveedor {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_prov;
	
	private String name_prov,nom_encargado,ape_encargado,ruc,
	direccion,telefono,email,fec_inicio;
	
	public EntProveedor() {
		super();
	}
	public EntProveedor(int id_prov) {
		this.id_prov = id_prov;
	}
	
	
	public int getId_prov() {
		return id_prov;
	}
	public void setId_prov(int id_prov) {
		this.id_prov = id_prov;
	}
	public String getName_prov() {
		return name_prov;
	}
	public void setName_prov(String name_prov) {
		this.name_prov = name_prov;
	}
	public String getNom_encargado() {
		return nom_encargado;
	}
	public void setNom_encargado(String nom_encargado) {
		this.nom_encargado = nom_encargado;
	}
	public String getApe_encargado() {
		return ape_encargado;
	}
	public void setApe_encargado(String ape_encargado) {
		this.ape_encargado = ape_encargado;
	}
	public String getRuc() {
		return ruc;
	}
	public void setRuc(String ruc) {
		this.ruc = ruc;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFec_inicio() {
		return fec_inicio;
	}
	public void setFec_inicio(String fec_inicio) {
		this.fec_inicio = fec_inicio;
	}
	
	
}
