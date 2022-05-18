import 'package:flutter/material.dart';
import 'package:v_connect_web/helpers/local_navigator.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16), child: localNavigator());
  }
}
