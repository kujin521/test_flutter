import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/util/color.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;
  const LoginButton(this.title,
      {Key? key, this.enable = true, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //创建一个小部件，将其子部件的大小调整为总可用空间的一小部分。
    return FractionallySizedBox(
      widthFactor: 1,
      //创建材质按钮。
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enable ? onPressed : null,
        disabledColor: primary[50],
        color: primary,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
