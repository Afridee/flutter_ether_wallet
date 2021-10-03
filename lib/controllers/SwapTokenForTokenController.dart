import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasForSwappingTokenAPI.dart';
import 'package:ether_wallet_flutter_app/functions/getAmountsOutForTokenSwapAPI.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:ether_wallet_flutter_app/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SwapTokenForTokenController extends GetxController{
   int minOutPercentage = 0;
   String estimatedamountsOut = "Calculating.. ";
   String amountsOutToken = "";
   String estimatedGasNeeded = "0";
   bool allowButtonPress = true;

   changeMinOutPercentage(int val){
     minOutPercentage = val;
     update();
   }

   estimateAmountsOut({
     required String network,
     required String fromContractAddress,
     required String toContractAddress,
     required String amountIn,
   }) async{
      if(toContractAddress.length==42 && amountIn.length>0){
        Map<String, dynamic> m = await estimateAmountsOutAPI(
          network: network,
          amountIn: amountIn,
          fromContractAddress: fromContractAddress,
          toContractAddress: toContractAddress,
        );
        if(m["error"]==null){
          estimatedamountsOut = m['estimatedamountsOut']+" " ?? "";
          amountsOutToken = m['tokenSymbol'] ?? "";
          update();
        }
      }
   }

   estimateGasForSwappingToken({
     required String network,
     required String fromContractAddress,
     required String toContractAddress,
     required String from,
     required String amountIn,
     required BuildContext context
   }) {
     if(toContractAddress.length==42 && amountIn.length>0){
       Timer(Duration(seconds: 3),() async{
         allowButtonPress = false;
         update();
         Map<String, dynamic> m = await estimateGasForSwappingTokenAPI(
           network : network,
           fromContractAddress : fromContractAddress,
           toContractAddress : toContractAddress,
           from : from,
           amountIn : amountIn,
         );
         if(m["error"]==null){
           estimatedGasNeeded = m['estimatedGasNeeded'] ?? "...";
           print("estimatedGasNeeded: "+ estimatedGasNeeded);
           update();
         }else{

           AwesomeDialog(
             context: context,
             dialogType: DialogType.ERROR,
             animType: AnimType.BOTTOMSLIDE,
             title: 'Oops!',
             desc: m["error"]+"\nNote: Please make sure you have approved the erc20 token before swapping",
             btnOkOnPress: () {},
             btnOkColor: kPrimaryColor
           )..show();
         }
       });
       allowButtonPress = true;
       update();
     }
   }

}