import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/constants/controllers.dart';
import 'package:v_connect_web/helpers/responsiveness.dart';
import 'package:v_connect_web/pages/Comptes/widgets/comptes_table.dart';
import 'package:v_connect_web/widgets/custom_text.dart';
import 'package:v_connect_web/widgets/overview_cards_large.dart';
import 'package:v_connect_web/widgets/overview_cards_medium.dart';
import 'package:v_connect_web/widgets/overview_cards_small.dart';

class ComptesPage extends StatefulWidget {
  @override
  _ComptesPageState createState() => _ComptesPageState();
}

class _ComptesPageState extends State<ComptesPage> {
  List meres = <dynamic>[];

  Future<void> getMere() async {
    await DataSource.getInstance.getHop(
        params: {"event": "FIND_MERE", "idHopital": MyPreferences.idHopital},
        donne: "mere").then((value) {
      setState(() {
        Constantes.listMere = value;
      });
    });
  }

  List meresT = <dynamic>[];
  List enfants = <dynamic>[];
  List ecv = <dynamic>[];
  List mcv = <dynamic>[];

  Future<void> getMereTout() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_MERE_TOUT",
      "idHopital": MyPreferences.idHopital
    }).then((data) {
      if (mounted)
        setState(() {
          meresT = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getEnfantTout() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_ENFANT_TOUT",
      "idHopital": MyPreferences.idHopital
    }).then((data) {
      if (mounted)
        setState(() {
          enfants = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getECV() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_ECV",
      "idHopital": MyPreferences.idHopital
    }).then((data) {
      if (mounted)
        setState(() {
          ecv = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getMCV() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_MCV",
      "idHopital": MyPreferences.idHopital
    }).then((data) {
      if (mounted)
        setState(() {
          mcv = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    getMereTout();
    getEnfantTout();
    getMere();
    getECV();
    getMCV();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60),
        Obx(() => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      color: Colors.black,
                      weight: FontWeight.bold),
                )
              ],
            )),
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
                      title: "Total enfants",
                      title2: "Total mères",
                      title3: "Enfants complètement vaccinés",
                      title4: "Mères complètement vaccinées",
                      done1: enfants.length,
                      done2: meresT.length,
                      done3: mcv.length,
                      doneECV: ecv.length,
                    ))
            else
              OverviewCardsSmallScreen(),
            ComptesTable(),
          ],
        ))
      ],
    );
  }
}
