package interfaces;

import java.util.List;

import model.EntProveedor;

public interface InterfaceProveedor {
	public void registrarProveedor(EntProveedor prov);
	public void actualizarProveedor(EntProveedor prov);
	public void eliminarProveedor(int id);
	public 		List<EntProveedor> ListarProveedor();
	public		EntProveedor BuscaProveedor(int id);

}
