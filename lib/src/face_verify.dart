import 'face_verify.g.dart';
import 'face_verify_result.dart';

class FaceVerify {
  static final FlutterFaceVerifyHostApi _verifyApi = FlutterFaceVerifyHostApi();

  /// 初始化SDK。建议在 App 运行初期尽早调用初始化代码，如隐私政策同意后的最早期。
  static Future<void> init() {
    return _verifyApi.initService();
  }

  /// 使用验证id进行验证
  static Future<FaceVerifyResult> verify(String certifyId) async {
    final response = await _verifyApi.verify(certifyId: certifyId);
    final result = FaceVerifyResult.from(response);
    return result;
  }
}
