import 'package:test_flutter/http/request/base_request.dart';

class TodosRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return '/users/1/todos';
  }
}
