import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:test_flutter/util/color.dart';

///登录input

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String>? onChange;
  final ValueChanged<bool>? focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType? keboardType;

  const LoginInput(
      {Key? key,
      required this.title,
      required this.hint,
      this.onChange,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keboardType})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //是否获取光标
    _focusNode.addListener(() {
      print("是否获取光标： ${_focusNode.hasPrimaryFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _input(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
          child: const Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  _input() {
    return Expanded(
      child: Listener(
        onPointerDown: (e) => FocusScope.of(context).requestFocus(_focusNode),
        child: TextField(
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          focusNode: _focusNode,
          onChanged: widget.onChange,
          obscureText: widget.obscureText,
          keyboardType: widget.keboardType,
          autofocus: !widget.obscureText,
          cursorColor: primary,
          style: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),

          //输入框样式
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
        ),
      ),
    );
  }
}
