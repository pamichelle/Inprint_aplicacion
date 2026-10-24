
import 'package:flutter/material.dart';

import '../../viewmodels/login_viewmodel.dart';
import '../../viewmodels/registro_viewmodel.dart';
import '../../viewmodels/pedidos_viewmodel.dart';
import '../auth/login_view.dart';

class SplashView extends StatefulWidget {
  final LoginViewModel loginViewModel;
  final RegistroViewModel registroViewModel;
  final PedidosViewModel pedidosViewModel;

  const SplashView({
    super.key,
    required this.loginViewModel,
    required this.registroViewModel,
    required this.pedidosViewModel,
  });

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => LoginView(
            viewModel: widget.loginViewModel,
            registroViewModel: widget.registroViewModel,
            pedidosViewModel: widget.pedidosViewModel,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/InPrintLOGO.jpeg',
              width: 260,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              color: Color(0xFFEE1A80),
            ),
          ],
        ),
      ),
    );
  }
}


