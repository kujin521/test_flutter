import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/widget/appbar.dart';
import 'package:test_flutter/widget/lgoin_effect.dart';
import 'package:test_flutter/widget/login_input.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool protect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        print('right button click');
      }),
      body: Container(
          child: ListView(
        //只适用键盘弹起，防止遮挡
        children: [
          LoginEffect(protect: protect),
          LoginInput(
            title: "用户名",
            hint: "请输入用户名",
            onChange: (text) {
              print(text);
            },
          ),
          LoginInput(
            title: "密码",
            hint: "请输入密码",
            lineStretch: true,
            obscureText: true,
            onChange: (text) {
              print(text);
            },
            focusChanged: (focus) => {
              setState(() {
                protect = focus;
              })
            },
          ),
        ],
      )),
    );
  }
}
