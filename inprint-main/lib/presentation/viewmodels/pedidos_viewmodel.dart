
import 'package:flutter/material.dart';

import '../../domain/entities/pedido.dart';
import '../../domain/repositories/pedido_repository.dart';

class PedidosViewModel extends ChangeNotifier {
  final PedidoRepository _pedidoRepository;

  PedidosViewModel(this._pedidoRepository);

  List<Pedido> get pedidos => _pedidoRepository.obtenerPedidos();

  void agregarPedido({
    required String nombreCliente,
    required String servicio,
    required String descripcion,
  }) {
    final pedido = Pedido(
      id: DateTime.now().microsecondsSinceEpoch,
      nombreCliente: nombreCliente.trim(),
      servicio: servicio,
      descripcion: descripcion.trim(),
      fecha: DateTime.now(),
    );

    _pedidoRepository.agregarPedido(pedido);
    notifyListeners();
  }

  void cambiarEstado(int id, EstadoPedido nuevoEstado) {
    _pedidoRepository.cambiarEstado(id, nuevoEstado);
    notifyListeners();
  }
}
