package interfaces;

import java.util.List;

import model.EntCliente;
import model.EntComprobante;
import model.EntDetalleCDP;
import model.EntUsuario;
import model.Pedido;

public interface InterfaceVenta {

	public List<EntCliente> buscarClienteName( String name );
	public int registrarCompra(EntComprobante com,List<Pedido> listPedido,EntUsuario usu);
	public EntCliente registrarClienteVenta(EntCliente cli);
	public EntComprobante buscarComprobante(int idCdp);
	public List<EntDetalleCDP> buscarDetalleComprobante(int idCdp);
}
