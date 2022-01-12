// ignore: file_names
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/db/hi_cache.dart';
import 'package:test_flutter/http/dao/login_dao.dart';
import 'package:test_flutter/http/request/notice_request.dart';
import 'package:test_flutter/http/request/todos_request.dart';
import 'package:test_flutter/models/owner.dart';
import 'package:test_flutter/page/registration_page.dart';
import 'package:test_flutter/util/color.dart';

import 'http/core/hi_error.dart';
import 'http/core/hi_net.dart';
import 'http/request/test_request.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: Registration(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    HiCache.preInit();
  }

  _incrementCounter() async {
    print("点击事件");
    //test_json();
    //await test_http();
    //testLogin();
    //await test_todos();
    await test_notice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void test_json() {
    const jsonString =
        "{\"code\":200,\"message\":\"OK\",\"data\":\"当前在线人数：1\"}";

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    print('name ${jsonMap['data']}');
  }

  void test1() {
    var ownerMap = {"name": "账号三", "face": "htttpsss", "fans": 110};
    Owner owner = Owner.fromJson(ownerMap);
    print(owner.name);
    print(owner.face);
    print(owner.fans);
  }

  void test2() {
    HiCache.getInstance().setString("aa", "1234");
    var value = HiCache.getInstance().get("aa");
    print('value: $value');
  }

  void testLogin() async {
    try {
      await LoginDao.regisration(
          'testusername', 'testpassword', 'testimoocId', 'testorderId');
      var result2 = await LoginDao.login('testusername', 'testpassword');
      print(result2);
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  Future<void> test_http() async {
    TestRequest request = TestRequest();
    request.add("name", "传递的参数");
    try {
      var result = await HiNet().fire(request);
      print(result);
    } on NeedAuth catch (e) {
      print(e);
    } on NeedLogin catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  Future<void> test_notice() async {
    NoticeRequest request = NoticeRequest();
    try {
      var result = await HiNet().fire(request);
      print(result);
    } on NeedAuth catch (e) {
      print(e);
    } on NeedLogin catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  Future<void> test_todos() async {
    TodosRequest request = TodosRequest();
    try {
      var result = await HiNet().fire(request);
      print(result);
    } on NeedAuth catch (e) {
      print(e);
    } on NeedLogin catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }
}
