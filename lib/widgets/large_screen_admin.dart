import 'package:flutter/material.dart';
import 'package:v_connect_web/pages/overview/Admin/dashboard.dart';

class LargeScreenAdmin extends StatefulWidget {
  const LargeScreenAdmin({Key? key}) : super(key: key);

  @override
  _LargeScreenAdminState createState() => _LargeScreenAdminState();
}

class _LargeScreenAdminState extends State<LargeScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          color: Colors.blue.shade200,
          // child: SideMenu(),
        )),
        Expanded(
            flex: 5,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DashboardAdmin()))
      ],
    );
  }
}
