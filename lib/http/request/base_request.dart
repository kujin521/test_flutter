enum HttpMethod { GET, POST, DELETE }

//基础请求
abstract class BaseRequest {
  //curl -X POST -H  "Accept:*/*" -H  "Request-Origion:Knife4j" -H"
  //""Content-Type:application/json" -d "{\"password\":\"zlz123456\",\"username\":\"zhaolizhi\"}"
  //"http://192.168.4.4:8080/user/login"
  var pathParams;
  var useHttps = true;

  String authority() {
    return "plm.lunan.com.cn";
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
