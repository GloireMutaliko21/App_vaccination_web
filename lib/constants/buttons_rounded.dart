import 'package:flutter/material.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class ButtonsRounded extends StatelessWidget {
  final text;
  final onPressed;

  const ButtonsRounded({Key? key, this.text, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          decoration: BoxDecoration(
            color: light,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: RaisedButton(
            onPressed: onPressed,
            child: CustomText(
              text: text,
              color: active.withOpacity(.7),
              weight: FontWeight.bold,
              size: 16,
            ),
          )),
    );
  }
}
