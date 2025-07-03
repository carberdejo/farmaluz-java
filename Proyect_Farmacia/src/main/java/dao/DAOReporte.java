package dao;


import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import interfaces.InterfaceReporte;
import model.*;

public class DAOReporte implements InterfaceReporte{

	EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("namePersistence");

	public List<VentaXCategoriaDTO> ReporteXCategoria() {
	    EntityManager em = fabrica.createEntityManager();
	    List<VentaXCategoriaDTO> Report1 = null;

	    try {
	        em.getTransaction().begin();
	        System.out.println("A iniciar");

	        
	        String sql = "SELECT new model.VentaXCategoriaDTO( " +
	                     "c.id_cate, c.name_cate, " +
	                     "SUM(dc.cantidad), SUM(dc.importe)) " +
	                     "FROM EntDetalleCDP dc " +
	                     "JOIN dc.producto p " +
	                     "JOIN p.categoria c " +
	                     "GROUP BY c.id_cate, c.name_cate " +
	                     "ORDER BY c.id_cate";

	        Report1 = em.createQuery(sql, VentaXCategoriaDTO.class).getResultList();
	        System.out.println("Total registros generados: " + Report1.size());

	          for (VentaXCategoriaDTO dto : Report1) {
	            Integer idCate = dto.getId_cat();

	            String jpqlProducto = "SELECT p.name_pro " +
	                                  "FROM EntDetalleCDP dc " +
	                                  "JOIN dc.producto p " +
	                                  "JOIN p.categoria c " +
	                                  "WHERE c.id_cate = :id_cate " +
	                                  "GROUP BY p.name_pro " +
	                                  "ORDER BY SUM(dc.cantidad) DESC";

	            List<String> resultado = em.createQuery(jpqlProducto, String.class)
	                                       .setParameter("id_cate", idCate)
	                                       .setMaxResults(1)  
	                                       .getResultList();

	            if (!resultado.isEmpty()) {
	                dto.setVendido(resultado.get(0));
	            } else {
	                dto.setVendido("Sin ventas");
	            }
	        }

	        em.getTransaction().commit();
	        System.out.println("hecho");

	    } catch (Exception e) {
	        if (em.getTransaction().isActive())
	            em.getTransaction().rollback();
	        e.printStackTrace();
	    } finally {
	        em.close();
	    }
	    return Report1;
	}

	public List<AnalisisLabDTO> AnalisisLab() {
	    EntityManager em = fabrica.createEntityManager();
	    List<AnalisisLabDTO> Report2 = null;
	    try {
	        em.getTransaction().begin();
	        System.out.println("A iniciar algo nuevo");
	        
	        String sql = "Select new model.AnalisisLabDTO(l.id_lab,l.name_lab,SUM(p.stock),count(DISTINCT p.id_produc)," + 
	        			 "MAX(p.fec_entrada),MAX(p.precio),AVG(p.precio)) FROM EntProducto p JOIN p.laboratorio l GROUP BY "
	        			 + "l.id_lab,l.name_lab ORDER BY l.id_lab";
	        Report2 = em.createQuery(sql, AnalisisLabDTO.class).getResultList();
	        System.out.println("Total registros generados: " + Report2.size());
	        em.getTransaction().commit();
	        System.out.println("hecho");
	    }catch(Exception e) {
	        if (em.getTransaction().isActive())
	            em.getTransaction().rollback();
	        e.printStackTrace();
	    }finally {
	    	em.close();
	    }
	    return Report2;
	}
	
}
