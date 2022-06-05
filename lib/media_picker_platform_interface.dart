import 'package:media_picker/utils.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'media_picker_method_channel.dart';

abstract class MediaPickerPlatform extends PlatformInterface {
  /// Constructs a MediaPickerPlatform.
  MediaPickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static MediaPickerPlatform _instance = MethodChannelMediaPicker();

  /// The default instance of [MediaPickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelMediaPicker].
  static MediaPickerPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MediaPickerPlatform] when
  /// they register themselves.
  static set instance(MediaPickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<MediaPickerResult> openPictureSelector(MediaType mediaType, int? maxSelect, SelectMode? selectMode) {
    throw UnimplementedError('openPictureSelector() has not been implemented.');
  }
}
