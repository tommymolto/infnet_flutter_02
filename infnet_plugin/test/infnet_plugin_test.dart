import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infnet_plugin/infnet_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('infnet_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await InfnetPlugin.platformVersion, '42');
  });
}
