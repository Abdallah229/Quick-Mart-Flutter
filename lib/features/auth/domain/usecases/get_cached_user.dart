import 'package:dartz/dartz.dart';
import 'package:quick_mart/core/errors/failures/failures.dart';
import 'package:quick_mart/features/auth/domain/repositories/auth_repository.dart';
import '../entities/user.dart';

/// Use Case for retrieving the active user session from local storage.
///
/// This is the backbone of the app's "Splash Screen" logic. It checks if
/// a user has previously logged in and still has a valid token on the device,
/// allowing the application to bypass the Login screen on startup.
class GetCachedUser {
  final AuthRepository repository;

  const GetCachedUser({required this.repository});

  /// Executes the Use Case.
  ///
  /// Queries the repository's local cache. Returns a [Future] containing
  /// either a [Failure] (if no active session is found) or the cached [User].
  Future<Either<Failure, User>> call() async {
    return await repository.getCachedUser();
  }
}
