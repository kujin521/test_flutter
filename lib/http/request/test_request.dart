import 'package:test_flutter/http/request/base_request.dart';

class TestRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return '/weihu/online';
  }
}
