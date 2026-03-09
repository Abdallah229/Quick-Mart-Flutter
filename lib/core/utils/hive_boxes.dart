/// Utility class to manage Hive box names and injection instance names.
///
/// We use a private constructor `_()` to prevent this class from ever
/// being instantiated, as it only serves as a namespace for constant strings.
class HiveBoxes {
  HiveBoxes._();

  /// The physical string name of the Hive box stored on the device disk.
  static const String cartBoxName = 'cart_cache';
  static const String menuBoxName = 'menu_cache';

  /// The unique identifier used by `get_it` to differentiate between
  /// multiple registered instances of `Box<dynamic>`.
  static const String cartBoxInstanceName = 'CartBox';
  static const String menuBoxInstanceName = 'MenuBox';
}