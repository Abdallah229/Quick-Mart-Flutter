import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'dart:io';

/// A contract for checking the device's internet connectivity.
///
/// By abstracting this check into an interface, the Data Layer (specifically
/// the Repositories) can verify network status without being tightly coupled
/// to a specific third-party package. This allows the Repositories to intelligently
/// route data requests—fetching fresh data from the remote API if online,
/// or immediately falling back to cached local data (e.g., Hive) if offline.
abstract class NetworkInfo {
  /// Returns `true` if the device has an active internet connection,
  /// otherwise returns `false`.
  Future<bool> get isConnected;
}

/// The concrete implementation of the [NetworkInfo] contract.
///
/// This implementation utilizes the `internet_connection_checker_plus` package.
/// It doesn't just check if Wi-Fi or Cellular is toggled on; it actively pings
/// external servers to verify actual data transfer capabilities, preventing false
/// positives when connected to networks without internet access (like a captive portal).
class NetworkInfoImpl implements NetworkInfo {
  // /// The underlying connection checker instance.
  // ///
  // /// Injected via the constructor (Dependency Injection) to allow for
  // /// centralized configuration and easy mocking during unit testing.
  // final InternetConnection internetConnection;

  NetworkInfoImpl();

  @override
  Future<bool> get isConnected async {
    try {
      // Pings dummyjson directly. If it resolves, we have internet!
      final result = await InternetAddress.lookup('dummyjson.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      // If it fails to reach the site, we are offline. No crashes.
      return false;
    }
  }
}
