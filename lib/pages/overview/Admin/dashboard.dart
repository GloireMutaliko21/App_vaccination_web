import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/pages/overview/widgets/revenue_section_large.dart';
import 'package:v_connect_web/widgets/overview_cards_large.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({Key? key}) : super(key: key);

  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  List enfants = <dynamic>[];
  List meres = <dynamic>[];
  List hop = <dynamic>[];
  List agents = <dynamic>[];
  List registreE = <dynamic>[];
  List registreM = <dynamic>[];
  List vaccins = <dynamic>[];
  List vat = <dynamic>[];
  List enfNv = <dynamic>[];
  List mereNv = <dynamic>[];
  List enfMp = <dynamic>[];
  List mereMp = <dynamic>[];

  Future<void> getEnfant() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_ENFANT_ADMIN",
    }).then((data) {
      if (mounted)
        setState(() {
          enfants = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getMere() async {
    await DataSource.getInstance
        .getCurrentData(params: {"event": "FIND_MERE_ADMIN"}).then((data) {
      if (mounted)
        setState(() {
          meres = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getHop() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_HOPITAL_TOUT",
    }).then((data) {
      if (mounted)
        setState(() {
          hop = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getAgents() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_AGENT",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          agents = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getRegistreE() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "REGISTRE_VACC",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          registreE = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getRegistreM() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "REGISTRE_VAT",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          registreM = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getVaccins() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "VACCINS",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          vaccins = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getVat() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "VAT",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          vat = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getenfNv() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "ENFANT_N0N_VACCINES_ADMIN",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          enfNv = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getmereNv() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "MERE_N0N_VACCINES_ADMIN",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          mereNv = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getenfMp() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "ENFANTS_VACCINES_LAST_MONTH_ADMIN",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          enfMp = dataMere;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getmereMp() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "MERES_VACCINES_LAST_MONTH_ADMIN",
    }).then((dataMere) {
      if (mounted)
        setState(() {
          mereMp = dataMere;
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
    getHop();
    getAgents();
    getRegistreE();
    getRegistreM();
    getVaccins();
    getVat();
    getenfNv();
    getmereNv();
    getenfMp();
    getmereMp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              OverviewCardsLargeScreen(
                done1: enfants.length,
                title: "Enfants inscrits",
                title2: "Mères inscrites",
                title3: "Hôpitaux enregistréss",
                title4: "Agents inscrits",
                done2: meres.length,
                done3: agents.length,
                doneECV: hop.length,
              ),
              SizedBox(
                height: 25,
              ),
              OverviewCardsLargeScreen(
                done1: registreE.length,
                title: "Nombre de vaccinations enfants",
                title2: "Nombre de vaccinations mères",
                title3: "Vaccins enfants",
                title4: "Vaccins mères",
                done2: registreM.length,
                done3: vat.length,
                doneECV: vaccins.length,
              ),
              RevenueSectionLarge(
                done1: enfNv.length,
                done2: mereNv.length,
                done3: enfMp.length,
                done4: mereMp.length,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
