import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/helpers/responsiveness.dart';
import 'package:v_connect_web/layout_admin.dart';
import 'package:v_connect_web/pages/agents/agents.dart';
import 'package:v_connect_web/pages/authentification/authentification.dart';
import 'package:v_connect_web/pages/hopitaux/hopitaux.dart';
import 'package:v_connect_web/pages/vaccin/vaccin.dart';
import 'package:v_connect_web/rapports/page/pdf_page_admin.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

TextEditingController nom =
    new TextEditingController(text: MyPreferences.nomsAgent);

TextEditingController numT =
    new TextEditingController(text: MyPreferences.numTel);

TextEditingController adresse =
    new TextEditingController(text: MyPreferences.adresse);

TextEditingController login =
    new TextEditingController(text: MyPreferences.loginAg);

TextEditingController pw = new TextEditingController(text: MyPreferences.pwAg);

AppBar topNavigationBarAdmin(
        BuildContext context, GlobalKey<ScaffoldState> key) =>
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
            text: "vConnect - Espace Admin",
            color: Colors.brown,
            size: 20,
            weight: FontWeight.bold,
          )),
          Expanded(child: Container()),
          IconButton(
            icon: Icon(
              Icons.home,
              color: active,
              // size: 18,
            ),
            onPressed: () {
              // Get.offAll(() => HopitauxPage());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (builder) => SiteLayoutAdmin(),
                ),
                (route) => false,
              );
            },
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          SizedBox(
            width: 10,
          ),
          TextButton(
            onPressed: () {
              // Get.offAll(() => HopitauxPage());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (builder) => HopitauxPage(),
                ),
                (route) => false,
              );
            },
            child: Text(
              "Gestion des hôpitaux",
              style: TextStyle(
                color: active,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          SizedBox(
            width: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (builder) => AgentsPage(),
                ),
                (route) => false,
              );
            },
            child: Text(
              "Gestion des agents",
              style: TextStyle(
                color: active,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          SizedBox(
            width: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (builder) => VaccinPage(),
                ),
                (route) => false,
              );
            },
            child: Text(
              "Gestion des vaccins",
              style: TextStyle(
                color: active,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          SizedBox(
            width: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (builder) => PdfPageAdmin(),
                ),
                (route) => false,
              );
            },
            child: Text(
              "Visualisations",
              style: TextStyle(
                color: active,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                Get.offAll(() => AuthentificationPage());
              },
              icon: Icon(
                Icons.logout,
                color: dark.withOpacity(.7),
              )),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          SizedBox(
            width: 10,
          ),
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
                            onPressed: () {
                              // your code

                              // setState(() {
                              //   initData();
                              // });
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
        ],
      ),
      iconTheme: IconThemeData(color: dark),
      backgroundColor: Colors.white,
    );
