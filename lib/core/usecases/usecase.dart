import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:quick_mart/core/errors/failures/failures.dart';

/// Base UseCase class to enforce a standard contract across all domain use cases.
///
/// [Type] is the expected successful return type.
/// [Params] represents the required input parameters wrapped in an object.
abstract class UseCase<Type, Params> {
  /// Executes the use case.
  Future<Either<Failure, Type>> call(Params params);
}

/// Represents the absence of parameters for a [UseCase].
///
/// Use this class when a UseCase does not require any inputs
/// (e.g., fetching a static list of categories).
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
