package interfaces;

import java.util.List;

import model.EntCategoria;
import model.EntLaboratorio;
import model.EntProveedor;

public interface InterfaceListado {
	public List<EntCategoria>listaCategoria();
	public List<EntLaboratorio>listaLaboratorio();
	public List<EntProveedor>listaProveedor();
}
