import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: crea un nuevo producto y lo retorna con su [id] asignado.
class CreateProductUseCase {
  final FakestoreRepository _repository;

  const CreateProductUseCase(this._repository);

  Future<Either<Failure, ProductEntity>> call(Map<String, dynamic> productData) =>
      _repository.createProduct(productData);
}
