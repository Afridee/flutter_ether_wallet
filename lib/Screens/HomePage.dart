

import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {

  final walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
          child: TextButton(onPressed: () async{
            walletController.createAEthAccount();
          }, child: Text("check Api"))
      ),
    );
  }
}

