/// Punto de entrada de la aplicación de ejemplo para el paquete
/// [brayan_fake_store_api].
///
/// Envuelve la app en un [ProviderScope] de Riverpod para habilitar la
/// inyección de dependencias en toda la jerarquía de widgets.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/products/presentation/screens/home_screen.dart';

/// Inicializa la aplicación dentro de un [ProviderScope] para que todos los
/// providers de Riverpod estén disponibles desde el primer frame.
void main() {
  runApp(const ProviderScope(child: FakeStoreApp()));
}

/// Widget raíz de la aplicación.
///
/// Configura el [MaterialApp] con el tema centralizado de [AppTheme] y
/// establece [HomeScreen] como pantalla inicial.
class FakeStoreApp extends StatelessWidget {
  /// Crea la instancia raíz de la aplicación.
  const FakeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fake Store',
      theme: AppTheme.theme,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
