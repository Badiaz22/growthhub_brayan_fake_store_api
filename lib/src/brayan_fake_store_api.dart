import 'package:brayan_fake_store_api/src/core/network/api_client.dart';
import 'package:brayan_fake_store_api/src/data/datasources/auth_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/data/datasources/cart_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/data/datasources/product_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/data/datasources/user_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/data/repositories/auth_repository_impl.dart';
import 'package:brayan_fake_store_api/src/data/repositories/cart_repository_impl.dart';
import 'package:brayan_fake_store_api/src/data/repositories/fakestore_repository_impl.dart';
import 'package:brayan_fake_store_api/src/data/repositories/product_repository_impl.dart';
import 'package:brayan_fake_store_api/src/data/repositories/user_repository_impl.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:http/http.dart' as http;

/// Factory para construir e inyectar dependencias del paquete Brayan Fake Store API.
///
/// Configura el stack HTTP completo: ApiClient, Datasources, Implementaciones
/// de repositorio e interfaz [FakestoreRepository].
///
/// ### Uso básico
/// ```dart
/// import 'package:http/http.dart' as http;
/// import 'package:brayan_fake_store_api/src/brayan_fake_store_api.dart';
///
/// final repository = BrayanFakeStoreApi.buildRepository();
/// final resultado = await repository.getProducts(limit: 5);
/// resultado.fold(
///   (falla) => print('Error: ${falla.message}'),
///   (productos) => print('Se obtuvieron ${productos.length} productos'),
/// );
/// ```
///
/// ### Inyección de dependencias / pruebas
/// Para pruebas, pasa un [http.Client] mockado:
/// ```dart
/// final mockClient = MockHttpClient();
/// final repository = BrayanFakeStoreApi.buildRepository(httpClient: mockClient);
/// ```
class BrayanFakeStoreApi {
  BrayanFakeStoreApi._();

  /// Construye e inyecta todas las dependencias necesarias del paquete.
  ///
  /// Retorna una instancia completamente configurada de [FakestoreRepository]
  /// lista para usarse.
  ///
  /// [httpClient] – cliente HTTP personalizado (opcional, útil para testing).
  static FakestoreRepository buildRepository({http.Client? httpClient}) {
    final apiClient = ApiClient(client: httpClient);

    final productDatasource = ProductRemoteDatasource(apiClient);
    final userDatasource = UserRemoteDatasource(apiClient);
    final cartDatasource = CartRemoteDatasource(apiClient);
    final authDatasource = AuthRemoteDatasource(apiClient);

    final productRepository = ProductRepositoryImpl(productDatasource);
    final userRepository = UserRepositoryImpl(userDatasource);
    final cartRepository = CartRepositoryImpl(cartDatasource);
    final authRepository = AuthRepositoryImpl(authDatasource);

    return FakestoreRepositoryImpl.composite(
      productRepository: productRepository,
      userRepository: userRepository,
      cartRepository: cartRepository,
      authRepository: authRepository,
    );
  }
}
