library json_to_widget;

import 'dart:convert';
import 'package:flutter/material.dart';

class JsonNav extends StatefulWidget {
  const JsonNav({
    Key? key,
    required this.nav,
    this.padding,
    this.navMap,
    this.decorations = const {},
    this.buttonSave,
    this.actionSave,
  }) : super(key: key);

  final Map decorations;
  final String nav;
  final Map? navMap;
  final double? padding;
  final Widget? buttonSave;
  final Function? actionSave;

  @override
  _CoreNavState createState() => _CoreNavState(navMap ?? json.decode(nav));
}

class _CoreNavState extends State<JsonNav> {
  final dynamic navGeneral;

  int? radioValue;

  // Return widgets

  List<Widget> jsonToNav() {
    List<Widget> navWidgets = <Widget>[];
    if (navGeneral['title'] != null) {
      navWidgets.add(Text(
        navGeneral['title'],
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ));
    }
    return navWidgets;
  }

  _CoreNavState(this.navGeneral);

  @override
  Widget build(BuildContext context) {
    return navGeneral['nav'] == 'AppBar'
        ? AppBar(
            title: navGeneral['title'],
            centerTitle: true,
          )
        : const BottomAppBar(
            child: Text('Ron Digital'),
          );
  }
}
