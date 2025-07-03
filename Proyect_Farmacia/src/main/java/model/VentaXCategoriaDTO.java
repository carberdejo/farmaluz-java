package model;

public class VentaXCategoriaDTO {
	 private int id_cat;
	    private String name_cate;
	    private Long total;
	    private Double importe;
	    private String vendido;
	    
		public VentaXCategoriaDTO(int id_cat, String name_cate, Long total, Double importe) {
			super();
			this.id_cat = id_cat;
			this.name_cate = name_cate;
			this.total = total;
			this.importe = importe;
	
		}
		public int getId_cat() {
			return id_cat;
		}
		public void setId_cat(int id_cat) {
			this.id_cat = id_cat;
		}
		public String getName_cate() {
			return name_cate;
		}
		public void setName_cate(String name_cate) {
			this.name_cate = name_cate;
		}
		public Long getTotal() {
			return total;
		}
		public void setTotal(Long total) {
			this.total = total;
		}
		public Double getImporte() {
			return importe;
		}
		public void setImporte(Double importe) {
			this.importe = importe;
		}

			
	    public void setVendido(String vendido) {
	        this.vendido = vendido;
	    }

	    public String getVendido() {
	        return vendido;
	    }
	   
}
