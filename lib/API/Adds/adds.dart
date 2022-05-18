import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/layout.dart';
import 'package:v_connect_web/layout_admin.dart';

class DataInsert extends GetxController {
  static DataInsert _instance = DataInsert();

  static DataInsert get getInstance {
    return _instance == null ? _instance = DataInsert() : _instance;
  }

//==============================================================================
//==============================================================================
//++++++++++++++++++++++ ENREGISTREMENT DE L'AGENT++++++++++++++++++++++++++++++

  Future<String?> register({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}Enregistrer.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});

        AlertDialog(
          scrollable: true,
          title: Text(
            "S'ENREGISTRER",
            textAlign: TextAlign.center,
          ),
        );
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }

//==============================================================================
//==============================================================================
//++++++++++++ ENREGISTREMENT DE L'ENFANT ET SON CALENDRIER ++++++++++++++++++

  Future<String?> addEnfant({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}AddEnfant.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});

        AlertDialog(
          scrollable: true,
          title: Text(
            "S'ENREGISTRER",
            textAlign: TextAlign.center,
          ),
        );
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }

  Future<String?> addCalEnf({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}AddCal.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});

        AlertDialog(
          scrollable: true,
          title: Text(
            "S'ENREGISTRER",
            textAlign: TextAlign.center,
          ),
        );
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }

  //==============================================================================
//==============================================================================
//++++++++++++++++++++++ ENREGISTREMENT DE LA MERE ET SON CALENDRIER++++++++++++++++++++++++++++++
// ============================== CALENDRIER DANS LE FICHIER PHP

  Future<String?> addMere({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}AddMere.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }

//==============================================================================
//==============================================================================
//++++++++++++++++++++++ ENREGISTREMENT DE L'HOPITAL++++++++++++++++++++++++++++++

  Future<String?> addHop({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}AddHop.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }
//==============================================================================
//==============================================================================
//++++++++++++++++++++++ ENREGISTREMENT D'UN CONSEIL'++++++++++++++++++++++++++++++

  Future<String?> addConseil({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}AddConseil.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }

//==============================================================================
//==============================================================================
//++++++++++++++++++++++ METHODES DE CONNEXION AU SYSTEME++++++++++++++++++++++++++++++

  login({var data}) async {
    try {
      // final response =
      //     await http.post(Uri.parse("${URL}Login.php"), body: jsonEncode(data));
      final response2 =
          await Dio().post("${URL}Login.php", data: jsonEncode(data));

      if (response2.statusCode == 200) {
        var resultat = await jsonDecode(response2.data);
        await MyPreferences.getInit.setPresistence(resultat);
        resultat.forEach((data) => {print("Connecté")});
        if (resultat.length > 0) {
          Get.offAll(() => SiteLayout());
        } else {
          ScaffoldMessenger(child: Text("Echec de login"));
        }
      } else {
        ScaffoldMessenger(child: Text("Echec de login 2"));
      }
    } catch (_) {
      ScaffoldMessenger(child: Text("Echec de login 3"));
    }
  }

  loginAdmin({var data}) async {
    try {
      final response2 =
          await Dio().post("${URL}LoginAdmin.php", data: jsonEncode(data));

      if (response2.statusCode == 200) {
        var resultat = await jsonDecode(response2.data);
        // await MyPreferences.getInit.setPresistence(resultat);
        resultat.forEach((data) => {print("Connecté")});
        if (resultat.length > 0) {
          Get.offAll(() => SiteLayoutAdmin());
        } else {
          ScaffoldMessenger(child: Text("Echec de login"));
        }
      } else {
        ScaffoldMessenger(child: Text("Echec de login 2"));
      }
    } catch (_) {
      ScaffoldMessenger(child: Text("Echec de login 3"));
    }
  }

//==============================================================================
//==============================================================================
// AJOUT DE LA VACCIBATION DES ENFANTS, AJUSTEMENT DES CALENDRIER ET ANNULATION DU PRECEDENT

  Future<String?> addRegistre({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}RegistreVacc.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }

  Future<String?> addCalSuiv({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}AddCalSuiv.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }

  Future<String?> modifCal({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}ModifCalEnf.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }

// +++++++++++ FIN VACCINATION ENFANT ET AJUSTEMENT DE SES CALENDRIERS ++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//==============================================================================
//==============================================================================
// AJOUT DE LA VACCIBATION DES FEMMES, AJUSTEMENT DES CALENDRIER ET ANNULATION DU PRECEDENT

  Future<String?> addRegistreVat({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}RegistreVat.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }

  Future<String?> addCalVatSuiv({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}AddCalVatSuiv.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }

  Future<String?> modifCalVat({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}ModifCalVat.php"),
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var resultat = await jsonDecode(response.body);
        resultat.forEach((data) => {print(data)});
      } else {}
    } catch (_) {
      print("=======================${_.toString()}");
    }
    return null;
  }

  // +++++++++++ FIN VACCINATION MERE ET AJUSTEMENT DE SES CALENDRIERS ++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
}
