import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

/// Example without datasource
class AvsTable extends StatefulWidget {
  @override
  _AvsTableState createState() => _AvsTableState();
}

class _AvsTableState extends State<AvsTable> {
  TextEditingController contenu = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getAvs();
  }

  List avs = <dynamic>[];

  Future<void> getAvs() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_AVS_TOUT",
      "idHopital": MyPreferences.idHopital
    }).then((data) {
      if (mounted)
        setState(() {
          avs = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              columnSpacing: 12,
              horizontalMargin: 12,
              columns: [
                DataColumn2(
                  label: Text("NOMS DE L'ENFANT"),
                  size: ColumnSize.L,
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              rows: List<DataRow>.generate(avs.length, (index) {
                var data = avs[index];
                // var id = TextEditingController(text: data["idAvs"]);
                // var contenu = TextEditingController(text: data["contenu"]);

                return DataRow(cells: [
                  DataCell(CustomText(
                    text: data["nom"],
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
                            text: "Notifier",
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
                              'NOTIFIER AVS',
                              textAlign: TextAlign.center,
                            ),
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                child: Container(
                                  width: 400,
                                  child: Column(
                                    children: <Widget>[
                                      // TextFormField(
                                      //   // initialValue: id.text,
                                      //   keyboardType: TextInputType.text,
                                      //   decoration: InputDecoration(
                                      //       enabled: false,
                                      //       labelText: 'Identifiant',
                                      //       icon: Icon(
                                      //         Icons.settings,
                                      //       )),
                                      // ),
                                      // TextFormField(
                                      //   controller: contenu,
                                      //   keyboardType:
                                      //       TextInputType.emailAddress,
                                      //   decoration: InputDecoration(
                                      //     labelText: 'Contenu',
                                      //     hintText: "Contenu",
                                      //     icon: Icon(Icons.list),
                                      //   ),
                                      // ),
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
}
