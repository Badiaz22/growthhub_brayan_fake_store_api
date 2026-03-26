import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/core/network/api_client.dart';
import 'package:brayan_fake_store_api/src/data/datasources/remote_datasource_helpers.dart';
import 'package:brayan_fake_store_api/src/data/models/auth_response_model.dart';
import 'package:dartz/dartz.dart';

/// Gestiona las llamadas HTTP relacionadas con autenticación.
///
/// Deserializa el JSON en [AuthResponseModel] tipados y delega
/// los cambios de estado de la aplicación a la capa superior.
class AuthRemoteDatasource {
  final ApiClient _client;

  const AuthRemoteDatasource(this._client);

  /// Autentica un usuario y retorna un token JWT.
  Future<Either<Failure, AuthResponseModel>> login(
    String username,
    String password,
  ) async {
    final result = await _client.post('/auth/login', {
      'username': username,
      'password': password,
    });
    return result.fold(
      (f) => Left(f),
      (json) =>
          RemoteDatasourceHelpers.parseObject(json, AuthResponseModel.fromJson),
    );
  }
}
