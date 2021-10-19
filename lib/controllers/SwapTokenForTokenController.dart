import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard/clipboard.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasForSwappingTokenAPI.dart';
import 'package:ether_wallet_flutter_app/functions/getAmountsOutForTokenSwapAPI.dart';
import 'package:ether_wallet_flutter_app/functions/swapTokensAPI.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SwapTokenForTokenController extends GetxController{
   int minOutPercentage = 0;
   String estimatedamountsOut = "Calculating.. ";
   String amountsOutToken = "";
   int estimatedGasNeeded = 0;
   bool allowButtonPress = true;
   bool makeTheSwap = false;

   reset(){
     minOutPercentage = 0;
     estimatedamountsOut = "Calculating.. ";
     amountsOutToken = "";
     estimatedGasNeeded = 0;
     allowButtonPress = true;
     makeTheSwap = false;
     update();
   }

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
     required BuildContext context,
     required bool showDialogue
   }) async{
     if(toContractAddress.length==42 && double.parse(amountIn=="" ? "0" : amountIn)>0){
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
         estimatedGasNeeded = m['estimatedGasNeeded'];
         makeTheSwap = true;
         update();
       }else{
         makeTheSwap = false;
         update();
         if(showDialogue){
           AwesomeDialog(
               context: context,
               dialogType: DialogType.ERROR,
               animType: AnimType.BOTTOMSLIDE,
               title: 'Oops!',
               desc: m["error"],
               btnOkOnPress: () {},
               btnOkColor: kPrimaryColor
           )..show();
         }
       }
       allowButtonPress = true;
       update();
     }
   }

   SwapTokens({
     required BuildContext context,
     required String network,
     required String fromContractAddress,
     required String toContractAddress,
     required double amountIn,
     required String privateKey,
     required double gasPrice,
     }) async{
     if(makeTheSwap && allowButtonPress){
       allowButtonPress = false;
       update();
       Map<String, dynamic> m = await swapTokensAPI(network: network, fromContractAddress: fromContractAddress, toContractAddress: toContractAddress, amountIn: amountIn, gas: estimatedGasNeeded, privateKey: privateKey, gasPrice: gasPrice, minOutPercentage: minOutPercentage);
       if(m["error"]==null){
         Navigator.of(context).pop();
         FlutterClipboard.copy(m["transactionHash"]).then((value) => {
           AwesomeDialog(
               context: context,
               dialogType: DialogType.SUCCES,
               animType: AnimType.BOTTOMSLIDE,
               title: 'Transaction hash is copied to clipboard',
               desc: "You can use it to see the status of your transaction in websites like etherscan.io",
           )..show()
         });
       }else{
         AwesomeDialog(
             context: context,
             dialogType: DialogType.ERROR,
             animType: AnimType.BOTTOMSLIDE,
             title: 'Oops!',
             desc: m["error"],
             btnOkOnPress: () {},
             btnOkColor: kPrimaryColor
         )..show();
       }
       makeTheSwap = false;
       update();
       Timer(Duration(seconds: 5),() async{
         allowButtonPress = true;
         update();
       });
     }

   }

}