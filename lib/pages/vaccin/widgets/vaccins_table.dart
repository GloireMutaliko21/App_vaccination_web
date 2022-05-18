import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/pages/overview/widgets/labelGestion.dart';
import 'package:v_connect_web/pages/vaccin/widgets/addVaccin.dart';
import 'package:v_connect_web/pages/vaccin/widgets/addVat.dart';
import 'package:v_connect_web/pages/vaccin/widgets/table.dart';
import 'package:v_connect_web/pages/vaccin/widgets/table2.dart';

class VaccinsTable extends StatefulWidget {
  @override
  _VaccinsTableState createState() => _VaccinsTableState();
}

class _VaccinsTableState extends State<VaccinsTable> {
  List vaccins = <dynamic>[];
  List vats = <dynamic>[];

  Future<void> getVaccin() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "VACCINS",
    }).then((data2) {
      if (mounted)
        setState(() {
          vaccins = data2;
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
    return Column(
      children: [
        LabelGestion(
          label: "  Gestion des vaccins \n PEV Routine enfants",
          message: "Nouveau vaccin",
          onPress: () {
            _showDialogVaccin(context);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 300,
            child: SingleChildScrollView(
                child: TableData(
              titreTable: "Liste des vaccins PEV routine",
              data2: vaccins,
            ))),
        SizedBox(
          height: 10,
        ),
        LabelGestion(
          label: "Gestion des VATs",
          message: "Nouveau VAT",
          onPress: () {
            _showDialogVAT(context);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 300,
            child: SingleChildScrollView(
                child: TableData2(
              titreTable: "Liste des VATs",
              data: vats,
            ))),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _showDialogVaccin(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'AJOUTER VACCIN',
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(child: AddVaccin()),
            ),
            actions: [
              RaisedButton(
                child: Text(
                  "Enregistrer",
                  style: TextStyle(color: light),
                ),
                onPressed: () {
                  // your code
                },
                color: active,
              )
            ],
          );
        });
  }

  _showDialogVAT(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'AJOUTER V.A.T',
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(child: AddVAT()),
            ),
            actions: [
              RaisedButton(
                child: Text(
                  "Enregistrer",
                  style: TextStyle(color: light),
                ),
                onPressed: () {
                  // your code
                },
                color: active,
              )
            ],
          );
        });
  }
}
