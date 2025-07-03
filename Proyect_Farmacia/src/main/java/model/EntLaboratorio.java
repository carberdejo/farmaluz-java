package model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "tb_laboratorio")
@NamedQuery(name = "EntLaboratorio.findAll",query = "Select l from EntLaboratorio l")
public class EntLaboratorio {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_lab;
	
	private String name_lab;

	public EntLaboratorio() {
		super();
	}
	public EntLaboratorio(int id_lab) {
		this.id_lab = id_lab;
	}
	public int getId_lab() {
		return id_lab;
	}
	public void setId_lab(int id_lab) {
		this.id_lab = id_lab;
	}
	public String getName_lab() {
		return name_lab;
	}
	public void setName_lab(String name_lab) {
		this.name_lab = name_lab;
	}
	
	
}
