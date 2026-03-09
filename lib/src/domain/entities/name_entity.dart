/// Nombre completo de un [UserEntity].
class NameEntity {
  final String firstname;
  final String lastname;

  const NameEntity({required this.firstname, required this.lastname});

  /// Getter de conveniencia que une nombre y apellido.
  String get fullName => '$firstname $lastname';
}
