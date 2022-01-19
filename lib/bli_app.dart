import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/routers/myrouter.dart';

class BilApp extends StatefulWidget {
  const BilApp({Key? key}) : super(key: key);

  @override
  _BilAppState createState() => _BilAppState();
}

class _BilAppState extends State<BilApp> {
  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  final BiliRouteInfomationParser _biliRouteInfomationParser =
      BiliRouteInfomationParser();

  @override
  Widget build(BuildContext context) {
    var widget = Router(
      routerDelegate: _routeDelegate,
      routeInformationParser: _biliRouteInfomationParser,
      routeInformationProvider: PlatformRouteInformationProvider(
          initialRouteInformation: const RouteInformation(location: "/")),
    );
    return MaterialApp(
      home: widget,
    );
  }
}
