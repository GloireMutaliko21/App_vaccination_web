import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/constants/style.dart';

class InfoCard extends StatefulWidget {
  final title;
  final value;
  final topColor;
  const InfoCard({
    Key? key,
    this.title,
    this.value,
    this.topColor,
  }) : super(key: key);

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  List list = <dynamic>[];
  Future<void> getCal() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "CALENDARS",
      "idHopital": MyPreferences.idHopital,
      "datePrev": widget.value.toString()
    }).then((value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCal();
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = list.length;
    var titre = widget.title;
    return Expanded(
      child: InkWell(
        child: Column(
          children: [
            Text(titre.toString()),
            Text(
              "Enfants attendus",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18, color: active, fontWeight: FontWeight.bold),
            ),
            Container(
                height: 136,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 6),
                          color: lightGrey.withOpacity(.1),
                          blurRadius: 12)
                    ],
                    borderRadius: BorderRadius.circular(8)),
                child: list.length < 1
                    ? Container()
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        itemCount: itemCount,
                        itemBuilder: (context, i) {
                          return Container(
                            color: Colors.green.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  minVerticalPadding: 1,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 6.0),
                                  subtitle: Text(
                                    "${list[i]['nom']} (Pour vaccin représenté ${list[i]['nomVaccin']})",
                                    style: TextStyle(
                                        color: Colors.brown[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                //   ],
                // ),
                ),
          ],
        ),
      ),
    );
  }
}
