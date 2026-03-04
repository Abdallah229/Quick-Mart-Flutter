import 'package:dartz/dartz.dart';
import 'package:food_ordering_system/features/menu/domain/entities/product.dart';
import 'package:food_ordering_system/features/menu/domain/repositories/menu_repository.dart';

import '../../../../core/errors/failures/failures.dart';

/// Use Case for fetching a paginated list of available food items.
///
/// In Clean Architecture, Use Cases encapsulate a single, specific business
/// rule or action. This class acts as a bridge between the Presentation
/// layer (BLoC) and the Data layer (Repository), ensuring the UI doesn't
/// interact with the Data layer directly.
class GetMenuItems {
  final MenuRepository repository;

  GetMenuItems({required this.repository});

  /// Executes the use case.
  ///
  /// Using Dart's `call` method allows the class instance to be invoked
  /// like a function (e.g., `final result = await getMenuItems(page: 1);`).
  /// Forwards the [page] parameter to the repository and returns either a
  /// [Failure] or a successful `List<Product>`.
  Future<Either<Failure, List<Product>>> call({required int page}) async {
    return await repository.getMenuItems(page: page);
  }
}