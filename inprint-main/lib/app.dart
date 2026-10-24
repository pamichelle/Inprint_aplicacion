
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/usuario_repository_impl.dart';
import 'data/repositories/pedido_repository_impl.dart';
import 'domain/usecases/iniciar_sesion_usecase.dart';
import 'presentation/viewmodels/login_viewmodel.dart';
import 'presentation/viewmodels/registro_viewmodel.dart';
import 'presentation/viewmodels/pedidos_viewmodel.dart';
import 'presentation/views/splash/splash_view.dart';

class InPrintApp extends StatelessWidget {
  InPrintApp({super.key});

  final _usuarioRepository = UsuarioRepositoryImpl();
  final _pedidoRepository = PedidoRepositoryImpl();

  late final LoginViewModel _loginViewModel =
      LoginViewModel(
    IniciarSesionUseCase(_usuarioRepository),
  );

  late final RegistroViewModel _registroViewModel =
      RegistroViewModel(_usuarioRepository);

  late final PedidosViewModel _pedidosViewModel =
      PedidosViewModel(_pedidoRepository);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InPrint',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
     home: SplashView(
  loginViewModel: _loginViewModel,
  registroViewModel: _registroViewModel,
  pedidosViewModel: _pedidosViewModel,
),
    );
  }
}




