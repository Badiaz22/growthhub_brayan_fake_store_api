/// Botón icónico de la cabecera principal.
library;

import 'package:flutter/material.dart';

/// Botón de 40×40 que muestra un icono de Material con el color neutro de la
/// cabecera.
///
/// Se usa exclusivamente en [AppHeader] para los iconos de menú y perfil.
/// El área de toque mínima de 40×40 cumple las guías de accesibilidad de
/// Material Design.
///
/// Ejemplo de uso:
/// ```dart
/// HeaderIconButton(icon: Icons.menu_rounded)
/// ```
class HeaderIconButton extends StatelessWidget {
  /// Icono de Material que se renderiza dentro del botón.
  final IconData icon;

  /// Crea el botón con el [icon] especificado.
  const HeaderIconButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Icon(icon, color: const Color(0xFF475569), size: 24),
    );
  }
}
