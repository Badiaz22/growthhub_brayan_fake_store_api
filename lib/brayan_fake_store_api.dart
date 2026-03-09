/// Paquete Brayan Fake Store API — interfaz completa para interactuar con
/// https://fakestoreapi.com
///
/// ### Uso básico
/// ```dart
/// import 'package:brayan_fake_store_api/brayan_fake_store_api.dart';
///
/// final api = BrayanFakeStoreApi();
///
/// final resultado = await api.getProducts(limit: 5, sort: 'desc');
/// resultado.fold(
///   (falla) => print(falla.message),
///   (productos) => productos.forEach((p) => print(p.title)),
/// );
/// ```
library brayan_fake_store_api;

/// Cliente principal para interactuar con FakeStore API
export 'src/brayan_fake_store_api.dart';

/// Entidades públicas
export 'src/domain/entities/product_entity.dart';
export 'src/domain/entities/user_entity.dart';
export 'src/domain/entities/cart_entity.dart';
export 'src/domain/entities/category_entity.dart';
export 'src/domain/entities/rating_entity.dart';
export 'src/domain/entities/name_entity.dart';
export 'src/domain/entities/address_entity.dart';
export 'src/domain/entities/geolocation_entity.dart';
export 'src/domain/entities/cart_product_entity.dart';
export 'src/domain/entities/auth_response_entity.dart';

/// Errores
export 'src/core/errors/failure.dart';

/// Either para manejo funcional de errores
export 'package:dartz/dartz.dart' show Either, Left, Right;

/// Se expone solo lo necesario para el uso del paquete
