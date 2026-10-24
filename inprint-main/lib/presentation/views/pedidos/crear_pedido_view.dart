
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../viewmodels/pedidos_viewmodel.dart';


class CrearPedidoView extends StatefulWidget {
  final PedidosViewModel viewModel;
  final String nombreCliente;
  final String? servicioInicial;

  const CrearPedidoView({
    super.key,
    required this.viewModel,
    required this.nombreCliente,
    this.servicioInicial,
  });

  @override
  State<CrearPedidoView> createState() => _CrearPedidoViewState();
}


class _CrearPedidoViewState extends State<CrearPedidoView> {
  final _formKey = GlobalKey<FormState>();

  final _cantidadController = TextEditingController();
  final _comentariosController = TextEditingController();

  final List<String> _servicios = [
    'Lonas',
    'Tarjetas',
    'Invitaciones',
    'Flyers',
    'Etiquetas',
    'Copias e impresiones',
  ];

  final List<String> _tamanos = [
    'Carta (21 x 28 cm)',
    'Media carta',
    'Oficio',
    'Personalizado',
  ];

  final List<String> _materiales = [
    'Couché',
    'Opalina',
    'Bond',
    'Vinil',
    'Otro',
  ];

  final List<String> _acabados = [
    'Sin acabado',
    'Brillante',
    'Mate',
    'Laminado',
  ];

  String? _servicioSeleccionado;
  String? _tamanoSeleccionado;
  String? _materialSeleccionado;
  String? _acabadoSeleccionado;

  
@override
void initState() {
  super.initState();
  _servicioSeleccionado = widget.servicioInicial;
}

  @override
  void dispose() {
    _cantidadController.dispose();
    _comentariosController.dispose();
    super.dispose();
  }

  void _registrarPedido() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final descripcion = '''
Cantidad: ${_cantidadController.text.trim()} piezas
Tamaño: $_tamanoSeleccionado
Material: $_materialSeleccionado
Acabado: $_acabadoSeleccionado
Comentarios: ${_comentariosController.text.trim().isEmpty ? 'Sin comentarios' : _comentariosController.text.trim()}
''';

    widget.viewModel.agregarPedido(
      nombreCliente: widget.nombreCliente,
      servicio: _servicioSeleccionado!,
      descripcion: descripcion.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Tu pedido se registró correctamente!'),
        backgroundColor: AppTheme.morado,
      ),
    );

    Navigator.pop(context);
  }

  Widget _tituloCampo(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppTheme.texto,
        ),
      ),
    );
  }

  Widget _crearSelector({
    required String titulo,
    required String pista,
    required String? valor,
    required List<String> opciones,
    required ValueChanged<String?> alCambiar,
    required IconData icono,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tituloCampo(titulo),
        DropdownButtonFormField<String>(
          value: valor,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: pista,
            prefixIcon: Icon(icono),
          ),
          items: opciones.map((opcion) {
            return DropdownMenuItem<String>(
              value: opcion,
              child: Text(
                opcion,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: alCambiar,
          validator: (valor) {
            if (valor == null || valor.isEmpty) {
              return 'Selecciona una opción';
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nuevo pedido',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(22),
            children: [
              // Encabezado
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppTheme.rosa,
                      AppTheme.morado,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.print_outlined,
                      color: Colors.white,
                      size: 36,
                    ),
                    SizedBox(height: 12),
                    Text(
                      '¡Hagamos realidad tu idea!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Cuéntanos cómo quieres tu impresión.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // Tipo de producto
              _crearSelector(
                titulo: 'Tipo de producto',
                pista: 'Selecciona un servicio',
                valor: _servicioSeleccionado,
                opciones: _servicios,
                icono: Icons.category_outlined,
                alCambiar: (valor) {
                  setState(() {
                    _servicioSeleccionado = valor;
                  });
                },
              ),

              const SizedBox(height: 22),

              // Cantidad
              _tituloCampo('Cantidad'),
              TextFormField(
                controller: _cantidadController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Ej. 100',
                  prefixIcon: Icon(Icons.numbers_outlined),
                  suffixText: 'piezas',
                ),
                validator: (valor) {
                  final cantidad = int.tryParse(valor?.trim() ?? '');

                  if (cantidad == null || cantidad <= 0) {
                    return 'Ingresa una cantidad válida';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 22),

              // Tamaño
              _crearSelector(
                titulo: 'Tamaño',
                pista: 'Selecciona el tamaño',
                valor: _tamanoSeleccionado,
                opciones: _tamanos,
                icono: Icons.straighten_outlined,
                alCambiar: (valor) {
                  setState(() {
                    _tamanoSeleccionado = valor;
                  });
                },
              ),

              const SizedBox(height: 22),

              // Material
              _crearSelector(
                titulo: 'Material',
                pista: 'Selecciona el material',
                valor: _materialSeleccionado,
                opciones: _materiales,
                icono: Icons.layers_outlined,
                alCambiar: (valor) {
                  setState(() {
                    _materialSeleccionado = valor;
                  });
                },
              ),

              const SizedBox(height: 22),

              // Acabado
              _crearSelector(
                titulo: 'Acabado',
                pista: 'Selecciona el acabado',
                valor: _acabadoSeleccionado,
                opciones: _acabados,
                icono: Icons.auto_awesome_outlined,
                alCambiar: (valor) {
                  setState(() {
                    _acabadoSeleccionado = valor;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Archivo adjunto
              _tituloCampo('Adjuntar archivo (opcional)'),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFE8E1E5),
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.cloud_upload_outlined,
                      size: 34,
                      color: AppTheme.morado,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '¿Ya tienes tu diseño?',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'La selección de archivos estará disponible próximamente.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Selecciona un archivo'),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Puedes continuar sin adjuntar un archivo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // Comentarios
              _tituloCampo('Comentarios adicionales'),
              TextFormField(
                controller: _comentariosController,
                maxLines: 4,
                maxLength: 300,
                decoration: const InputDecoration(
                  hintText: 'Agrega indicaciones para tu pedido...',
                  prefixIcon: Icon(Icons.description_outlined),
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 26),

              // Registrar pedido
              ElevatedButton.icon(
                onPressed: _registrarPedido,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Registrar pedido'),
              ),

              const SizedBox(height: 12),

              // Cancelar
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  foregroundColor: AppTheme.rosa,
                  side: const BorderSide(color: AppTheme.rosa),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Cancelar'),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
