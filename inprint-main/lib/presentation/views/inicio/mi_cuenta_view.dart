
import 'package:flutter/material.dart';

import '../../../domain/entities/usuario.dart';

class MiCuentaView extends StatelessWidget {
  final Usuario usuario;

  const MiCuentaView({
    super.key,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi cuenta',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xFFFFE1EF),
              child: Icon(
                Icons.person_outline,
                size: 54,
                color: Color(0xFFEE1A80),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              usuario.nombre,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF171923),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Información de tu cuenta',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 30),
            _DatoCuenta(
              icono: Icons.person_outline,
              titulo: 'Nombre completo',
              valor: usuario.nombre,
            ),
            const SizedBox(height: 14),
            _DatoCuenta(
              icono: Icons.email_outlined,
              titulo: 'Correo electrónico',
              valor: usuario.correo,
            ),
            const SizedBox(height: 14),
            _DatoCuenta(
              icono: Icons.badge_outlined,
              titulo: 'Tipo de cuenta',
              valor: _nombreRol(usuario.rol),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE8E1E5),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.favorite_outline,
                    color: Color(0xFFEE1A80),
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Gracias por confiar en InPrint. '
                      '¡Tu idea en tus manos!',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
}

class _DatoCuenta extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String valor;

  const _DatoCuenta({
    required this.icono,
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8E1E5),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFFE1EF),
            child: Icon(
              icono,
              color: const Color(0xFFEE1A80),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
