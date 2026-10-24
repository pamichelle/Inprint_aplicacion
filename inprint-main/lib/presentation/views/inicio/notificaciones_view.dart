
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class NotificacionesView extends StatelessWidget {
  const NotificacionesView({super.key});

  static const List<Map<String, dynamic>> _notificaciones = [
    {
      'titulo': 'Tu pedido está listo',
      'mensaje': 'Tu pedido #0041 ya puede recogerse en la imprenta.',
      'fecha': '12 abr 2026 · 10:24 a. m.',
      'icono': Icons.check_circle_outline,
      'color': Colors.green,
    },
    {
      'titulo': 'Cotización disponible',
      'mensaje': 'Ya puedes revisar la cotización de tu pedido #0042.',
      'fecha': '10 abr 2026 · 6:15 p. m.',
      'icono': Icons.request_quote_outlined,
      'color': AppTheme.morado,
    },
    {
      'titulo': 'En producción',
      'mensaje': 'Tu pedido #0042 se encuentra en producción.',
      'fecha': '8 abr 2026 · 2:30 p. m.',
      'icono': Icons.print_outlined,
      'color': AppTheme.azul,
    },
    {
      'titulo': 'Nuevo mensaje',
      'mensaje': 'El administrador ha respondido tu consulta.',
      'fecha': '7 abr 2026 · 7:20 p. m.',
      'icono': Icons.chat_bubble_outline,
      'color': AppTheme.rosa,
    },
    {
      'titulo': 'Pedido recibido',
      'mensaje': 'Tu pedido #0041 ha sido recibido y está en revisión.',
      'fecha': '5 abr 2026 · 9:10 a. m.',
      'icono': Icons.receipt_long_outlined,
      'color': AppTheme.amarillo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notificaciones',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Mantente al tanto',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppTheme.texto,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Aquí encontrarás las novedades de tus pedidos.',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 22),
            ..._notificaciones.map((notificacion) {
              final color = notificacion['color'] as Color;
              final icono = notificacion['icono'] as IconData;

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE8E1E5),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.13),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        icono,
                        color: color == AppTheme.amarillo
                            ? const Color(0xFF9B7600)
                            : color,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notificacion['titulo'] as String,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.texto,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            notificacion['mensaje'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.4,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            notificacion['fecha'] as String,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
