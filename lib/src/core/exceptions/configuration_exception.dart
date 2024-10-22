import 'dash_shield_exception.dart';

/// Exception for configuration-related errors (e.g., missing certificate).
class ConfigurationException extends DashShieldException {
  ConfigurationException(super.message, [super.stackTrace]);

  @override
  String toString() => 'ConfigurationException: $message';
}
