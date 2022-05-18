import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/controllers/menu_controller.dart';
import 'package:v_connect_web/controllers/navigation_controller.dart';
import 'package:v_connect_web/pages/authentification/authentification.dart';

void main() {
  Get.put(MenuController());
  Get.put(NavigationController());
  Get.put(DataSource());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final String title = 'Rapports';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "vConnect",
      theme: ThemeData(
          scaffoldBackgroundColor: active2, //Colors.grey.shade300
          textTheme: GoogleFonts.mulishTextTheme(
            Theme.of(context).textTheme,
          ).apply(bodyColor: Colors.black),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
          }),
          primaryColor: Colors.blue),
      home: AuthentificationPage(),
    );
  }
}
