package cn.stormyang.flutter.face_verify.face_verify;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.alipay.mobile.android.verify.sdk.MPVerifyService;

import cn.stormyang.flutter.face_verify.face_verify.FaceVerifyGen.FlutterFaceVerifyHostApi;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

/** FaceVerifyPlugin */
public class FaceVerifyPlugin implements FlutterPlugin, ActivityAware {

  @Nullable
  private FaceVerifyApi faceVerifyApi;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    faceVerifyApi = new FaceVerifyApi(binding);
    FlutterFaceVerifyHostApi.setUp(binding.getBinaryMessenger(), faceVerifyApi);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    faceVerifyApi = null;
    FlutterFaceVerifyHostApi.setUp(binding.getBinaryMessenger(), null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    if (faceVerifyApi != null) {
      faceVerifyApi.setActivity(binding.getActivity());
    }
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    if (faceVerifyApi != null) {
      faceVerifyApi.setActivity(null);
    }
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    if (faceVerifyApi != null) {
      faceVerifyApi.setActivity(binding.getActivity());
    }
  }

  @Override
  public void onDetachedFromActivity() {
    if (faceVerifyApi != null) {
      faceVerifyApi.setActivity(null);
    }
  }
}
