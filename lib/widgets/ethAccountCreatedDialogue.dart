import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


//function 5:
void ethAccountCreatedDialog({required BuildContext context,required String title,required Color
color, required String ethAddress}) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(
          title,
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontFamily: 'Varela'),
        ),
        content: Text("0x" + ethAddress,
          style: TextStyle(
              color: Colors.white
          ),),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(
              "Okay",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
        backgroundColor: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      );
    },
  );
}