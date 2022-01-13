import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/http/core/hi_error.dart';
import 'package:test_flutter/http/dao/login_dao.dart';
import 'package:test_flutter/util/toast.dart';
import 'package:test_flutter/widget/appbar.dart';
import 'package:test_flutter/widget/lgoin_effect.dart';
import 'package:test_flutter/widget/login_button.dart';
import 'package:test_flutter/widget/login_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //是否选择密码框
  bool protect = false;
  //是否可以登录
  bool loginEnable = false;
  //登录信息
  String? userName;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {}),
      body: Container(
          child: ListView(
        //只适用键盘弹起，防止遮挡
        children: [
          LoginEffect(protect: protect),
          LoginInput(
            title: "用户名",
            hint: "请输入用户名",
            onChange: (text) {
              userName = text;
              checkInput();
            },
          ),
          LoginInput(
            title: "密码",
            hint: "请输入密码",
            lineStretch: true,
            obscureText: true,
            onChange: (text) {
              password = text;
              checkInput();
            },
            focusChanged: (focus) => {
              setState(() {
                protect = focus;
              })
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: LoginButton(
              '登录',
              enable: loginEnable,
              onPressed: send,
            ),
          )
        ],
      )),
    );
  }

  //检查输入框
  void checkInput() {
    bool enable = false;
    if (userName!.isNotEmpty && password!.isNotEmpty) {
      enable = true;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result = await LoginDao.login(userName!, password!);
      showToast(result['userId'].toString());
      if (result['code'] == 0) {
        showToast('登录成功');
      }
    } on NeedAuth catch (e) {
      showWarnToast("错误码：${e.code} 错误信息：${e.message} 错误信息：${e.data}");
    } on HiNetError catch (e) {
      if (e.code == 404) {
        showWarnToast("错误码：${e.code} 错误信息：网络请求不到！");
      } else {
        showWarnToast("错误码：${e.code} 错误信息：${e.message} 错误信息：${e.data}");
      }
    }
  }
}
