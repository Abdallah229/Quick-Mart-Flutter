import 'package:dartz/dartz.dart';
import 'package:food_ordering_system/core/errors/failures/failures.dart';
import '../entities/user.dart';

/// The contract for the Authentication Feature's Data Layer.
///
/// This repository defines the strict rules for how the app handles user
/// identity and sessions. By keeping this abstract, the Domain layer doesn't
/// care if you use Firebase Auth, a custom Node.js backend, or Auth0.
/// It only cares that these four specific operations exist and return the
/// expected [Either] types.
abstract class AuthRepository {
  /// Authenticates an existing user using their [email] and [password].
  ///
  /// Returns a [Future] containing either a [Failure] (e.g., wrong password,
  /// user not found) or the authenticated [User] entity.
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  /// Creates a new user account with a [name], [email], and [password].
  ///
  /// Returns a [Future] containing either a [Failure] (e.g., email already
  /// in use, weak password) or the newly created [User] entity.
  Future<Either<Failure, User>> register({
    required String email,
    required String name,
    required String password,
  });

  /// Terminates the current user's session.
  ///
  /// This typically involves clearing the cached token from local storage
  /// and potentially notifying the backend to invalidate the session.
  /// Returns a successful [Unit] upon completion.
  Future<Either<Failure, Unit>> logout();

  /// Retrieves the currently logged-in user from local device storage.
  ///
  /// This is crucial for keeping users logged in across app restarts.
  /// It returns the [User] if a valid session exists in cache, or a [Failure]
  /// (like a `CacheFailure`) if no user is found, prompting the UI to show
  /// the Login screen instead of the Home screen.
  Future<Either<Failure, User>> getCachedUser();
}