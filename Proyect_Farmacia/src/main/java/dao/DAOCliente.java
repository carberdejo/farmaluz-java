package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import interfaces.InterfaceCliente;
import model.EntCliente;


public class DAOCliente implements InterfaceCliente {
	
	EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("namePersistence");

	public void registrarCliente(EntCliente clien) {
		EntityManager em = fabrica.createEntityManager();
		try {
			em.getTransaction().begin();
			em.persist(clien);
			em.getTransaction().commit();
			
		} catch (RuntimeException e ) {
		if (em.getTransaction().isActive()) em.getTransaction().rollback();
		e.printStackTrace();
		}finally {
			
			em.close();
		}
		
	}

	public void actualizarCliente(EntCliente clien) {
		EntityManager em=fabrica.createEntityManager();
		
		try {
			em.getTransaction().begin();
			em.merge(clien);
			em.getTransaction().commit();
					
					
		} catch (RuntimeException e) {
		
			if (em.getTransaction().isActive())em.getTransaction().rollback();
			e.printStackTrace();
				
	
					
		}finally {
			
			em.close();
			
		}
		
	}

	public void EliminarCliente(EntCliente clien) {
		EntityManager em=fabrica.createEntityManager();
		try {
			
			em.getTransaction().begin();
			EntCliente eliminar = em.find(EntCliente.class,clien.getIdCliente());
			
			if (eliminar!=null) {
				
				em.remove(eliminar);
				em.getTransaction().commit();
				
			}
			
			
		} catch (RuntimeException e) {
			
			if (em.getTransaction().isActive())em.getTransaction().rollback();
			e.printStackTrace();
				
			
			
		}finally {
			em.close();
		}
		
	}
 
	public List<EntCliente> ListarClientes() {
		
		EntityManager em=fabrica.createEntityManager();
		List<EntCliente>list=null;
		
		try {
		
			em.getTransaction().begin();
			list=em.createNamedQuery("EntCliente.findAll",EntCliente.class).getResultList();
			em.getTransaction().commit();
			
		} catch (RuntimeException e) {
			e.printStackTrace();
		}finally {
			em.close();
		}
		
		
		return list;
	}

	public EntCliente BuscaCliente(EntCliente clien) {
        EntityManager em = fabrica.createEntityManager();
        EntCliente busca = null;
        try {
            busca = em.find(EntCliente.class, clien.getIdCliente());
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return busca;
	}
	
	

}
