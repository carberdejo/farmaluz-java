package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import interfaces.InterfaceUsuario;
import model.EntUsuario;

public class DAOUsuario implements InterfaceUsuario {
	
	EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("namePersistence");
	
	public void registrarUsuario(EntUsuario usu) {
		EntityManager em = fabrica.createEntityManager();
		
		try {
			em.getTransaction().begin();
			em.persist(usu);
			em.getTransaction().commit();
		} catch (RuntimeException e) {
			if(em.getTransaction().isActive()) em.getTransaction().rollback();
			e.printStackTrace();
		} finally {
			em.close();
		}
		
	}

	public void actualizarUsuario(EntUsuario usu) {
		EntityManager em = fabrica.createEntityManager();
		try {
			em.getTransaction().begin();
			em.merge(usu);
			em.getTransaction().commit();
		} catch (RuntimeException e) {
			if(em.getTransaction().isActive()) em.getTransaction().rollback();
			e.printStackTrace();
		} finally {
			em.close();
		}
		
	}

	public void EliminarUsuario(int id) {
		EntityManager em = fabrica.createEntityManager();
		
		try {
			em.getTransaction().begin();
			
			EntUsuario delete = em.find(EntUsuario.class, id);
			
			if(delete != null){
				em.remove(delete);
				em.getTransaction().commit();
			}
		} catch (RuntimeException e) {
			if(em.getTransaction().isActive()) em.getTransaction().rollback();
			e.printStackTrace();
		} finally {
			em.close();
		}
		
	}

	public List<EntUsuario> ListarUsuarios() {
		EntityManager em = fabrica.createEntityManager();
		List<EntUsuario> lista = null;
		
		try {
			em.getTransaction().begin();
			lista = em.createNamedQuery("EntUsuario.findAll", EntUsuario.class).getResultList();
			em.getTransaction().commit();
		} catch (RuntimeException e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		
		return lista;
	}

	public EntUsuario BuscaUsuario(int id) {
		EntityManager em = fabrica.createEntityManager();
        EntUsuario search = null;
        try {
        	search = em.find(EntUsuario.class, id);
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return search;
	}

	public EntUsuario accediendoAlSistema(String usu, String pass) {
		
        EntityManager em = fabrica.createEntityManager();
        
        EntUsuario consulta = null;
        
        try {
        	em.getTransaction().begin();

        	String jpql = "SELECT u from EntUsuario u WHERE u.nickUsu = :usu AND u.passwordUsu = :pass";

        	consulta = em.createQuery(jpql,EntUsuario.class)
        											.setParameter("usu", usu)
        											.setParameter("pass", pass).getSingleResult();

        	em.getTransaction().commit();
        	
		} catch (Exception e) {
			if(em.getTransaction().isActive()) 
				em.getTransaction().rollback();
		}finally {
			em.close();
		}
        
		return consulta;
	}

}
