package model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.PrePersist;
import javax.persistence.Table;

@Entity
@Table(name = "tb_producto")
@NamedQuery(name = "EntProducto.findAll",query = "Select p from EntProducto p")
public class EntProducto implements Serializable {
	private static final long serialVersionUID=1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_produc;
	
	private String name_pro,descripcion,fec_entrada,fec_ultimo;
	private double precio;
	private int stock;
	
	@ManyToOne
	@JoinColumn(name = "id_lab")
	private EntLaboratorio laboratorio;
	
	@JoinColumn(name = "id_cate")
	private EntCategoria categoria;
	
	@JoinColumn(name = "id_prov")
	private EntProveedor proveedor;
	
	@PrePersist
	public void asignarFechas() {
		Date todayDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String fechaActual = sdf.format(todayDate);
		
		if (fec_entrada == null) {
			fec_entrada = fechaActual;
        }
        if (fec_ultimo == null) {
        	fec_ultimo = fechaActual;
        }
	}
	public EntProducto() {
		super();
	}


	public EntProducto(int id_produc) {
		super();
		this.id_produc = id_produc;
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


	public String getFec_entrada() {
		return fec_entrada;
	}


	public void setFec_entrada(String fec_entrada) {
		this.fec_entrada = fec_entrada;
	}


	public String getFec_ultimo() {
		return fec_ultimo;
	}


	public void setFec_ultimo(String fec_ultimo) {
		this.fec_ultimo = fec_ultimo;
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


	public EntLaboratorio getLaboratorio() {
		return laboratorio;
	}


	public void setLaboratorio(EntLaboratorio laboratorio) {
		this.laboratorio = laboratorio;
	}


	public EntCategoria getCategoria() {
		return categoria;
	}


	public void setCategoria(EntCategoria categoria) {
		this.categoria = categoria;
	}


	public EntProveedor getProveedor() {
		return proveedor;
	}


	public void setProveedor(EntProveedor proveedor) {
		this.proveedor = proveedor;
	}

	
	
	
	
	
	
	
	
	
}
