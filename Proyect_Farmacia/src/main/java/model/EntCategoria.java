package model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "tb_categoria")
@NamedQuery(name = "EntCategoria.findAll",query = "Select c from EntCategoria c")
public class EntCategoria {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_cate;
	
	private String name_cate;

	public EntCategoria() {
		super();
	}
	public EntCategoria(int id_cate) {
		this.id_cate = id_cate;
	}
	
	
	public int getId_cate() {
		return id_cate;
	}
	public void setId_cate(int id_cate) {
		this.id_cate = id_cate;
	}
	public String getName_cate() {
		return name_cate;
	}
	public void setName_cate(String name_cate) {
		this.name_cate = name_cate;
	}
	
	
	
}
