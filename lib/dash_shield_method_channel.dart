import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dash_shield_platform_interface.dart';

/// An implementation of [DashShieldPlatform] that uses method channels.
class MethodChannelDashShield extends DashShieldPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dash_shield');

  @override
  Future<void> preventScreenshotsGlobally() async {
    try {
      await methodChannel.invokeMethod('preventScreenshotsGlobally');
    } on PlatformException catch (e) {
      throw 'Failed to globally prevent screenshots: ${e.message}';
    }
  }

  @override
  Future<void> preventScreenshotsAndRecording() async {
    try {
      await methodChannel.invokeMethod('preventScreenshots');
    } on PlatformException catch (e) {
      throw 'Failed to prevent screenshots: ${e.message}';
    }
  }
}
