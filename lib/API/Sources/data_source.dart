import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:v_connect_web/constants/constantes_class.dart';

class DataSource extends GetxController {
  static DataSource _instance = DataSource();

  static DataSource get getInstance {
    return _instance == null ? _instance = DataSource() : _instance;
  }

  getHop({required Map<String, dynamic> params, donne}) async {
    List element = <String>[];
    final response = await http.post(
      Uri.parse("${URL}selectHop.php"),
      body: params,
    );
    var resultat = await jsonDecode(response.body);
    for (int index = 0; index < resultat.length; index++) {
      element.add(resultat[index][donne]);
    }
    return element;
  }

  Future<List<dynamic>> getCurrentData(
      {required Map<dynamic, String> params}) async {
    List<dynamic> data = <dynamic>[];
    final response =
        await http.post(Uri.parse("${URL}selectHop.php"), body: params);
    var resultat = await jsonDecode(response.body);
    for (int i = 0; i < resultat.length; i++) {
      data.add(resultat[i]);
    }
    return data;
  }
}
