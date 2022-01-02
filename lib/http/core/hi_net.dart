import 'package:test_flutter/http/core/adapter/dio_adapter.dart';
import 'package:test_flutter/http/core/adapter/hi_net_adapter.dart';
import 'package:test_flutter/http/core/hi_error.dart';
import 'package:test_flutter/http/request/base_request.dart';

class HiNet {
  //单例模式
  static final HiNet _singleton = HiNet._internal();

  factory HiNet() {
    return _singleton;
  }

  HiNet._internal();

  ///发送请求处理
  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      print(e.data);
      response = e.data;
      print(e.message);
    } catch (e) {
      error = e;
      print(e);
    }

    if (response == null) {
      print(error);
    }
    var result = response?.data;
    printLog(request);
    print('结果：$result');
    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status ?? -1, result.toString(), data: result);
    }
  }

  ///发送数据
  Future<dynamic> send<T>(BaseRequest request) async {
    request.addHeader("token", "123");
    //HiNetAdapter adapter = MockAdapter();
    HiNetAdapter adapter = DioAdapter();
    return adapter.sned(request);
  }

  ///打印请求日志
  void printLog(BaseRequest request) {
    print('url :${request.url()}');
    print('method: ${request.httpMethod()}');
    print('header: ${request.header}');
  }
}
