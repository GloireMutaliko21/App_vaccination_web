import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_connect_web/constants/controllers.dart';
import 'package:v_connect_web/helpers/responsiveness.dart';
import 'package:v_connect_web/pages/clients/widgets/clients_table.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class ClientsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 60),
            Obx(
              () => Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top:
                              ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                      child: CustomText(
                        text: menuController.activeItem.value,
                        size: 24,
                        weight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                ClientsTable(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
