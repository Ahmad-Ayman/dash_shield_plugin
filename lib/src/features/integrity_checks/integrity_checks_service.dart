import 'package:freerasp/freerasp.dart';

import '../../core/exceptions/dash_shield_exception.dart';
import '../../core/utils/enums.dart';
import 'security_config.dart'; // Import the configuration class

/// The service responsible for managing app integrity checks for Android and iOS.
class IntegrityChecksService {
  /// Starts the integrity checks based on the configuration provided.
  /// Handles the process of setting up platform-specific checks and applying the necessary actions.
  static Future<void> startIntegrityChecks({
    required SecurityConfig config,
  }) async {
    try {
      // Get the enabled checks from the config
      final enabledChecks = config.getEnabledChecks();

      // Set up the config for the Talsec library
      final talsecConfig = TalsecConfig(
        androidConfig: config.enableOnAndroid
            ? AndroidConfig(
                packageName: config.androidPackageName!,
                signingCertHashes: config.androidSigningCertHashes!,
                supportedStores: config.supportedStores ?? [],
              )
            : null,
        iosConfig: config.enableOniOS
            ? IOSConfig(
                bundleIds: config.iosBundleIds!,
                teamId: config.iosTeamId!,
              )
            : null,
        watcherMail: config.watcherEmail,
        isProd: config.isProduction,
      );

      // Set up the callback for security checks
      final callback = _buildThreatCallback(config, enabledChecks);

      // Attach the listener and start the security checks
      Talsec.instance.attachListener(callback);
      await Talsec.instance.start(talsecConfig);
    } catch (e) {
      // Handle any exceptions related to starting integrity checks
      throw DashShieldException(
        'IntegrityChecksService Error: Failed to start integrity checks: ${e.toString()}',
      );
    }
  }

  /// Builds the callback for handling the detected threats.
  static ThreatCallback _buildThreatCallback(
      SecurityConfig config, List<SecOnControlsToApply> enabledChecks) {
    return ThreatCallback(
      onAppIntegrity: () => _handleCheck(config, enabledChecks,
          SecOnControlsToApply.appIntegrity, 'App Integrity'),
      onObfuscationIssues: () => _handleCheck(config, enabledChecks,
          SecOnControlsToApply.obfuscationIssues, 'Obfuscation issues'),
      onDebug: () => _handleCheck(
          config, enabledChecks, SecOnControlsToApply.debug, 'Debugging'),
      onDeviceBinding: () => _handleCheck(config, enabledChecks,
          SecOnControlsToApply.deviceBinding, 'Device binding'),
      onHooks: () => _handleCheck(
          config, enabledChecks, SecOnControlsToApply.hooks, 'Hooks'),
      onPasscode: () => _handleCheck(config, enabledChecks,
          SecOnControlsToApply.hooks, 'Passcode not set'),
      onPrivilegedAccess: () => _handleCheck(config, enabledChecks,
          SecOnControlsToApply.privilegedAccess, 'Privileged access'),
      onSecureHardwareNotAvailable: () => _handleCheck(
          config,
          enabledChecks,
          SecOnControlsToApply.secureHardwareNotAvailable,
          'Secure hardware not available'),
      onSimulator: () => _handleCheck(config, enabledChecks,
          SecOnControlsToApply.simulator, 'Simulator/Emulator Detected'),
      onSystemVPN: () => _handleCheck(
          config, enabledChecks, SecOnControlsToApply.systemVPN, 'System VPN'),
      onDevMode: () => _handleCheck(config, enabledChecks,
          SecOnControlsToApply.devMode, 'Developer mode'),
      onUnofficialStore: () => _handleCheck(config, enabledChecks,
          SecOnControlsToApply.unofficialStore, 'Unofficial store'),
    );
  }

  /// Handles each security check by applying the correct action or throwing relevant exceptions.
  static void _handleCheck(
      SecurityConfig config,
      List<SecOnControlsToApply> enabledChecks,
      SecOnControlsToApply check,
      String issue) {
    try {
      // Check if this specific security check is enabled
      if (enabledChecks.contains(check)) {
        // Get the action for this check or fallback to the general action
        final action = config.getActionForCheck(check);
        action(issue); // Execute the action
      }
    } catch (e) {
      // Handle any specific issue with executing the action
      throw DashShieldException(
        'IntegrityChecksService Error: Failed to execute action for check $check: ${e.toString()}',
      );
    }
  }
}
