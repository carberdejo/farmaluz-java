package interfaces;
import java.util.List;

import model.EntNotificacion;;

public interface InterfaceNotificacion {
	public List<EntNotificacion> listarPorUsuario(int idUsuario); 
	public int contarNoLeidasPorUsuario(int idUsuario);
	public void marcarComoLeidasPorUsuario(int idnoti);
	public EntNotificacion buscarPorId(int id);
}
