import 'dart:convert';

import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// Envoltorio HTTP de bajo nivel que mapea respuestas a [Either].
///
/// Inyecta un [http.Client] personalizado para pruebas:
/// ```dart
/// final api = ApiClient(client: MockHttpClient());
/// ```
class ApiClient {
  final http.Client _client;
  final String baseUrl;

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  ApiClient({http.Client? client, this.baseUrl = 'https://fakestoreapi.com'})
    : _client = client ?? http.Client();

  // ---------------------------------------------------------------------------
  // Interfaz pública
  // ---------------------------------------------------------------------------

  /// Solicitud GET que espera una respuesta JSON de tipo **objeto**.
  Future<Either<Failure, Map<String, dynamic>>> getMap(String path) =>
      _safeRequest(() async {
        final response = await _client.get(
          Uri.parse('$baseUrl$path'),
          headers: _headers,
        );
        return _parseMap(response);
      });

  /// Solicitud GET que espera una respuesta JSON de tipo **arreglo**.
  Future<Either<Failure, List<dynamic>>> getList(String path) =>
      _safeRequest(() async {
        final response = await _client.get(
          Uri.parse('$baseUrl$path'),
          headers: _headers,
        );
        return _parseList(response);
      });

  /// Solicitud POST con cuerpo JSON. Espera una respuesta de tipo objeto.
  Future<Either<Failure, Map<String, dynamic>>> post(
    String path,
    Map<String, dynamic> body,
  ) => _safeRequest(() async {
    final response = await _client.post(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _parseMap(response);
  });

  /// Solicitud PUT con cuerpo JSON. Espera una respuesta de tipo objeto.
  Future<Either<Failure, Map<String, dynamic>>> put(
    String path,
    Map<String, dynamic> body,
  ) => _safeRequest(() async {
    final response = await _client.put(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _parseMap(response);
  });

  /// Solicitud PATCH con cuerpo JSON. Espera una respuesta de tipo objeto.
  Future<Either<Failure, Map<String, dynamic>>> patch(
    String path,
    Map<String, dynamic> body,
  ) => _safeRequest(() async {
    final response = await _client.patch(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _parseMap(response);
  });

  /// Solicitud DELETE. Espera una respuesta de tipo objeto.
  Future<Either<Failure, Map<String, dynamic>>> delete(String path) =>
      _safeRequest(() async {
        final response = await _client.delete(
          Uri.parse('$baseUrl$path'),
          headers: _headers,
        );
        return _parseMap(response);
      });

  // ---------------------------------------------------------------------------
  // Métodos privados de soporte
  // ---------------------------------------------------------------------------

  Future<Either<Failure, T>> _safeRequest<T>(
    Future<Either<Failure, T>> Function() request,
  ) async {
    try {
      return await request();
    } on http.ClientException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Either<Failure, Map<String, dynamic>> _parseMap(http.Response response) {
    if (_isSuccess(response.statusCode)) {
      try {
        return Right(jsonDecode(response.body) as Map<String, dynamic>);
      } catch (_) {
        return const Left(ParsingFailure());
      }
    }
    return Left(
      ServerFailure(
        'La solicitud falló con estado ${response.statusCode}',
        statusCode: response.statusCode,
      ),
    );
  }

  Either<Failure, List<dynamic>> _parseList(http.Response response) {
    if (_isSuccess(response.statusCode)) {
      try {
        return Right(jsonDecode(response.body) as List<dynamic>);
      } catch (_) {
        return const Left(ParsingFailure());
      }
    }
    return Left(
      ServerFailure(
        'La solicitud falló con estado ${response.statusCode}',
        statusCode: response.statusCode,
      ),
    );
  }

  bool _isSuccess(int statusCode) => statusCode >= 200 && statusCode < 300;
}
