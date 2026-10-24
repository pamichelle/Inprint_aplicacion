
import 'package:flutter/material.dart';

import '../../../domain/entities/usuario.dart';

class UsuariosView extends StatefulWidget {
  final List<Usuario> usuarios;

  const UsuariosView({
    super.key,
    required this.usuarios,
  });

  @override
  State<UsuariosView> createState() => _UsuariosViewState();
}

class _UsuariosViewState extends State<UsuariosView> {
  String busqueda = '';

  @override
  Widget build(BuildContext context) {
    final usuariosFiltrados = widget.usuarios.where((usuario) {
      final texto = busqueda.trim().toLowerCase();

      return usuario.nombre.toLowerCase().contains(texto) ||
          usuario.correo.toLowerCase().contains(texto) ||
          _nombreRol(usuario.rol).toLowerCase().contains(texto);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Usuarios',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (valor) {
                setState(() {
                  busqueda = valor;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Buscar usuario...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  color: Color(0xFFEE1A80),
                ),
                const SizedBox(width: 8),
                Text(
                  'Usuarios registrados: ${widget.usuarios.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: usuariosFiltrados.isEmpty
                ? Center(
                    child: Text(
                      busqueda.isEmpty
                          ? 'Todavía no hay usuarios registrados.'
                          : 'No se encontraron usuarios.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: usuariosFiltrados.length,
                    itemBuilder: (context, index) {
                      final usuario = usuariosFiltrados[index];

                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xFFE8E1E5),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(14),
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFFFE1EF),
                            child: Icon(
                              Icons.person_outline,
                              color: Color(0xFFEE1A80),
                            ),
                          ),
                          title: Text(
                            usuario.nombre,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(usuario.correo),
                                const SizedBox(height: 6),
                                Text(
                                  'Rol: ${_nombreRol(usuario.rol)}',
                                  style: const TextStyle(
                                    color: Color(0xFF9D35E5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

String _nombreRol(RolUsuario rol) {
  switch (rol) {
    case RolUsuario.cliente:
      return 'Cliente';
    case RolUsuario.operador:
      return 'Operador';
    case RolUsuario.administrador:
      return 'Administrador';
  }
}
