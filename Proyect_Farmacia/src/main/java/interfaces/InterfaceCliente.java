package interfaces;

import java.util.List;

import model.EntCliente;

public interface InterfaceCliente {
	public void registrarCliente(EntCliente clien);
	public void actualizarCliente(EntCliente clien);
	public void EliminarCliente(EntCliente clien);
	public 		List<EntCliente> ListarClientes();
	public		EntCliente BuscaCliente(EntCliente clien);
}
