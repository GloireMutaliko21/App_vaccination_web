import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:v_connect_web/constants/constantes_class.dart';

class DataUpdate extends GetxController {
  static DataUpdate _instance = DataUpdate();

  static DataUpdate get getInstance {
    return _instance == null ? _instance = DataUpdate() : _instance;
  }

//==============================================================================
//==============================================================================
//++++++++++++++++++++++ MODIFIER L'ENFANT++++++++++++++++++++++++++++++

  Future<String?> modifEnf({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}ModifEnf.php"),
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
//++++++++++++++++++++++ MODIFIER LA MERE++++++++++++++++++++++++++++++

  Future<String?> modifMere({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}ModifMere.php"),
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
//++++++++++++++++++++++ MODIFIER HOPITAL ++++++++++++++++++++++++++++++

  Future<String?> modifHop({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}ModifHop.php"),
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
//++++++++++++++++++++++ MODIFIER HOPITAL ++++++++++++++++++++++++++++++

  Future<String?> modifAg({var data}) async {
    try {
      final response = await http.post(Uri.parse("${URL}ModifAgent.php"),
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
}
