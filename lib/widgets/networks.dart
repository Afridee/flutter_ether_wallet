import 'package:ether_wallet_flutter_app/Screens/CreateEthAccount.dart';
import 'package:ether_wallet_flutter_app/Screens/ImportEthAccount.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

Networks(BuildContext context){
  final WalletController walletController = Get.put(WalletController());
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Select a network to explore.",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15
                    ), textAlign: TextAlign.center),
              ),
              Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: (){
                  walletController.changeExplorer("mainnet");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle, color: Colors.greenAccent, size: 12,),
                      SizedBox(width: 10),
                      Text(
                          "Ethereum Mainnet",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight:  FontWeight.bold,
                              fontSize: 15
                          ), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(

                ),
              ),
              InkWell(
                onTap: (){
                  walletController.changeExplorer("rinkeby");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle, color: Colors.pinkAccent, size: 12,),
                      SizedBox(width: 10),
                      Text(
                          "Rinkeby Testnet",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight:  FontWeight.bold,
                              fontSize: 15
                          ), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}