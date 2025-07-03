package model;


public class AnalisisLabDTO {
	
	private int id_lab;
	private String nom_lab;
	private Long stockTot,cantProd;
	 private String fEnt; 
	 private double prodCaro;
	 private Double prePromedio;
	 
	 
	public AnalisisLabDTO(int id_lab, String nom_lab, Long stockTot, Long cantProd, String fEnt, double prodCaro,
			Double prePromedio) {
		super();
		this.id_lab = id_lab;
		this.nom_lab = nom_lab;
		this.stockTot = stockTot;
		this.cantProd = cantProd;
		this.fEnt = fEnt;
		this.prodCaro = prodCaro;
		this.prePromedio = prePromedio;
	}
	public int getId_lab() {
		return id_lab;
	}
	public void setId_lab(int id_lab) {
		this.id_lab = id_lab;
	}
	public String getNom_lab() {
		return nom_lab;
	}
	public void setNom_lab(String nom_lab) {
		this.nom_lab = nom_lab;
	}
	public Long getStockTot() {
		return stockTot;
	}
	public void setStockTot(Long stockTot) {
		this.stockTot = stockTot;
	}
	public Long getCantProd() {
		return cantProd;
	}
	public void setCantProd(Long cantProd) {
		this.cantProd = cantProd;
	}
	public String getfEnt() {
		return fEnt;
	}
	public void setfEnt(String fEnt) {
		this.fEnt = fEnt;
	}
	public double getProdCaro() {
		return prodCaro;
	}
	public void setProdCaro(double prodCaro) {
		this.prodCaro = prodCaro;
	}
	public Double getPrePromedio() {
		return prePromedio;
	}
	public void setPrePromedio(Double prePromedio) {
		this.prePromedio = prePromedio;
	}

}
