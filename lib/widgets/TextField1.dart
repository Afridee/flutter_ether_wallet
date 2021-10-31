import 'dart:math';

import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/material.dart';

class TextField1 extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;
  final String label;
  final bool validator;
  final String errorText;
  final bool obsucureText;

  const TextField1({
    Key? key,
    required this.controller,
    required this.inputType,
    required this.hint,
    required this.label, required this.validator, required this.errorText, required this.obsucureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsucureText,
      keyboardType: inputType,
      controller: controller,
      decoration: InputDecoration(
        focusColor: Colors.black,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        labelStyle: TextStyle(
          color: Colors.black
        ),
        errorText: !validator ? errorText : "",
        errorStyle: TextStyle(
          color: kPrimaryColor2,
          height: 2
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        labelText: label,
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}