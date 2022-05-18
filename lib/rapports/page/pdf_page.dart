import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/main.dart';
import 'package:v_connect_web/rapports/abandons_pev.dart';
import 'package:v_connect_web/rapports/enfant_2_dates.dart';
import 'package:v_connect_web/rapports/enfant_mois.dart';
import 'package:v_connect_web/rapports/enfant_vaccin.dart';
import 'package:v_connect_web/rapports/enfants_all.dart';
import 'package:v_connect_web/rapports/mere_2_dates.dart';
import 'package:v_connect_web/rapports/mere_mois.dart';
import 'package:v_connect_web/rapports/widget/button_widget.dart';
import 'package:v_connect_web/rapports/widget/title_widget.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  void initState() {
    super.initState();
    getVaccins();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            MyApp.title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              children: [
                TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Rapports vaccinaux',
                ),
                Center(
                  child: Container(
                    width: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 48),
                        ButtonWidget(
                          text: 'Enfants vaccinés ce mois',
                          onClicked: () async {
                            _showDialog(context);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonWidget(
                          text: 'Mères vaccinés ce mois',
                          onClicked: () async {
                            _showDialogMere(context);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonWidget(
                          text: 'Vaccination enfants du... au ...',
                          onClicked: () async {
                            _showDialog2dates(context);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonWidget(
                          text: 'Vaccination mères du... au ...',
                          onClicked: () async {
                            _showDialog2datesMere(context);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonWidget(
                          text: 'Enfants vaccinés par vaccin',
                          onClicked: () async {
                            _showDialogVaccins(context);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonWidget(
                          text: 'Abandons au PEV de routine',
                          onClicked: () async {
                            _showDialogAbandon(context);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonWidget(
                          text: 'Tous les enfants enregistrés',
                          onClicked: () async {
                            _showDialogEnfAll(context);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonWidget(
                          text: 'Toutes les mères enregistrées',
                          onClicked: () async {
                            _showDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  _showDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              "PRODUCTION RAPPORT",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.cyan.shade100,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Container(
                  width: 200,
                  child: RapportEnfantMois(),
                ),
              ),
            ),
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
              "PRODUCTION RAPPORT",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.cyan.shade100,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Container(
                  width: 200,
                  child: RapportMereMois(),
                ),
              ),
            ),
          );
        });
  }

  _showDialogAbandon(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              "PRODUCTION RAPPORT",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.cyan.shade100,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Container(
                  width: 200,
                  child: AbandonsPev(),
                ),
              ),
            ),
          );
        });
  }

  _showDialogEnfAll(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              "PRODUCTION RAPPORT",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.cyan.shade100,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Container(
                  width: 200,
                  child: EnfantsAll(),
                ),
              ),
            ),
          );
        });
  }

  _showDialog2dates(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              "PRODUCTION RAPPORT",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.cyan.shade100,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Date de début",
                        icon: Icon(Icons.calendar_today, color: Colors.black),
                      ),
                      controller: ControllersDates.date1,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          initDate();
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Date de fin",
                        icon: Icon(Icons.calendar_today, color: Colors.black),
                      ),
                      controller: ControllersDates.date2,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          initDate2();
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 400,
                      child: RapportEnfants2Dates(),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _showDialog2datesMere(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              "PRODUCTION RAPPORT",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.cyan.shade100,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Date de début",
                        icon: Icon(Icons.calendar_today, color: Colors.black),
                      ),
                      controller: ControllersDates.date1,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          initDate();
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Date de fin",
                        icon: Icon(Icons.calendar_today, color: Colors.black),
                      ),
                      controller: ControllersDates.date2,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          initDate2();
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 400,
                      child: RapportMeres2Dates(),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  DateTime selectedDate2 = DateTime.now();
  initDate() async {
    selectedDate2 = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2050)))!;
    if (selectedDate2 != null)
      setState(() {
        ControllersDates.date1.text = selectedDate2.toString().substring(0, 10);
      });
  }

  initDate2() async {
    selectedDate2 = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2050)))!;
    if (selectedDate2 != null)
      setState(() {
        ControllersDates.date2.text = selectedDate2.toString().substring(0, 10);
      });
  }

  List<String> vaccins = <String>[];

  Future<void> getVaccins() async {
    await DataSource.getInstance.getHop(
        params: {"event": "FIND_VACCIN_FORMAL"}, donne: "vacc").then((value) {
      setState(() {
        vaccins = value;
      });
    });
  }

  _showDialogVaccins(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              "PRODUCTION RAPPORT",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.cyan.shade100,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: cbList(
                            title: "vaccins",
                            list: isList(value: vaccins),
                            onChanged: (val) {
                              ControllersDates.vacc = val;
                              ControllersDates.indexOfM =
                                  ControllersDates.vacc.toString().indexOf('-');
                            })),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 400,
                      child: EnfantsVaccin(),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class ControllersDates {
  static TextEditingController date1 = TextEditingController();
  static TextEditingController date2 = TextEditingController();
  static var vacc;
  static var indexOfM;
}
