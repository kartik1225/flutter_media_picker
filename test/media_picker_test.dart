import 'package:flutter_test/flutter_test.dart';
import 'package:media_picker/media_picker.dart';
import 'package:media_picker/media_picker_platform_interface.dart';
import 'package:media_picker/media_picker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMediaPickerPlatform 
    with MockPlatformInterfaceMixin
    implements MediaPickerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MediaPickerPlatform initialPlatform = MediaPickerPlatform.instance;

  test('$MethodChannelMediaPicker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMediaPicker>());
  });

  test('getPlatformVersion', () async {
    MediaPicker mediaPickerPlugin = MediaPicker();
    MockMediaPickerPlatform fakePlatform = MockMediaPickerPlatform();
    MediaPickerPlatform.instance = fakePlatform;
  
    expect(await mediaPickerPlugin.getPlatformVersion(), '42');
  });
}
