library json_to_widget;

import 'dart:convert';
import 'package:flutter/material.dart';

import 'custom_decoration.dart';
import 'ron.dart';

class JsonFormObject extends StatefulWidget {
  const JsonFormObject({
    Key? key,
    required this.form,
    required this.onChanged,
    this.padding,
    this.formMap,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.buttonSave,
    this.actionSave,
  }) : super(key: key);

  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final String form;
  final Map? formMap;
  final double? padding;
  final Widget? buttonSave;
  final Function? actionSave;
  final ValueChanged<dynamic> onChanged;

  @override
  _CoreWidgetState createState() =>
      _CoreWidgetState(formMap ?? json.decode(form));
}

class _CoreWidgetState extends State<JsonFormObject> {
  final dynamic widgetGeneral;

  int? radioValue;

  // validators

  String? isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['key']] ?? 'Lütfen zorunlu alanları doldurunuz';
    }
  }

  String? validateEmail(item, String value) {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = RegExp(p);

    if (!regExp.hasMatch(value)) {
      return 'Email onaylı değil';
    }
  }

  bool labelHidden(item) {
    if (item.containsKey('hiddenLabel')) {
      if (item['hiddenLabel'] is bool) {
        return !item['hiddenLabel'];
      }
    } else {
      return true;
    }
    return false;
  }

  // Return widgets

  List<Widget> jsonToForm() {
    List<Widget> listWidget = <Widget>[];
    if (widgetGeneral['title'] != null) {
      listWidget.add(Text(
        widgetGeneral['title'],
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ));
    }
    if (widgetGeneral['description'] != null) {
      listWidget.add(Text(
        widgetGeneral['description'],
        style: const TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
      ));
    }

    for (var count = 0; count < widgetGeneral['fields'].length; count++) {
      Map item = widgetGeneral['fields'][count];

      if (item.containsKey('command')) {
        if (item['command'].runtimeType == String) {
          Ron().call(item['command'], []);
        } else {
          Ron().call(item['command']['function'], {
            'args': item['command']['args'],
            'result': item['command']['result']
          });
        }
      }

      if (item['type'] == "container") {
        listWidget.add(Container(
            margin: EdgeInsets.only(
                top: item['top'] ?? 1,
                bottom: item['bottom'] ?? 1,
                left: item['left'] ?? 1,
                right: item['right'] ?? 1),
            width: item['width'],
            height: item['height'],
            color: Color.fromRGBO(
                item['R'], item['G'], item['B'], item['Opacity']),
            child: item['child'] == "text"
                ? Center(
              child: Text(
                item['text'],
              ),
            )
                : null));
      }

      if (item['type'] == "Input" ||
          item['type'] == "Password" ||
          item['type'] == "Email" ||
          item['type'] == "TextArea" ||
          item['type'] == "TextInput") {
        Widget label = const SizedBox.shrink();
        if (labelHidden(item)) {
          label = Text(
            item['label'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          );
        }

        listWidget.add(Container(
          margin: const EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              label,
              TextFormField(
                controller: null,
                initialValue: widgetGeneral['fields'][count]['value'],
                decoration: item['decoration'] ??
                    widget.decorations[item['key']] ??
                    CustomDecoration().textFieldDecoration(item),
                maxLines: item['type'] == "TextArea" ? 10 : 1,
                onChanged: (String value) {
                  widgetGeneral['fields'][count]['value'] = value;
                  _handleChanged();
                },
                obscureText: item['type'] == "Password" ? true : false,
                validator: (value) {
                  if (widget.validations.containsKey(item['key'])) {
                    return widget.validations[item['key']](item, value);
                  }
                  if (item.containsKey('validator')) {
                    if (item['validator'] != null) {
                      if (item['validator'] is Function) {
                        return item['validator'](item, value);
                      }
                    }
                  }
                  if (item['type'] == "Email") {
                    return validateEmail(item, value!);
                  }

                  if (item.containsKey('required')) {
                    if (item['required'] == true ||
                        item['required'] == 'True' ||
                        item['required'] == 'true') {
                      return isRequired(item, value);
                    }
                  }

                  return null;
                },
              ),
            ],
          ),
        ));
      }

      if (item['type'] == "RadioButton") {
        List<Widget> radios = [];

        if (labelHidden(item)) {
          radios.add(Text(item['label'],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16.0)));
        }
        radioValue = item['value'];
        for (var i = 0; i < item['items'].length; i++) {
          radios.add(
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                        widgetGeneral['fields'][count]['items'][i]['label'])),
                Radio<int>(
                    value: widgetGeneral['fields'][count]['items'][i]['value'],
                    groupValue: radioValue,
                    onChanged: (int? value) {
                      setState(() {
                        radioValue = value!;
                        widgetGeneral['fields'][count]['value'] = value;
                        _handleChanged();
                      });
                    })
              ],
            ),
          );
        }

        listWidget.add(
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: radios,
            ),
          ),
        );
      }

      if (item['type'] == "Switch") {
        if (item['value'] == null) {
          widgetGeneral['fields'][count]['value'] = false;
        }
        listWidget.add(
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Row(children: <Widget>[
              Expanded(child: Text(item['label'])),
              Switch(
                value: item['value'] ?? false,
                onChanged: (bool value) {
                  setState(() {
                    widgetGeneral['fields'][count]['value'] = value;
                    _handleChanged();
                  });
                },
              ),
            ]),
          ),
        );
      }

      if (item['type'] == "Checkbox") {
        List<Widget> checkboxes = [];
        if (labelHidden(item)) {
          checkboxes.add(Text(item['label'],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16.0)));
        }
        for (var i = 0; i < item['items'].length; i++) {
          checkboxes.add(
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                        widgetGeneral['fields'][count]['items'][i]['label'])),
                Checkbox(
                  value: widgetGeneral['fields'][count]['items'][i]['value'],
                  onChanged: (bool? value) {
                    setState(
                          () {
                        widgetGeneral['fields'][count]['items'][i]['value'] =
                            value;
                        _handleChanged();
                      },
                    );
                  },
                ),
              ],
            ),
          );
        }

        listWidget.add(
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: checkboxes,
            ),
          ),
        );
      }

      if (item['type'] == "Select") {
        Widget label = const SizedBox.shrink();
        if (labelHidden(item)) {
          label = Text(item['label'],
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
        }

        listWidget.add(Container(
          margin: const EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              label,
              DropdownButton<String>(
                hint: const Text("Select a user"),
                value: widgetGeneral['fields'][count]['value'],
                onChanged: (String? newValue) {
                  setState(() {
                    widgetGeneral['fields'][count]['value'] = newValue;
                    _handleChanged();
                  });
                },
                items:
                item['items'].map<DropdownMenuItem<String>>((dynamic data) {
                  return DropdownMenuItem<String>(
                    value: data['value'],
                    child: Text(
                      data['label'],
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ));
      }
    }

    if (widget.buttonSave != null) {
      listWidget.add(Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              widget.actionSave!(widgetGeneral);
            }
          },
          child: widget.buttonSave,
        ),
      ));
    }
    return listWidget;
  }

  _CoreWidgetState(this.widgetGeneral);

  void _handleChanged() {
    widget.onChanged(widgetGeneral);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode:
      widgetGeneral['autoValidated'] ?? AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(widget.padding ?? 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: jsonToForm(),
        ),
      ),
    );
  }
}
