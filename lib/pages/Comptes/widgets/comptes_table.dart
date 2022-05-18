import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Adds/adds.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/pages/Comptes/widgets/prepareCal.dart';
import 'package:v_connect_web/pages/Comptes/widgets/table_enf.dart';
import 'package:v_connect_web/pages/overview/widgets/labelGestion.dart';
import 'package:v_connect_web/pages/Comptes/widgets/table.dart';
import 'package:intl/intl.dart';

/// Example without datasource
class ComptesTable extends StatefulWidget {
  @override
  _ComptesTableState createState() => _ComptesTableState();
}

class _ComptesTableState extends State<ComptesTable> {
  TextEditingController nom = new TextEditingController();
  TextEditingController lieu = new TextEditingController();
  TextEditingController poids = new TextEditingController();
  TextEditingController taille = new TextEditingController();
  TextEditingController numCarte = new TextEditingController();
  TextEditingController nomM = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController numT = new TextEditingController();
  TextEditingController adress = new TextEditingController();
  TextEditingController log = new TextEditingController();
  TextEditingController pw = new TextEditingController();
  TextEditingController pw2 = new TextEditingController();
  var dateNaisse = TextEditingController();

  late DateTime selectedDate = DateTime.now();
  late String idHop;
  late String idMere;
  late String sexe;

  @override
  void initState() {
    super.initState();
    getMere();
    getHopital();
    getMereTout();
    getEnfantTout();
  }

  Future<void> getHopital() async {
    await DataSource.getInstance.getHop(
        params: {"event": "FIND_HOPITAL"}, donne: "hopital").then((value) {
      setState(() {
        Constantes.listHopital = value;
      });
    });
  }

  List meres = <dynamic>[];
  List enfants = <dynamic>[];

  Future<void> getMere() async {
    await DataSource.getInstance.getHop(
        params: {"event": "FIND_MERE", "idHopital": MyPreferences.idHopital},
        donne: "mere").then((value) {
      setState(() {
        Constantes.listMere = value;
      });
    });
  }

  Future<void> getMereTout() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_MERE_TOUT",
      "idHopital": MyPreferences.idHopital
    }).then((data) {
      if (mounted)
        setState(() {
          meres = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getEnfantTout() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_ENFANT_TOUT",
      "idHopital": MyPreferences.idHopital
    }).then((data) {
      if (mounted)
        setState(() {
          enfants = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  late int indexOfM;
  late int indexOfH;
  Future<bool> initData() async {
    await DataInsert.getInstance.addEnfant(data: {
      "noms": nom.text,
      "lieuNaiss": lieu.text,
      "dateNaissance": dateNaisse.text,
      "sexe": sexe.substring(0, 1),
      "poids": poids.text,
      "taille": taille.text,
      "numCarteVacc": numCarte.text,
      "idMere": idMere.substring(0, indexOfM),
      "idHopital": MyPreferences.idHopital
    }).then((value) {
      return true;
    });
    return false;
  }

  void initDataMere() async {
    // ignore: await_only_futures
    await findDateAndVaccMere();
    await DataInsert.getInstance.addMere(data: {
      "noms": nomM.text,
      "dateNaiss": date.text,
      "tel": numT.text,
      "adresse": adress.text,
      "loginM": log.text,
      "pwM": pw2.text,
      "idHopital": MyPreferences.idHopital,
      "datePrevue": datePrevue,
      "idVAT": idVAT
    }).then((value) {
      print(value);
    });
  }

  late String datePrevue;
  late int idVAT, jours, nbreDoses;
  String datePrev = "";
  String datePrev2 = "";
  String datePrev3 = "";
  String datePrev4 = "";
  int idVaccin = 3, idVaccin2 = 7, idVaccin3 = 11, idVaccin4 = 15;
  late int joursEnf;
  var dateLastVat = TextEditingController();
  DateTime selectedDate2 = DateTime.now();

  final DateTime dateNow = new DateTime.now();
  DateFormat formatter = new DateFormat('yyyy-MM-dd');
  late String dateformatted;

  void findDateAndVacc() {
    // setState(() {
    //   joursEnf = dateNow.difference(selectedDate).inDays;
    //   dateformatted = formatter.format(dateNow);
    //   print(joursEnf);

    //   if (dateformatted == dateNaisse.text) {
    //     datePrev = formatter.format(dateNow.add(const Duration(days: 42)));
    //     idVaccin = 3;
    //     print(datePrev);
    //   } else if ((dateformatted != dateNaisse.text) && (joursEnf < 42)) {
    //     datePrev =
    //         formatter.format(dateNow.add(Duration(days: (42 - joursEnf))));
    //     idVaccin = 3;
    //   } else if ((joursEnf > 42) && (joursEnf < 70)) {
    //     datePrev =
    //         formatter.format(dateNow.add(Duration(days: (70 - joursEnf))));
    //     idVaccin = 7;
    //   } else if ((joursEnf > 70) && (joursEnf < 98)) {
    //     datePrev =
    //         formatter.format(dateNow.add(Duration(days: (98 - joursEnf))));
    //     idVaccin = 11;
    //   } else if ((joursEnf > 98) && (joursEnf < 270)) {
    //     datePrev =
    //         formatter.format(dateNow.add(Duration(days: (270 - joursEnf))));
    //     idVaccin = 15;
    //   }
    // });
    setState(() {
      joursEnf = dateNow.difference(selectedDate).inDays;
      dateformatted = formatter.format(dateNow);
      print(joursEnf);
      datePrev = formatter.format(dateNow.add(Duration(days: (42 - joursEnf))));
      datePrev2 =
          formatter.format(dateNow.add(Duration(days: (70 - joursEnf))));
      datePrev3 =
          formatter.format(dateNow.add(Duration(days: (98 - joursEnf))));
      datePrev4 =
          formatter.format(dateNow.add(Duration(days: (270 - joursEnf))));

      if (dateformatted == dateNaisse.text) {
        for (var i = 0; i < 4; i++) {
          i == 0
              ? DataInsert.getInstance.addCalEnf(data: {
                  "datePrev": datePrev.toString(),
                  "idVaccin": idVaccin,
                }).then((value) {
                  return true;
                })
              : i == 1
                  ? DataInsert.getInstance.addCalEnf(data: {
                      "datePrev": datePrev2.toString(),
                      "idVaccin": idVaccin2,
                    }).then((value) {
                      return true;
                    })
                  : i == 2
                      ? DataInsert.getInstance.addCalEnf(data: {
                          "datePrev": datePrev3.toString(),
                          "idVaccin": idVaccin3,
                        }).then((value) {
                          return true;
                        })
                      : i == 3
                          ? DataInsert.getInstance.addCalEnf(data: {
                              "datePrev": datePrev4.toString(),
                              "idVaccin": idVaccin4,
                            }).then((value) {
                              return true;
                            })
                          : null;
        }
      } else if ((joursEnf > 42) && (joursEnf < 70)) {
        for (var i = 0; i < 3; i++) {
          i == 0
              ? DataInsert.getInstance.addCalEnf(data: {
                  "datePrev": datePrev2.toString(),
                  "idVaccin": idVaccin2,
                }).then((value) {
                  return true;
                })
              : i == 1
                  ? DataInsert.getInstance.addCalEnf(data: {
                      "datePrev": datePrev3.toString(),
                      "idVaccin": idVaccin3,
                    }).then((value) {
                      return true;
                    })
                  : i == 2
                      ? DataInsert.getInstance.addCalEnf(data: {
                          "datePrev": datePrev4.toString(),
                          "idVaccin": idVaccin4,
                        }).then((value) {
                          return true;
                        })
                      : null;
        }
      } else if ((joursEnf > 70) && (joursEnf < 98)) {
        for (var i = 0; i < 2; i++) {
          i == 0
              ? DataInsert.getInstance.addCalEnf(data: {
                  "datePrev": datePrev3.toString(),
                  "idVaccin": idVaccin3,
                }).then((value) {
                  return true;
                })
              : i == 1
                  ? DataInsert.getInstance.addCalEnf(data: {
                      "datePrev": datePrev4.toString(),
                      "idVaccin": idVaccin4,
                    }).then((value) {
                      return true;
                    })
                  : null;
        }
      } else if ((joursEnf > 98) && (joursEnf < 270)) {
        DataInsert.getInstance.addCalEnf(data: {
          "datePrev": datePrev4.toString(),
          "idVaccin": idVaccin4,
        }).then((value) {
          return true;
        });
      }
    });
  }

  Future<bool> initDateCal() async {
    // ignore: await_only_futures
    findDateAndVacc();
    // await DataInsert.getInstance.addCalEnf(data: {
    //   "datePrev": datePrev.toString(),
    //   "idVaccin": idVaccin // Il faut revoir ici pour trouver l'id
    // }).then((value) {
    //   return true;
    // });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelGestion(
          label: "Gestion des enfants",
          message: "Nouvel enfant",
          onPress: () {
            _showDialogEnfant(context);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 300,
            child: SingleChildScrollView(
                child: TableDataEnfant(
              data: enfants,
              titreTable: "Liste des enfants",
            ))),
        SizedBox(
          height: 10,
        ),
        LabelGestion(
          label: "Gestion des mères",
          message: "Nouveau mère",
          onPress: () {
            _showDialogMere(context);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 300,
            child: SingleChildScrollView(
                child: TableData(
              data: meres,
              titreTable: "Liste des mères",
            ))),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _showDialogEnfant(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'AJOUTER ENFANT',
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
                              list: isList(value: ["Féminin", "Masculin"]),
                              onChanged: (val) {
                                sexe = val;
                              })),
                      TextFormField(
                        controller: poids,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Poids',
                          hintText: "Poids",
                          icon: Icon(Icons.accessibility_new_outlined),
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
                              list: isList(value: Constantes.listMere),
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
              RaisedButton(
                child: Text(
                  "Enregistrer",
                  style: TextStyle(color: light),
                ),
                onPressed: () async {
                  await initData().then((value) {
                    value = true;
                    if (value) {
                      setState(() {
                        initDateCal();
                      });
                    }
                  });
                },
                color: active,
              )
            ],
          );
        });
  }

  _showDialogMere(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'AJOUTER MERE',
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
                          icon: Icon(Icons.accessibility_new_outlined),
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
                      TextFormField(
                        controller: pw2,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Confirmer',
                          hintText: "Confirmer mdp",
                          icon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "PREPARATION DU CALENDRIER",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      PrepareCal(),
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
                  initDataMere();
                },
                color: active,
              )
            ],
          );
        });
  }

  initDate(context) async {
    selectedDate = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2050)))!;
    if (selectedDate != null)
      dateNaisse.text = selectedDate.toString().substring(0, 10);
    date.text = selectedDate.toString().substring(0, 10);
  }

  findDateAndVaccMere() {
    setState(() {
      jours = dateNow.difference(selectedDate2).inDays;
      dateformatted = formatter.format(dateNow);
      print(jours);

      if (Doses.doses == 0) {
        datePrevue = formatter.format(dateNow.add(const Duration(days: 2)));
        idVAT = 1;
      } else if (Doses.doses == 1) {
        if (dateformatted == Doses.date.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 30)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 30) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (30 - jours))));
        }
        idVAT = 2;
      } else if (Doses.doses == 2) {
        if (dateformatted == Doses.date.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 180)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 180) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (180 - jours))));
        }
        idVAT = 3;
      } else if (Doses.doses == 3) {
        if (dateformatted == Doses.date.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 365)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 365) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (365 - jours))));
        }
        idVAT = 4;
      } else if (Doses.doses == 4) {
        if (dateformatted == Doses.date.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 365)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 365) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (365 - jours))));
        }
        idVAT = 5;
      }
    });
  }
}
