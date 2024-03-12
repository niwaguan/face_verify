package cn.stormyang.flutter.face_verify.face_verify;

import android.app.Activity;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.alipay.mobile.android.verify.sdk.BizCode;
import com.alipay.mobile.android.verify.sdk.MPVerifyService;
import com.alipay.mobile.android.verify.sdk.ServiceFactory;
import com.alipay.mobile.android.verify.sdk.interfaces.IService;

import java.util.HashMap;
import java.util.Map;

import cn.stormyang.flutter.face_verify.face_verify.FaceVerifyGen.FlutterError;
import cn.stormyang.flutter.face_verify.face_verify.FaceVerifyGen.FlutterFaceVerifyHostApi;
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding;

public class FaceVerifyApi implements FlutterFaceVerifyHostApi {
    private static final int REQUEST_PERMISSION_READ_PHONE_STATE = 0x05;
    private final FlutterPluginBinding binding;
    private IService mService;
    @Nullable
    private Activity activity;

    @Nullable
    public Activity getActivity() {
        return activity;
    }

    public void setActivity(@Nullable Activity activity) {
        this.activity = activity;
    }

    public FaceVerifyApi(FlutterPluginBinding binding) {
        this.binding = binding;
    }

    @Override
    public void initService(@NonNull FaceVerifyGen.VoidResult result) {
        try {
            MPVerifyService.setup(binding.getApplicationContext());
            MPVerifyService.markUserAgreedPrivacyPolicy(binding.getApplicationContext());
            mService = ServiceFactory.create(getActivity()).build();
            result.success();
        } catch (Exception e) {
            result.error(new FlutterError("-1", e.getMessage(), null));
        }

    }

    @Override
    public void verify(@NonNull String certifyId, @NonNull FaceVerifyGen.Result<Map<String, Object>> result) {
        try {
            new PermissionRequest(activity, android.Manifest.permission.READ_PHONE_STATE, REQUEST_PERMISSION_READ_PHONE_STATE, new PermissionRequest.OnPermissionResultListener() {
                @Override
                public void onPermissionGranted() {
                    Map<String, Object> requestInfo = new HashMap<String, Object>() {{
                        put("bizCode", BizCode.Value.FACE_APP);
                        put("certifyId", certifyId);
                    }};
                    mService.startService(requestInfo, true, response -> {
                        Number code = parseNumber(response.get("resultStatus"));
                        if (code != null) {
                            result.success(new HashMap<String, Object>() {{
                                put("code", code);
                            }});
                        } else {
                            result.error(new FlutterError("-1", "无法获取认证结果", null));
                        }
                    });
                }

                @Override
                public void onPermissionDenied() {
                    result.error(new FlutterError("-1", "暂无权限", null));
                }
            }).requestPermission();
        } catch (Exception e) {
            result.error(new FlutterError("-1", e.getMessage(), null));
        }
    }

    /// 将Object转换为Number
    Number parseNumber(Object obj) {
        if (obj == null) {
            return -1;
        }
        if (obj instanceof Number) {
            return (Number) obj;
        }
        try {
            return Integer.parseInt(obj.toString());
        } catch (NumberFormatException e) {
            return  -1;
        }
    }
}
