package model;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "tb_notificaciones")
@NamedQuery(name = "EntNotificacion.findAll",query = "Select n from EntNotificacion n")
public class EntNotificacion {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_noti;

    @ManyToOne
    @JoinColumn(name = "id_usu")
    private EntUsuario receptor;

    private String mensaje,titulo,tipo,link_referencia;
    private LocalDateTime fecha;
    private boolean leido;
    private int objeto_id;
    
	public EntNotificacion() {
		super();
	}

	public int getId() {
		return id_noti;
	}

	public void setId(int id) {
		this.id_noti = id;
	}

	public EntUsuario getReceptor() {
		return receptor;
	}

	public void setReceptor(EntUsuario receptor) {
		this.receptor = receptor;
	}

	public int getId_noti() {
		return id_noti;
	}

	public void setId_noti(int id_noti) {
		this.id_noti = id_noti;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getLinkReferencia() {
		return link_referencia;
	}

	public void setLinkReferencia(String link_referencia) {
		this.link_referencia = link_referencia;
	}

	public int getObjetoId() {
		return objeto_id;
	}

	public void setObjetoId(int objeto_id) {
		this.objeto_id = objeto_id;
	}

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}

	public LocalDateTime getFecha() {
		return fecha;
	}

	public void setFecha(LocalDateTime fecha) {
		this.fecha = fecha;
	}

	public boolean isLeido() {
		return leido;
	}

	public void setLeido(boolean leido) {
		this.leido = leido;
	}
    
    
    
    
}
