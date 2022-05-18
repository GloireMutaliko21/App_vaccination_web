import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Adds/updates.dart';
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/pages/hopitaux/hopitaux.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class TableData extends StatefulWidget {
  final List data;
  const TableData({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _TableDataState createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
          minWidth: 600,
          columns: [
            DataColumn2(
              label: Text("Noms"),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('Localisation'),
            ),
            DataColumn(
              label: Text('Zone de santé'),
            ),
            DataColumn(
              label: Text('E-mail'),
            ),
            DataColumn(
              label: Text('Action'),
            ),
          ],
          rows: List<DataRow>.generate(widget.data.length, (index) {
            var data = widget.data[index];
            // var id = data['idhopital'];
            var zs;
            TextEditingController denomination =
                new TextEditingController(text: data['denomination']);
            TextEditingController id =
                new TextEditingController(text: data['idHopital']);
            TextEditingController mail =
                new TextEditingController(text: data['mail']);
            TextEditingController adresse =
                new TextEditingController(text: data['adresse']);

            void vider() {
              id.text = "";
              denomination.text = "";
              mail.text = "";
              adresse.text = "";
            }

            return DataRow(cells: [
              DataCell(CustomText(
                text: data['denomination'],
                color: Colors.black,
                size: 16,
                weight: FontWeight.normal,
              )),
              DataCell(CustomText(
                text: data['adresse'],
                color: Colors.black,
                size: 16,
                weight: FontWeight.normal,
              )),
              DataCell(CustomText(
                text: data['zoneSante'],
                color: Colors.black,
                size: 16,
                weight: FontWeight.normal,
              )),
              DataCell(CustomText(
                text: data['mail'],
                color: Colors.black,
                size: 16,
                weight: FontWeight.normal,
              )),
              DataCell(
                  Container(
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: active, width: .5),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: CustomText(
                        text: "Modifier",
                        color: active.withOpacity(.7),
                        weight: FontWeight.bold,
                        size: 16,
                      )), onTap: () {
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
                                    controller: id,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        enabled: false,
                                        labelText: 'Identifiant',
                                        icon: Icon(
                                          Icons.local_hospital,
                                        )),
                                  ),
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
                                          list: isList(value: [
                                            "Kadutu",
                                            "Ibanda",
                                            "Bagira"
                                          ]),
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
                              "Terminer",
                              style: TextStyle(color: light),
                            ),
                            onPressed: () async {
                              await DataUpdate.getInstance.modifHop(data: {
                                "idHopital": id.text,
                                "denomination": denomination.text,
                                "mail": mail.text,
                                "zoneSante": zs,
                                "adresse": adresse.text,
                              }).then((value) {
                                vider();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text("Modifié avec succès"),
                                      );
                                    });
                                HopitauxPage();
                                print(value);
                              });
                            },
                            color: active,
                          )
                        ],
                      );
                    });
              }),
            ]);
          }).toList()),
    );
  }
}
