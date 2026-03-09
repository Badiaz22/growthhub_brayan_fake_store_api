# brayan_fake_store_api

Paquete Flutter/Dart que proporciona una **interfaz limpia y completamente tipada** para la
[Fake Store API](https://fakestoreapi.com) — ideal para construir apps de e-commerce de demostración.

Construido con **Clean Architecture**, **principios SOLID** y manejo funcional de errores
mediante `Either<Failure, T>` usando [dartz](https://pub.dev/packages/dartz).

---

## Funcionalidades

| Recurso        | Operaciones |
|----------------|-------------|
| **Productos**  | obtener todos, obtener por id, obtener por categoría, crear, actualizar (PUT/PATCH), eliminar |
| **Categorías** | obtener todas |
| **Usuarios**   | obtener todos, obtener por id, crear, actualizar (PUT/PATCH), eliminar |
| **Carritos**   | obtener todos, obtener por id, obtener por usuario, crear, actualizar (PUT/PATCH), eliminar |
| **Auth**       | login (retorna token JWT) |

Todos los métodos retornan `Future<Either<Failure, T>>` — ninguna excepción se propaga al llamador.

---

## Instalación

```yaml
dependencies:
  brayan_fake_store_api:
    git:
      url: https://github.com/Badiaz22/growthhub_brayan_fake_store_api.git
      ref: main
```

```bash
flutter pub get
```

---

## Inicio rápido

```dart
import 'package:brayan_fake_store_api/brayan_fake_store_api.dart';

final api = BrayanFakeStoreApi();

final resultado = await api.getProducts(limit: 10, sort: 'desc');

resultado.fold(
  (falla) => print('Error: ${falla.message}'),
  (productos) {
    for (final p in productos) {
      print('${p.title}  \$${p.price}  ★${p.rating.rate}');
    }
  },
);
```

---

## Referencia de la API

### Productos

```dart
// Todos los productos
final resultado = await api.getProducts(limit: 5, sort: 'asc');

// Producto por ID
final resultado = await api.getProductById(1);

// Todas las categorías
final resultado = await api.getCategories();

// Productos por categoría
final resultado = await api.getProductsByCategory('electronics', limit: 3);

// Crear
final resultado = await api.createProduct({
  'title': 'Mi producto',
  'price': 29.99,
  'description': 'Un gran producto',
  'category': "men's clothing",
  'image': 'https://example.com/img.png',
});

// Actualización completa (PUT)
final resultado = await api.updateProduct(1, {'title': 'Título actualizado', ...});

// Actualización parcial (PATCH)
final resultado = await api.patchProduct(1, {'price': 19.99});

// Eliminar
final resultado = await api.deleteProduct(1);
```

### Usuarios

```dart
// Todos los usuarios
final resultado = await api.getUsers(limit: 5);

// Usuario por ID
final resultado = await api.getUserById(1);

// Crear
final resultado = await api.createUser({
  'email': 'nuevo@ejemplo.com',
  'username': 'nuevousuario',
  'password': 'secreto',
  'name': {'firstname': 'Juan', 'lastname': 'Pérez'},
  'phone': '555-1234',
  'address': { ... },
});

// Actualizar / Actualización parcial / Eliminar
final resultado = await api.updateUser(1, { ... });
final resultado = await api.patchUser(1, {'email': 'otro@ejemplo.com'});
final resultado = await api.deleteUser(1);
```

### Carritos

```dart
// Todos los carritos (con filtro de fechas opcional)
final resultado = await api.getCarts(
  limit: 5,
  sort: 'desc',
  startDate: '2020-01-01',
  endDate: '2020-12-31',
);

// Carrito por ID
final resultado = await api.getCartById(1);

// Carritos de un usuario específico
final resultado = await api.getCartsByUser(2);

// Crear
final resultado = await api.createCart(2, [
  const CartProduct(productId: 1, quantity: 2),
  const CartProduct(productId: 5, quantity: 1),
]);

// Actualizar / Actualización parcial / Eliminar
final resultado = await api.updateCart(1, 2, [ ... ]);
final resultado = await api.patchCart(1, 2, [ ... ]);
final resultado = await api.deleteCart(1);
```

### Autenticación

```dart
final resultado = await api.login('johnd', 'm38rmF\$');

resultado.fold(
  (f) => print('Login fallido: ${f.message}'),
  (auth) => print('Token JWT: ${auth.token}'),
);
```

---

## Manejo de errores

Cada método retorna `Either<Failure, T>`. Usa `.fold()` para manejar ambos casos:

```dart
resultado.fold(
  (falla) {
    switch (falla) {
      case NetworkFailure():
        print('Sin conexión a internet');
      case ServerFailure():
        print('Error del servidor: ${(falla as ServerFailure).statusCode}');
      case ParsingFailure():
        print('Formato de respuesta inválido');
      case UnexpectedFailure():
        print('Error inesperado: ${falla.message}');
    }
  },
  (dato) => print('Éxito: $dato'),
);
```

Tipos de falla disponibles:

| Tipo | Cuándo ocurre |
|------|---------------|
| `NetworkFailure`    | Sin conectividad / la solicitud no pudo enviarse |
| `ServerFailure`     | El servidor respondió con un código no 2xx |
| `ParsingFailure`    | El cuerpo de la respuesta no pudo decodificarse |
| `UnexpectedFailure` | Cualquier otra excepción en tiempo de ejecución |

---

## Testing / Inyección de dependencias

Pasa un `http.Client` personalizado para evitar llamadas reales a la red:

```dart
final api = BrayanFakeStoreApi(httpClient: miMockClient);
```

O inyecta un repositorio personalizado directamente:

```dart
final api = BrayanFakeStoreApi.withRepository(miRepositorioFalso);
```

---

## Arquitectura

```
lib/
├── brayan_fake_store_api.dart        ← barrel público
└── src/
    ├── core/
    │   ├── errors/failure.dart       ← jerarquía de Failure
    │   └── network/api_client.dart   ← envoltorio HTTP
    ├── domain/
    │   ├── entities/                 ← objetos de valor inmutables
    │   ├── repositories/             ← contrato abstracto
    │   └── usecases/                 ← una clase por operación
    └── data/
        ├── models/                   ← extienden entidades + JSON I/O
        ├── datasources/              ← llamadas HTTP → modelos
        └── repositories/             ← implementa el contrato de dominio
```

---

## Requisitos

- Dart SDK `^3.11.0`
- Flutter `>=1.17.0`
- [`http`](https://pub.dev/packages/http) `^1.2.2`
- [`dartz`](https://pub.dev/packages/dartz) `^0.10.1`

---

**Desarrollado como parte del Reto GrowthHub  — Fase 3**
