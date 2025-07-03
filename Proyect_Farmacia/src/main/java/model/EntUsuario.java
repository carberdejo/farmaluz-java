package model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "tb_usuario")
@NamedQuery(name = "EntUsuario.findAll",query = "Select u from EntUsuario u")
public class EntUsuario {
private static final long serialVersionUID=1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	@Column(name = "id_usu")
	private int idUsuario;
	
	@Column(name = "nombre_usu")
	private String nombreUsu;
	
	@Column(name = "apellido_usu")
	private String apellidoUsu;
	
	@Column(name = "dni_usu")
	private String dni;
	
	@Column(name = "telefono_usu")
	private String telefono;
	
	@Column(name = "direccion_usu")
	private String direccionUsu;
	
	@Column(name = "nick_usu")
	private String nickUsu;
	
	@Column(name = "password_usu")
	private String passwordUsu;
	
	@Column(name = "rol")
	private String rol;

	public EntUsuario() {
		super();
	}
	
	
	public EntUsuario(int idUsuario) {
		super();
		this.idUsuario = idUsuario;
	}


	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getNombreUsu() {
		return nombreUsu;
	}

	public void setNombreUsu(String nombreUsu) {
		this.nombreUsu = nombreUsu;
	}

	public String getApellidoUsu() {
		return apellidoUsu;
	}

	public void setApellidoUsu(String apellidoUsu) {
		this.apellidoUsu = apellidoUsu;
	}

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getDireccionUsu() {
		return direccionUsu;
	}

	public void setDireccionUsu(String direccionUsu) {
		this.direccionUsu = direccionUsu;
	}

	public String getNickUsu() {
		return nickUsu;
	}

	public void setNickUsu(String nickUsu) {
		this.nickUsu = nickUsu;
	}

	public String getPasswordUsu() {
		return passwordUsu;
	}

	public void setPasswordUsu(String passwordUsu) {
		this.passwordUsu = passwordUsu;
	}

	public String getRol() {
		return rol;
	}

	public void setRol(String rol) {
		this.rol = rol;
	}
	
	
	
}
