
import 'package:flutter/material.dart';

import '../../viewmodels/registro_viewmodel.dart';

import '../../../domain/entities/usuario.dart';

class RegistroView extends StatefulWidget {
  final RegistroViewModel viewModel;

  const RegistroView({
    super.key,
    required this.viewModel,
  });

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final _formKey = GlobalKey<FormState>();
  bool _ocultarContrasena = true;

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;

    return AnimatedBuilder(
      animation: vm,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Crear cuenta')),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '¡Únete a InPrint!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Crea tu cuenta para comenzar',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),

                    TextFormField(
                      onChanged: vm.cambiarNombre,
                      decoration: const InputDecoration(
                        labelText: 'Nombre completo',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Ingresa tu nombre'
                              : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      onChanged: vm.cambiarCorreo,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Ingresa tu correo';
                        }
                        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(value.trim())) {
                          return 'Ingresa un correo válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      onChanged: vm.cambiarContrasena,
                      obscureText: _ocultarContrasena,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _ocultarContrasena = !_ocultarContrasena;
                            });
                          },
                          icon: Icon(
                            _ocultarContrasena
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa una contraseña';
                        }
                        if (value.length < 6) {
                          return 'Usa al menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Tipo de cuenta',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),

                    DropdownButtonFormField<RolUsuario>(
                      value: vm.rol,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.badge_outlined),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: RolUsuario.cliente,
                          child: Text('Cliente'),
                        ),
                        DropdownMenuItem(
                          value: RolUsuario.operador,
                          child: Text('Operador'),
                        ),
                        DropdownMenuItem(
                          value: RolUsuario.administrador,
                          child: Text('Administrador'),
                        ),
                      ],
                      onChanged: (valor) {
                        if (valor != null) vm.cambiarRol(valor);
                      },
                    ),

                    if (vm.error != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        vm.error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ],

                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        final correcto = vm.registrar();

                        if (correcto && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('¡Cuenta creada correctamente!'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Crear cuenta'),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Ya tengo una cuenta'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

