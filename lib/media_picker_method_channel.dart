import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:media_picker/utils.dart';

import 'media_picker_platform_interface.dart';

/// An implementation of [MediaPickerPlatform] that uses method channels.
class MethodChannelMediaPicker extends MediaPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('media_picker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<MediaPickerResult> openPictureSelector(
      MediaType mediaType,
      int? maxSelect,
      SelectMode? selectMode,
      ) async {

    final result =
    await methodChannel.invokeMethod<Map<dynamic, dynamic>>('openPictureSelector', {
      'mediaType': mediaType.index,
      if (maxSelect != null) 'maxSelect': maxSelect,
      if (selectMode != null) 'selectMode': selectMode.pos,
    });

    final paths = result?['paths'];

    List<String> pathsList = [];

    if (paths != null) {
      pathsList = paths.cast<String>();
    }

    return MediaPickerResult(selectedPaths: pathsList);
  }

}
