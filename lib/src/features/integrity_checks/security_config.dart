import '../../core/utils/enums.dart';
import '../../core/utils/toaster_helper.dart';

/// The configuration object to initialize security checks for the plugin.
class SecurityConfig {
  /// SHA256 hashes for Android app signing certificates (required for Android).
  final List<String>? androidSigningCertHashes;

  /// Package name for Android (required for Android).
  final String? androidPackageName;

  /// iOS Bundle IDs (required for iOS).
  final List<String>? iosBundleIds;

  /// Team ID for iOS (required for iOS).
  final String? iosTeamId;

  /// Supported stores (optional).
  final List<String>? supportedStores;

  /// Watcher email (required).
  final String watcherEmail;

  /// Indicates if the app is in production mode - (default is true)
  final bool isProduction;

  /// Selected checks to enable (optional).
  /// If `null`, all checks will be enabled by default.
  final List<SecOnControlsToApply>? checksToEnable;

  /// The general action (method) to take when an issue is detected.
  final void Function(String)? generalAction;

  /// A map of specific actions (methods) to take for each specific check.
  /// If `null`, the general action will be applied for all checks.
  final Map<SecOnControlsToApply, void Function(String)>? specificActions;

  /// Boolean indicate whether you want to enable this on Android or not
  final bool enableOnAndroid;

  /// Boolean indicate whether you want to enable this on IOS or not
  final bool enableOniOS;

  /// Constructor for setting security config options.
  /// Validates the provided arguments using asserts to ensure required fields are provided based on the platform(s) selected.
  SecurityConfig({
    this.androidSigningCertHashes,
    this.androidPackageName,
    this.iosBundleIds,
    this.iosTeamId,
    this.supportedStores,
    required this.watcherEmail,
    this.isProduction = true,
    this.checksToEnable,
    this.generalAction,
    this.specificActions,
    required this.enableOnAndroid,
    required this.enableOniOS,
  }) {
    // Assert validations based on platform requirements
    assert(
      enableOnAndroid
          ? androidPackageName != null &&
              androidSigningCertHashes != null &&
              androidSigningCertHashes!.isNotEmpty
          : true,
      'Android package name and signing certificate hashes are required when Android checks are enabled.',
    );

    assert(
      enableOniOS
          ? iosTeamId != null &&
              iosBundleIds != null &&
              iosBundleIds!.isNotEmpty
          : true,
      'iOS team ID and bundle IDs are required when iOS checks are enabled.',
    );

    assert(
      enableOnAndroid || enableOniOS,
      'At least one platform (Android or iOS) must be enabled for checks.',
    );
    assert(watcherEmail.isNotEmpty, "Can't Leave watcher email empty");
  }

  /// Returns the list of enabled checks.
  /// If `checksToEnable` is null, all checks are enabled by default.
  List<SecOnControlsToApply> getEnabledChecks() {
    return checksToEnable ?? SecOnControlsToApply.values;
  }

  /// Returns the action to take for a specific check.
  /// If no specific action is provided, the general action is applied.
  void Function(String issue) getActionForCheck(SecOnControlsToApply check) {
    return specificActions?[check] ??
        (generalAction ?? (issue) => AppToast.showToastWithoutContext(issue));
  }
}
