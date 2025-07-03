package interfaces;

import java.util.List;

import model.EntProducto;

public interface InterfaceProductos {
	public void registrarProducto(EntProducto pro);
	public void actualizarProducto(EntProducto pro);
	public void EliminarProducto(int id);
	public 		List<EntProducto> ListarProductos();
	public		EntProducto BuscaProducto(int id);
	public		int ActualizarStock(int id,int stock);
}
