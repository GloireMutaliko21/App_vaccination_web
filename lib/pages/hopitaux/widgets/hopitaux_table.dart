import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Adds/adds.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/pages/hopitaux/widgets/table.dart';
import 'package:v_connect_web/pages/overview/widgets/labelGestion.dart';

class HopitauxTable extends StatefulWidget {
  @override
  _HopitauxTableState createState() => _HopitauxTableState();
}

class _HopitauxTableState extends State<HopitauxTable> {
  TextEditingController denomination = new TextEditingController();

  TextEditingController mail = new TextEditingController();

  TextEditingController adresse = new TextEditingController();

  late String zs;

  @override
  void initState() {
    super.initState();
    getHopTout();
  }

  List hop = <dynamic>[];

  Future<void> getHopTout() async {
    await DataSource.getInstance
        .getCurrentData(params: {"event": "FIND_HOPITAL_TOUT"}).then((data) {
      if (mounted)
        setState(() {
          hop = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  void initData() async {
    // ignore: await_only_futures
    await DataInsert.getInstance.addHop(data: {
      "denomination": denomination.text,
      "mail": mail.text,
      "zoneSante": zs,
      "adresse": adresse.text,
    }).then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelGestion(
          label: "Gestion des hôpitaux",
          message: "Nouvel Hôpital/C.S/C.H",
          onPress: () {
            _showDialogHopital(context);
          },
        ),
        SizedBox(
          height: 10,
        ),
        TableData(
          data: hop,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _showDialogHopital(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'AJOUTER HOPITAL',
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Container(
                  width: 400,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: denomination,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Denomination',
                            hintText: "Ex. C.H. Biopharm",
                            icon: Icon(
                              Icons.local_hospital,
                            )),
                      ),
                      TextFormField(
                        controller: mail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          hintText: "hopital@gmail.com",
                          icon: Icon(Icons.mail),
                        ),
                      ),
                      Container(
                          child: cbList(
                              title: "Zone de santé",
                              list:
                                  isList(value: ["Kadutu", "Ibanda", "Bagira"]),
                              onChanged: (val) {
                                zs = val;
                              })),
                      TextFormField(
                        controller: adresse,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Adresse',
                          hintText: "Adresse hôpital",
                          icon: Icon(Icons.home_work_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              RaisedButton(
                child: Text(
                  "Enregistrer",
                  style: TextStyle(color: light),
                ),
                onPressed: () {
                  setState(() {
                    initData();
                  });
                },
                color: active,
              )
            ],
          );
        });
  }
}
