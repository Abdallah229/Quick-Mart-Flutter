/// Centralized repository for all external API endpoints.
///
/// By storing these as `static const` variables, we eliminate "magic strings"
/// from our Data Sources. This prevents typos and makes future refactoring
/// incredibly simple if the backend URL structure ever changes.
class ApiEndpoints {
  ApiEndpoints._();
  // The root URL for your API (this usually goes in your Dio BaseOptions)
  static const String baseUrl = 'https://dummyjson.com/';

  // ==========================================
  // MENU FEATURE ENDPOINTS
  // ==========================================
  static const String products = 'products';
  static const String searchProducts = 'products/search';

  // ==========================================
  // AUTH FEATURE ENDPOINTS (For later)
  // ==========================================
  static const String login = 'auth/login';
}
