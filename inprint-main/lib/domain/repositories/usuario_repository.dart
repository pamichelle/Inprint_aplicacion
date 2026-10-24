
import '../entities/usuario.dart';

abstract class UsuarioRepository {
  Usuario? iniciarSesion(String correo, String contrasena);

  bool registrarUsuario(Usuario usuario);

  List<Usuario> obtenerUsuarios();
}
