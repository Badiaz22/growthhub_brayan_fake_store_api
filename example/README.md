# Fake Store Example

Aplicación Flutter de ejemplo que demuestra el uso del paquete
[`brayan_fake_store_api`](https://github.com/Badiaz22/growthhub_brayan_fake_store_api)
para consumir la [Fake Store API](https://fakestoreapi.com).

---

## Características

- Listado de productos en grilla de 2 columnas.
- Filtrado reactivo por categoría mediante chips horizontales animados.
- Pantalla de detalle con imagen, rating con estrellas, descripción y precio.
- Manejo completo de estados: **loading**, **error** (con retry) y **success**.
- Arquitectura limpia con separación estricta de responsabilidades.
- Un widget por archivo, sin widgets privados en screens.

---

## Stack tecnológico

| Dependencia | Versión | Uso |
|---|---|---|
| `brayan_fake_store_api` | `^1.0.0` | Cliente de la Fake Store API |
| `flutter_riverpod` | `^2.5.1` | Gestión de estado |
| Flutter SDK | `^3.0.0` | Framework UI |

---

## Arquitectura

La aplicación sigue **Clean Architecture** organizada por features:

```
lib/
├── main.dart                              # Punto de entrada + FakeStoreApp
│
├── core/
│   └── theme/
│       └── app_theme.dart                 # Tema Material 3 centralizado
│
└── features/
    └── products/
        ├── data/
        │   └── repositories/
        │       └── products_repository.dart     # Adaptador Either → Future
        │
        └── presentation/
            ├── providers/
            │   └── products_provider.dart       # Providers de Riverpod
            │
            ├── screens/
            │   ├── home_screen.dart             # Pantalla principal
            │   └── product_details_screen.dart  # Pantalla de detalle
            │
            └── widgets/
                ├── add_cart_button.dart         # Botón de agregar al carrito
                ├── app_error_widget.dart        # Estado de error con retry
                ├── loading_widget.dart          # Estado de carga
                ├── price_tag.dart               # Etiqueta de precio
                ├── product_card.dart            # Tarjeta de producto en grilla
                │
                ├── home/
                │   ├── app_header.dart          # Cabecera con logo
                │   ├── header_icon_button.dart  # Botón icónico de cabecera
                │   ├── store_search_bar.dart    # Barra de búsqueda
                │   ├── categories_row.dart      # Fila desplazable de categorías
                │   ├── category_chip.dart       # Chip individual de categoría
                │   └── section_header.dart      # Encabezado de sección con contador
                │
                └── detail/
                    ├── product_details_body.dart  # Cuerpo del detalle de producto
                    └── rating_section.dart        # Estrellas y conteo de reseñas
```

### Flujo de datos

```
BrayanFakeStoreApi (paquete)
        │  Either<Failure, T>
        ▼
ProductsRepository           ← convierte Either → Exception (lanza si Left)
        │  Future<T>
        ▼
Riverpod Providers           ← FutureProvider / StateProvider
        │  AsyncValue<T>
        ▼
Screens / Widgets            ← .when(loading:, error:, data:)
```

---

## Providers

| Provider | Tipo | Descripción |
|---|---|---|
| `productsRepositoryProvider` | `Provider` | Instancia única del repositorio |
| `categoriesProvider` | `FutureProvider` | Categorías disponibles en la API |
| `selectedCategoryProvider` | `StateProvider<String?>` | Categoría activa (`null` = All) |
| `filteredProductsProvider` | `FutureProvider` | Productos filtrados por categoría seleccionada |
| `productDetailProvider` | `FutureProvider.family<int>` | Producto individual por id |

---

## Cómo ejecutar

### Prerrequisitos

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Conexión a internet (la app consume `fakestoreapi.com` en línea)

### Pasos

```bash
# 1. Clonar el repositorio del paquete
git clone https://github.com/Badiaz22/growthhub_brayan_fake_store_api.git
cd growthhub_brayan_fake_store_api

# 2. Entrar a la carpeta del ejemplo
cd example

# 3. Instalar dependencias
flutter pub get

# 4. Ejecutar en un dispositivo/emulador conectado
flutter run
```

> Si la carpeta `android/` o `ios/` no existe, generar los archivos de
> plataforma primero sin sobreescribir el código existente:
> ```bash
> flutter create . --project-name fake_store_example --platforms android,ios
> flutter pub get
> ```

---

## Uso del paquete

```dart
import 'package:brayan_fake_store_api/brayan_fake_store_api.dart';

final api = BrayanFakeStoreApi();

// Obtener todos los productos
final result = await api.getProducts();
result.fold(
  (failure) => print('Error: ${failure.message}'),
  (products) => print('${products.length} productos cargados'),
);

// Obtener producto por id
final detail = await api.getProductById(1);

// Filtrar por categoría
final electronics = await api.getProductsByCategory('electronics');

// Listar categorías disponibles
final categories = await api.getCategories();
```

## Licencia

Distribuido bajo la misma licencia del paquete `brayan_fake_store_api`.
