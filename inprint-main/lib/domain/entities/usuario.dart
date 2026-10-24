
enum RolUsuario {
  cliente,
  operador,
  administrador,
}

class Usuario {
  final int id;
  final String nombre;
  final String correo;
  final String contrasena;
  final RolUsuario rol;
  final bool activo;

  const Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.rol,
    this.activo = true,
  });
}
