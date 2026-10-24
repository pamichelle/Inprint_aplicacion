
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/usuario.dart';
import '../../../domain/entities/pedido.dart';

import '../../viewmodels/login_viewmodel.dart';
import '../../viewmodels/registro_viewmodel.dart';
import '../../viewmodels/pedidos_viewmodel.dart';

import '../auth/login_view.dart';
import '../pedidos/pedidos_view.dart';
import '../pedidos/crear_pedido_view.dart';
import '../pedidos/servicios_view.dart';
import '../pedidos/cotizacion_view.dart';

import 'mi_cuenta_view.dart';
import 'usuarios_view.dart';
import 'reportes_view.dart';
import 'notificaciones_view.dart';

class DashboardView extends StatelessWidget {
  final Usuario usuario;
  final PedidosViewModel pedidosViewModel;
  final LoginViewModel loginViewModel;
  final RegistroViewModel registroViewModel;

  const DashboardView({
    super.key,
    required this.usuario,
    required this.pedidosViewModel,
    required this.loginViewModel,
    required this.registroViewModel,
  });

  bool get _esCliente => usuario.rol == RolUsuario.cliente;

  bool get _esOperador => usuario.rol == RolUsuario.operador;

  bool get _esAdministrador =>
      usuario.rol == RolUsuario.administrador;

  void _abrirCotizacion(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CotizacionView(),
      ),
    );
  }

  void _abrirNotificaciones(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NotificacionesView(),
      ),
    );
  }

  void _abrirServicios(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiciosView(
          viewModel: pedidosViewModel,
          nombreCliente: usuario.nombre,
        ),
      ),
    );
  }

  void _abrirPedidos(
    BuildContext context, {
    EstadoPedido? estadoFiltro,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PedidosView(
          viewModel: pedidosViewModel,
          soloCliente: _esCliente,
          estadoFiltro: estadoFiltro,
        ),
      ),
    );
  }

  void _abrirCrearPedido(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CrearPedidoView(
          viewModel: pedidosViewModel,
          nombreCliente: usuario.nombre,
        ),
      ),
    );
  }

  void _abrirPedidoDeServicio(
    BuildContext context,
    String servicio,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CrearPedidoView(
          viewModel: pedidosViewModel,
          nombreCliente: usuario.nombre,
          servicioInicial: servicio,
        ),
      ),
    );
  }

  void _abrirMiCuenta(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MiCuentaView(usuario: usuario),
      ),
    );
  }

  void _abrirUsuarios(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UsuariosView(
          usuarios: registroViewModel.usuarios,
        ),
      ),
    );
  }

  void _abrirReportes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReportesView(
          pedidos: pedidosViewModel.pedidos,
          usuarios: registroViewModel.usuarios,
        ),
      ),
    );
  }

  void _cerrarSesion(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => LoginView(
          viewModel: loginViewModel,
          registroViewModel: registroViewModel,
          pedidosViewModel: pedidosViewModel,
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'InPrint',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Notificaciones',
            onPressed: () => _abrirNotificaciones(context),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: () => _cerrarSesion(context),
            icon: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¡Hola, ${usuario.nombre.split(' ').first}!',
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.texto,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                _esCliente
                    ? '¿Qué necesitas imprimir hoy?'
                    : _esOperador
                        ? 'Administra los pedidos de InPrint.'
                        : 'Bienvenido al panel de administración.',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 26),

              if (_esCliente)
                _tarjetaPrincipal(
                  titulo: 'Nuevo pedido',
                  descripcion:
                      'Solicita una cotización o realiza un pedido de impresión.',
                  textoBoton: 'Crear pedido',
                  icono: Icons.add_shopping_cart_rounded,
                  alPresionar: () => _abrirCrearPedido(context),
                )
              else if (_esOperador)
                _tarjetaPrincipal(
                  titulo: 'Gestionar pedidos',
                  descripcion:
                      'Consulta los pedidos y actualiza su estado.',
                  textoBoton: 'Ver pedidos',
                  icono: Icons.inventory_2_outlined,
                  alPresionar: () => _abrirPedidos(context),
                )
              else
                _tarjetaPrincipal(
                  titulo: 'Panel de administración',
                  descripcion:
                      'Consulta pedidos, usuarios y reportes del negocio.',
                  textoBoton: 'Ver reportes',
                  icono: Icons.bar_chart_rounded,
                  alPresionar: () => _abrirReportes(context),
                ),

              const SizedBox(height: 28),

              if (_esCliente) ...[
                const Text(
                  'Tu pedido actual',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.texto,
                  ),
                ),
                const SizedBox(height: 13),
                _tarjetaPedidoActual(),
                const SizedBox(height: 28),
              ],

              if (_esCliente) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Nuestros servicios',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.texto,
                      ),
                    ),
                    TextButton(
                      onPressed: () => _abrirServicios(context),
                      child: const Text('Ver todos'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 115,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _servicioRapido(
                        nombre: 'Lonas',
                        icono: Icons.panorama_outlined,
                        color: AppTheme.rosa,
                        alPresionar: () =>
                            _abrirPedidoDeServicio(context, 'Lonas'),
                      ),
                      _servicioRapido(
                        nombre: 'Tarjetas',
                        icono: Icons.contact_page_outlined,
                        color: AppTheme.morado,
                        alPresionar: () =>
                            _abrirPedidoDeServicio(context, 'Tarjetas'),
                      ),
                      _servicioRapido(
                        nombre: 'Invitaciones',
                        icono: Icons.mail_outline,
                        color: AppTheme.azul,
                        alPresionar: () =>
                            _abrirPedidoDeServicio(context, 'Invitaciones'),
                      ),
                      _servicioRapido(
                        nombre: 'Flyers',
                        icono: Icons.description_outlined,
                        color: AppTheme.rosa,
                        alPresionar: () =>
                            _abrirPedidoDeServicio(context, 'Flyers'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
              ],

              Text(
                _esCliente
                    ? 'Tus opciones'
                    : _esOperador
                        ? 'Pedidos por estado'
                        : 'Administración',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.texto,
                ),
              ),
              const SizedBox(height: 14),

              // Opciones exclusivas del cliente.
              if (_esCliente) ...[
                _opcion(
                  icono: Icons.category_outlined,
                  titulo: 'Servicios',
                  descripcion: 'Explora todo lo que puedes imprimir.',
                  color: AppTheme.rosa,
                  alPresionar: () => _abrirServicios(context),
                ),
                _opcion(
                  icono: Icons.receipt_long_outlined,
                  titulo: 'Mis pedidos',
                  descripcion: 'Consulta el estado de tus pedidos.',
                  color: AppTheme.morado,
                  alPresionar: () => _abrirPedidos(context),
                ),
                _opcion(
                  icono: Icons.person_outline,
                  titulo: 'Mi cuenta',
                  descripcion: 'Consulta tus datos de usuario.',
                  color: AppTheme.azul,
                  alPresionar: () => _abrirMiCuenta(context),
                ),
                _opcion(
                  icono: Icons.request_quote_outlined,
                  titulo: 'Cotización',
                  descripcion:
                      'Revisa el precio y los detalles de tu pedido.',
                  color: AppTheme.morado,
                  alPresionar: () => _abrirCotizacion(context),
                ),
              ],

              // Opciones exclusivas del operador.
              if (_esOperador) ...[
                _opcion(
                  icono: Icons.pending_actions_outlined,
                  titulo: 'Pedidos pendientes',
                  descripcion: 'Pedidos que aún no comienzan.',
                  color: AppTheme.rosa,
                  alPresionar: () => _abrirPedidos(
                    context,
                    estadoFiltro: EstadoPedido.pendiente,
                  ),
                ),
                _opcion(
                  icono: Icons.print_outlined,
                  titulo: 'Pedidos en proceso',
                  descripcion: 'Pedidos que están en producción.',
                  color: AppTheme.morado,
                  alPresionar: () => _abrirPedidos(
                    context,
                    estadoFiltro: EstadoPedido.enProceso,
                  ),
                ),
                _opcion(
                  icono: Icons.check_circle_outline,
                  titulo: 'Pedidos entregados',
                  descripcion: 'Consulta los pedidos entregados.',
                  color: AppTheme.azul,
                  alPresionar: () => _abrirPedidos(
                    context,
                    estadoFiltro: EstadoPedido.entregado,
                  ),
                ),
              ],

              // Opciones exclusivas del administrador.
              if (_esAdministrador) ...[
                _opcion(
                  icono: Icons.inventory_2_outlined,
                  titulo: 'Pedidos',
                  descripcion: 'Consulta y administra los pedidos.',
                  color: AppTheme.rosa,
                  alPresionar: () => _abrirPedidos(context),
                ),
                _opcion(
                  icono: Icons.people_outline,
                  titulo: 'Usuarios',
                  descripcion: 'Consulta los usuarios registrados.',
                  color: AppTheme.morado,
                  alPresionar: () => _abrirUsuarios(context),
                ),
                _opcion(
                  icono: Icons.bar_chart_outlined,
                  titulo: 'Reportes',
                  descripcion: 'Consulta el resumen del negocio.',
                  color: AppTheme.azul,
                  alPresionar: () => _abrirReportes(context),
                ),
              ],

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tarjetaPrincipal({
    required String titulo,
    required String descripcion,
    required String textoBoton,
    required IconData icono,
    required VoidCallback alPresionar,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.rosa, AppTheme.morado],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, size: 37, color: Colors.white),
          const SizedBox(height: 14),
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            descripcion,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: alPresionar,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.rosa,
              minimumSize: const Size(double.infinity, 46),
              elevation: 0,
            ),
            child: Text(textoBoton),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaPedidoActual() {
    final pedidos = pedidosViewModel.pedidos
        .where((pedido) => pedido.nombreCliente == usuario.nombre)
        .toList()
      ..sort((a, b) => b.fecha.compareTo(a.fecha));

    if (pedidos.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8E1E5)),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              color: AppTheme.morado,
              size: 34,
            ),
            SizedBox(height: 10),
            Text(
              'Todavía no tienes pedidos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Cuando registres uno, podrás consultar aquí su estado.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    }

    final pedido = pedidos.first;
    final idTexto = pedido.id.toString();
    final numero = idTexto.length > 4
        ? idTexto.substring(idTexto.length - 4)
        : idTexto;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8E1E5)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.morado.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.print_outlined,
              color: AppTheme.morado,
              size: 27,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pedido.servicio,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Pedido #$numero',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                _etiquetaEstado(pedido.estado),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _etiquetaEstado(EstadoPedido estado) {
    late String texto;
    late Color color;

    switch (estado) {
      case EstadoPedido.pendiente:
        texto = 'Pendiente';
        color = AppTheme.amarillo;
        break;
      case EstadoPedido.enProceso:
        texto = 'En producción';
        color = AppTheme.azul;
        break;
      case EstadoPedido.terminado:
        texto = 'Terminado';
        color = AppTheme.morado;
        break;
      case EstadoPedido.entregado:
        texto = 'Entregado';
        color = Colors.green;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: color == AppTheme.amarillo
              ? const Color(0xFF8A6700)
              : color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _servicioRapido({
    required String nombre,
    required IconData icono,
    required Color color,
    required VoidCallback alPresionar,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: InkWell(
        onTap: alPresionar,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE8E1E5)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icono, color: color, size: 30),
              const SizedBox(height: 9),
              Text(
                nombre,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _opcion({
    required IconData icono,
    required String titulo,
    required String descripcion,
    required Color color,
    required VoidCallback alPresionar,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: alPresionar,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8E1E5)),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icono, color: color, size: 25),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        descripcion,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






