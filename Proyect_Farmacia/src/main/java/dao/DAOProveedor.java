package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import interfaces.InterfaceProveedor;
import model.EntProveedor;

public class DAOProveedor implements InterfaceProveedor{
	EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("namePersistence");

	public void registrarProveedor(EntProveedor prov) {
		// TODO Auto-generated method stub
		EntityManager em = fabrica.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(prov);
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

	public void actualizarProveedor(EntProveedor prov) {
		// TODO Auto-generated method stub
		EntityManager em = fabrica.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(prov);
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

	public void eliminarProveedor(int id) {
		// TODO Auto-generated method stub
		EntityManager em = fabrica.createEntityManager();
        try {
            em.getTransaction().begin();
            EntProveedor busca = em.find(EntProveedor.class, id);
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

	public List<EntProveedor> ListarProveedor() {
		EntityManager em = fabrica.createEntityManager();
        List<EntProveedor> listado = null;
        try {
            em.getTransaction().begin();
            listado = em.createQuery("SELECT p FROM EntProveedor p", EntProveedor.class).getResultList();
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return listado;
	}

	public EntProveedor BuscaProveedor(int id) {
		// TODO Auto-generated method stub
		  EntityManager em = fabrica.createEntityManager();
	        EntProveedor busca = null;
	        try {
	            busca = em.find(EntProveedor.class, id);
	        } catch (RuntimeException e) {
	            e.printStackTrace();
	        } finally {
	            em.close();
	        }
	        return busca;
	}

}
