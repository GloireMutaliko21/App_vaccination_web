import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_connect_web/constants/controllers.dart';
import 'package:v_connect_web/routing/router.dart';
import 'package:v_connect_web/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: OverViewPageRoute,
    );
