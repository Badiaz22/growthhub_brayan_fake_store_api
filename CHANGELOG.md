# Changelog

Todas las cambios notables en este proyecto serán documentados en este archivo.

El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto se adhiere al [Versionado Semántico](https://semver.org/es/).

## [1.0.0] - 2026-03-26

### Added
- Implementación inicial del paquete `brayan_fake_store_api` con soporte completo para Fake Store API
- **Datasources separados por dominio**: `ProductRemoteDatasource`, `UserRemoteDatasource`, `CartRemoteDatasource`, `AuthRemoteDatasource`
- **Interfases de repositorio**: `ProductRepository`, `UserRepository`, `CartRepository`, `AuthRepository`
- **Implementaciones de repositorio**: `ProductRepositoryImpl`, `UserRepositoryImpl`, `CartRepositoryImpl`, `AuthRepositoryImpl`
- **Interfase unificada**: `FakestoreRepository` que combina todas las operaciones
- **Factory pattern**: `BrayanFakeStoreApi.buildRepository()` para inyección de dependencias sin acoplamiento
- **Manejo funcional de errores**: `Either<Failure, T>` usando el paquete `dartz`
- **Entidades completamente tipadas**: `ProductEntity`, `UserEntity`, `CartEntity`, `AuthResponseEntity` y sus sub-entidades
- **Casos de uso organizados por dominio**: 19 use cases en carpetas `product/`, `user/`, `cart/`, `auth/`
- **Pruebas unitarias completas**: cobertura para todas las operaciones principales
- **Documentación exhaustiva**: documentación en español con ejemplos de uso

### Architecture
- **Clean Architecture**: separación clara entre capas (data, domain, presentation)
- **Single Responsibility Principle (SRP)**: cada clase tiene una única responsabilidad
- **Dependency Inversion Principle (DIP)**: consumidores dependen de contratos (interfaces), no de implementaciones
- **Factory Pattern**: `BrayanFakeStoreApi` actúa como builder puro, reduciendo acoplamiento
- **Composite Pattern**: `FakestoreRepositoryImpl` delega a 4 implementaciones específicas sin lógica propia

### Example App
- Aplicación Flutter de ejemplo que demuestra el uso del paquete
- `ProductsRepository` en el ejemplo depende de `FakestoreRepository` (interfase estable)
- Integración con Riverpod para state management
- Pantalla de productos con listado, filtrado por categoría y detalle de producto

### Files Structure
```
lib/
├── brayan_fake_store_api.dart          # Punto de entrada (exports públicos)
└── src/
    ├── brayan_fake_store_api.dart      # Factory (BrayanFakeStoreApi)
    ├── core/
    │   ├── errors/                      # Failure types
    │   └── network/                     # ApiClient
    ├── data/
    │   ├── datasources/                 # 4 datasources específicos por dominio
    │   ├── models/                      # Modelos JSON (no expuestos)
    │   └── repositories/                # 5 implementaciones (4 específicas + 1 composite)
    └── domain/
        ├── entities/                    # Entidades de negocio
        ├── repositories/                # 5 interfaces
        └── usecases/                    # 19 use cases (4 carpetas por dominio)
```

## Notas Importantes

### Breaking Changes
- **Versión 1.0.0**: Primera versión pública, no hay breaking changes anteriores

### Decisiones Arquitectónicas

#### Por qué FakestoreRepositoryImpl existe
- `FakestoreRepository` combina todas las operaciones (productos, usuarios, carritos, auth)
- `FakestoreRepositoryImpl.composite()` proporciona la implementación unificada
- Los consumidores reciben esta interfaz estable, sin acoplamiento a detalles de implementación
- Cada implementación específica (`ProductRepositoryImpl`, etc.) mantiene SRP: **delegación pura, sin lógica**

#### Por qué BrayanFakeStoreApi solo tiene buildRepository()
- Patrón Factory: configura el stack HTTP completo e inyecta dependencias
- Reduce acoplamiento: consumidores dependen de `FakestoreRepository` (contrato), no de la clase concreta
- Facilita testing: permite inyectar clientes HTTP mock
- Escalabilidad: nueva forma de construcción sin cambiar la interfaz pública

#### Por qué los use cases no se usan en el ejemplo
- Se proporcionan como referencia arquitectónica y para uso futuro
- El flujo actual va directamente desde la UI → repositorio → datasource
- Los use cases pueden activarse si se necesita lógica de negocio compleja en el futuro

### Dependencias
- `http: ^1.2.2` - Cliente HTTP para llamadas a la API
- `dartz: ^0.10.1` - Programación funcional (Either, Left, Right)
- `flutter: >=1.17.0` - Framework Flutter
- `flutter_test` - Testing (dev dependency)
- `flutter_lints: ^4.0.0` - Análisis de código (dev dependency)

