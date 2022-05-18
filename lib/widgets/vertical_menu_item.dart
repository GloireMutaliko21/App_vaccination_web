import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:v_connect_web/constants/controllers.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class VerticalMenuItem extends StatelessWidget {
  final String itemName;
  final onTap;
  const VerticalMenuItem({Key? key, required this.itemName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover("not hoverinf");
      },
      child: Obx(() => Container(
            color: menuController.isHovering(itemName)
                ? Colors.deepPurple
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuController.isHovering(itemName) ||
                      menuController.isActive(itemName),
                  child: Container(
                    width: 3,
                    height: 72,
                    color: dark,
                  ),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                ),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: menuController.returnIconFor(itemName),
                    ),
                    if (!menuController.isActive(itemName))
                      Flexible(
                          child: CustomText(
                        text: itemName,
                        size: 19,
                        color: menuController.isHovering(itemName)
                            ? Colors.blue
                            : Colors.blue.withOpacity(.5),
                        weight: FontWeight.normal,
                      ))
                    else
                      Flexible(
                          child: CustomText(
                        text: itemName,
                        size: 16,
                        color: dark,
                        weight: FontWeight.bold,
                      ))
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
