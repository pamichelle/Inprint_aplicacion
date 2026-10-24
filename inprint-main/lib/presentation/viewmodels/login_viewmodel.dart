
import 'package:flutter/material.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/usecases/iniciar_sesion_usecase.dart';

class LoginViewModel extends ChangeNotifier {
  final IniciarSesionUseCase _iniciarSesionUseCase;

  LoginViewModel(this._iniciarSesionUseCase);

  String correo = '';
  String contrasena = '';
  String? error;
  bool cargando = false;
  bool ocultarContrasena = true;

  Usuario? usuarioAutenticado;

  void cambiarCorreo(String valor) {
    correo = valor;
    error = null;
    notifyListeners();
  }

  void cambiarContrasena(String valor) {
    contrasena = valor;
    error = null;
    notifyListeners();
  }

  void cambiarVisibilidadContrasena() {
    ocultarContrasena = !ocultarContrasena;
    notifyListeners();
  }

  bool iniciarSesion() {
    if (correo.trim().isEmpty || contrasena.isEmpty) {
      error = 'Completa todos los campos.';
      notifyListeners();
      return false;
    }

    cargando = true;
    error = null;
    notifyListeners();

    final usuario = _iniciarSesionUseCase.ejecutar(
      correo,
      contrasena,
    );

    cargando = false;

    if (usuario == null) {
      error = 'Correo o contraseña incorrectos.';
      notifyListeners();
      return false;
    }

    usuarioAutenticado = usuario;
    notifyListeners();
    return true;
  }
}
