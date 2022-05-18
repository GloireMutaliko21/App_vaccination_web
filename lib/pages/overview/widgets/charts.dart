import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:v_connect_web/constants/constantes_class.dart';
import 'package:v_connect_web/constants/style.dart';

class ChartsData extends StatefulWidget {
  const ChartsData({Key? key}) : super(key: key);

  @override
  _ChartsDataState createState() => _ChartsDataState();
}

class _ChartsDataState extends State<ChartsData> {
  List<Vaccin> fromJson(String strJson) {
    final data = jsonDecode(strJson);
    return List<Vaccin>.from(data.map((i) => Vaccin.fromMap(i)));
  }

  List<Vaccin> vaccins = [];

  Future<List<Vaccin>> getStat() async {
    List<Vaccin> list = [];
    final response = await http.get(Uri.parse("${URL}charts.php"));
    if (response.statusCode == 200) {
      list = fromJson(response.body);
    }
    return list;
  }

  static List<charts.Series<Vaccin, String>> chartData(List<Vaccin> data) {
    return [
      charts.Series<Vaccin, String>(
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(active.withOpacity(.9)),
          id: 'Vaccin',
          domainFn: (Vaccin v, _) => v.date,
          measureFn: (Vaccin v, _) => v.vaccin,
          data: data),
    ];
  }

  @override
  void initState() {
    getStat().then((value) => vaccins = value);
    print(vaccins);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      height: 400,
      child: charts.BarChart(
        chartData(vaccins),
        animate: true,
      ),
    )));
  }
}

class Vaccin {
  final date;
  final vaccin;

  Vaccin({this.date, this.vaccin});

  factory Vaccin.fromMap(Map<String, dynamic> map) {
    return Vaccin(date: map["dateVacc"], vaccin: int.parse(map["counte"]));
  }
}
