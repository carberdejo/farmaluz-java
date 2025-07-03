package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

import interfaces.InterfaceFiltros;
import model.DTOProducto;
import model.EntProducto;
import model.Pedido;

public class DAOFiltros implements InterfaceFiltros{

	EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("namePersistence");
	
	public List<DTOProducto> listaCategoria(int id_cate) {
		
		EntityManager em = fabrica.createEntityManager();
		List<DTOProducto> lisCat = null;
		try {
			em.getTransaction().begin();
			String jpql = "SELECT new model.DTOProducto(p.id_produc,p.name_pro,p.descripcion,l.name_lab,c.name_cate,p.precio,p.stock) FROM EntProducto p JOIN p.categoria c JOIN p.laboratorio l WHERE p.categoria.id_cate = :id_cate";
			lisCat = em.createQuery(jpql,DTOProducto.class).setParameter("id_cate", id_cate).getResultList();
			em.getTransaction().commit();
			
		} catch (Exception e) {
			if(em.getTransaction().isActive()) 
				em.getTransaction().rollback();
		}finally {
			em.close();
		}
		return lisCat;
	}

	public List<DTOProducto> listaLaboratorio(int id_lab) {
		EntityManager em = fabrica.createEntityManager();
		List<DTOProducto> lisCat = null;
		try {
			em.getTransaction().begin();
			String jpql = "SELECT new model.DTOProducto(p.id_produc,p.name_pro,p.descripcion,l.name_lab,c.name_cate,p.precio,p.stock) FROM EntProducto p JOIN p.categoria c JOIN p.laboratorio l WHERE p.laboratorio.id_lab = :id_lab";
			lisCat = em.createQuery(jpql,DTOProducto.class).setParameter("id_lab", id_lab).getResultList();
			em.getTransaction().commit();
			
		} catch (Exception e) {
			if(em.getTransaction().isActive()) 
				em.getTransaction().rollback();
		}finally {
			em.close();
		}
		return lisCat;
	}

	public List<DTOProducto> listaNombres(String nombre) {
		
		EntityManager em = fabrica.createEntityManager();
		List<DTOProducto> lisNom = null;
		try {
			em.getTransaction().begin();
			String jpql = "SELECT new model.DTOProducto(p.id_produc,p.name_pro,p.descripcion,l.name_lab,c.name_cate,p.precio,p.stock) FROM EntProducto p JOIN p.categoria c JOIN p.laboratorio l WHERE p.name_pro LIKE concat(:nombre,'%' )";
			lisNom = em.createQuery(jpql,DTOProducto.class).setParameter("nombre", nombre).getResultList();
			em.getTransaction().commit();
			
		} catch (Exception e) {
			if(em.getTransaction().isActive()) 
				em.getTransaction().rollback();
		}finally {
			em.close();
		}
		return lisNom;
	}
	
	public List<DTOProducto>listaFiltros( Integer cat,Integer lab, String nombre ){
		EntityManager em = fabrica.createEntityManager();
		List<DTOProducto> lista = null;
		try {
			em.getTransaction().begin();
			String jpql = "SELECT new model.DTOProducto(p.id_produc,p.name_pro,p.descripcion,l.name_lab,"
					+ "c.name_cate,p.precio,p.stock) FROM EntProducto p JOIN p.categoria c JOIN p.laboratorio l"
					+ " WHERE 1=1";
			if(nombre!= null && !nombre.isEmpty()) {
				jpql+=" AND p.name_pro LIKE :nombre";
			}
			if(cat != null ) {
				jpql+=" AND p.categoria.id_cate = :cat";
			}
			if(lab != null) {
				jpql+=" AND l.id_lab = :lab";
			} 
			
			
			TypedQuery<DTOProducto> query = em.createQuery(jpql,DTOProducto.class);
			
			if (nombre != null && !nombre.isEmpty()) {
			    query.setParameter("nombre", "%" + nombre + "%");
			}
			 if (cat != null) {
	            query.setParameter("cat", cat);
	        }
	        if (lab != null) {
	            query.setParameter("lab", lab);
	        }
	        lista=query.getResultList();
			
			
		} catch (Exception e) {
			if(em.getTransaction().isActive()) 
				em.getTransaction().rollback();
		}finally {
			em.close();
		}
		return lista;
	}

	public Pedido crearPedido( int id,int cant ) {
		EntityManager em = fabrica.createEntityManager();
		Pedido pedido = null;
		try {
			em.getTransaction().begin();
			EntProducto p = em.find(EntProducto.class, id);
			
			if(p != null) {
				int stockActual = p.getStock();
				if (stockActual >= cant && (stockActual - cant) >= 10) {
					System.out.println("stockActual "+stockActual+" cant "+cant);
					pedido = new Pedido(p.getId_produc(), cant, p.getName_pro(), p.getPrecio());
				}else {
	                System.out.println("Stock insuficiente o no se cumple el mínimo restante.");
	            }
			} else {
	            System.out.println("Producto no encontrado.");
	        }
			
			em.getTransaction().commit();
			
		} catch (Exception e) {
			if(em.getTransaction().isActive()) 
				em.getTransaction().rollback();
			e.printStackTrace();
		}finally {
			em.close();
		}
		return pedido;
	}
	
}
