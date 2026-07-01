/// A clean, user-friendly exception that returns only the message
/// when converted to a String — no "Exception: " prefix.
class AppException implements Exception {
  final String message;

  const AppException(this.message);

  /// Returns just the message, so `error.toString()` is display-ready.
  @override
  String toString() => message;
}
