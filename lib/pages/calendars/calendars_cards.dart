import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/pages/calendars/info_card.dart';

class CalendarsCards extends StatefulWidget {
  const CalendarsCards({Key? key}) : super(key: key);

  @override
  _CalendarsCardsState createState() => _CalendarsCardsState();
}

class _CalendarsCardsState extends State<CalendarsCards> {
  List agent = <dynamic>[];
  // Future<void> getCal() async {
  //   await DataSource.getInstance.getCurrentData(params: {
  //     "event": "CALENDARS",
  //     "idHopital": MyPreferences.idHopital
  //   }).then((value) {
  //     setState(() {
  //       agent = value;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getCal();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Column(
        children: [
          Row(
            children: [
              InfoCard(
                title: "${DateTime.now().toString().substring(0, 10)}",
                value: "${DateTime.now().toString().substring(0, 10)}",
                topColor: Colors.orange,
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title:
                    "${DateTime.now().add(const Duration(days: 1)).toString().substring(0, 10)}",
                value:
                    "${DateTime.now().add(const Duration(days: 1)).toString().substring(0, 10)}",
                topColor: Colors.lightGreen,
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title:
                    "${DateTime.now().add(const Duration(days: 2)).toString().substring(0, 10)}",
                value:
                    "${DateTime.now().add(const Duration(days: 2)).toString().substring(0, 10)}",
                topColor: Colors.redAccent,
              ),
            ],
          ),
          SizedBox(
            height: _width / 64,
          ),
          Row(
            children: [
              InfoCard(
                title:
                    "${DateTime.now().add(const Duration(days: 3)).toString().substring(0, 10)}",
                value:
                    "${DateTime.now().add(const Duration(days: 3)).toString().substring(0, 10)}",
                topColor: Colors.orange,
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title:
                    "${DateTime.now().add(const Duration(days: 4)).toString().substring(0, 10)}",
                value:
                    "${DateTime.now().add(const Duration(days: 4)).toString().substring(0, 10)}",
                topColor: Colors.lightGreen,
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title:
                    "${DateTime.now().add(const Duration(days: 5)).toString().substring(0, 10)}",
                value:
                    "${DateTime.now().add(const Duration(days: 5)).toString().substring(0, 10)}",
                topColor: Colors.redAccent,
              ),
            ],
          ),
          SizedBox(
            height: _width / 64,
          ),
          Row(
            children: [
              InfoCard(
                title:
                    "${DateTime.now().add(const Duration(days: 6)).toString().substring(0, 10)}",
                value:
                    "${DateTime.now().add(const Duration(days: 6)).toString().substring(0, 10)}",
                topColor: Colors.orange,
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title:
                    "${DateTime.now().add(const Duration(days: 7)).toString().substring(0, 10)}",
                value:
                    "${DateTime.now().add(const Duration(days: 7)).toString().substring(0, 10)}",
                topColor: Colors.lightGreen,
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title:
                    "${DateTime.now().add(const Duration(days: 8)).toString().substring(0, 10)}",
                value:
                    "${DateTime.now().add(const Duration(days: 8)).toString().substring(0, 10)}",
                topColor: Colors.redAccent,
              ),
            ],
          ),
          SizedBox(
            height: _width / 64,
          ),
          Row(
            children: [
              InfoCard(
                title:
                    "${DateTime.now().add(const Duration(days: 9)).toString().substring(0, 10)}",
                value:
                    "${DateTime.now().add(const Duration(days: 9)).toString().substring(0, 10)}",
                topColor: Colors.orange,
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title:
                    "${DateTime.now().add(const Duration(days: 10)).toString().substring(0, 10)}",
                value:
                    "${DateTime.now().add(const Duration(days: 10)).toString().substring(0, 10)}",
                topColor: Colors.lightGreen,
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title:
                    "${DateTime.now().add(const Duration(days: 11)).toString().substring(0, 10)}",
                value:
                    "${DateTime.now().add(const Duration(days: 11)).toString().substring(0, 10)}",
                topColor: Colors.redAccent,
              ),
              SizedBox(
                width: _width / 64,
              ),
            ],
          ),
          SizedBox(
            height: _width / 64,
          ),
        ],
      ))),
    );
  }
}
