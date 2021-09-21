import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

snackBar({required BuildContext context, required String text, required Widget trailingIcon, required Color bgColor, required Color textColor, required int duration}){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: new Duration(seconds: duration),
      content: Row(
        children: <Widget>[
          Text(text,
            style: TextStyle(
                color: textColor
            ),),
          SizedBox(
            width: 10,
          ),
          trailingIcon,
        ],
      ),
      backgroundColor: bgColor,
    ),
  );
}