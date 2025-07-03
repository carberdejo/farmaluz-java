package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import interfaces.InterfaceListado;
import model.EntCategoria;
import model.EntLaboratorio;
import model.EntProveedor;

public class DAOListado implements InterfaceListado {

	EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("namePersistence");
	
	public List<EntCategoria> listaCategoria() {
		EntityManager em = fabrica.createEntityManager();
		return em.createQuery("SELECT c FROM EntCategoria c",EntCategoria.class).getResultList();
	}

	public List<EntLaboratorio> listaLaboratorio() {
		EntityManager em = fabrica.createEntityManager();
		return em.createQuery("SELECT l FROM EntLaboratorio l",EntLaboratorio.class).getResultList();
	}

	public List<EntProveedor> listaProveedor() {
		EntityManager em = fabrica.createEntityManager();
		return em.createQuery("SELECT p FROM EntProveedor p",EntProveedor.class).getResultList();
	}

}
