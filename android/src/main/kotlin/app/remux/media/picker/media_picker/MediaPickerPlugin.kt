package app.remux.media.picker.media_picker

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.net.Uri
import android.util.Log
import androidx.annotation.NonNull
import app.remux.media.picker.media_picker.GlideEngine.Companion.createGlideEngine
import com.luck.picture.lib.basic.PictureSelector
import com.luck.picture.lib.config.SelectModeConfig
import com.luck.picture.lib.entity.LocalMedia
import com.luck.picture.lib.interfaces.OnResultCallbackListener
import com.luck.picture.lib.style.BottomNavBarStyle
import com.luck.picture.lib.style.PictureSelectorStyle
import com.luck.picture.lib.style.SelectMainStyle
import com.luck.picture.lib.style.TitleBarStyle

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MediaPickerPlugin */
class MediaPickerPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity

  companion object {
    const val TAG = "MediaPickerPlugin"
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "media_picker")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "openPictureSelector") {
      openImageSelector(result, call)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  private fun openImageSelector(result: Result, call: MethodCall) {
    val mimeType = call.argument<Int>("mediaType")
    var maxSelect = call.argument<Int>("maxSelect")
    var selectMode = call.argument<Int>("selectMode")


    assert(mimeType != null)
    maxSelect = maxSelect ?: 10
    selectMode = selectMode ?: SelectModeConfig.MULTIPLE

    val style = PictureSelectorStyle()

    val secondaryColor = 0xFFFFC107.toInt()
    val surfaceColor = 0xFF000000.toInt()

    TitleBarStyle().run {
      titleBackgroundColor = secondaryColor
      style.titleBarStyle = this
    }

    SelectMainStyle().run {
      mainListBackgroundColor = surfaceColor
      style.selectMainStyle = this
    }

    BottomNavBarStyle().run {
      bottomNarBarBackgroundColor = Color.WHITE
      bottomPreviewNarBarBackgroundColor = Color.WHITE
      bottomPreviewNormalTextColor = Color.WHITE
      bottomPreviewSelectTextColor = Color.WHITE
      bottomEditorTextColor = Color.WHITE
      bottomOriginalTextColor = Color.WHITE
      bottomSelectNumTextColor = Color.WHITE
      style.bottomBarStyle = this
    }

    PictureSelector.create(activity)
      .openGallery(mimeType!!)
      .setSelectionMode(selectMode)
//                .setSelectorUIStyle(style)
      .setImageEngine(createGlideEngine())
      .setMaxSelectNum(maxSelect)
      .forResult(object : OnResultCallbackListener<LocalMedia?> {
        override fun onResult(mResult: ArrayList<LocalMedia?>?) {
          val map = HashMap<String, Any>()
          val paths = ArrayList<String>()
          for (media in mResult!!) {
            // convert uri to file
            media?.path?.let {
              val abs = FileUtils.getFileFromUri(context, Uri.parse(it))
              paths.add(abs.absolutePath)
            } ?: run {
              Log.e(TAG, "onResult: media?.path = null")
            }
          }

          map["paths"] = paths
          result.success(map)
        }

        override fun onCancel() {
          result.success(null)
        }
      })
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

  override fun onDetachedFromActivity() {}


}
