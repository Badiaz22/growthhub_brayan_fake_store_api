import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/core/network/api_client.dart';
import 'package:brayan_fake_store_api/src/data/datasources/remote_datasource_helpers.dart';
import 'package:brayan_fake_store_api/src/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

/// Gestiona las llamadas HTTP relacionadas con usuarios.
///
/// Deserializa el JSON en [UserModel] tipados y delega
/// los cambios de estado de la aplicación a la capa superior.
class UserRemoteDatasource {
  final ApiClient _client;

  const UserRemoteDatasource(this._client);

  /// Retorna todos los usuarios, con paginación y ordenamiento opcionales.
  Future<Either<Failure, List<UserModel>>> getUsers({
    int? limit,
    String? sort,
  }) async {
    final result = await _client.getList(
      RemoteDatasourceHelpers.buildPath('/users', limit: limit, sort: sort),
    );
    return result.fold(
      (f) => Left(f),
      (list) => RemoteDatasourceHelpers.parseList(list, UserModel.fromJson),
    );
  }

  /// Retorna un único usuario por su [id].
  Future<Either<Failure, UserModel>> getUserById(int id) async {
    final result = await _client.getMap('/users/$id');
    return result.fold(
      (f) => Left(f),
      (json) => RemoteDatasourceHelpers.parseObject(json, UserModel.fromJson),
    );
  }

  /// Crea un nuevo usuario. Retorna el recurso con su id asignado.
  Future<Either<Failure, UserModel>> createUser(
    Map<String, dynamic> data,
  ) async {
    final result = await _client.post('/users', data);
    return result.fold(
      (f) => Left(f),
      (json) => RemoteDatasourceHelpers.parseObject(json, UserModel.fromJson),
    );
  }

  /// Reemplaza un usuario completo (actualización PUT).
  Future<Either<Failure, UserModel>> updateUser(
    int id,
    Map<String, dynamic> data,
  ) async {
    final result = await _client.put('/users/$id', data);
    return result.fold(
      (f) => Left(f),
      (json) => RemoteDatasourceHelpers.parseObject(json, UserModel.fromJson),
    );
  }

  /// Actualiza parcialmente un usuario (PATCH).
  Future<Either<Failure, UserModel>> patchUser(
    int id,
    Map<String, dynamic> data,
  ) async {
    final result = await _client.patch('/users/$id', data);
    return result.fold(
      (f) => Left(f),
      (json) => RemoteDatasourceHelpers.parseObject(json, UserModel.fromJson),
    );
  }

  /// Elimina un usuario y retorna el recurso eliminado.
  Future<Either<Failure, UserModel>> deleteUser(int id) async {
    final result = await _client.delete('/users/$id');
    return result.fold(
      (f) => Left(f),
      (json) => RemoteDatasourceHelpers.parseObject(json, UserModel.fromJson),
    );
  }
}
