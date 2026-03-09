import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: elimina un producto por [id] y retorna el recurso eliminado.
class DeleteProductUseCase {
  final FakestoreRepository _repository;

  const DeleteProductUseCase(this._repository);

  Future<Either<Failure, ProductEntity>> call(int id) =>
      _repository.deleteProduct(id);
}
