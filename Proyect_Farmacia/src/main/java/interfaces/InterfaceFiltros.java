package interfaces;

import java.util.List;


import model.DTOProducto;
import model.Pedido;



public interface InterfaceFiltros {

	public List<DTOProducto>listaCategoria(int id_cate);
	public List<DTOProducto>listaLaboratorio(int id_lab);
	public List<DTOProducto>listaNombres(String nombre);
	public List<DTOProducto>listaFiltros( Integer cat,Integer lab,String nombre);
	public Pedido crearPedido(int id,int cant); 
}
