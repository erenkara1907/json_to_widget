import 'dart:convert';

import 'package:flutter/material.dart';
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

  Map decorations = {
    'input1': InputDecoration(
        prefixIcon: Icon(Icons.account_box), border: OutlineInputBorder()),
    'password1': InputDecoration(
        prefixIcon: Icon(Icons.security), border: OutlineInputBorder())
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: <Widget>[
          const Text(
            "Login Form",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          JsonWidget(
            decorations: decorations,
            form: form,
            onChanged: (dynamic response) {
              this.response = response;
            },
            actionSave: (data) {
              print(data);
            },
            buttonSave: Container(
              height: 40.0,
              color: Colors.blueAccent,
              child: const Center(
                child: Text("Login",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
