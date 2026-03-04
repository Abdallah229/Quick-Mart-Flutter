import 'package:dartz/dartz.dart';
import 'package:food_ordering_system/core/errors/failures/failures.dart';
import 'package:food_ordering_system/features/auth/domain/repositories/auth_repository.dart';
import '../entities/user.dart';

/// Use Case for creating a brand new user account.
///
/// Handles the specific action of registration. Keeping this separate from
/// [LoginUser] respects the Single Responsibility Principle, as the rules
/// for registering (e.g., password strength checks, validating the [name])
/// are vastly different from the rules for simply logging in.
class RegisterUser {
  final AuthRepository repository;

  const RegisterUser({required this.repository});

  /// Executes the Use Case.
  ///
  /// Forwards the [email], [name], and [password] to the repository. Returns
  /// a [Future] containing either a [Failure] (e.g., email already exists)
  /// or the newly created [User] entity.
  Future<Either<Failure, User>> call({
    required String email,
    required String name,
    required String password,
  }) async {
    return await repository.register(
      email: email,
      name: name,
      password: password,
    );
  }
}