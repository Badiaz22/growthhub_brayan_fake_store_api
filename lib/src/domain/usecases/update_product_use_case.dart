import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: reemplaza un producto completo (PUT). Retorna el recurso actualizado.
class UpdateProductUseCase {
  final FakestoreRepository _repository;

  const UpdateProductUseCase(this._repository);

  Future<Either<Failure, ProductEntity>> call(
    int id,
    Map<String, dynamic> productData,
  ) =>
      _repository.updateProduct(id, productData);
}
