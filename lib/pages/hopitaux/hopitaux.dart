import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/constants/controllers.dart';
import 'package:v_connect_web/helpers/responsiveness.dart';
import 'package:v_connect_web/pages/hopitaux/widgets/hopitaux_table.dart';
import 'package:v_connect_web/widgets/custom_text.dart';
import 'package:v_connect_web/widgets/overview_cards_large.dart';
import 'package:v_connect_web/widgets/overview_cards_medium.dart';
import 'package:v_connect_web/widgets/overview_cards_small.dart';
import 'package:v_connect_web/widgets/top_nav_admin.dart';

class HopitauxPage extends StatefulWidget {
  const HopitauxPage({Key? key}) : super(key: key);

  @override
  _HopitauxPageState createState() => _HopitauxPageState();
}

class _HopitauxPageState extends State<HopitauxPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  List kadutu = <dynamic>[];
  List bagira = <dynamic>[];
  List ibanda = <dynamic>[];

  Future<void> getHopKdt() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_HOPITAL_KADUTU",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          kadutu = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getHopIbd() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_HOPITAL_IBANDA",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          ibanda = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getHopBgr() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_HOPITAL_BAGIRA",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          bagira = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    getHopKdt();
    getHopIbd();
    getHopBgr();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBarAdmin(context, scaffoldKey),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            // SizedBox(height: 20),
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
                  if (ResponsiveWidget.isCustomScreen(context))
                    OverviewCardsMediumScreen()
                  else
                    Container(
                        margin: EdgeInsets.only(bottom: 15),
                        color: Colors.transparent,
                        child: OverviewCardsLargeScreen(
                          title: "Commune de Kadutu",
                          title2: "Commune d'Ibanda",
                          title3: "Commune de Bagira",
                          title4: "Total Hôpitaux",
                          done1: kadutu.length,
                          done2: ibanda.length,
                          done3: kadutu.length + ibanda.length + bagira.length,
                          doneECV: bagira.length,
                        ))
                else
                  OverviewCardsSmallScreen(),
                HopitauxTable(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
