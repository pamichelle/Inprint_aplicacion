
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../viewmodels/pedidos_viewmodel.dart';
import 'crear_pedido_view.dart';

class ServiciosView extends StatefulWidget {
  final PedidosViewModel viewModel;
  final String nombreCliente;

  const ServiciosView({
    super.key,
    required this.viewModel,
    required this.nombreCliente,
  });

  @override
  State<ServiciosView> createState() => _ServiciosViewState();
}

class _ServiciosViewState extends State<ServiciosView> {
  final TextEditingController _busquedaController =
      TextEditingController();

  final List<Map<String, dynamic>> _servicios = [
    {
      'nombre': 'Lonas',
      'descripcion': 'Ideales para publicidad y eventos.',
      'icono': Icons.panorama_outlined,
      'color': AppTheme.rosa,
    },
    {
      'nombre': 'Tarjetas',
      'descripcion': 'Presenta tu marca con gran diseño.',
      'icono': Icons.contact_page_outlined,
      'color': AppTheme.morado,
    },
    {
      'nombre': 'Invitaciones',
      'descripcion': 'Para todo tipo de eventos.',
      'icono': Icons.mail_outline,
      'color': AppTheme.azul,
    },
    {
      'nombre': 'Flyers',
      'descripcion': 'Promociona tus ideas.',
      'icono': Icons.description_outlined,
      'color': AppTheme.amarillo,
    },
    {
      'nombre': 'Etiquetas',
      'descripcion': 'Personaliza tus productos.',
      'icono': Icons.sell_outlined,
      'color': AppTheme.rosa,
    },
    {
      'nombre': 'Copias e impresiones',
      'descripcion': 'Imprime tus documentos fácilmente.',
      'icono': Icons.print_outlined,
      'color': AppTheme.morado,
    },
  ];

  String _busqueda = '';

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  void _abrirPedido(String servicio) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CrearPedidoView(
          viewModel: widget.viewModel,
          nombreCliente: widget.nombreCliente,
          servicioInicial: servicio,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviciosFiltrados = _servicios.where((servicio) {
      final nombre = servicio['nombre'] as String;
      return nombre.toLowerCase().contains(_busqueda.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Servicios',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
              child: TextField(
                controller: _busquedaController,
                onChanged: (valor) {
                  setState(() {
                    _busqueda = valor.trim();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Buscar un servicio...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.tune),
                ),
              ),
            ),
            Expanded(
              child: serviciosFiltrados.isEmpty
                  ? const Center(
                      child: Text('No se encontraron servicios.'),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      itemCount: serviciosFiltrados.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final servicio = serviciosFiltrados[index];
                        final color = servicio['color'] as Color;

                        return Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () => _abrirPedido(
                              servicio['nombre'] as String,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: const Color(0xFFE8E1E5),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 58,
                                    height: 58,
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.13),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      servicio['icono'] as IconData,
                                      color: color,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          servicio['nombre'] as String,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.texto,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          servicio['descripcion'] as String,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Solicitar pedido',
                                          style: TextStyle(
                                            color: AppTheme.rosa,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
