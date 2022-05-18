import 'package:flutter/material.dart';
import 'package:v_connect_web/constants/style.dart';
// import 'package:v_connect_web/pages/overview/widgets/bar_chart.dart';
import 'package:v_connect_web/pages/overview/widgets/charts.dart';
import 'package:v_connect_web/pages/overview/widgets/revenue_info.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class RevenueSectionLarge extends StatelessWidget {
  final int done1;
  final int done2;
  final int done3;
  final int done4;
  const RevenueSectionLarge(
      {Key? key,
      required this.done1,
      required this.done2,
      required this.done3,
      required this.done4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              // color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(
        children: [
          Text(
            "Nombre des vaccinés",
            style: TextStyle(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Historique vaccination derniers mois",
                  size: 22,
                  weight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
                Container(width: 400, height: 250, child: ChartsData()),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    RevenueInfo(
                      title: "Enfants non vaccinés",
                      amount: "${done1}",
                    ),
                    RevenueInfo(
                      title: "Mères non vaccinées",
                      amount: "${done2}",
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    RevenueInfo(
                      title: "Enfants vaccinés le mois passé",
                      amount: "${done3}",
                    ),
                    RevenueInfo(
                      title: "Mères vaccinées le mois passé",
                      amount: "${done4}",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
