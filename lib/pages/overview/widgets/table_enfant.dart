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
class AvailableDriversTable extends StatefulWidget {
  late final List data;
  AvailableDriversTable({required this.data});
  @override
  _AvailableDriversTableState createState() => _AvailableDriversTableState();
}

class _AvailableDriversTableState extends State<AvailableDriversTable> {
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
                text: "Enfants attendus pour le vaccin",
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
                    "Noms de l'enfant",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade900),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Sexe',
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
              rows: List<DataRow>.generate(widget.data.length, (index) {
                var data = widget.data[index];

                var id = data['idEnfant'];
                var vacc = data['idVaccin'];

                return DataRow(
                  cells: [
                    DataCell(CustomText(
                      text: data['idEnfant'],
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
                          Icons.person,
                          color: Colors.deepOrange,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: data['sexe'],
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
                                          initialValue: "$id",
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              labelText: "ID de l'enfant",
                                              icon: Icon(
                                                Icons.person,
                                                color: Colors.brown,
                                              )),
                                        ),
                                        TextFormField(
                                          initialValue: "$vacc",
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              labelText: "ID du vaccin",
                                              icon: Icon(
                                                Icons.medication,
                                                color: Colors.brown,
                                              )),
                                        ),
                                        Container(
                                            child: cbList(
                                                title: "As/Has/Hz",
                                                list: isList(
                                                    value: ["As", "Has", "Hz"]),
                                                onChanged: (val) {
                                                  has = val;
                                                })),
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
                                    if (vacc == "3") {
                                      datePrevue = formatter.format(dateNow
                                          .add(const Duration(days: 28)));
                                      idVacc = 7;
                                    } else if (vacc == "7") {
                                      datePrevue = formatter.format(
                                          dateNow.add(Duration(days: 28)));
                                      idVacc = 11;
                                    } else if (vacc == "11") {
                                      datePrevue = formatter.format(
                                          dateNow.add(Duration(days: 195)));
                                      idVacc = 16;
                                    }
                                    initAddCal(datePrevue, id, idVacc);
                                    await initRegistre(
                                            dateformatted,
                                            id,
                                            vacc,
                                            has,
                                            observ.text,
                                            MyPreferences.idAgent,
                                            MyPreferences.idHopital)
                                        .then((value) {
                                      value = true;
                                      if (value) {
                                        setState(() {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content:
                                                      Text("Sujet vacciné"),
                                                );
                                              });
                                          initModif(id, vacc);
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

  initRegistre(var date, idEnf, idVac, asHas, obs, idAg, idHop) async {
    // ignore: await_only_futures
    // await findDateAndVacc(idVac);
    await DataInsert.getInstance.addRegistre(data: {
      "dateRecue": date,
      "idEnfant": idEnf,
      "idVaccin": idVac,
      "asHasHz": asHas,
      "observation": obs,
      "idAgent": idAg,
      "idHopital": idHop
    }).then((value) {
      print(value);
    });
  }

  void initModif(var idEnf, idVac) async {
    // ignore: await_only_futures
    await DataInsert.getInstance.modifCal(data: {
      "idEnfant": idEnf,
      "idVaccin": idVac,
    }).then((value) {
      print(value);
    });
  }

  void initAddCal(var date, idEnf, idVac) async {
    // ignore: await_only_futures
    // await findDateAndVacc(idVac);
    await DataInsert.getInstance.addCalSuiv(data: {
      "idVaccin": idVac,
      "datePrev": date,
      "idEnfant": idEnf,
    }).then((value) {
      print(value);
    });
  }
}
