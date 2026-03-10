/// Widget reutilizable para el estado de carga.
library;

import 'package:flutter/material.dart';

/// Indicador de carga centrado en pantalla con un mensaje opcional.
///
/// Se usa en todos los estados `loading` de los providers para mantener una
/// experiencia de espera consistente en la aplicación.
///
/// Ejemplo de uso con Riverpod:
/// ```dart
/// productsAsync.when(
///   loading: () => const LoadingWidget(message: 'Cargando productos...'),
///   ...
/// )
/// ```
class LoadingWidget extends StatelessWidget {
  /// Texto descriptivo que se muestra debajo del indicador de progreso.
  ///
  /// Si es `null`, solo se muestra el [CircularProgressIndicator].
  final String? message;

  /// Crea el widget de carga con un [message] opcional.
  const LoadingWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}
