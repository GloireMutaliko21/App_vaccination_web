import 'package:flutter/material.dart';
import 'package:v_connect_web/helpers/responsiveness.dart';
import 'package:v_connect_web/widgets/large_screen.dart';
import 'package:v_connect_web/widgets/side_menu.dart';
import 'package:v_connect_web/widgets/small_screen.dart';
import 'package:v_connect_web/widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
        mediumScreen: LargeScreen(),
      ),
    );
  }
}
