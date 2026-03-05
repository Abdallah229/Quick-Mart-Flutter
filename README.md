# 🍔 Online Food Ordering System

![Flutter](https://img.shields.io/badge/Flutter-%5E3.11.0-blue.svg?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-Fast-00C4B3.svg?logo=dart)
![Architecture](https://img.shields.io/badge/Architecture-Clean-success)

A high-performance, scalable Flutter mobile application built using **Clean Architecture** and **Feature-First** modularity. This project demonstrates advanced state management, robust RESTful API integration, and persistent offline data handling.

## ✨ Features

### Business Features

* **Authentication Flow:** Secure user sign-up, login, and session management.
* **Menu Catalog:** Browse restaurant menus with paginated and lazy-loaded lists.
* **Cart Management:** Full CRUD capabilities (Create, Read, Update, Delete) for order management.
* **Order History:** View past orders with detailed receipt breakdowns.

### Technical Features

* **Clean Architecture:** Strict separation of Presentation, Domain, and Data layers.
* **State Management:** Predictable state transitions using `flutter_bloc` (Cubit).
* **API Integration:** Robust REST communication using `dio` with custom error interceptors.
* **Local Caching:** Offline-first data persistence using `hive` and `shared_preferences`.
* **Dependency Injection:** Decoupled service locator pattern utilizing `get_it`.
* **Declarative Routing:** Systematic navigation handling via `go_router`.
* **Functional Error Handling:** Safe failure resolution using `dartz` (`Either<Failure, Success>`).
* **Environment Security:** API keys and Base URLs protected via `.env` configurations.

## 🛠️ Tech Stack

* **Framework:** Flutter (Dart)
* **State Management:** `flutter_bloc`, `equatable`
* **Network:** `dio`, `internet_connection_checker_plus`
* **Database/Storage:** `hive`, `hive_flutter`, `shared_preferences`
* **Routing:** `go_router`
* **Dependency Injection:** `get_it`
* **Utilities:** `dartz`, `flutter_dotenv`

[Image of Clean Architecture diagram]

## 📂 Project Architecture

The project strictly follows a Feature-First Clean Architecture approach.

```text
lib/
├── core/                                # Shared app-wide resources
│   ├── errors/
│   │   ├── exceptions.dart              # Server and Cache exceptions
│   │   ├── failures.dart                # Domain-level Failure classes
│   │   └── error_message_model.dart     # API error parsing model
│   ├── network/
│   │   ├── api_consumer.dart            # Abstract network contract
│   │   ├── dio_consumer.dart            # Dio implementation of ApiConsumer
│   │   ├── error_interceptor.dart       # Dio interceptor for global error handling
│   │   └── network_info.dart            # Connectivity checker
│   ├── utils/
│   │   └── api_endpoints.dart           # Centralized API URLs and paths
├── features/                            # Feature modules
│   ├── auth/
│   │   ├── data/                        
│   │   ├── domain/                      
│   │   └── presentation/                
│   ├── cart/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── menu/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── local/               # Hive caching logic
│       │   │   └── remote/              # Dio API calls
│       │   ├── models/                  # JSON serialization (ProductModel)
│       │   └── repositories/            # Data layer repository implementations
│       ├── domain/
│       │   ├── entities/                # Pure Dart business objects
│       │   ├── repositories/            # Abstract contracts
│       │   └── usecases/                # Isolated business actions
│       └── presentation/                # BLoCs, Pages, Widgets
├── injection_container.dart             # GetIt service locator setup
└── main.dart                            # App entry point

```

## 🚀 Getting Started

### Prerequisites

* Flutter SDK (`^3.11.0`)
* Dart SDK

### Installation

1. Clone the repository:

```bash
git clone https://github.com/Abdallah229/Online-Food-Ordering-Flutter.git

```

1. Create a `.env` file in the root directory and add your API URLs:

```env
BASE_URL=[https://dummyjson.com/](https://dummyjson.com/)

```

1. Fetch dependencies:

```bash
flutter pub get

```

1. Run the app:

```bash
flutter run

```
