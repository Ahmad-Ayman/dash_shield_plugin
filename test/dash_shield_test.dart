import 'package:dash_shield/dash_shield.dart';
import 'package:dash_shield/dash_shield_method_channel.dart';
import 'package:dash_shield/dash_shield_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDashShieldPlatform
    with MockPlatformInterfaceMixin
    implements DashShieldPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> preventScreenshotsAndRecording() {
    // TODO: implement preventScreenshotsAndRecording
    throw UnimplementedError();
  }

  @override
  Future<void> preventScreenshotsGlobally() {
    // TODO: implement preventScreenshotsGlobally
    throw UnimplementedError();
  }
}

void main() {
  final DashShieldPlatform initialPlatform = DashShieldPlatform.instance;

  test('$MethodChannelDashShield is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDashShield>());
  });

  test('getPlatformVersion', () async {
    DashShield dashShieldPlugin = DashShield();
    MockDashShieldPlatform fakePlatform = MockDashShieldPlatform();
    DashShieldPlatform.instance = fakePlatform;

    // expect(await dashShieldPlugin.getPlatformVersion(), '42');
  });
}
