import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:quick_mart/core/errors/failures/failures.dart';

/// The foundational blueprint for all UseCases in the application.
///
/// [Type] defines the successful return data type of the UseCase.
/// [Params] defines the specific arguments required to execute the logic.
///
/// By enforcing a strict `call` method, this ensures all business logic
/// flows through a standardized execution pipeline, always returning a
/// functional [Either] containing a Failure or the expected Data.
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
