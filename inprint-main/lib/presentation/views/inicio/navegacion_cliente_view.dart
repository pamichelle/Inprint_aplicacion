
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/usuario.dart';
import '../../viewmodels/login_viewmodel.dart';
import '../../viewmodels/registro_viewmodel.dart';
import '../../viewmodels/pedidos_viewmodel.dart';

import 'dashboard_view.dart';
import 'mi_cuenta_view.dart';
import '../pedidos/pedidos_view.dart';

class NavegacionClienteView extends StatefulWidget {
  final Usuario usuario;
  final PedidosViewModel pedidosViewModel;
  final LoginViewModel loginViewModel;
  final RegistroViewModel registroViewModel;

  const NavegacionClienteView({
    super.key,
    required this.usuario,
    required this.pedidosViewModel,
    required this.loginViewModel,
    required this.registroViewModel,
  });

  @override
  State<NavegacionClienteView> createState() =>
      _NavegacionClienteViewState();
}

class _NavegacionClienteViewState
    extends State<NavegacionClienteView> {
  int _indiceSeleccionado = 0;

  void _cambiarSeccion(int indice) {
    setState(() {
      _indiceSeleccionado = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pantallas = [
      DashboardView(
        usuario: widget.usuario,
        pedidosViewModel: widget.pedidosViewModel,
        loginViewModel: widget.loginViewModel,
        registroViewModel: widget.registroViewModel,
      ),
      Scaffold(
        appBar: AppBar(
          title: const Text('Mis pedidos'),
        ),
        body: SafeArea(
          child: PedidosView(
            viewModel: widget.pedidosViewModel,
            soloCliente: true,
          ),
        ),
      ),
      Scaffold(
        appBar: AppBar(
          title: const Text('Mi cuenta'),
        ),
        body: SafeArea(
          child: MiCuentaView(usuario: widget.usuario),
        ),
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _indiceSeleccionado,
        children: pantallas,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceSeleccionado,
        onDestinationSelected: _cambiarSeccion,
        backgroundColor: Colors.white,
        indicatorColor: AppTheme.rosa.withValues(alpha: 0.14),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Pedidos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
