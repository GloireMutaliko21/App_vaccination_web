import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:v_connect_web/API/Adds/adds.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/pages/agents/widgets/table.dart';
import 'package:v_connect_web/pages/overview/widgets/labelGestion.dart';
import 'package:get/get.dart';

class AgentsTables extends StatefulWidget {
  const AgentsTables({Key? key}) : super(key: key);

  @override
  _AgentsTablesState createState() => _AgentsTablesState();
}

class _AgentsTablesState extends State<AgentsTables> {
  Future<void> getHopital() async {
    await DataSource.getInstance.getHop(
        params: {"event": "FIND_HOPITAL"}, donne: "hopital").then((value) {
      setState(() {
        Constantes.listHopital = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getHopital();
    getAgentTout();
  }

  List agent = <dynamic>[];

  Future<void> getAgentTout() async {
    await DataSource.getInstance
        .getCurrentData(params: {"event": "FIND_AGENT"}).then((data) {
      if (mounted)
        setState(() {
          agent = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelGestion(
          label: "Gestion des agents",
          message: "Nouvel Agent",
          onPress: () {
            _showDialogAgent(context);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: isLoad
              ? Container(
                  width: 60,
                  height: 60,
                  color: active,
                  child: Center(
                    child: SpinKitChasingDots(
                      color: Colors.white,
                    ),
                  ),
                )
              : TableDataAgent(
                  data: agent,
                  //titreTable: "Liste des hôpitaux",
                ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  TextEditingController nom = new TextEditingController();

  TextEditingController numT = new TextEditingController();

  TextEditingController adresse = new TextEditingController();

  var hop;

  bool isLoad = false;
  void initData() async {
    setState(() {
      isLoad = true;
    });
    await DataInsert.getInstance.register(data: {
      "nomsAgent": nom.text,
      "numTel": numT.text,
      "adresse": adresse.text,
      // "loginAg": nom.text,
      // "pwAg": numT.text,
      "idHopital": hop.substring(0, 1),
    }).then((value) {
      print(value);
      setState(() {
        isLoad = false;
      });
    });
    isLoad = false;
  }

  _showDialogAgent(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              "S'ENREGISTRER",
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
                        validator: (x) =>
                            x!.isNotEmpty ? null : "Saisissez votre nom",
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Nom complet',
                            hintText: "Votre nom",
                            icon: Icon(
                              Icons.person,
                              color: Colors.brown,
                            )),
                      ),
                      TextFormField(
                        controller: numT,
                        validator: (x) =>
                            x!.isNotEmpty ? null : "Saisissez votre numéro",
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Numéro de téléphone',
                          hintText: "+243 998979669",
                          icon: Icon(
                            Icons.phone_callback_rounded,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: adresse,
                        validator: (x) =>
                            x!.isNotEmpty ? null : "Saisissez votre adresse",
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Adresse locale',
                          hintText: "Av. Mbaki/Ndendere/Ibanda",
                          icon: Icon(
                            Icons.home_work_outlined,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      Container(
                          child: cbList(
                              title: "Votre hôpital",
                              list: isList(value: Constantes.listHopital.obs),
                              onChanged: (val) {
                                hop = val;
                              })),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              RaisedButton(
                child: isLoad
                    ? Container(
                        width: 60,
                        height: 60,
                        color: active,
                        child: Center(
                          child: SpinKitChasingDots(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        "Enregistrer",
                        style: TextStyle(color: light),
                      ),
                onPressed: () {
                  // your code

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
