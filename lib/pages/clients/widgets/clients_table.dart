import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:v_connect_web/API/Adds/adds.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/pages/overview/widgets/labelGestion.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

/// Example without datasource
class ClientsTable extends StatefulWidget {
  @override
  _ClientsTableState createState() => _ClientsTableState();
}

class _ClientsTableState extends State<ClientsTable> {
  TextEditingController contenu = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getConseil();
  }

  List conseil = <dynamic>[];

  Future<void> getConseil() async {
    await DataSource.getInstance
        .getCurrentData(params: {"event": "FIND_CONSEIL_TOUT"}).then((data) {
      if (mounted)
        setState(() {
          conseil = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  late DateTime datePub = DateTime.now();
  // var datePu = datePub.toString().substring(0);

  void initData() async {
    // ignore: await_only_futures
    await DataInsert.getInstance.addConseil(data: {
      "contenu": contenu.text,
      "datePub": DateTime.now().toString().substring(0, 10),
      "idAgent": MyPreferences.idAgent,
    }).then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelGestion(
          label: "Gestion des conseils",
          message: "Nouveau conseil",
          onPress: () {
            _showDialogConseil(context);
          },
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            border: Border.all(color: active.withOpacity(.4), width: .5),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 6),
                  color: lightGrey.withOpacity(.1),
                  blurRadius: 12)
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 30),
          child: DataTable2(
              dataRowHeight: 150,
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: [
                DataColumn2(
                  label: Text("Conseil"),
                  size: ColumnSize.L,
                ),
                DataColumn(
                  label: Text('Date publication'),
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              rows: List<DataRow>.generate(conseil.length, (index) {
                var data = conseil[index];
                var id = TextEditingController(text: data["idConseil"]);
                var contenu = TextEditingController(text: data["contenu"]);

                return DataRow(cells: [
                  DataCell(CustomText(
                    text: data["contenu"],
                    color: Colors.black,
                    size: 16,
                    weight: FontWeight.normal,
                  )),
                  DataCell(CustomText(
                    text: data["datePub"],
                    color: Colors.black,
                    size: 16,
                    weight: FontWeight.normal,
                  )),
                  DataCell(
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: active, width: .5),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: CustomText(
                            text: "Modifier",
                            color: Colors.white,
                            weight: FontWeight.bold,
                            size: 16,
                          )), onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text(
                              'MODIFIER CONSEIL',
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
                                        initialValue: id.text,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            enabled: false,
                                            labelText: 'Identifiant',
                                            icon: Icon(
                                              Icons.settings,
                                            )),
                                      ),
                                      TextFormField(
                                        controller: contenu,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelText: 'Contenu',
                                          hintText: "Contenu",
                                          icon: Icon(Icons.list),
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
                                  setState(() {});
                                },
                                color: active,
                              )
                            ],
                          );
                        });
                  }),
                ]);
              })),
        ),
      ],
    );
  }

  _showDialogConseil(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'AJOUTER CONSEIL',
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
                        controller: contenu,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Contenu',
                            hintText: "Conseil",
                            icon: Icon(
                              Icons.local_hospital,
                            )),
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
                    print(
                      DateTime.now().toString().substring(0, 10),
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Conseil enregistré"),
                          );
                        });
                    contenu.text = "";
                  });
                },
                color: active,
              )
            ],
          );
        });
  }
}
