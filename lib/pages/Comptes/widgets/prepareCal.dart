import 'package:flutter/material.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/pages/Comptes/widgets/utils.dart';

class PrepareCal extends StatefulWidget {
  const PrepareCal({Key? key}) : super(key: key);

  @override
  _PrepareCalState createState() => _PrepareCalState();
}

class _PrepareCalState extends State<PrepareCal> {
  int indexTop = 0;
  late int nbreDoses;
  DateTime selectedDate2 = DateTime.now();
  var dateLastVat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: light,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(
              color: Colors.black,
            ),
            Text("Combien de doses avez-vous déjà réçu ?",
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 14,
                )),
            SizedBox(height: 8),
            buildSliderTopLabel(),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: 8),
            Text(
              """
    Ne sélectionner la date que si vous avez déjà réçu une ou plusieurs doses""",
              style: TextStyle(
                color: Colors.brown,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Date derniere dose",
                icon: Icon(Icons.calendar_today, color: Colors.black),
              ),
              controller: Doses.date,
              readOnly: true,
              onTap: () {
                setState(() {
                  initDate2();
                });
              },
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget buildSliderTopLabel() {
    final labels = ['0', '1', '2', '3', '4', '5'];
    final double min = 0;
    final double max = labels.length - 1.0;
    final divisions = labels.length - 1;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Utils.modelBuilder(
              labels,
              (index, label) {
                final selectedColor = Colors.indigo.shade900;
                final unselectedColor = Colors.indigo.withOpacity(0.6);
                final isSelected = index <= indexTop;
                final color = isSelected ? selectedColor : unselectedColor;

                return buildLabel(
                    label: label as String, color: color, width: 30);
              },
            ),
          ),
        ),
        Slider(
          value: indexTop.toDouble(),
          min: min,
          max: max,
          divisions: divisions,
          // label: labels[indexTop],
          onChanged: (value) => setState(() {
            this.indexTop = value.toInt();
            this.nbreDoses = indexTop;
            Doses.doses = indexTop;
          }),
        ),
      ],
    );
  }

  initDate2() async {
    selectedDate2 = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2050)))!;
    if (selectedDate2 != null)
      setState(() {
        dateLastVat.text = selectedDate2.toString().substring(0, 10);
        Doses.date.text = selectedDate2.toString().substring(0, 10);
      });
  }

  Widget buildLabel({
    required String label,
    required double width,
    required Color color,
  }) =>
      Container(
        width: width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ).copyWith(color: color),
        ),
      );
}

class Doses {
  static int doses = 0;
  static TextEditingController date = TextEditingController();
}
