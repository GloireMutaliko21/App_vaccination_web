import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Adds/updates.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/helpers/responsiveness.dart';
import 'package:v_connect_web/widgets/custom_text.dart';
import 'package:http/http.dart' as http;

TextEditingController nom =
    new TextEditingController(text: MyPreferences.nomsAgent);

TextEditingController numT =
    new TextEditingController(text: MyPreferences.numTel);

TextEditingController adresse =
    new TextEditingController(text: MyPreferences.adresse);

TextEditingController login =
    new TextEditingController(text: MyPreferences.loginAg);

TextEditingController pw = new TextEditingController(text: MyPreferences.pwAg);

void vider() {
  nom.text = "";
  numT.text = "";
  adresse.text = "";
  login.text = "";
  pw.text = "";
}

notifier() async {
  try {
    final response = await http.post(
      Uri.parse("http://172.20.10.3/vConnectMobile/api_controller.php"),
    );
    if (response.statusCode == 200) {
      var resultat = await jsonDecode(response.body);
      print(resultat);
    }
  } on SocketException catch (_) {}
  return null;
}

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 14),
                  child: Image.asset(
                    "assets/icons/logo.png",
                    width: 28,
                  ),
                )
              ],
            )
          : IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                key.currentState!.openDrawer();
              },
            ),
      elevation: 0,
      title: Row(
        children: [
          Visibility(
              child: CustomText(
            text: "vConnect",
            color: Colors.brown,
            size: 20,
            weight: FontWeight.bold,
          )),
          Expanded(child: Container()),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Text(
                          "MON COMPTE",
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
                                    initialValue: MyPreferences.idAgent,
                                    decoration: InputDecoration(
                                        enabled: false,
                                        labelText: 'Mon identifiant',
                                        icon: Icon(
                                          Icons.security,
                                          color: Colors.brown,
                                        )),
                                  ),
                                  TextFormField(
                                    controller: nom,
                                    validator: (x) => x!.isNotEmpty
                                        ? null
                                        : "Saisissez votre nom",
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
                                    validator: (x) => x!.isNotEmpty
                                        ? null
                                        : "Saisissez votre numéro",
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
                                    validator: (x) => x!.isNotEmpty
                                        ? null
                                        : "Saisissez votre adresse",
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
                                  TextFormField(
                                    controller: login,
                                    validator: (x) => x!.isNotEmpty
                                        ? null
                                        : "Saisissez votre login",
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'User name',
                                      hintText: "Ex. Salva21",
                                      icon: Icon(
                                        Icons.person_pin,
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    controller: pw,
                                    validator: (x) => x!.isNotEmpty
                                        ? null
                                        : "Saisissez votre mot de passe",
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'mot de passe',
                                      hintText: "*************",
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.brown,
                                      ),
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
                              "Modifier",
                              style: TextStyle(color: light),
                            ),
                            onPressed: () async {
                              await DataUpdate.getInstance.modifAg(data: {
                                "idAgent": MyPreferences.idAgent,
                                "nomsAgent": nom.text,
                                "numTel": numT.text,
                                "adresse": adresse.text,
                                "loginAg": login.text,
                                "pwAg": pw.text,
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
              },
              icon: Icon(
                Icons.settings,
                color: dark.withOpacity(.7),
              )),
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text(
                              "Envoi des notifications",
                              textAlign: TextAlign.center,
                            ),
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                child: Container(
                                  width: 400,
                                  child: Column(
                                    children: <Widget>[],
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              RaisedButton(
                                child: Text(
                                  "Envoyer",
                                  style: TextStyle(color: light),
                                ),
                                onPressed: () async {
                                  await notifier();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content:
                                              Text("Notifications envoyées"),
                                        );
                                      });
                                },
                                color: active,
                              )
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.notifications, color: dark.withOpacity(.7))),
              Positioned(
                  top: 7,
                  right: 7,
                  child: Container(
                    width: 12,
                    height: 12,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: active,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: light, width: 2)),
                  ))
            ],
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          SizedBox(
            width: 24,
          ),
          CustomText(
              text: "${MyPreferences.nomsAgent}",
              size: 16,
              color: lightGrey,
              weight: FontWeight.normal),
          SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: light,
                child: Icon(
                  Icons.person_outline,
                  color: dark,
                ),
              ),
            ),
          )
        ],
      ),
      iconTheme: IconThemeData(color: dark),
      backgroundColor: Colors.white,
    );
