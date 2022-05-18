import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Adds/updates.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class TableData extends StatefulWidget {
  final titreTable;
  final List data;
  const TableData({this.titreTable, required this.data});

  @override
  _TableDataState createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 550,
      // alignment: Alignment.topRight,
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
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CustomText(
                text: widget.titreTable,
                color: active,
                weight: FontWeight.bold,
                size: 16,
              ),
            ],
          ),
          DataTable2(
            columnSpacing: 5,
            horizontalMargin: 5,
            minWidth: 300,
            columns: [
              DataColumn2(
                label: Text("Identifiant"),
                size: ColumnSize.M,
              ),
              DataColumn(
                label: Text('Noms'),
              ),
              DataColumn(
                label: Text('Numéro téléphone'),
              ),
              DataColumn(
                label: Text('Action'),
              ),
            ],
            rows: List<DataRow>.generate(widget.data.length, (index) {
              var data = widget.data[index];
              var id = data['idMere'];

              TextEditingController nomM = new TextEditingController();
              TextEditingController date = new TextEditingController();
              TextEditingController numT = new TextEditingController();
              TextEditingController adress = new TextEditingController();
              TextEditingController log = new TextEditingController();
              TextEditingController pw = new TextEditingController();
              late DateTime selectedDate = DateTime.now();

              nomM.text = data['noms'];
              date.text = data['dateNaiss'];
              numT.text = data['tel'];
              adress.text = data['adresse'];
              log.text = data['loginM'];
              pw.text = data['pwM'];

              void vider() {
                nomM.text = "";
                date.text = "";
                numT.text = "";
                adress.text = "";
                log.text = "";
                pw.text = "";
              }

              initDate(context) async {
                selectedDate = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1960),
                    lastDate: DateTime(2050)))!;
                if (selectedDate != null)
                  date.text = selectedDate.toString().substring(0, 10);
              }

              return DataRow(cells: [
                DataCell(CustomText(
                  text: data['idMere'],
                  color: Colors.black,
                  size: 16,
                  weight: FontWeight.normal,
                )),
                DataCell(CustomText(
                  text: data['noms'],
                  color: Colors.black,
                  size: 16,
                  weight: FontWeight.normal,
                )),
                DataCell(Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.deepOrange,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CustomText(
                      text: data['tel'],
                      color: Colors.black,
                      size: 16,
                      weight: FontWeight.normal,
                    )
                  ],
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
                            'MODIFIER MERE',
                            textAlign: TextAlign.center,
                          ),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Container(
                                width: 500,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      initialValue: "${id}",
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        labelText: 'Identifiant',
                                        icon: Icon(Icons.account_box),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: nomM,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        labelText: 'Noms',
                                        hintText: "Nom complet",
                                        icon: Icon(Icons.account_box),
                                      ),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Date de naissance",
                                        icon: Icon(
                                          Icons.calendar_today,
                                        ),
                                      ),
                                      controller: date,
                                      readOnly: true,
                                      onTap: () {
                                        initDate(context);
                                      },
                                    ),
                                    TextFormField(
                                      controller: numT,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Téléphone',
                                        hintText: "Numéro téléphone",
                                        icon: Icon(
                                            Icons.accessibility_new_outlined),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: adress,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Adresse',
                                        hintText: "Adresse locale",
                                        icon: Icon(Icons.home_work_rounded),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: log,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Login',
                                        hintText: "Votre login",
                                        icon: Icon(Icons.person),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: pw,
                                      obscureText: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Mot de passe',
                                        hintText: "Mot de passe",
                                        icon: Icon(Icons.lock),
                                      ),
                                    ),
                                    SizedBox(height: 10),
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
                                await DataUpdate.getInstance.modifMere(data: {
                                  "idMere": id,
                                  "noms": nomM.text,
                                  "dateNaiss": date.text,
                                  "tel": numT.text,
                                  "adresse": adress.text,
                                  "loginM": log.text,
                                  "pwM": pw.text,
                                  "idHopital": MyPreferences.idHopital,
                                }).then((value) {
                                  vider();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text("Modifié avec succès"),
                                        );
                                      });
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
            }).toList(),
          ),
        ],
      ),
    );
  }
}
