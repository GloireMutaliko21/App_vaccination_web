import 'package:flutter/material.dart';
import 'package:v_connect_web/widgets/large_screen_admin.dart';
import 'package:v_connect_web/widgets/top_nav_admin.dart';

class SiteLayoutAdmin extends StatefulWidget {
  @override
  _SiteLayoutAdminState createState() => _SiteLayoutAdminState();
}

class _SiteLayoutAdminState extends State<SiteLayoutAdmin> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBarAdmin(context, scaffoldKey),
      // drawer: Drawer(
      //   child: SideMenu(),
      // ),
      body: LargeScreenAdmin(),
    );
  }
}
