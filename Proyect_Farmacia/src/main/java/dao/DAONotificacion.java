package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import interfaces.InterfaceNotificacion;
import model.EntNotificacion;

public class DAONotificacion implements InterfaceNotificacion {

	EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("namePersistence");

	public List<EntNotificacion> listarPorUsuario(int idUsuario) {
		EntityManager em = fabrica.createEntityManager();
		List<EntNotificacion> lista = null;
		try {
            return em.createQuery("SELECT n FROM EntNotificacion n WHERE n.receptor.idUsuario = :id ORDER BY n.fecha DESC", EntNotificacion.class)
                    .setParameter("id", idUsuario)
                    .getResultList();
        }catch (Exception e) {
			e.printStackTrace();
		} finally {
            em.close();
        }
		return lista;
	}
	
	public void marcarComoLeidasPorUsuario(int idnoti) {
		EntityManager em = fabrica.createEntityManager();
	    try {
	    	em.getTransaction().begin();
	        EntNotificacion noti = em.find(EntNotificacion.class, idnoti);
	        if (noti != null && !noti.isLeido()) {
	            noti.setLeido(true);
	        }
	        em.getTransaction().commit();
	    } catch (Exception e) {
	        em.getTransaction().rollback();
	        e.printStackTrace();
	    } finally {
	        em.close();
	    }
	}
	
	public int contarNoLeidasPorUsuario(int idUsuario) {
	    EntityManager em = fabrica.createEntityManager();
	    try {
	        Long resLong = em.createQuery("SELECT COUNT(n) FROM EntNotificacion n WHERE n.receptor.idUsuario = :id AND n.leido = false", Long.class)
	                 .setParameter("id", idUsuario)
	                 .getSingleResult();
	        return resLong.intValue();
	    } finally {
	        em.close();
	    }
	}

	public EntNotificacion buscarPorId(int id) {
		EntityManager em = fabrica.createEntityManager();
	    try {
	        return em.find(EntNotificacion.class, id);
	    } finally {
	        em.close();
	    }
	}

}
