/// Definición centralizada del tema visual de la aplicación.
///
/// Exporta las constantes de color [kPrimary] y [kBackground] para que
/// cualquier widget pueda acceder a ellas sin necesidad de consultar el
/// [BuildContext].
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Color primario de la marca: dorado cálido oscuro.
const kPrimary = Color(0xFF7B6B43);

/// Color de fondo general de la aplicación: crema suave.
const kBackground = Color(0xFFF7F7F6);

/// Configuración global del tema Material 3 de la aplicación.
///
/// Usa el patrón de constructor privado para evitar instanciación y expone
/// únicamente el getter estático [theme].
///
/// Ejemplo de uso en [MaterialApp]:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.theme,
/// )
/// ```
class AppTheme {
  // Constructor privado: esta clase no debe ser instanciada.
  AppTheme._();

  /// Retorna el [ThemeData] configurado con Material 3 y la paleta de colores
  /// de la aplicación.
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimary,
          primary: kPrimary,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: kPrimary.withValues(alpha: 0.08)),
          ),
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Public Sans',
            fontSize: 14,
          ),
        ),
      );
}
