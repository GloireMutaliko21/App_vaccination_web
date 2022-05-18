import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/helpers/responsiveness.dart';
import 'package:v_connect_web/pages/vaccin/widgets/vaccins_table.dart';
import 'package:v_connect_web/widgets/overview_cards_large.dart';
import 'package:v_connect_web/widgets/overview_cards_medium.dart';
import 'package:v_connect_web/widgets/overview_cards_small.dart';
import 'package:v_connect_web/widgets/top_nav_admin.dart';

class VaccinPage extends StatefulWidget {
  const VaccinPage({Key? key}) : super(key: key);

  @override
  _VaccinPageState createState() => _VaccinPageState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

class _VaccinPageState extends State<VaccinPage> {
  List vaccins = <dynamic>[];
  List vats = <dynamic>[];

  Future<void> getVaccin() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "VACCINS",
    }).then((data) {
      if (mounted)
        setState(() {
          vaccins = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getVat() async {
    await DataSource.getInstance
        .getCurrentData(params: {"event": "VAT"}).then((data) {
      if (mounted)
        setState(() {
          vats = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    getVaccin();
    getVat();
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
                          title: "Vaccins PEV Routine enfants",
                          title2: "VATs",
                          title3: "Vaccins : vaccination de masse",
                          title4: "Tous les vaccins",
                          done1: vaccins.length,
                          done2: vats.length,
                          done3: vaccins.length + vats.length,
                          doneECV: 0,
                        ))
                else
                  OverviewCardsSmallScreen(),
                VaccinsTable(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
