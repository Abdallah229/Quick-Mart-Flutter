import 'package:equatable/equatable.dart';

/// Represents an authenticated user in the application.
///
/// This Entity contains only the core profile information needed by the UI
/// (like displaying the user's name on a profile screen) and the session
/// [token] required to authorize future API requests. It intentionally omits
/// backend-specific metadata (like `createdAt` or `roles`) that the user
/// interface does not care about.
class User extends Equatable {
  /// The unique identifier for the user in the database.
  final String id;

  /// The user's display name.
  final String name;

  /// The user's registered email address.
  final String email;

  /// The JWT (JSON Web Token) or session token used to authenticate
  /// subsequent API calls to secure endpoints.
  final String token;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  @override
  List<Object?> get props => [id, email, name, token];
}