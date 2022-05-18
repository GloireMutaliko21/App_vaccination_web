import 'package:flutter/material.dart';
import 'package:v_connect_web/helpers/responsiveness.dart';
import 'package:v_connect_web/widgets/horizontal_menu_item.dart';
import 'package:v_connect_web/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final onTap;
  const SideMenuItem({Key? key, required this.itemName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomScreen(context)) {
      return VerticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    } else {
      return HorizontalMenuItem(itemName: itemName, onTap: onTap);
    }
  }
}
