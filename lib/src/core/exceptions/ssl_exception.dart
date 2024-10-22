import 'dash_shield_exception.dart';

/// Exception for SSL-related errors such as SSL pinning issues.
class SSLException extends DashShieldException {
  SSLException(String message, [StackTrace? stackTrace])
      : super(message, stackTrace);

  @override
  String toString() => 'SSLException: $message';
}
