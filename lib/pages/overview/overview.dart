import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/controllers.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/helpers/responsiveness.dart';
import 'package:v_connect_web/pages/overview/widgets/table_enfant.dart';
import 'package:v_connect_web/pages/overview/widgets/revenue_section_large.dart';
import 'package:v_connect_web/pages/overview/widgets/revenue_section_small.dart';
import 'package:v_connect_web/pages/overview/widgets/table_mere.dart';
import 'package:v_connect_web/widgets/custom_text.dart';
import 'package:v_connect_web/widgets/overview_cards_large.dart';
import 'package:v_connect_web/widgets/overview_cards_medium.dart';
import 'package:v_connect_web/widgets/overview_cards_small.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  List att = <dynamic>[];
  List attM = <dynamic>[];
  List attVE = <dynamic>[];
  List attMt = <dynamic>[];
  List enfNv = <dynamic>[];
  List merNv = <dynamic>[];
  List enfVlastMonth = <dynamic>[];
  List merVlastMonth = <dynamic>[];
  List list = <List<dynamic>>[];
  int count = 0;

  Future<void> getEnfant() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "ENFANTS_ATTENDUS",
      "idHopital": MyPreferences.idHopital
    }).then((data) {
      if (mounted)
        setState(() {
          att = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getVacc() async {
    await DataSource.getInstance
        .getCurrentData(params: {"event": "VACCINES_TODAY"}).then((data) {
      if (mounted)
        setState(() {
          attVE = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getMonth() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "VACCINES_MONTH",
      "idHopital": MyPreferences.idHopital
    }).then((data) {
      if (mounted)
        setState(() {
          attMt = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getMere() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "MERES_ATTENDUES",
      "idHopital": MyPreferences.idHopital
    }).then((dataMere) {
      if (mounted)
        setState(() {
          attM = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getEnfNVacc() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "ENFANT_N0N_VACCINES",
      "idHopital": MyPreferences.idHopital
    }).then((dataMere) {
      if (mounted)
        setState(() {
          enfNv = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getMerNVacc() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "MERE_N0N_VACCINES",
      "idHopital": MyPreferences.idHopital
    }).then((dataMere) {
      if (mounted)
        setState(() {
          merNv = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getEnfVaccLastM() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "ENFANTS_VACCINES_LAST_MONTH",
      "idHopital": MyPreferences.idHopital
    }).then((dataMere) {
      if (mounted)
        setState(() {
          enfVlastMonth = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getMereVaccLastM() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "MERES_VACCINES_LAST_MONTH",
      "idHopital": MyPreferences.idHopital
    }).then((dataMere) {
      if (mounted)
        setState(() {
          merVlastMonth = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    getEnfant();
    getMere();
    getVacc();
    getMonth();
    getEnfNVacc();
    getMerNVacc();
    getEnfVaccLastM();
    getMereVaccLastM();
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
                  child: Column(
                    children: [
                      CustomText(
                          text: menuController.activeItem.value,
                          size: 24,
                          color: Colors.black,
                          weight: FontWeight.bold),
                      Container(
                        child: Text(
                          " Situation du ${DateTime.now().toString().substring(0, 10)}",
                          style: TextStyle(
                              color: active,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 300),
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
                OverviewCardsLargeScreen(
                  done1: att.length + attM.length,
                  title: "Sujets attendus",
                  title2: "Sujets vaccinés",
                  title3: "Reste à vacciner",
                  title4: "Total mensuel",
                  done2: attVE.length,
                  done3: attMt.length,
                  doneECV: 0,
                )
            else
              OverviewCardsSmallScreen(),
            if (!ResponsiveWidget.isSmallScreen(context))
              RevenueSectionLarge(
                done1: enfNv.length,
                done2: merNv.length,
                done3: enfVlastMonth.length,
                done4: merVlastMonth.length,
              )
            else
              RevenueSectionSmall(),
            AvailableDriversTable(data: att),
            TableMere(data2: attM)
          ],
        ))
      ],
    );
  }
}
