# 📋 Project Roadmap: Online Food Ordering System

This document tracks the development progress of the Online Food Ordering System. The project follows a strict Feature-First Clean Architecture.

## Phase 1: Core Utilities & Infrastructure

*The foundation of the app. These must be completed before touching any feature.*

- **Network Configuration (`core/network`)**
  -  Set up `Dio` consumer/client.
  -  Implement `ErrorInterceptor` for logging and global error catching.
  -  Create `NetworkInfo` to check internet connectivity.
- **Error Handling (`core/errors`)**
  - Define `Failure` classes (ServerFailure, CacheFailure, NetworkFailure).
  - Define `Exception` classes (ServerException, CacheException).
  - Create `ErrorMessageModel` to parse API error responses.
- [ ] **Theming & UI Constants (`core/theming` & `core/constants`)**
  - [ ] Define `AppColors`, `AppTypography`, and global `ThemeData`.
  - [ ] Set up `ApiConstants` (fetching base URLs from `.env`).
- [ ] **Routing (`core/routing`)**
  - [ ] Define route name constants.
  - [ ] Set up `go_router` in `app_router.dart` with initial placeholder screens.
- [ ] **Dependency Injection (`injection_container.dart`)**
  - [ ] Register core external packages (`Dio`, `SharedPreferences`, `Hive`).
  - [ ] Register core utilities (NetworkInfo, AppRouter).

## Phase 2: Domain Layer (The Blueprint)

*Pure Dart. No Flutter UI, no JSON parsing. Define what the app does.*

- **Auth Feature**
  - Define `User` Entity.
  - Define `AuthRepository` abstract class.
  - Create Use Cases: `LoginUser`, `RegisterUser`, `LogoutUser`, `GetCachedUser`.
- **Menu Feature**
  - Define `Product` (Food Item) Entity.
  - Define `MenuRepository` abstract class.
  - Create Use Cases: `GetMenuItems` (with pagination), `SearchMenuItems`.
- **Cart/Order Feature**
  - Define `CartItem` and `Order` Entities.
  - Define `CartRepository` abstract class.
  - Create Use Cases (Full CRUD): `AddToCart` (Create), `GetCart` (Read), `UpdateCartQuantity` (Update), `RemoveFromCart` (Delete), `CheckoutOrder`.

## Phase 3: Data Layer (The Engine)

*API communication and local caching. Implements the Domain contracts.*

- [ ] **Auth Feature**
  - [ ] Create `UserModel` (with `fromJson`/`toJson`).
  - [ ] Implement `AuthRemoteDataSource` (using `reqres.in` or `dummyjson.com/auth`).
  - [ ] Implement `AuthLocalDataSource` (store session token).
  - [ ] Implement `AuthRepositoryImpl` mapping Data to Domain (`Either<Failure, User>`).
- [ ] **Menu Feature**
  - Create `ProductModel`.
  - Implement `MenuRemoteDataSource` (fetch from `dummyjson.com/products`).
  - [ ] Implement `MenuLocalDataSource` (cache menus using Hive for offline access).
  - [ ] Implement `MenuRepositoryImpl`.
- [ ] **Cart/Order Feature**
  - [ ] Create `CartItemModel` and `OrderModel`.
  - [ ] Implement `CartRemoteDataSource` (simulate via `dummyjson.com/carts`).
  - [ ] Implement `CartLocalDataSource` (sync pending cart changes via Hive).
  - [ ] Implement `CartRepositoryImpl`.

## Phase 4: Presentation Layer (UI & State)

*State management and Flutter widgets.*

- [ ] **Auth Feature**
  - [ ] Create `AuthBloc` (Events: LoginRequested, LogoutRequested | States: Initial, Loading, Success, Error).
  - [ ] Build `LoginPage` UI with input validation.
  - [ ] Build `SignUpPage` UI.
- [ ] **Menu Feature**
  - [ ] Create `MenuBloc` (handle lazy loading and pagination states).
  - [ ] Build `MenuScreen` with Grid/List adaptive layouts.
  - [ ] Build `ProductDetailsScreen` (Hero animations for food images).
- [ ] **Cart/Order Feature**
  - [ ] Create `CartBloc` (optimistic UI updates for quantity changes).
  - [ ] Build `CartScreen` UI.
  - [ ] Build `CheckoutSuccessScreen` UI.

## Phase 5: Integration & Polish

*Tying it all together and making it production-ready.*

- [ ] Register all Feature Data Sources, Repositories, Use Cases, and BLoCs in `injection_container.dart`.
- [ ] Connect `go_router` paths to the actual UI pages.
- [ ] Test API error handling (simulate network drops, invalid credentials).
- [ ] Ensure memory is managed properly (dispose controllers, close streams).
- [ ] Final UI/UX review (responsive design checks, feedback snackbars/messages).
- [ ] Clean up code (resolve all analyzer warnings, remove unused imports).
