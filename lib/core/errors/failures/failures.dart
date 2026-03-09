import 'package:equatable/equatable.dart';

/// Base class for all Domain-level errors in the application.
///
/// Unlike Exceptions (which are thrown in the Data layer and disrupt execution),
/// [Failure]s are safely returned from Repositories using functional
/// error handling (e.g., returning an `Either<Failure, Success>` using dartz).
///
/// They contain a user-friendly [message] that the Presentation layer (BLoC/UI)
/// can display directly in Snackbars, Dialogs, or Error Screens without
/// needing to parse complex logic.
///
/// Extends [Equatable] to allow BLoC to compare error states properly.
abstract class Failure extends Equatable {
  /// The user-facing error message ready to be displayed in the UI.
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Represents an error explicitly returned by the backend API.
///
/// Typically created in the Repository implementation by catching a
/// `ServerException` from the Data layer and extracting its parsed error message.
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

/// Represents a failure to communicate with the external server.
///
/// Typically created in the Repository layer when a `NetworkException`
/// is caught (e.g., a timeout), or when `NetworkInfo` detects that the
/// device has no active internet connection before a request is even made.
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

class CacheFailure extends Failure {
 const  CacheFailure({required super.message});

}