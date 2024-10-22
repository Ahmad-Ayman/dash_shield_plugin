import 'package:dash_shield/src/features/integrity_checks/integrity_checks_service.dart';
import 'package:dash_shield/src/features/integrity_checks/security_config.dart';

import 'dash_shield_platform_interface.dart';
import 'src/features/ssl_pinning/ssl_security_service.dart';

class DashShield {
  /// Prevents screenshots and screen recording globally for the entire app.
  ///
  /// This method should be called during app initialization (e.g., in the `main()` function).
  ///
  /// Example usage:
  /// ```dart
  /// DashShield.preventScreenshotsGlobally();
  /// ```
  static Future<void> preventScreenshotsGlobally() {
    return DashShieldPlatform.instance.preventScreenshotsGlobally();
  }

  /// Prevents screenshots and screen recording on a specific screen.
  ///
  /// This method can be called when navigating to a specific screen.
  ///
  /// Example usage:
  /// ```dart
  /// DashShield.preventScreenshotsAndRecording();
  /// ```
  static Future<void> preventScreenshotsAndRecording() {
    return DashShieldPlatform.instance.preventScreenshotsAndRecording();
  }

  /// Applies SSL Pinning using the given [certificateAssetPath] for the specified [client].
  ///
  /// This method acts as a proxy, delegating the actual SSL pinning logic to the [SSLSecurityService].
  /// The [client] can be either a Dio instance or an http.Client.
  static void applySSLPinning(
      String certificateAssetPath, dynamic client) async {
    // Delegates to SSLSecurityService for actual SSL pinning.
    await SSLSecurityService.attachSSLCertificate(certificateAssetPath, client);
  }

  /// Initializes security checks for Android and iOS.
  ///
  /// Delegates the responsibility to `IntegrityChecksService`.
  /// Initializes security checks for Android and iOS platforms.
  ///
  /// This method delegates the integrity checks to the [IntegrityChecksService] class,
  /// which handles the security configuration and threat detection process.
  ///
  /// ### Parameters:
  ///
  /// - [config]: A [SecurityConfig] object that contains all required information to configure the security checks.
  ///   - This includes Android signing hashes, Android package name, iOS bundle IDs, iOS team ID, production flag, and action methods.
  ///   - The developer can specify whether to apply general actions for all checks or define specific actions for each check.
  ///
  ///
  /// ### Example:
  ///
  /// ```dart
  /// final config = SecurityConfig(
  ///   androidSigningCertHashes: ['SHA256_HASH1', 'SHA256_HASH2'],
  ///   androidPackageName: 'com.example.app',
  ///   iosBundleIds: ['com.example.app.ios'],
  ///   iosTeamId: 'TEAM_ID',
  ///   isProduction: true,
  ///   generalAction: (issue) {
  ///     Fluttertoast.showToast(msg: 'Issue detected: $issue');
  ///   },
  ///   specificActions: {
  ///     SecOnControlsToApply.debug: (issue) {
  ///       exit(0); // Terminate app on debug detection
  ///     },
  ///   },
  /// );
  ///
  /// DashShield.initSecurity(
  ///   config: config,
  /// );
  /// ```
  ///
  /// ### Throws:
  ///
  /// - [DashShieldException]: If an error occurs during the initialization of the security checks or
  ///   if any of the required parameters are missing for the enabled platforms.
  ///
  /// ### Notes:
  ///
  /// - If no checks are enabled using the `checksToEnable` field in [SecurityConfig], all checks will be enabled by default.
  /// - If no specific actions are defined for checks in `specificActions`, the `generalAction` will be applied to all checks.
  ///
  /// ### Security Features Covered:
  ///  appIntegrity,
  ///  obfuscationIssues,
  ///  debug,
  ///   deviceBinding,
  ///  hooks,
  ///  onPasscode,
  ///  privilegedAccess,
  ///   secureHardwareNotAvailable,
  ///   simulator,
  ///   systemVPN,
  ///   devMode,
  ///   unofficialStore,
  ///
  static void initSecurity({required SecurityConfig config}) async {
    // Delegate to IntegrityChecksService for starting security checks
    await IntegrityChecksService.startIntegrityChecks(config: config);
  }
}
