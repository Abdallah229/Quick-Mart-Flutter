import 'package:dartz/dartz.dart';
import 'package:food_ordering_system/core/errors/failures/failures.dart';
import 'package:food_ordering_system/features/auth/domain/repositories/auth_repository.dart';
import '../entities/user.dart';

/// Use Case for authenticating an existing user.
///
/// Encapsulates the specific business rules for logging into the application.
/// By keeping this isolated, any future pre-login validation (like checking
/// if the email string is properly formatted before hitting the network)
/// can be safely added here without bloating the UI or Data layers.
class LoginUser {
  final AuthRepository repository;

  const LoginUser({required this.repository});

  /// Executes the Use Case.
  ///
  /// Passes the user's [email] and [password] to the repository. Returns
  /// a [Future] containing either a [Failure] (e.g., invalid credentials)
  /// or a successful [User] entity containing the active session token.
  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}