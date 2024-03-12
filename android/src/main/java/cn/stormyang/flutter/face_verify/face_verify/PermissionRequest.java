package cn.stormyang.flutter.face_verify.face_verify;

import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener;

public class PermissionRequest implements RequestPermissionsResultListener {
    private final Activity activity;
    private final String permission;
    private final int requestCode;
    private final OnPermissionResultListener listener;

    public PermissionRequest(Activity activity, String permission, int requestCode, OnPermissionResultListener listener) {
        this.activity = activity;
        this.permission = permission;
        this.requestCode = requestCode;
        this.listener = listener;
    }

    public void requestPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            if (ContextCompat.checkSelfPermission(activity, permission)
                    != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(activity,
                        new String[]{permission},
                        requestCode);
            } else {
                listener.onPermissionGranted();
            }
        } else {
            listener.onPermissionGranted();
        }

    }

    public boolean onRequestPermissionsResult(int requestCode, @NonNull String[] permissions,
                                              @NonNull int[] grantResults) {
        if (requestCode == this.requestCode) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                listener.onPermissionGranted();
            } else {
                listener.onPermissionDenied();
            }
            return true;
        }
        return false;
    }

    public interface OnPermissionResultListener {
        void onPermissionGranted();
        void onPermissionDenied();
    }
}
