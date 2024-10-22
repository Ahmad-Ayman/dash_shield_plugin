/// The base class for all exceptions in the dash_shield package.
///
/// It provides a general structure for custom exceptions within the package.
class DashShieldException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  DashShieldException(this.message, [this.stackTrace]);

  @override
  String toString() => 'DashShieldException: $message';
}
