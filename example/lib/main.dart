import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_to_widget/json_to_widget.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String form = json.encode({
    'fields': [
      {
        'key': 'input1',
        'type': 'Input',
        'label': 'Username',
        'placeholder': "Enter Your Username",
        'required': true
      },
      {
        'key': 'password1',
        'type': 'Password',
        'label': 'Password',
        'required': true
      },
    ]
  });

  dynamic response;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: JsonWidget(
          form: form,
          onChanged: (dynamic response) {
            this.response = response;
          }),
    );
  }
}
