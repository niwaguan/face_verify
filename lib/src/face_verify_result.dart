import 'dart:io';

/// 认证结果
/// code码参考文档：
/// Android https://opendocs.alipay.com/open/02zlo7?pathHash=3c880197#调用%20startService%20接口请求认证并传入回调
/// iOS https://opendocs.alipay.com/open/043r4u?pathHash=bd18ad30#开始刷脸服务
class FaceVerifyResult {
  final int code;

  bool get isSuccessful =>
      (Platform.isIOS && code == 1000) || (Platform.isAndroid && code == 9000);

  FaceVerifyResult({required this.code});

  factory FaceVerifyResult.from(Map<Object?, Object?> args) {
    try {
      final code = args["code"] as int?;
      return FaceVerifyResult(code: code ?? -1);
    } catch (e) {
      return FaceVerifyResult(code: -1);
    }
  }
}
