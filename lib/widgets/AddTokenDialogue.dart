import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


//function 5:
void addTokenDialog({required BuildContext context,required String title,required Color
color}) {
  String tokenName = '';
  final walletController = Get.put(WalletController());
  // flutter defined function
  AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.INFO_REVERSED,
    body: Center(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          label: Text("Enter ERC20 token address"),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusColor: Colors.black,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        style: TextStyle(
            color: Colors.black
        ),
        onChanged: (value){
          tokenName = value;
        },
      ),
    ),),
    btnOkOnPress: () {
      walletController.AddToken(tknAddress: tokenName);
    },
  )..show();
}