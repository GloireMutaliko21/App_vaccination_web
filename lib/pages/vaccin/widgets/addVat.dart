import 'package:flutter/material.dart';

class AddVAT extends StatelessWidget {
  TextEditingController nom = new TextEditingController();
  TextEditingController age = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: nom,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Période vaccination',
                hintText: "Ex. 1 mois après VAT 1",
                icon: Icon(
                  Icons.calendar_today,
                )),
          ),
          TextFormField(
            controller: age,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'Durée de protection',
                hintText: "Ex. 3 ans",
                icon: Icon(Icons.security)),
          ),
        ],
      ),
    );
  }
}
