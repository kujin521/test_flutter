import 'package:test_flutter/http/core/hi_error.dart';
import 'package:test_flutter/http/core/hi_net_adapter.dart';
import 'package:test_flutter/http/core/mock_adapter.dart';
import 'package:test_flutter/http/request/base_request.dart';

class HiNet {
  //单例模式
  static final HiNet _singleton = HiNet._internal();

  factory HiNet() {
    return _singleton;
  }

  HiNet._internal();

  ///
  Future fire(BaseRequest request) async {
    HiNetResponse response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.code as HiNetResponse;
      print(e.message);
    }
    if (response == null) {
      printLog(error);
    }
    var result = response.data;
    printLog(result.toString());

    var status = response.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status!, result.toString(), data: result);
    }
  }

  ///
  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url :${request.url()}');
    print('method: ${request.httpMethod()}');
    request.addHeader("token", "123");
    print('header: ${request.header}');
    HiNetAdapter adapter = MockAdapter();
    return adapter.sned(request);
  }

  void printLog(String message) {
    print(message);
  }
}
