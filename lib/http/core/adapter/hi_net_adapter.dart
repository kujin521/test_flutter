import 'dart:convert';

import 'package:test_flutter/http/request/base_request.dart';

///网络请求抽象类型
abstract class HiNetAdapter {
  Future<HiNetResponse<T>> sned<T>(BaseRequest request);
}

///统一网络格式返回类型
class HiNetResponse<T> {
  T? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  HiNetResponse(
      {this.data,
      this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
