import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dash_shield_method_channel.dart';

/// The interface that implementations of DashShield must implement.
///
/// This allows DashShield to support multiple platforms (e.g., Android, iOS) using the same API.
abstract class DashShieldPlatform extends PlatformInterface {
  /// Constructs a DashShieldPlatform.
  DashShieldPlatform() : super(token: _token);

  static final Object _token = Object();

  static DashShieldPlatform _instance = MethodChannelDashShield();

  /// The default instance of [DashShieldPlatform] to use.
  /// Defaults to [MethodChannelDashShield].
  static DashShieldPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DashShieldPlatform] when they register themselves.
  static set instance(DashShieldPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Prevents screenshots and screen recording globally for the entire app.
  ///
  /// This method must be implemented by platform-specific code (e.g., Android and iOS).
  Future<void> preventScreenshotsGlobally() {
    throw UnimplementedError(
        'preventScreenshotsGlobally() has not been implemented.');
  }

  /// Prevents screenshots and screen recording on a specific screen.
  ///
  /// This method must be implemented by platform-specific code (e.g., Android and iOS).
  Future<void> preventScreenshotsAndRecording() {
    throw UnimplementedError(
        'preventScreenshotsAndRecording() has not been implemented.');
  }
}
