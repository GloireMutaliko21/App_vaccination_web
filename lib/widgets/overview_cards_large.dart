import 'package:flutter/material.dart';
import 'package:v_connect_web/pages/overview/widgets/info_card.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  final title;
  final title2;
  final title3;
  final title4;
  final int done1;
  final int done2;
  final int doneECV;
  final int done3;
  const OverviewCardsLargeScreen(
      {Key? key,
      this.title,
      this.title2,
      this.title3,
      this.title4,
      required this.done1,
      required this.done2,
      required this.done3,
      required this.doneECV})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            InfoCard(
              title: title,
              value: "${done1}",
              onTap: () {},
              topColor: Colors.orange,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: title2,
              value: "${done2}",
              topColor: Colors.lightGreen,
              onTap: () {},
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: title3,
              value: "${doneECV}",
              topColor: Colors.redAccent,
              onTap: () {},
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: title4,
              value: "${done3}",
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
