import 'package:flutter/material.dart';
import 'package:v_connect_web/constants/style.dart';

class RevenueInfo extends StatelessWidget {
  final title;
  final amount;

  const RevenueInfo({Key? key, this.title, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: "$title \n\n",
                style: TextStyle(
                    color: Colors.green.shade900,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: "$amount",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ])),
    );
  }
}
