
import 'package:flutter/material.dart';

import '../../domain/entities/usuario.dart';
import '../../domain/repositories/usuario_repository.dart';

class RegistroViewModel extends ChangeNotifier {
  final UsuarioRepository _usuarioRepository;

  RegistroViewModel(this._usuarioRepository);

  String nombre = '';
  String correo = '';
  String contrasena = '';
  RolUsuario rol = RolUsuario.cliente;
  String? error;
  bool registroExitoso = false;

  List<Usuario> get usuarios => _usuarioRepository.obtenerUsuarios();

  void cambiarNombre(String valor) {
    nombre = valor;
    notifyListeners();
  }

  void cambiarCorreo(String valor) {
    correo = valor;
    notifyListeners();
  }

  void cambiarContrasena(String valor) {
    contrasena = valor;
    notifyListeners();
  }

  void cambiarRol(RolUsuario valor) {
    rol = valor;
    notifyListeners();
  }

  bool registrar() {
    error = null;
    registroExitoso = false;

    if (nombre.trim().isEmpty ||
        correo.trim().isEmpty ||
        contrasena.isEmpty) {
      error = 'Completa todos los campos.';
      notifyListeners();
      return false;
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(correo.trim())) {
      error = 'Ingresa un correo válido.';
      notifyListeners();
      return false;
    }

    if (contrasena.length < 6) {
      error = 'La contraseña debe tener al menos 6 caracteres.';
      notifyListeners();
      return false;
    }

    final usuario = Usuario(
      id: DateTime.now().microsecondsSinceEpoch,
      nombre: nombre.trim(),
      correo: correo.trim().toLowerCase(),
      contrasena: contrasena,
      rol: rol,
    );

    final registrado = _usuarioRepository.registrarUsuario(usuario);

    if (!registrado) {
      error = 'Ya existe una cuenta con ese correo.';
      notifyListeners();
      return false;
    }

    registroExitoso = true;
    notifyListeners();
    return true;
  }
}

