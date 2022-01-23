import 'package:flutter/material.dart';

class CustomDecoration extends StatelessWidget {
  const CustomDecoration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  InputDecoration textFieldDecoration(item) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
          vertical: item['contentVertical'] ?? 1,
          horizontal: item['contentHorizontal'] ?? 1),
      helperText: item['helperText'] ?? '',
      labelText: item['labelText'] ?? '',
      labelStyle: TextStyle(
          fontSize: item['labelFontSize'] ?? 14,
          color: Color.fromRGBO(item['labelR'] ?? 1, item['labelG'] ?? 1,
              item['labelB'] ?? 1, item['labelOpacity'] ?? 1)),
      fillColor: Color.fromRGBO(item['fillR'] ?? 1, item['fillG'] ?? 1,
          item['fillB'] ?? 1, item['fillOpacity'] ?? 1),
      filled: item['filled'],
      prefixText: item['prefixText'] ?? '',
      suffixIcon: Text(
        item['icon'] ?? 'hourglass_empty',
        style: TextStyle(
            fontFamily: 'MaterialIcons', fontSize: 30, color: Colors.black),
      ),
      prefixIconConstraints: BoxConstraints(
        minWidth: item['prefixConstraintMinWidth'] ?? 1,
        maxWidth: item['prefixConstraintMaxWidth'] ?? 1,
        minHeight: item['prefixConstraintMinHeight'] ?? 1,
        maxHeight: item['prefixConstraintMaxHeight'] ?? 1,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(item['enabledBorderRadius'] ?? 1),
        borderSide: BorderSide(
          color: Color.fromRGBO(
              item['enabledBorderR'] ?? 1,
              item['enabledBorderG'] ?? 1,
              item['enabledBorderB'] ?? 1,
              item['enabledBorderOpacity'] ?? 1),
          width: item['enabledBorderWidth'] ?? 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(item['focusedBorderRadius'] ?? 1),
        borderSide: BorderSide(
          color: Color.fromRGBO(
              item['focusedBorderR'] ?? 1,
              item['focusedBorderG'] ?? 1,
              item['focusedBorderB'] ?? 1,
              item['focusedBorderOpacity'] ?? 1),
          width: item['focusedBorderWidth'] ?? 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(item['focusedErrorBorderRadius'] ?? 1),
        borderSide: BorderSide(
          color: Color.fromRGBO(
              item['focusedErrorBorderR'] ?? 1,
              item['focusedErrorBorderG'] ?? 1,
              item['focusedErrorBorderB'] ?? 1,
              item['focusedErrorBorderOpacity'] ?? 1),
          width: item['focusedErrorBorderWidth'] ?? 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(item['errorBorderRadius'] ?? 1),
        borderSide: BorderSide(
          color: Color.fromRGBO(
              item['errorBorderR'] ?? 1,
              item['errorBorderG'] ?? 1,
              item['errorBorderB'] ?? 1,
              item['errorBorderOpacity'] ?? 1),
          width: item['errorBorderWidth'] ?? 1,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(item['disabledBorderRadius'] ?? 1),
        borderSide: BorderSide(
          color: Color.fromRGBO(
              item['disabledBorderR'] ?? 1,
              item['disabledBorderG'] ?? 1,
              item['disabledBorderB'] ?? 1,
              item['disabledBorderOpacity'] ?? 1),
          width: item['disabledBorderWidth'] ?? 1,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(item['borderRadius'] ?? 1),
        borderSide: BorderSide(
          color: Color.fromRGBO(item['borderR'] ?? 1, item['borderG'] ?? 1,
              item['borderB'] ?? 1, item['borderOpacity'] ?? 1),
          width: item['borderWidth'] ?? 1,
        ),
      ),
    );
  }
}
