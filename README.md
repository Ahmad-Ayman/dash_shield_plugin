# dash_shield

---------------------------------------
# SSL Security Service

This package provides a single static method to implement SSL certificate pinning for Flutter applications using Dio, http, or Retrofit.

### Usage

1. **Attach SSL Certificate**:
   
   Attach the SSL certificate directly by calling the static method `attachSSLCertificate()`:

   ```dart
   // Using with Dio
   Dio dio = Dio();
   await SSLSecurityService.attachSSLCertificate('assets/certificates/mycert.pem', dio);

   // Using with http package
   http.Client client = await SSLSecurityService.attachSSLCertificate('assets/certificates/mycert.pem', http.Client());

   // Using with Retrofit (via Dio)
   final dio = Dio();
   await SSLSecurityService.attachSSLCertificate('assets/certificates/mycert.pem', dio);
   final retrofit = Retrofit(dio);  // Retrofit uses Dio internally.


---------------------------------------

# DashShield Plugin

DashShield is a Flutter plugin that provides app security checks for both Android and iOS. You can configure it to check for app integrity, debug mode, device binding, hooks, secure hardware, and more. It offers flexibility for developers to set custom actions and checks for different security threats.

## Features

- **App Integrity Checks**: Verify app integrity, debug detection, and other security threats.
- **Custom Actions**: Developers can define actions for different issues like showing a toast message or terminating the app.
- **Multi-Platform**: Supports Android, iOS, or both.

## Configuration

To use DashShield, you need to provide a configuration object where you specify the following:

- Android signing hashes (required if Android enabled).
- Package name (required if Android enabled).
- iOS Bundle IDs and team ID (required if ios enabled)
- Watcher email (required).
- Supported stores (optional).
- Enable or disable specific security checks.
- Specify General Action for all checks or leave it to use the default action (Showing Toast)

## Example Usage

```dart
import 'package:dash_shield/dash_shield.dart';

void main() {
  final config = SecurityConfig(
    androidSigningCertHashes: ['REPLACE_WITH_SHA256_HASH1', 'REPLACE_WITH_SHA256_HASH2'],
    androidPackageName: 'com.example.app',
    iosBundleIds: ['com.example.app.ios'],
    iosTeamId: 'TEAM_ID',
    isProduction: true,
    generalAction: (issue) {
      // Default action for any issue
      Fluttertoast.showToast(msg: 'Issue detected: $issue');
    },
    specificActions: {
      SecOnControlsToApply.debug: (issue) {
        // Custom action for debug issue
        exit(0);  // Terminate app
      },
    },
  );

  // Initialize the checker with configurations
  DashShield.initSecurity(
    config: config,
  );
}

