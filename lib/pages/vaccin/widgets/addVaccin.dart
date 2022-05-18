import 'package:flutter/material.dart';

class AddVaccin extends StatelessWidget {
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
                labelText: 'Nom vaccin',
                hintText: "Ex. VPOb 0",
                icon: Icon(
                  Icons.medical_services_rounded,
                )),
          ),
          TextFormField(
            controller: age,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'Age concerné',
                hintText: "Ex. A la naissance",
                icon: Icon(Icons.calendar_today)),
          ),
        ],
      ),
    );
  }
}
