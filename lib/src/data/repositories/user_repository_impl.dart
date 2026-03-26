import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/data/datasources/user_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

/// Implementación concreta de [UserRepository].
///
/// Delega todo el trabajo HTTP a [UserRemoteDatasource] y expone
/// entidades de dominio tipadas al resto de la aplicación.
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource _datasource;

  const UserRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers({
    int? limit,
    String? sort,
  }) => _datasource.getUsers(limit: limit, sort: sort);

  @override
  Future<Either<Failure, UserEntity>> getUserById(int id) =>
      _datasource.getUserById(id);

  @override
  Future<Either<Failure, UserEntity>> createUser(
    Map<String, dynamic> userData,
  ) => _datasource.createUser(userData);

  @override
  Future<Either<Failure, UserEntity>> updateUser(
    int id,
    Map<String, dynamic> userData,
  ) => _datasource.updateUser(id, userData);

  @override
  Future<Either<Failure, UserEntity>> patchUser(
    int id,
    Map<String, dynamic> userData,
  ) => _datasource.patchUser(id, userData);

  @override
  Future<Either<Failure, UserEntity>> deleteUser(int id) =>
      _datasource.deleteUser(id);
}
