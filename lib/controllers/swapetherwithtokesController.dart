import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard/clipboard.dart';
import 'package:ether_wallet_flutter_app/functions/SwapEthForTokensAPI.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasForSwappingEtherAPI.dart';
import 'package:ether_wallet_flutter_app/functions/getAmountsOutForTokenSwapAPI.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SwapetherwithtokesController extends GetxController {
  int estimatedGasNeeded = 0;
  bool allowButtonPress = true;
  String estimatedamountsOut = "Calculating.. ";
  String tokenName = "...";
  String errortextForAmountsOut = "";

  reset(){
    estimatedGasNeeded = 0;
    allowButtonPress = true;
    estimatedamountsOut = "Calculating.. ";
    tokenName = "...";
    update();
  }

  swap({required String network,
      required String privateKey,
      required String tokenAddress,
      required double amountOutMin,
      required double value,
      required double gasPrice,
      required BuildContext context}) async {
      if(allowButtonPress){
        allowButtonPress = false;
        update();
        Map<String, dynamic> m = await swapEthForTokensAPI(network: network, privateKey: privateKey, tokenAddress: tokenAddress, amountOutMin: amountOutMin, gas: estimatedGasNeeded.toString(), value: value.toString(), gasPrice: gasPrice.toString());
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
        Timer(Duration(seconds: 5),() async{
          allowButtonPress = true;
          update();
        });
      }
      print("amountOutMin: " + amountOutMin.toString());
  }

  Future<String> estimateAmountsOut({
    required String network,
    required String toContractAddress,
    required double amountIn,
    required BuildContext context
  }) async{
    if(amountIn>0 && toContractAddress.length==42){
      Map<String, dynamic> m = await estimateAmountsOutAPI(
        network: network,
        amountIn: amountIn.toString(),
        fromContractAddress: "0xc778417e063141139fce010982780140aa0cd5ab",
        toContractAddress: toContractAddress, //weth's contract address, weth has same value as eth
      );
      if(m["error"]==null){
        tokenName = m['tokenSymbol'];
        update();
        return m['estimatedamountsOut'];
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
        return "";
      }
    }else{
      // AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.ERROR,
      //     animType: AnimType.BOTTOMSLIDE,
      //     title: 'Oops!',
      //     desc: "Make sure to specify the token address and sending Amount.",
      //     btnOkOnPress: () {},
      //     btnOkColor: kPrimaryColor
      // )..show();
      return "";
    }
  }

  estimateGas({required String network,
    required String amountOutMin,
    required String tokenAddress,
    required String value,
    required String admin,
    required BuildContext context
  }) async{
     print("ran...");
     if(amountOutMin.isNotEmpty && tokenAddress.isNotEmpty && value.isNotEmpty && admin.isNotEmpty){
       Map<String, dynamic> m = await estimateGasForSwappingEtherAPI(network: network, amountOutMin: amountOutMin, tokenAddress: tokenAddress, value: value, admin: admin);
       if(m["error"]==null){
         estimatedGasNeeded = m["estimatedGasNeeded"];
         errortextForAmountsOut = "";
         update();
       }else{
         print(m["error"]);
         ///todo: put something else instead of a dialogue... (._.)
         if(m["error"] == '{"error":"Returned error: execution reverted: UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT"}'){
           errortextForAmountsOut = "Please reduce the output amount";
         }
         update();
       }
     }
  }

}
