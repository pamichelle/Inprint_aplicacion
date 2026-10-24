
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/usuario.dart';

import '../../viewmodels/login_viewmodel.dart';
import '../../viewmodels/registro_viewmodel.dart';
import '../../viewmodels/pedidos_viewmodel.dart';

import '../inicio/dashboard_view.dart';
import '../inicio/navegacion_cliente_view.dart';
import 'registro_view.dart';

class LoginView extends StatefulWidget {
  final LoginViewModel viewModel;
  final RegistroViewModel registroViewModel;
  final PedidosViewModel pedidosViewModel;

  const LoginView({
    super.key,
    required this.viewModel,
    required this.registroViewModel,
    required this.pedidosViewModel,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  void _iniciarSesion() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final correcto = widget.viewModel.iniciarSesion();

    if (!correcto) {
      setState(() {});
      return;
    }

    final usuario = widget.viewModel.usuarioAutenticado;

    if (usuario == null) {
      return;
    }

    final Widget pantalla;

    if (usuario.rol == RolUsuario.cliente) {
      pantalla = NavegacionClienteView(
        usuario: usuario,
        pedidosViewModel: widget.pedidosViewModel,
        loginViewModel: widget.viewModel,
        registroViewModel: widget.registroViewModel,
      );
    } else {
      pantalla = DashboardView(
        usuario: usuario,
        pedidosViewModel: widget.pedidosViewModel,
        loginViewModel: widget.viewModel,
        registroViewModel: widget.registroViewModel,
      );
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => pantalla),
    );
  }

  void _abrirRegistro() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistroView(
          viewModel: widget.registroViewModel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppTheme.fondo,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 25),

                      
Image.asset(
  'assets/images/InPrintLOGO.jpeg',
  height: 100,
  fit: BoxFit.contain,
),


                      const SizedBox(height: 15),

                      const Text(
                        'InPrint',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.rosa,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Tus ideas, impresas.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 35),

                      const Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.texto,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Ingresa tus datos para continuar.',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 25),

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: widget.viewModel.cambiarCorreo,
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFFE8E1E5),
                            ),
                          ),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Ingresa tu correo electrónico.';
                          }

                          if (!valor.contains('@') ||
                              !valor.contains('.')) {
                            return 'Ingresa un correo válido.';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      TextFormField(
                        obscureText:
                            widget.viewModel.ocultarContrasena,
                        onChanged:
                            widget.viewModel.cambiarContrasena,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _iniciarSesion(),
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                          ),
                          suffixIcon: IconButton(
                            onPressed: widget.viewModel
                                .cambiarVisibilidadContrasena,
                            icon: Icon(
                              widget.viewModel.ocultarContrasena
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFFE8E1E5),
                            ),
                          ),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return 'Ingresa tu contraseña.';
                          }

                          return null;
                        },
                      ),

                      if (widget.viewModel.error != null) ...[
                        const SizedBox(height: 14),
                        Text(
                          widget.viewModel.error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        ),
                      ],

                      const SizedBox(height: 25),

                      ElevatedButton(
                        onPressed: widget.viewModel.cargando
                            ? null
                            : _iniciarSesion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.rosa,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(
                            double.infinity,
                            52,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: widget.viewModel.cargando
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            child: Text(
                              '¿No tienes una cuenta?',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: _abrirRegistro,
                            child: const Text(
                              'Regístrate',
                              style: TextStyle(
                                color: AppTheme.rosa,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


