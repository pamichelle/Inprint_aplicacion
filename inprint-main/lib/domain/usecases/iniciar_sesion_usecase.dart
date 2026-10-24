
import '../entities/usuario.dart';
import '../repositories/usuario_repository.dart';

class IniciarSesionUseCase {
  final UsuarioRepository _usuarioRepository;

  IniciarSesionUseCase(this._usuarioRepository);

  Usuario? ejecutar(String correo, String contrasena) {
    if (correo.trim().isEmpty || contrasena.isEmpty) {
      return null;
    }

    return _usuarioRepository.iniciarSesion(
      correo,
      contrasena,
    );
  }
}
