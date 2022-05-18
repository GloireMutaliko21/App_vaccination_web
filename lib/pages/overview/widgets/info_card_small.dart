import 'package:flutter/material.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class InfoCardSmall extends StatelessWidget {
  final title;
  final value;
  final isActive;
  final onTap;
  const InfoCardSmall(
      {Key? key, this.title, this.value, this.isActive = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: isActive ? active : lightGrey, width: .5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: title,
                size: 24,
                color: isActive ? active : lightGrey,
                weight: FontWeight.w300),
            CustomText(
                text: value,
                size: 24,
                color: isActive ? active : lightGrey,
                weight: FontWeight.bold),
          ],
        ),
      ),
    ));
  }
}
