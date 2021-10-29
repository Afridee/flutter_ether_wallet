import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard/clipboard.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasForSendingERC20API.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasForSendingEthAPI.dart';
import 'package:ether_wallet_flutter_app/functions/sendErc20API.dart';
import 'package:ether_wallet_flutter_app/functions/sendEthAPI.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SendERC20TokenController extends GetxController {
  int estimatedGasNeeded = 0;
  bool allowButtonPress = true;

  reset(){
    estimatedGasNeeded = 0;
    update();
  }

  sendERC20(
      {required String network,
        required String fromAddress,
        required String toAddress,
        required String contractAddress,
        required double amountIn,
        required String fromAddressPrivateKey,
        required double gasPrice,
        required BuildContext context}) async {
    if(allowButtonPress){
      allowButtonPress = false;
      update();
      Map<String, dynamic> m = await sendErc20API(
          network: network,
          fromAddress: fromAddress,
          toAddress: toAddress,
          amountIn: amountIn,
          gas: estimatedGasNeeded,
          fromAddressPrivateKey: fromAddressPrivateKey,
          gasPrice: gasPrice,
          contractAddress: contractAddress);
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
    }
    Timer(Duration(seconds: 5),() async{
      allowButtonPress = true;
      update();
    });
  }

  estimateGas({
    required String network,
    required String fromAddress,
    required String toAddress,
    required String contractAddress,
    required double amountIn,
    required BuildContext context}
  ) async {
    Map<String, dynamic> m = await estimateGasForSendingERC20API(
        network: network,
        fromAddress: fromAddress,
        toAddress: toAddress,
        amountIn: amountIn,
        contractAddress: contractAddress);
    if (m["error"] == null) {
      estimatedGasNeeded = m['estimatedGasNeeded'];
      update();
    } else {
      print(m["error"]);
    }
  }

}