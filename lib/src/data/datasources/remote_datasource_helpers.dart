import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

/// Métodos auxiliares reutilizables para todos los datasources remotos.
abstract base class RemoteDatasourceHelpers {
  /// Construye la ruta con parámetros de consulta opcionales.
  static String buildPath(
    String base, {
    int? limit,
    String? sort,
    Map<String, String>? extra,
  }) {
    final params = <String, String>{
      if (limit != null) 'limit': '$limit',
      if (sort != null) 'sort': sort,
      ...?extra,
    };
    if (params.isEmpty) return base;
    final query = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$base?$query';
  }

  /// Parsea una lista de objetos JSON a un tipo específico.
  static Either<Failure, List<T>> parseList<T>(
    List<dynamic> list,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      return Right(list.cast<Map<String, dynamic>>().map(fromJson).toList());
    } catch (e) {
      return Left(ParsingFailure(e.toString()));
    }
  }

  /// Parsea un objeto JSON a un tipo específico.
  static Either<Failure, T> parseObject<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      return Right(fromJson(json));
    } catch (e) {
      return Left(ParsingFailure(e.toString()));
    }
  }
}
