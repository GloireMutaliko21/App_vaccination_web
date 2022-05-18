import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  static MyPreferences _myPreferences = new MyPreferences();

  static String idAgent = "";
  static String idHopital = "";
  static String nomsAgent = "";
  static String numTel = "";
  static String adresse = "";
  static String loginAg = "";
  static String pwAg = "";

  static MyPreferences get getInit {
    return _myPreferences == null
        ? _myPreferences = MyPreferences()
        : _myPreferences;
  }

  Future<bool> setPresistence(var data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("idAgent", data[0]['idAgent']);
    preferences.setString("idHopital", data[0]['idHopital']);
    preferences.setString("nomsAgent", data[0]['nomsAgent']);
    preferences.setString("numTel", data[0]['numTel']);
    preferences.setString("adresse", data[0]['adresse']);
    preferences.setString("loginAg", data[0]['loginAg']);
    preferences.setString("pwAg", data[0]['pwAg']);
    return preferences.setString("idHopital", data[0]['idHopital']);
  }

  Future<void> getPresistence() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idAgent = preferences.getString("idAgent")!;
    idHopital = preferences.getString("idHopital")!;
    nomsAgent = preferences.getString("nomsAgent")!;
    numTel = preferences.getString("numTel")!;
    adresse = preferences.getString("adresse")!;
    loginAg = preferences.getString("loginAg")!;
    pwAg = preferences.getString("pwAg")!;
  }
}
