import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:v_connect_web/API/Adds/adds.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';
import 'package:intl/intl.dart';

/// Example without datasource
class TableMere extends StatefulWidget {
  late final List data2;
  TableMere({required this.data2});
  @override
  _TableMereState createState() => _TableMereState();
}

class _TableMereState extends State<TableMere> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController observ = new TextEditingController();
  // TextEditingController idVaccin = new TextEditingController();

  var has;
  var id;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CustomText(
                text: "Mères attendues pour le vaccin",
                color: Colors.indigoAccent.shade700,
                weight: FontWeight.bold,
                size: 16,
              ),
            ],
          ),
          DataTable2(
              horizontalMargin: 50,
              columns: [
                DataColumn2(
                  label: Text(
                    "Identifiant",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade900),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn(
                  label: Text(
                    "Noms de la mère",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade900),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Téléphone',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade900),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Adresse',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade900),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Action',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade900),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(widget.data2.length, (index) {
                var data2 = widget.data2[index];

                var idM = data2['idMere'];
                var vat = data2['idVat'];

                return DataRow(
                  cells: [
                    DataCell(CustomText(
                      text: data2['idMere'],
                      color: Colors.black,
                      size: 16,
                      weight: FontWeight.normal,
                    )),
                    DataCell(CustomText(
                      text: data2['noms'],
                      color: Colors.black,
                      size: 16,
                      weight: FontWeight.normal,
                    )),
                    DataCell(CustomText(
                      text: data2['tel'],
                      color: Colors.black,
                      size: 16,
                      weight: FontWeight.normal,
                    )),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.deepOrange,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: data2['adresse'],
                          color: Colors.black,
                          size: 16,
                          weight: FontWeight.normal,
                        )
                      ],
                    )),
                    DataCell(
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade600,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: active, width: .5),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: CustomText(
                              text: "Vacciner",
                              color: Colors.white,
                              weight: FontWeight.normal,
                              size: 16,
                            )), onTap: () {
                      // _showDialogAgent(context);

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text(
                                "VACCINER",
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
                                          initialValue: "$idM",
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              labelText: "ID de la mère",
                                              icon: Icon(
                                                Icons.person,
                                                color: Colors.brown,
                                              )),
                                        ),
                                        TextFormField(
                                          initialValue: "$vat",
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              labelText: "ID du VAT",
                                              icon: Icon(
                                                Icons.medication,
                                                color: Colors.brown,
                                              )),
                                        ),
                                        TextFormField(
                                          controller: observ,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              labelText: "Onservation",
                                              hintText: "Observation",
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.brown,
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
                                  onPressed: () async {
                                    var idVacc;
                                    var datePrevue;
                                    final DateTime dateNow = new DateTime.now();
                                    DateFormat formatter =
                                        new DateFormat('yyyy-MM-dd');
                                    String dateformatted = "";

                                    dateformatted = formatter.format(dateNow);
                                    if (vat == "1") {
                                      datePrevue = formatter.format(dateNow
                                          .add(const Duration(days: 30)));
                                      idVacc = 2;
                                    } else if (vat == "2") {
                                      datePrevue = formatter.format(
                                          dateNow.add(Duration(days: 180)));
                                      idVacc = 3;
                                    } else if (vat == "3") {
                                      datePrevue = formatter.format(
                                          dateNow.add(Duration(days: 365)));
                                      idVacc = 4;
                                    } else if (vat == "4") {
                                      datePrevue = formatter.format(
                                          dateNow.add(Duration(days: 365)));
                                      idVacc = 5;
                                    }
                                    initAddCal(datePrevue, idM, idVacc);
                                    await initRegistre(
                                            dateformatted,
                                            idM,
                                            vat,
                                            observ.text,
                                            MyPreferences.idAgent,
                                            MyPreferences.idHopital)
                                        .then((value) {
                                      value = true;
                                      if (value) {
                                        setState(() {
                                          initModif(idM, vat);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Text(
                                                      "Modifié avec succès"),
                                                );
                                              });
                                        });
                                      }
                                    });
                                  },
                                  color: active,
                                )
                              ],
                            );
                          });
                    }),
                  ],
                );
              }).toList()), //ici on change pas
        ],
      ),
    );
  }

  initRegistre(var date, idM, idVat, obs, idAg, idHop) async {
    // ignore: await_only_futures
    // await findDateAndVacc(idVac);
    await DataInsert.getInstance.addRegistreVat(data: {
      "dateRecue": date,
      "idMere": idM,
      "idVat": idVat,
      "obs": obs,
      "idAgent": idAg,
      "idHopital": idHop
    }).then((value) {
      print(value);
    });
  }

  void initModif(var idM, idVat) async {
    // ignore: await_only_futures
    await DataInsert.getInstance.modifCalVat(data: {
      "idMere": idM,
      "idVat": idVat,
    }).then((value) {
      print(value);
    });
  }

  void initAddCal(var date, idM, idVat) async {
    // ignore: await_only_futures
    // await findDateAndVacc(idVac);
    await DataInsert.getInstance.addCalVatSuiv(data: {
      "idVat": idVat,
      "datePrevue": date,
      "idMere": idM,
    }).then((value) {
      print(value);
    });
  }
}
