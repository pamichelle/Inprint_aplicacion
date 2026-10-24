
import '../../domain/entities/pedido.dart';
import '../../domain/repositories/pedido_repository.dart';

class PedidoRepositoryImpl implements PedidoRepository {
  final List<Pedido> _pedidos = [];

  @override
  List<Pedido> obtenerPedidos() {
    return List.unmodifiable(_pedidos);
  }

  @override
  void agregarPedido(Pedido pedido) {
    _pedidos.add(pedido);
  }

  @override
  void cambiarEstado(int id, EstadoPedido nuevoEstado) {
    final indice = _pedidos.indexWhere(
      (pedido) => pedido.id == id,
    );

    if (indice != -1) {
      _pedidos[indice].estado = nuevoEstado;
    }
  }
}
