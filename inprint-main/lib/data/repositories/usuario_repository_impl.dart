
import '../../domain/entities/usuario.dart';
import '../../domain/repositories/usuario_repository.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final List<Usuario> _usuarios = [];

  @override
  Usuario? iniciarSesion(String correo, String contrasena) {
    final correoLimpio = correo.trim().toLowerCase();

    for (final usuario in _usuarios) {
      if (usuario.correo.toLowerCase() == correoLimpio &&
          usuario.contrasena == contrasena &&
          usuario.activo) {
        return usuario;
      }
    }

    return null;
  }

  @override
  bool registrarUsuario(Usuario usuario) {
    final correoLimpio = usuario.correo.trim().toLowerCase();

    final existe = _usuarios.any(
      (u) => u.correo.trim().toLowerCase() == correoLimpio,
    );

    if (existe) {
      return false;
    }

    _usuarios.add(usuario);
    return true;
  }

  @override
  List<Usuario> obtenerUsuarios() {
    return List.unmodifiable(_usuarios);
  }
}
