import 'package:quick_mart/core/errors/error_message_model.dart';

/// Exception thrown when the remote server returns an error status code
/// (e.g., 400 Bad Request, 404 Not Found, 500 Internal Server Error).
///
/// It carries the [errorModel], which contains the specific error message
/// parsed from the server's JSON response. This allows the Data Layer to pass
/// exact backend feedback up to the Domain Layer.
class ServerException implements Exception {
  final ErrorMessageModel errorModel;

  ServerException({required this.errorModel});
}

/// Exception thrown when a local database operation fails.
///
/// As a strict Clean Architecture marker exception, it contains no message string.
/// It is thrown by the Local Data Source (e.g., Hive) when reading or writing
/// fails. The Repository catches this and maps it to a `CacheFailure` containing
/// the actual user-facing error message.
class CacheException implements Exception {}

/// Exception thrown when the device cannot successfully connect to the internet.
///
/// This empty marker exception is used when the device has no active network
/// connection, or when an API call times out before reaching the server.
/// The Repository catches this and maps it to a `NetworkFailure`.
class NetworkException implements Exception {}
