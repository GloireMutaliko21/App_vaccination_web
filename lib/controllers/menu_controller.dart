import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/routing/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = OverViewPageRoute.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case OverViewPageRoute:
        return _customIcon(Icons.dashboard, itemName);
      case ComptesPageRoute:
        return _customIcon(Icons.people_alt, itemName);
      case ClientsPageRoute:
        return _customIcon(Icons.info, itemName);
      case RapportPageRoute:
        return _customIcon(Icons.file_copy, itemName);
      case AvsPageRoute:
        return _customIcon(Icons.person, itemName);
      case CalendriersPageRoute:
        return _customIcon(Icons.calendar_today, itemName);
      case AuthentificationPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: Colors.white);

    return Icon(
      icon,
      color: isHovering(itemName) ? Colors.deepPurpleAccent : lightGrey,
    );
  }
}
