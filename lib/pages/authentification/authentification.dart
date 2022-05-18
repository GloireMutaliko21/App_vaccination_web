import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v_connect_web/API/Adds/adds.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class AuthentificationPage extends StatefulWidget {
  @override
  _AuthentificationPageState createState() => _AuthentificationPageState();
}

class _AuthentificationPageState extends State<AuthentificationPage> {
  int status = 0;

  Future<void> initSession() async {
    await MyPreferences.getInit.getPresistence().then((value) {
      setState(() {
        status = ifExist;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // initSession();
  }

  int get ifExist {
    if (MyPreferences.idAgent != null) {
      return 1;
    } else {
      return 0;
    }
  }

  // Future<void> logOut() async {
  //   SharedPreferences p = await SharedPreferences.getInstance();
  //   setState(() {
  //     p.remove("idMere");
  //     status = 0;
  //     p.commit();
  //   });
  //   print(status);
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(
  //       builder: (builder) => LoginScreen(),
  //     ),
  //     (route) => false,
  //   );
  // }

  TextEditingController log = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  var choix;

  void vider() {
    log.clear();
    pass.clear();
  }

  bool isLoad = false;

  initData() async {
    setState(() {
      isLoad = true;
    });
    await DataInsert.getInstance.login(data: {
      "loginAg": log.text,
      "pwAg": pass.text,
    }).then((value) {
      initSession();
      print(value);
      setState(() {
        isLoad = false;
      });
    });
    isLoad = false;
  }

  initDataAdmin() async {
    setState(() {
      isLoad = true;
    });
    await DataInsert.getInstance.loginAdmin(data: {
      "loginA": log.text,
      "pwA": pass.text,
    }).then((value) {
      print(value);
      setState(() {
        isLoad = false;
      });
    });
    isLoad = false;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(width: 1, color: active)),
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 600),
          padding: EdgeInsets.all(24),
          child: Column(
            key: _formKey,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Connectez-vous ici",
                      style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade800)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(width: 270, height: 1, color: active),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Bienvenue dans vConnect",
                    color: lightGrey,
                    size: 16,
                    weight: FontWeight.normal,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: cbList(
                          title: "type user",
                          list: isList(value: ["", "Admin", "Agent"]),
                          onChanged: (val) {
                            choix = val;
                          })),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: log,
                validator: (x) {
                  if (x == null || x.isEmpty) {
                    return 'Saisissez votre login';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Login ou E-mail",
                    hintText: "abc@domain.com 0970101010",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                obscureText: true,
                controller: pass,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "ABCabc123",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      CustomText(
                        text: "Remeber Me",
                        color: Colors.black,
                        size: 16,
                        weight: FontWeight.normal,
                      ),
                    ],
                  ),
                  CustomText(
                    text: "                  Forgot password?",
                    color: active,
                    size: 16,
                    weight: FontWeight.normal,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  choix == "Agent"
                      ? initData()
                      : choix == "Admin"
                          ? initDataAdmin()
                          : ScaffoldMessenger(child: Text("Echec de login"));
                },
                child: isLoad
                    ? Container(
                        width: 60,
                        height: 60,
                        color: Colors.white,
                        child: Center(
                          child: SpinKitChasingDots(
                            color: active,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: active,
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CustomText(
                          text: "Login",
                          color: Colors.white,
                          weight: FontWeight.normal,
                          size: 16,
                        ),
                      ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: "       Vous n'avez pas de compte ?  "),
                  ])),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(
                        right: 0,
                      ),
                      child: Column(
                        children: [
                          CustomText(
                            text: " Inscrivez-vous",
                            color: active,
                            weight: FontWeight.normal,
                            size: 16,
                          ),
                          Container(
                            width: 100,
                            height: 1,
                            color: active,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
