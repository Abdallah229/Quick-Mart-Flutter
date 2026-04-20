import 'package:dio/dio.dart';
import 'package:quick_mart/core/errors/error_message_model.dart';
import 'package:quick_mart/core/errors/exceptions/exceptions.dart';

/// A global Dio interceptor responsible for catching and transforming all
/// HTTP errors before they reach the `DioConsumer`.
///
/// In Clean Architecture, the Data Layer must not expose third-party
/// framework details to the rest of the app. This interceptor acts as a
/// middleware that translates raw [DioException]s into our application's
/// custom [ServerException] and [NetworkException]. This centralizes
/// error parsing and keeps the network clients exceptionally clean.
class ErrorInterceptor extends Interceptor {
  /// Intercepts failed API requests and throws the appropriate custom Exception.
  ///
  /// It evaluates the `err.type` to appropriately route the error:
  /// * Connection/Timeout errors automatically throw a [NetworkException].
  /// * `badResponse` (4xx, 5xx) errors attempt to parse the server's JSON
  ///   into an [ErrorMessageModel] and throw a [ServerException].
  /// * Unknown or cancellation errors throw a generic safe [ServerException].
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      // ==========================================
      // 1. NETWORK & CONNECTION ERRORS
      // ==========================================
      // Using "fall-through" to catch all timeout/connection issues at once
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        {
          throw NetworkException();
        }
      // ==========================================
      // 2. SERVER RESPONSE ERRORS (4xx, 5xx)
      // ==========================================
      case DioExceptionType.badResponse:
        {
          // The server replied, but with an error status code.
          // We try to extract the custom backend message.
          if (err.response != null && err.response?.data != null) {
            try {
              final errorModel = ErrorMessageModel.fromJson(
                err.response!.data as Map<String, dynamic>,
              );
              throw ServerException(errorModel: errorModel);
            } catch (e) {
              // Fallback if the server crashes and returns HTML or malformed JSON
              throw ServerException(
                errorModel: const ErrorMessageModel(
                  'Unexpected server error format.',
                ),
              );
            }
          } else {
            throw ServerException(
              errorModel: const ErrorMessageModel(
                'Server returned an empty error response',
              ),
            );
          }
        }

      // ==========================================
      // 3. FALLBACK / UNKNOWN ERRORS
      // ==========================================
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
      default:
        {
          throw ServerException(
            errorModel: const ErrorMessageModel('An unknown error occurred.'),
          );
        }
    }
  }
}
