import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:swiftvote/responses/BaseResponse.dart';

abstract class DeviceInfoService {

  static Future<BaseResponse> getUniqueDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    var _result;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        _result = BaseResponse(success: true, value: build.androidId);
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        _result = BaseResponse(success: true, value: iosDeviceInfo.identifierForVendor);
      }
    } catch(e) {
      print(e);
      _result = BaseResponse(success: false, value: e.message);
    }

    return _result;
  }
}