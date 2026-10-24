
import 'package:flutter/material.dart';

import '../../../domain/entities/pedido.dart';
import '../../../domain/entities/usuario.dart';

class ReportesView extends StatelessWidget {
  final List<Pedido> pedidos;
  final List<Usuario> usuarios;

  const ReportesView({
    super.key,
    required this.pedidos,
    required this.usuarios,
  });

  @override
  Widget build(BuildContext context) {
    final pendientes = pedidos
        .where((p) => p.estado == EstadoPedido.pendiente)
        .length;

    final enProceso = pedidos
        .where((p) => p.estado == EstadoPedido.enProceso)
        .length;

    final terminados = pedidos
        .where((p) => p.estado == EstadoPedido.terminado)
        .length;

    final entregados = pedidos
        .where((p) => p.estado == EstadoPedido.entregado)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reportes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen general',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF171923),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Consulta el estado actual de InPrint.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),

            _TarjetaReporte(
              titulo: 'Total de pedidos',
              cantidad: pedidos.length,
              icono: Icons.receipt_long_outlined,
              color: const Color(0xFF9D35E5),
            ),
            _TarjetaReporte(
              titulo: 'Pedidos pendientes',
              cantidad: pendientes,
              icono: Icons.pending_actions,
              color: const Color(0xFFEE1A80),
            ),
            _TarjetaReporte(
              titulo: 'Pedidos en proceso',
              cantidad: enProceso,
              icono: Icons.print_outlined,
              color: const Color(0xFF20ACE9),
            ),
            _TarjetaReporte(
              titulo: 'Pedidos terminados',
              cantidad: terminados,
              icono: Icons.task_alt,
              color: const Color(0xFFCC9500),
            ),
            _TarjetaReporte(
              titulo: 'Pedidos entregados',
              cantidad: entregados,
              icono: Icons.check_circle_outline,
              color: const Color(0xFF299764),
            ),
            _TarjetaReporte(
              titulo: 'Usuarios registrados',
              cantidad: usuarios.length,
              icono: Icons.people_outline,
              color: const Color(0xFF9D35E5),
            ),

            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE8E1E5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Avance de los pedidos',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  LinearProgressIndicator(
                    value: pedidos.isEmpty
                        ? 0
                        : entregados / pedidos.length,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: const Color(0xFFFFE1EF),
                    color: const Color(0xFFEE1A80),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    pedidos.isEmpty
                        ? 'Todavía no hay pedidos registrados.'
                        : '$entregados de ${pedidos.length} pedidos entregados.',
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TarjetaReporte extends StatelessWidget {
  final String titulo;
  final int cantidad;
  final IconData icono;
  final Color color;

  const _TarjetaReporte({
    required this.titulo,
    required this.cantidad,
    required this.icono,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8E1E5),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(
              icono,
              color: color,
              size: 27,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              titulo,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$cantidad',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
