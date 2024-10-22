import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../../core/exceptions/configuration_exception.dart';
import '../../core/handlers/exception_handler.dart';

/// A service in dash_shield package for applying SSL certificate pinning to Dio, Retrofit, and http package.
///
/// This class provides a single static method to load a certificate and attach it to the client.
class SSLSecurityService {
  /// Attaches SSL certificate pinning to the provided [client] using the certificate from [certificateAssetPath].
  ///
  /// This method is static, so it can be called directly without creating an instance of the class.
  ///
  /// Supports Dio, Retrofit (via Dio), and http package.
  ///
  /// Example usage:
  /// ```dart
  /// Dio dio = Dio();
  /// await SSLSecurityService.attachSSLCertificate('assets/certificates/mycert.pem', dio);
  ///
  /// http.Client client = await SSLSecurityService.attachSSLCertificate('assets/certificates/mycert.pem', http.Client());
  /// ```
  ///
  /// Throws an [SSLException] or [ConfigurationException] if there is an issue.
  static Future<dynamic> attachSSLCertificate(
      String certificateAssetPath, dynamic client) async {
    try {
      final ByteData data = await rootBundle.load(certificateAssetPath);
      SecurityContext securityContext =
          SecurityContext(withTrustedRoots: false);
      securityContext.setTrustedCertificatesBytes(data.buffer.asInt8List());

      if (client is Dio) {
        HttpClient httpClient = HttpClient(context: securityContext);
        httpClient.badCertificateCallback =
            (X509Certificate cert, String host, int port) => false;
        (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
            () => httpClient;

        return client;
      } else if (client is http.Client) {
        HttpClient httpClient = HttpClient(context: securityContext);
        httpClient.badCertificateCallback =
            (X509Certificate cert, String host, int port) => false;
        return IOClient(httpClient);
      } else {
        throw ConfigurationException(
            'Unsupported client type. Only Dio, http.Client, are supported.');
      }
    } catch (e, stackTrace) {
      ExceptionHandler.handleError(e, stackTrace);
    }
  }
}
