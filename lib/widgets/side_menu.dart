import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_connect_web/constants/controllers.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/helpers/responsiveness.dart';
import 'package:v_connect_web/pages/authentification/authentification.dart';
import 'package:v_connect_web/routing/routes.dart';
import 'package:v_connect_web/widgets/custom_text.dart';
import 'package:v_connect_web/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _widh = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.blueGrey.shade900,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "vConnect",
                        size: 20,
                        color: Colors.red,
                        weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: _widh / 48),
                  ],
                ),
              ],
            ),
          SizedBox(
            height: 30,
          ),
          Divider(
            color: Colors.white.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((itemName) => SideMenuItem(
                      itemName: itemName == AuthentificationPageRoute
                          ? "Log Out"
                          : itemName,
                      onTap: () {
                        if (itemName == AuthentificationPageRoute) {
                          Get.offAll(() => AuthentificationPage());
                        }

                        if (!menuController.isActive(itemName)) {
                          menuController.changeActiveItemTo(itemName);
                          if (ResponsiveWidget.isSmallScreen(context))
                            Get.back();
                          navigationController.navigateTo(itemName);
                        }
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
