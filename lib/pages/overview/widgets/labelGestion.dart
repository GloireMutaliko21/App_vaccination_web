import 'package:flutter/material.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class LabelGestion extends StatelessWidget {
  final label;
  final message;
  final onPress;
  const LabelGestion({Key? key, this.label, this.message, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 450,
        ),
        CustomText(
            text: label,
            size: 18,
            color: Colors.green,
            weight: FontWeight.bold),
        SizedBox(
          width: 420,
        ),
        Tooltip(
          message: message,
          textStyle: TextStyle(
              fontSize: 18, color: active, backgroundColor: Colors.white),
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.red,
              size: 24,
            ),
            onPressed: onPress,
          ),
        ),
      ],
    );
  }

  _showDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'Login',
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        icon: Icon(Icons.account_box),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Message',
                        icon: Icon(Icons.message),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    // your code
                  })
            ],
          );
        });
  }
}
