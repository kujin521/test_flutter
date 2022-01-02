import 'package:test_flutter/http/core/hi_net_adapter.dart';
import 'package:test_flutter/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> sned<T>(BaseRequest request) {
    return Future<HiNetResponse<T>>.delayed(const Duration(seconds: 2), () {
      return HiNetResponse(
          data: {"code": 200, "message": "自定义数据返回成功"} as T, statusCode: 403);
    });
  }
}
