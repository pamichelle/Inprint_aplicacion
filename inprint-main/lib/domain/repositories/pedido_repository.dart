
import '../entities/pedido.dart';

abstract class PedidoRepository {
  List<Pedido> obtenerPedidos();

  void agregarPedido(Pedido pedido);

  void cambiarEstado(int id, EstadoPedido nuevoEstado);
}
