import 'package:test_flutter/http/dao/login_dao.dart';

enum HttpMethod { GET, POST, DELETE }

//基础请求
abstract class BaseRequest {
  var pathParams;
  var useHttps = false;

  String authority() {
    return "jsonplaceholder.typicode.com";
  }

  HttpMethod httpMethod();
  String path();
  String url() {
    Uri uri;
    var pathStr = path();

    ///拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    /// http和https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    if (needLogin()) {
      add(LoginDao.BOARDING_PASS, LoginDao.getBordingPass());
    }

    return uri.toString();
  }

  //是否需要登录
  bool needLogin();

  Map<String, String> params = Map();

  //添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  //
  Map<String, dynamic> header = Map();

  ///添加hender
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
