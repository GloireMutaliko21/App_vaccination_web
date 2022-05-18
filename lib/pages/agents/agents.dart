import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_connect_web/constants/controllers.dart';
import 'package:v_connect_web/helpers/responsiveness.dart';
import 'package:v_connect_web/pages/agents/widgets/agents_tables.dart';
import 'package:v_connect_web/widgets/custom_text.dart';
import 'package:v_connect_web/widgets/overview_cards_large.dart';
import 'package:v_connect_web/widgets/overview_cards_medium.dart';
import 'package:v_connect_web/widgets/overview_cards_small.dart';
import 'package:v_connect_web/widgets/top_nav_admin.dart';

class AgentsPage extends StatefulWidget {
  const AgentsPage({Key? key}) : super(key: key);

  @override
  _AgentsPageState createState() => _AgentsPageState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

class _AgentsPageState extends State<AgentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBarAdmin(context, scaffoldKey),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            // SizedBox(height: 60),
            // Obx(() => Row(
            //       children: [
            //         Container(
            //           margin: EdgeInsets.only(
            //               top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
            //           child: CustomText(
            //               text: menuController.activeItem.value,
            //               size: 24,
            //               color: Colors.black,
            //               weight: FontWeight.bold),
            //         )
            //       ],
            //     )),
            Expanded(
                child: ListView(
              children: [
                if (ResponsiveWidget.isLargeScreen(context) ||
                    ResponsiveWidget.isMediumScreen(context))
                  // if (ResponsiveWidget.isCustomScreen(context))
                  //   OverviewCardsMediumScreen()
                  // // else
                  // //   Container(
                  // //       margin: EdgeInsets.only(bottom: 15),
                  // //       color: Colors.transparent,
                  // //       child: OverviewCardsLargeScreen(
                  // //         title: "Commune de Kadutu",
                  // //         title2: "Commune d'Ibanda",
                  // //         title3: "Commune de Bagira",
                  // //         title4: "Total Hôpitaux",
                  // //         done1: 0,
                  // //         done2: 0,
                  // //         done3: 0,
                  // //         doneECV: 0,
                  // //       ))
                  // else
                  //   OverviewCardsSmallScreen(),
                  AgentsTables(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
