import 'package:dartz/dartz.dart';
import 'package:food_ordering_system/core/errors/failures/failures.dart';
import 'package:food_ordering_system/features/auth/domain/repositories/auth_repository.dart';

/// Use Case for terminating the current user session.
///
/// Encapsulates the logout flow. Triggering this Use Case ensures that all
/// repository-level cleanups (like deleting the cached auth token from local
/// storage) happen consistently, regardless of whether the user tapped a
/// "Logout" button or if the session simply expired.
class LogoutUser {
  final AuthRepository repository;

  const LogoutUser({required this.repository});

  /// Executes the Use Case.
  ///
  /// Instructs the repository to end the session. Returns a [Future]
  /// containing either a [Failure] or a successful [Unit].
  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }
}