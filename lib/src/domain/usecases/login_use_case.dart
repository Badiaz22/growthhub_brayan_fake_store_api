import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/auth_response_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: autentica un usuario con [username] y [password].
///
/// En caso de éxito retorna un [AuthResponseEntity] con el token JWT.
class LoginUseCase {
  final FakestoreRepository _repository;

  const LoginUseCase(this._repository);

  Future<Either<Failure, AuthResponseEntity>> call(
    String username,
    String password,
  ) =>
      _repository.login(username, password);
}
