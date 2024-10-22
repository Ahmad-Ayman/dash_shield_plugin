import 'dart:io';

import '../exceptions/configuration_exception.dart';
import '../exceptions/dash_shield_exception.dart';
import '../exceptions/ssl_exception.dart';

/// A utility class that categorizes and handles exceptions within the dash_shield package.
class ExceptionHandler {
  /// Throws the appropriate exception based on the error [e] and optional [stackTrace].
  ///
  /// Categorizes exceptions into SSL, HTTP, or general configuration-related errors.
  static void handleError(dynamic e, [StackTrace? stackTrace]) {
    if (e is IOException) {
      throw SSLException(
          'An SSL or IO error occurred: ${e.toString()}', stackTrace);
    } else if (e is DashShieldException) {
      throw e;
    } else {
      throw ConfigurationException(
          'An unknown error occurred: ${e.toString()}', stackTrace);
    }
  }
}
