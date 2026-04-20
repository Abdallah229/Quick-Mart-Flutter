import 'package:quick_mart/core/network/api_consumer.dart';
import 'package:dio/dio.dart';
import '../errors/error_message_model.dart';
import '../errors/exceptions/exceptions.dart';

/// The concrete implementation of the [ApiConsumer] interface using the
/// third-party `dio` HTTP client.
///
/// This class acts as a protective boundary around the Dio package. It handles
/// the actual HTTP requests but strictly returns only the pure `response.data`
/// payload. It explicitly catches and converts framework-specific errors into
/// our custom Clean Architecture Domain exceptions ([ServerException] and
/// [NetworkException]), ensuring that the Data and Domain layers remain
/// completely ignorant of Dio's existence.
class DioConsumer implements ApiConsumer {
  /// The underlying HTTP client.
  ///
  /// Injected via the constructor (Dependency Injection) to allow for
  /// centralized configuration of `BaseOptions` and `Interceptors`
  /// inside the `injection_container.dart`, and to enable easy mocking
  /// during unit testing.
  final Dio client;

  DioConsumer({required this.client});

  /// Executes an HTTP DELETE request.
  ///
  /// Relies on the globally registered `ErrorInterceptor` to catch and parse
  /// API or network failures. If an exception bubbles past the interceptor,
  /// it is caught here and converted to a safe fallback [ServerException].
  @override
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.delete<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on ServerException {
      // Caught by the ErrorInterceptor; bubble it up to the Repository.
      rethrow;
    } on NetworkException {
      // Caught by the ErrorInterceptor; bubble it up to the Repository.
      rethrow;
    } catch (e) {
      // Ultimate safety net for runtime or parsing errors that slip through.
      throw ServerException(
        errorModel: const ErrorMessageModel('An unexpected error occurred'),
      );
    }
  }

  /// Executes an HTTP GET request to fetch data.
  ///
  /// Returns the raw JSON data. Exception handling matches the [delete] method,
  /// ensuring a uniform error architecture across all network calls.
  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get<dynamic>(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(
        errorModel: const ErrorMessageModel('An unexpected error occurred'),
      );
    }
  }

  /// Executes an HTTP POST request to create new data.
  ///
  /// If [isFormData] is `true`, it intercepts the raw [data] map and
  /// converts it into Dio's `FormData` format before transmission,
  /// which is necessary for file or image uploads.
  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (isFormData) {
        data = FormData.fromMap(data as Map<String, dynamic>);
      }
      final response = await client.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(
        errorModel: const ErrorMessageModel('An unexpected error occurred'),
      );
    }
  }

  /// Executes an HTTP PUT request to modify existing data.
  ///
  /// Supports [isFormData] conversion for multipart uploads. Includes the
  /// standard custom exception routing.
  @override
  Future<dynamic> put(
    String path, {
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (isFormData) {
        data = FormData.fromMap(data as Map<String, dynamic>);
      }
      final response = await client.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(
        errorModel: const ErrorMessageModel('An unexpected error occurred'),
      );
    }
  }
}
