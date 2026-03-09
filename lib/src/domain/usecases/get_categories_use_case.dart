import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/category_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: obtiene todas las categorías de productos disponibles.
class GetCategoriesUseCase {
  final FakestoreRepository _repository;

  const GetCategoriesUseCase(this._repository);

  Future<Either<Failure, List<CategoryEntity>>> call() =>
      _repository.getCategories();
}
