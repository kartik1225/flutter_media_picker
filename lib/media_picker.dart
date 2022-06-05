
import 'package:media_picker/utils.dart';

import 'media_picker_platform_interface.dart';

class MediaPicker {
  Future<String?> getPlatformVersion() {
    return MediaPickerPlatform.instance.getPlatformVersion();
  }

  Future<MediaPickerResult> open({
    required MediaType mediaType,
    int? maxSelect,
    SelectMode selectMode = SelectMode.multiple,
  }) async {

    if(selectMode == SelectMode.single) {
      maxSelect = 1;
    }

    return MediaPickerPlatform.instance.openPictureSelector(
      mediaType,
      maxSelect,
      selectMode,
    );
  }

}
