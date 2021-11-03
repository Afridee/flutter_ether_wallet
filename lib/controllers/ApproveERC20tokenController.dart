import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard/clipboard.dart';
import 'package:ether_wallet_flutter_app/functions/approveErc20TokenForSwappingAPI.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasForApprovingTokenAPI.dart';
import 'package:ether_wallet_flutter_app/functions/getTokenBalanceAPI.dart';
import 'package:ether_wallet_flutter_app/models/getTokenBalanceModel.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ApproveERC20tokenController extends GetxController {
  int estimatedGasNeeded = 0;
  bool allowButtonPress = true;

  reset(){
    estimatedGasNeeded = 0;
    update();
  }

  approve(
      {required String network,
        required String tokenAddress,
        required String privateKey,
        required double gasPrice,
        required String from,
        required double amountIn,
        required BuildContext context
      }
      ) async{
      if(allowButtonPress){
        allowButtonPress = false;
        update();

        Map<String, dynamic> m = await approveErc20TokenForSwappingAPI(network: network, tokenAddress: tokenAddress, gas: estimatedGasNeeded, privateKey: privateKey, gasPrice: gasPrice, from: from, amountIn: amountIn.toString());
        if(m['error']==null){
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
  }

  estimateGasForApprovingToken({
    required String network,
    required String tokenAddress,
    required String from,
    required double amountIn,
  }) async {

    Map<String, dynamic> m = await estimateGasForApprovingTokenAPI(
        network: network,
        tokenAddress: tokenAddress,
        from: from,
        amountIn: amountIn.toString());

    if(m["error"]==null){
      estimatedGasNeeded = m["estimatedGasNeeded"];
      update();
    }else{
      print(m["error"]);
    }
  }
}
