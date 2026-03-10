/// Widget reutilizable para el estado de error.
library;

import 'package:flutter/material.dart';

/// Pantalla de error centrada con icono, mensaje descriptivo y botón de reintento
/// opcional.
///
/// Se usa en todos los estados `error` de los providers para ofrecer una
/// experiencia de error consistente. Si se proporciona [onRetry], el usuario
/// puede volver a intentar la operación fallida.
///
/// Ejemplo de uso con Riverpod:
/// ```dart
/// productsAsync.when(
///   error: (error, _) => AppErrorWidget(
///     message: error.toString(),
///     onRetry: () => ref.invalidate(productsProvider),
///   ),
///   ...
/// )
/// ```
class AppErrorWidget extends StatelessWidget {
  /// Descripción del error que se muestra al usuario.
  final String message;

  /// Callback que se ejecuta al presionar el botón "Retry".
  ///
  /// Si es `null`, el botón no se renderiza.
  final VoidCallback? onRetry;

  /// Crea el widget de error con el [message] requerido y un [onRetry] opcional.
  const AppErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
