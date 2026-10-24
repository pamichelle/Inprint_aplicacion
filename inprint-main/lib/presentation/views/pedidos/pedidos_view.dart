
import 'package:flutter/material.dart';

import '../../../domain/entities/pedido.dart';
import '../../viewmodels/pedidos_viewmodel.dart';

class PedidosView extends StatelessWidget {
  final PedidosViewModel viewModel;
  final bool soloCliente;
  final EstadoPedido? estadoFiltro;

  const PedidosView({
    super.key,
    required this.viewModel,
    this.soloCliente = false,
    this.estadoFiltro,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, child) {
        final pedidos = viewModel.pedidos.where((pedido) {
          if (estadoFiltro != null) {
            return pedido.estado == estadoFiltro;
          }
          return true;
        }).toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Pedidos'),
          ),
          body: pedidos.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 76,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No hay pedidos todavía',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Cuando se registre un pedido, aparecerá aquí.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: pedidos.length,
                  itemBuilder: (context, index) {
                    final pedido = pedidos[index];

                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Color(0xFFE8E1E5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Color(0xFFFFE1EF),
                                  child: Icon(
                                    Icons.print_outlined,
                                    color: Color(0xFFEE1A80),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    pedido.servicio,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text('Cliente: ${pedido.nombreCliente}'),
                            const SizedBox(height: 6),
                            Text('Descripción: ${pedido.descripcion}'),
                            const SizedBox(height: 6),
                            Text(
                              'Fecha: ${pedido.fecha.day}/'
                              '${pedido.fecha.month}/'
                              '${pedido.fecha.year}',
                            ),
                            const SizedBox(height: 12),
                            _EstadoEtiqueta(estado: pedido.estado),
                            if (!soloCliente) ...[
                              const SizedBox(height: 12),
                              DropdownButtonFormField<EstadoPedido>(
                                value: pedido.estado,
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  labelText: 'Cambiar estado',
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                                items: EstadoPedido.values.map((estado) {
                                  return DropdownMenuItem(
                                    value: estado,
                                    child: Text(
                                      _nombreEstado(estado),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (nuevoEstado) {
                                  if (nuevoEstado != null) {
                                    viewModel.cambiarEstado(
                                      pedido.id,
                                      nuevoEstado,
                                    );
                                  }
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

String _nombreEstado(EstadoPedido estado) {
  switch (estado) {
    case EstadoPedido.pendiente:
      return 'Pendiente';
    case EstadoPedido.enProceso:
      return 'En proceso';
    case EstadoPedido.terminado:
      return 'Terminado';
    case EstadoPedido.entregado:
      return 'Entregado';
  }
}

class _EstadoEtiqueta extends StatelessWidget {
  final EstadoPedido estado;

  const _EstadoEtiqueta({required this.estado});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: estado == EstadoPedido.entregado
            ? const Color(0xFFDDF5E5)
            : estado == EstadoPedido.enProceso
                ? const Color(0xFFDDF0FF)
                : estado == EstadoPedido.terminado
                    ? const Color(0xFFFFF0C2)
                    : const Color(0xFFFFE1EF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _nombreEstado(estado),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
