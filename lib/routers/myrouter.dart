import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/models/video_model.dart';
import 'package:test_flutter/page/home_page.dart';
import 'package:test_flutter/page/video_detail_page.dart';

class BiliRouteDelegate extends RouterDelegate<BilRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BilRoutePath> {
  /// 为 Navigator设置一个key 必要时侯通过NavigtorKey.currentState来获取NavigatorState对象
  final GlobalKey<NavigatorState> navigatorKey;
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<MaterialPage> pages = [];

  VideoModel? videoModel;
  BilRoutePath? path;

  @override
  Widget build(BuildContext context) {
    //构建路由页面
    pages = [
      pageWrap(HomePage(
        onJumpToDetail: (VideoModel videoModel) {
          this.videoModel = videoModel;

          /// 调用所有注册的监听器。
          /// 每当对象更改时调用此方法，以通知任何客户端该对象可能已更改。
          /// 在此迭代期间添加的侦听器将不会被访问。 在此迭代期间移除的侦听器在移除后将不会被访问。
          notifyListeners();
        },
      )),
      if (videoModel != null) pageWrap(VideoDetailPage(videoModel: videoModel!))
    ];

    ///创建一个小部件，该小部件维护基于堆栈的子小部件历史记录。
    return Navigator(
      key: navigatorKey,

      /// 用于填充历史记录的页面列表。
      pages: pages,
      onPopPage: (route, result) {
        /// 控制是否可以返回
        /// 已请求弹出此路由。 如果路由可以在内部处理它（例如，因为它有自己的内部状态堆栈），则返回 false，否则返回 true（通过返回调用super.didPop的值）。 返回 false 将阻止NavigatorState.pop的默认行为。
        // 当此函数返回 true 时，导航器会从历史记录中删除此路由，但尚未调用dispose 。 相反，调用NavigatorState.finalizeRoute是路由的责任，这反过来又会调用路由上的dispose 。 这个序列让路由在被弹出之后但在被释放之前执行退出动画（或其他一些视觉效果）。
        // 这个方法应该调用didComplete来解决popped的未来（这就是默认实现所做的一切）； 在这样做之前，路线不应等待其退出动画完成。
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BilRoutePath path) async {
    this.path = path;
  }
}

/// 可缺省 主要与web 持有RouterInformationProvider 提供的RouteInformation 可以将其解析为我们定义的数据类
class BiliRouteInfomationParser extends RouteInformationParser<BilRoutePath> {
  @override
  Future<BilRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    print('uri: ${uri.path}');
    if (uri.pathSegments.isEmpty) {
      return BilRoutePath.home();
    } else {
      return BilRoutePath.detail();
    }
  }
}

/// 定义路由数据 path
class BilRoutePath {
  String location = "/";

  BilRoutePath.home() : location = "/";
  BilRoutePath.detail() : location = "/detail";
  BilRoutePath.baserow() : location = "/baserow";
}

/// 创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}
