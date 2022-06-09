# flutter_media_picker

**Before you read further: This flutter plugin is only supported for android as of now**

Opens native picture selector activity and returns selected file's path
You can choose Image, Videos or Both!

<p float="center">
  <img src="https://raw.githubusercontent.com/kartik1225/flutter_media_picker/master/assets/1.jpeg" width="200" />
  <img src="https://raw.githubusercontent.com/kartik1225/flutter_media_picker/master/assets/2.jpeg" width="200" /> 
</p>

## Prerequisites
Add This to `android/src/main/AndroidManifest.xml` file
```
<application>
    ...
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    ...
</application>
```

## Install
Add this in your `pubspec.yaml` file

```
    android_picture_selector:    
        git:
            url: git://github.com/kartik1225/flutter_media_picker.git
            ref: master
```

## API

```
import 'package:android_picture_selector/utils.dart';
import 'package:android_picture_selector/android_picture_selector.dart';

Future<String?> selectMedia() async {
    final result = MediaPicker()
                    .open(mediaType: MediaType.video);
    return result;
}
```
#### Misc
If you find bug or want to add new feture then feel free to creare and issue or PR.

#### Credit
* Android lib [PictureSelector](https://github.com/LuckSiege/PictureSelector)
