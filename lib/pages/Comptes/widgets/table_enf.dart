import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:v_connect_web/API/Adds/updates.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class TableDataEnfant extends StatefulWidget {
  final titreTable;
  final List data;
  const TableDataEnfant({this.titreTable, required this.data});

  @override
  _TableDataState createState() => _TableDataState();
}

class _TableDataState extends State<TableDataEnfant> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoad = true;
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
                label: Text('Sexe'),
              ),
              DataColumn(
                label: Text('Action'),
              ),
            ],
            rows: List<DataRow>.generate(widget.data.length, (index) {
              var data = widget.data[index];
              var id = data['idEnfant'];

              TextEditingController nom = new TextEditingController();
              TextEditingController lieu = new TextEditingController();
              TextEditingController poids = new TextEditingController();
              TextEditingController taille = new TextEditingController();
              TextEditingController numCarte = new TextEditingController();
              var dateNaisse = TextEditingController();

              nom.text = data['noms'];
              lieu.text = data['lieuNaiss'];
              poids.text = data['poids'];
              taille.text = data['taille'];
              numCarte.text = data['numCarteVacc'];
              dateNaisse.text = data['dateNaissance'];

              void vider() {
                id = "";
                nom.text = "";
                poids.text = "";
                taille.text = "";
                numCarte.text = "";
                dateNaisse.text = "";
              }

              late DateTime selectedDate = DateTime.now();
              late String idHop;
              late String idMere;
              late String sexe;
              late int indexOfM;
              late int indexOfH;
              initDate(context) async {
                selectedDate = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1960),
                    lastDate: DateTime(2050)))!;
                if (selectedDate != null)
                  dateNaisse.text = selectedDate.toString().substring(0, 10);
              }

              return DataRow(cells: [
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
                      Icons.star,
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
                            'MODIFIER ENFANT',
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
                                      initialValue: "${id}",
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        labelText: 'Identifiant',
                                        icon: Icon(Icons.account_box),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: nom,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        labelText: 'Noms',
                                        hintText: "Nom complet",
                                        icon: Icon(Icons.account_box),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: lieu,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        labelText: 'Lieu Naissance',
                                        hintText: "Lieu Naissance",
                                        icon: Icon(Icons.place_outlined),
                                      ),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Date de naissance",
                                        icon: Icon(
                                          Icons.calendar_today,
                                        ),
                                      ),
                                      controller: dateNaisse,
                                      readOnly: true,
                                      onTap: () {
                                        initDate(context);
                                      },
                                    ),
                                    Container(
                                        child: cbList(
                                            title: "Sexe",
                                            list: isList(
                                                value: ["Féminin", "Masculin"]),
                                            onChanged: (val) {
                                              sexe = val;
                                            })),
                                    TextFormField(
                                      controller: poids,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Poids',
                                        hintText: "Poids",
                                        icon: Icon(
                                            Icons.accessibility_new_outlined),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: taille,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Taille',
                                        hintText: "Taille",
                                        icon: Icon(Icons.height_sharp),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: numCarte,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Num carte',
                                        hintText: "Numero carte",
                                        icon: Icon(Icons.document_scanner),
                                      ),
                                    ),
                                    Container(
                                        child: cbList(
                                            title: "mère",
                                            list: isList(
                                                value: Constantes.listMere),
                                            onChanged: (vale) {
                                              setState(() {
                                                idMere = vale;
                                                indexOfM = idMere.indexOf("-");
                                              });
                                            })),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            Container(
                              child: isLoad
                                  ? RaisedButton(
                                      child: Text(
                                        "Terminer",
                                        style: TextStyle(color: light),
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          isLoad = false;
                                        });
                                        await DataUpdate.getInstance
                                            .modifEnf(data: {
                                          "idEnfant": id,
                                          "noms": nom.text,
                                          "lieuNaiss": lieu.text,
                                          "dateNaissance": dateNaisse.text,
                                          "sexe": sexe.substring(0, 1),
                                          "poids": poids.text,
                                          "taille": taille.text,
                                          "numCarteVacc": numCarte.text,
                                          "idMere":
                                              idMere.substring(0, indexOfM),
                                          "idHopital": MyPreferences.idHopital
                                        }).then((value) {
                                          setState(() {
                                            isLoad = true;
                                          });
                                          vider();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Text(
                                                      "Modifié avec succès"),
                                                );
                                              });
                                        });
                                      },
                                      color: active,
                                    )
                                  : Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.white,
                                      child: Center(
                                        child: SpinKitChasingDots(
                                          color: active,
                                        ),
                                      ),
                                    ),
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
