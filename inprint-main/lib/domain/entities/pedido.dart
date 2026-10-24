
enum EstadoPedido {
  pendiente,
  enProceso,
  terminado,
  entregado,
}

class Pedido {
  final int id;
  final String nombreCliente;
  final String servicio;
  final String descripcion;
  final DateTime fecha;
  EstadoPedido estado;

  Pedido({
    required this.id,
    required this.nombreCliente,
    required this.servicio,
    required this.descripcion,
    required this.fecha,
    this.estado = EstadoPedido.pendiente,
  });
}
