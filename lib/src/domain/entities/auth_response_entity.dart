/// Respuesta retornada por el endpoint de inicio de sesión.
class AuthResponseEntity {
  /// Token JWT para incluir en solicitudes autenticadas posteriores.
  final String token;

  const AuthResponseEntity({required this.token});
}
