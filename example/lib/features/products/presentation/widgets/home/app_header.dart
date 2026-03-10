/// Cabecera principal de la pantalla de inicio.
library;

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import 'header_icon_button.dart';

/// Barra de cabecera fija de la [HomeScreen] con el logo de la tienda y los
/// iconos de menú y perfil.
///
/// Diseño:
/// ```
/// [ ≡ ]   BRAYAN FAKE STORE   [ 👤 ]
/// ```
///
/// Los iconos laterales están implementados en [HeaderIconButton].
class AppHeader extends StatelessWidget {
  /// Crea la cabecera de la pantalla principal.
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          HeaderIconButton(icon: Icons.menu_rounded),
          Expanded(
            child: Center(
              child: Text(
                'BRAYAN FAKE STORE',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: kPrimary,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          HeaderIconButton(icon: Icons.account_circle_outlined),
        ],
      ),
    );
  }
}
