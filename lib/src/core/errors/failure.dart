/// Clase base para todas las fallas del paquete.
///
/// Usa [fold] en cualquier `Either<Failure, T>` para manejar errores:
/// ```dart
/// resultado.fold(
///   (falla) => print(falla.message),
///   (dato)  => print(dato),
/// );
/// ```
abstract class Failure {
  /// Descripción legible de la falla.
  final String message;

  const Failure(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

/// Se lanza cuando el dispositivo no tiene conectividad o la solicitud expiró.
class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'Error de red. Por favor verifica tu conexión.',
  ]);
}

/// Se lanza cuando el servidor responde con un código HTTP.
class ServerFailure extends Failure {
  /// Código de estado HTTP retornado por el servidor, si está disponible.
  final int? statusCode;

  const ServerFailure(super.message, {this.statusCode});
}

/// Se lanza cuando el cuerpo de la respuesta no puede convertirse al modelo esperado.
class ParsingFailure extends Failure {
  const ParsingFailure([
    super.message = 'No se pudo interpretar la respuesta del servidor.',
  ]);
}

/// Falla de respaldo para cualquier excepción inesperada en tiempo de ejecución.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Ocurrió un error inesperado.']);
}
