package dao;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import interfaces.InterfaceProductos;
import model.EntNotificacion;
import model.EntProducto;
import model.EntUsuario;

public class DAOProductos implements InterfaceProductos {
	EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("namePersistence");
	
	public void registrarProducto(EntProducto pro) {
		
        EntityManager em = fabrica.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(pro);
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            e.printStackTrace();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
        } finally {
            em.close();
        }
		
	}

	public void actualizarProducto(EntProducto pro) {
		
        EntityManager em = fabrica.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(pro);
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            e.printStackTrace();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
        } finally {
            em.close();
        }
		
	}

	public void EliminarProducto(int id) {

		EntityManager em = fabrica.createEntityManager();
        try {
            em.getTransaction().begin();
            EntProducto busca = em.find(EntProducto.class, id);
            if (busca != null) {
                em.remove(busca);
                em.getTransaction().commit();
            }
        } catch (RuntimeException e) {
            e.printStackTrace();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
        } finally {
            em.close();
        }
		
	}

	public List<EntProducto> ListarProductos() {

		EntityManager em = fabrica.createEntityManager();
        List<EntProducto> listado = null;
        try {
        	em.getTransaction().begin();
            listado = em.createQuery("SELECT p FROM EntProducto p", EntProducto.class).getResultList();
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return listado;
	}

	public EntProducto BuscaProducto(int id) {

		EntityManager em = fabrica.createEntityManager();
        EntProducto busca = null;
        try {
            busca = em.find(EntProducto.class, id);
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return busca;
	}

	public int ActualizarStock(int id, int stock) {
		 EntityManager em = fabrica.createEntityManager();
		 int pro = 0;
	        try {
	            em.getTransaction().begin();
	            
	             pro = em.createQuery("UPDATE EntProducto p set p.stock = p.stock + :stock WHERE p.id_produc = :id")
	            								.setParameter("stock", stock).setParameter("id", id).executeUpdate();
	             em.flush();
	            
	            
	            
	            EntProducto produc = em.find(EntProducto.class, id);
	            //Notificacion
	            List<EntUsuario> emple = em.createQuery(
	    	            "SELECT u FROM EntUsuario u WHERE u.rol = 'EMP'", EntUsuario.class).getResultList();
	            
	            for (EntUsuario e : emple) {
	            	EntNotificacion noti = new EntNotificacion();
	            	noti.setReceptor(e);
	            	noti.setTitulo("Stock Reabastecido");
	            	noti.setMensaje("EL producto "+produc.getName_pro()+" ha sido reabastecido con "+stock+" unidades");
	            	noti.setTipo("STOCK");
					noti.setObjetoId(produc.getId_produc());
					noti.setFecha(LocalDateTime.now());
					noti.setLeido(false);
					em.persist(noti);
				}
	            
	            em.getTransaction().commit();
	            
	        } catch (RuntimeException e) {
	            e.printStackTrace();
	            if (em.getTransaction().isActive()) {
	                em.getTransaction().rollback();
	            }
	        } finally {
	            em.close();
	        }
		return pro;
	}

}
