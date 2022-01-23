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

  // Return widgets

  List<Widget> jsonToBottomBar() {
    List<Widget> bottomWidgets = <Widget>[];

    for (int count = 0; count < navGeneral['fields'].length; count++) {
      Map item = navGeneral['fields'][count];

      if (item['type'] == 'text') {
        bottomWidgets.add(Text(item['bottomText']));
      }

      if(item.containsKey('iconName')){
        bottomWidgets.add(Text(item['iconName'],style: const TextStyle(fontFamily: 'MaterialIcons'),));
      }
    }

    return bottomWidgets;
  }

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
    return navGeneral['type'] == 'AppBar'
        ? AppBar(
      title: Text(navGeneral['title']),
      centerTitle: true,
    )
        : BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: jsonToBottomBar(),
      ),
    );
  }
}
