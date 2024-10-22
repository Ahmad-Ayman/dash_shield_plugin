import 'dash_shield_exception.dart';

/// Exception for errors related to HttpClient operations.
class HttpClientException extends DashShieldException {
  HttpClientException(super.message, [super.stackTrace]);

  @override
  String toString() => 'HttpClientException: $message';
}
