import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard/clipboard.dart';
import 'package:ether_wallet_flutter_app/controllers/SwapTokenForTokenController.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasForswappinTokensForEthAPI.dart';
import 'package:ether_wallet_flutter_app/functions/swapTokensForEthAPI.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwapTokenWithEtherController extends SwapTokenForTokenController {
  swapTokenWithEther(
      {required BuildContext context,
      required String network,
      required String fromContractAddress,
      required double amountIn,
      required String privateKey,
      required double gasPrice}) async {
    if (allowButtonPress) {
      print("mmm");
      allowButtonPress = false;
      update();
      Map<String, dynamic> m = await swapTokensForEthAPI(
          network: network,
          fromContractAddress: fromContractAddress,
          amountIn: amountIn,
          gas: estimatedGasNeeded,
          privateKey: privateKey,
          gasPrice: gasPrice,
          minOutPercentage: minOutPercentage);
      if (m["error"] == null) {
        Navigator.of(context).pop();
        FlutterClipboard.copy(m["transactionHash"]).then((value) => {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Transaction hash is copied to clipboard',
                desc:
                    "You can use it to see the status of your transaction in websites like etherscan.io",
              )..show()
            });
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Oops!',
            desc: m["error"],
            btnOkOnPress: () {},
            btnOkColor: kPrimaryColor)
          ..show();
      }
      makeTheSwap = false;
      update();
      Timer(Duration(seconds: 5), () async {
        allowButtonPress = true;
        update();
      });
    }
  }

  estimateGasForSwappingTokenWithEther(
      {required BuildContext context,
      required String network,
      required String address,
      required String fromContractAddress,
      required String amountIn,
      required bool showDialogue}) async {
    if (fromContractAddress.length == 42 &&
        double.parse(amountIn == "" ? "0" : amountIn) > 0) {
      Map<String, dynamic> m = await estimateGasForswappinTokensForEthAPI(
          amountIn: amountIn,
          minOutPercentage: minOutPercentage,
          address: address,
          network: network,
          fromContractAddress: fromContractAddress);
      if (m["error"] == null) {
        estimatedGasNeeded = m['estimatedGasNeeded'];
        makeTheSwap = true;
        update();
      } else {
        makeTheSwap = false;
        update();
        if (showDialogue) {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Oops!',
              desc: m["error"],
              btnOkOnPress: () {},
              btnOkColor: kPrimaryColor)
            ..show();
        }
      }
    }
  }
}
