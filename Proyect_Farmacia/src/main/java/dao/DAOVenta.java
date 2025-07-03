package dao;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.http.HttpSession;

import interfaces.InterfaceVenta;
import model.DetalleCDPid;
import model.EntCliente;
import model.EntComprobante;
import model.EntDetalleCDP;
import model.EntNotificacion;
import model.EntProducto;
import model.EntUsuario;
import model.Pedido;

public class DAOVenta implements InterfaceVenta {

	EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("namePersistence");
	
	public List<EntCliente> buscarClienteName(String name) {
		EntityManager em = fabrica.createEntityManager();
		List<EntCliente> cliente = null;
		try {
			em.getTransaction().begin();
			
			String jpql = "SELECT c FROM EntCliente c WHERE c.nombreClien LIKE :name";
			cliente = em.createQuery(jpql,EntCliente.class).setParameter("name", "%" + name + "%").getResultList();
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
            em.close();
        }
		return cliente;
	}

	public int registrarCompra(EntComprobante com,List<Pedido> listPedido,EntUsuario usu) {
		EntityManager em = fabrica.createEntityManager();
		try {
			em.getTransaction().begin();
			
			em.persist(com);
			em.flush();
			
			 // Buscar administradores
	        List<EntUsuario> admins = em.createQuery(
	            "SELECT u FROM EntUsuario u WHERE u.rol = 'ADMIN'", EntUsuario.class).getResultList();
			
			for (Pedido p : listPedido) {
				DetalleCDPid id = new DetalleCDPid( com.getId_cdp(),p.getIdPro());
				EntProducto pro = em.find(EntProducto.class, p.getIdPro());
				EntDetalleCDP dtCdp = new EntDetalleCDP(id, com, pro, p.getCantidad(), p.getImporte());
				em.persist(dtCdp);
				pro.setStock(pro.getStock()-p.getCantidad());
				
				if(pro.getStock() <= 20) {
					for (EntUsuario entUsuario : admins) {
						
						EntNotificacion notistock = new EntNotificacion();
						notistock.setReceptor(entUsuario);
						notistock.setTitulo("Prevencion de Stock");
						notistock.setMensaje("Despues de la venta N° " +com.getId_cdp()+" el stock del "
			            		+ "producto "+pro.getName_pro()+" con codigo "+ pro.getId_produc() + " se necesita reavastecer.");
						notistock.setTipo("STOCK");
						notistock.setObjetoId(pro.getId_produc());
						notistock.setFecha(LocalDateTime.now());
						notistock.setLeido(false);
						em.persist(notistock);
			            
					}
				}
			}      
			// Notificación de venta
	        for (EntUsuario admin : admins) {
	        	EntNotificacion noti = new EntNotificacion();
	            noti.setReceptor(admin);
	            noti.setTitulo("Venta N° "+com.getId_cdp()+" de "+usu.getNombreUsu()+" "+usu.getApellidoUsu());
	            noti.setMensaje("El empleado " +usu.getNombreUsu()+" "+ usu.getApellidoUsu() + " realizó una venta.");
	            noti.setTipo("VENTA");
	            noti.setObjetoId(com.getId_cdp());
	            noti.setFecha(LocalDateTime.now());
	            noti.setLeido(false);
	            em.persist(noti);
	            
	        }
			
			em.getTransaction().commit();
			System.out.println("Venta registrada y notificaciones enviadas.");
			
			
		} catch (Exception e) {
			 e.printStackTrace();
	         if (em.getTransaction().isActive()) {
	             em.getTransaction().rollback();
	         }
		} finally {
            em.close();
        }
		return com.getId_cdp();
	}

	public EntCliente registrarClienteVenta(EntCliente cli) {
		EntityManager em = fabrica.createEntityManager();
		
		try {
			em.getTransaction().begin();
			em.persist(cli);
			em.flush();
			em.getTransaction().commit();
			
		} catch (RuntimeException e ) {
		if (em.getTransaction().isActive()) em.getTransaction().rollback();
		e.printStackTrace();
		}finally {
			
			em.close();
		}
		return cli;
	}

	public EntComprobante buscarComprobante(int idCdp) {
		EntityManager em = fabrica.createEntityManager();
		EntComprobante busca = null;
        try {
            busca = em.find(EntComprobante.class, idCdp);
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return busca;
	}

	public List<EntDetalleCDP> buscarDetalleComprobante(int idCdp) {
		EntityManager em = fabrica.createEntityManager();
		List<EntDetalleCDP> lista = null;
		try {
            return em.createQuery("SELECT d FROM EntDetalleCDP d WHERE d.comprobante.id_cdp = :id", EntDetalleCDP.class)
                    .setParameter("id", idCdp)
                    .getResultList();
        }catch (Exception e) {
			e.printStackTrace();
		} finally {
            em.close();
        }
		return lista;
	}
	
}
