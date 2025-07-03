package interfaces;

import java.util.List;

import model.EntUsuario;;

public interface InterfaceUsuario {
	public void registrarUsuario(EntUsuario usu);
	public void actualizarUsuario(EntUsuario usu);
	public void EliminarUsuario(int id);
	public 		List<EntUsuario> ListarUsuarios();
	public		EntUsuario BuscaUsuario(int id);
	public		EntUsuario accediendoAlSistema(String usu, String pass);
}
