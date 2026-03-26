import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/data/datasources/auth_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/domain/entities/auth_response_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

/// Implementación concreta de [AuthRepository].
///
/// Delega todo el trabajo HTTP a [AuthRemoteDatasource] y expone
/// entidades de dominio tipadas al resto de la aplicación.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;

  const AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, AuthResponseEntity>> login(
    String username,
    String password,
  ) => _datasource.login(username, password);
}
