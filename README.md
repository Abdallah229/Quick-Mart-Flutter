# 🛒 QuickMart - Flutter E-Commerce Application

![Flutter Version](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter)
![Dart Version](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![Architecture](https://img.shields.io/badge/Architecture-Clean_Architecture-4CAF50)
![State Management](https://img.shields.io/badge/State_Management-Cubit/Bloc-blue)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Linux%20%7C%20Web-lightgrey)

A production-ready, highly responsive e-commerce and market application built with Flutter. Designed strictly adhering to **Clean Architecture** principles, this project demonstrates advanced state management, local data caching, and dynamic tablet/mobile responsiveness.

---

## 📑 Table of Contents
1. [Key Features](#-key-features)
2. [Screenshots](#-screenshots)
3. [Tech Stack](#-tech-stack)
4. [Architecture & Project Structure](#-architecture--project-structure)
5. [Getting Started](#-getting-started)
6. [Development & Git Flow](#-development--git-flow)

---

## ✨ Key Features
* **Clean Architecture Boundary Separation:** Strict decoupling of Presentation, Domain, and Data layers to ensure scalability and testability.
* **Responsive Design System:** Custom `LayoutBuilder` wrappers dynamically adapt the UI between Mobile (Bottom Navigation) and Tablet/Web (Navigation Rail) interfaces without memory leaks.
* **Hybrid Search Functionality:** Debounced network searching combined with strict local filtering to prevent backend query anomalies.
* **Offline-First Caching:** Utilizes `Hive` to locally cache cart states and product catalogs for seamless UX during poor network conditions.
* **Advanced State Management:** Predictable, synchronous UI state containers managed via `flutter_bloc` and `Cubit`.
* **Enterprise Theming:** Centralized Material 3 Design System with meticulously defined light and dark color schemes.

## 📱 Screenshots

> **Note:** Replace these placeholder links with actual raw image URLs once uploaded to your repository's `/docs/assets` folder.

|                               Home Screen (Mobile)                                |                               Product Details (Tablet)                               |                                   Cart Screen                                   |
|:---------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|
| <img src="https://via.placeholder.com/250x500.png?text=Mobile+Home" width="250"/> | <img src="https://via.placeholder.com/400x500.png?text=Tablet+Details" width="400"/> | <img src="https://via.placeholder.com/250x500.png?text=Cart+View" width="250"/> |

## 🛠️ Tech Stack
* **Framework:** Flutter & Dart
* **State Management:** `flutter_bloc` / `equatable`
* **Networking:** `dio` (configured with global Error Interceptors)
* **Local Storage:** `hive` / `hive_flutter`
* **Dependency Injection:** `get_it`

---

## 🏗️ Architecture & Project Structure

This project strictly follows the **Clean Architecture** pattern, segmented by feature to ensure high cohesion and low coupling.

```text
lib/
├── core/                   # App-wide shared resources
│   ├── constants/          # Static app constants
│   ├── enums/              # Shared enums (e.g., RequestState, CartAction)
│   ├── errors/             # Global failure and exception handling
│   ├── network/            # Dio consumers and API interceptors
│   ├── theming/            # Material 3 light/dark color palettes and ThemeData
│   ├── usecases/           # Base UseCase contracts
│   ├── utils/              # Helper functions, Hive boxes, and API endpoints
│   └── widgets/            # Reusable UI components (e.g., ResponsiveLayout)
│
├── features/               # Feature-based clean architecture modules
│   ├── auth/               # Authentication domain logic
│   ├── cart/               # Order management and checkout flows
│   ├── explore/            # Category directory
│   ├── home/               # Market dashboard and item search
│   ├── product_details/    # Dynamic tablet/mobile layouts for items
│   └── profile/            # User settings and placeholders
│       │
│       ├── data/           # (Inside features) Models, Data Sources, Repositories
│       ├── domain/         # (Inside features) Entities, UseCases, Contracts
│       └── presentation/   # (Inside features) UI Pages, Widgets, Cubits
│
├── injection_container.dart # Service locator (GetIt) dependency injection setup
└── main.dart               # App entry point
````

-----

## 🚀 Getting Started

### Prerequisites

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.10 or higher)
* Dart SDK (v3.0 or higher)
* Target platforms configured (Android Studio, Xcode, or Linux desktop dependencies)

### Installation & Setup

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/Abdallah229/Quick-Mart-Flutter.git
    cd quick_mart
    ```

2.  **Fetch dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Code Generation (if applicable in future updates):**

    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the application:**
    Launch an emulator or connect a physical device, then run:

    ```bash
    # For default connected device
    flutter run

    # For specific platform testing (e.g., Linux desktop or Chrome)
    flutter run -d linux
    flutter run -d chrome
    ```

-----

## 🌿 Development & Git Flow

This project utilizes a strict, enterprise-grade Git Flow to maintain repository integrity.

* **`main`**: The production-ready release branch. Locked for direct commits.
* **`dev`**: The active integration branch. All features merge here first.
* **`feature/*`**: Scoped branches for active development (e.g., `feature/auth`, `feature/tablet-ui`).

**Contribution Steps:**

1.  Checkout the `dev` branch and pull the latest changes.
2.  Create a new `feature/` branch.
3.  Commit your changes with descriptive, conventional commit messages.
4.  Push to your remote branch and open a Pull Request targeting `dev`.

-----

*Architected and developed by [Abdallah Mohamed](https://www.google.com/search?q=https://github.com/%3CAbdallah229%3E)*
