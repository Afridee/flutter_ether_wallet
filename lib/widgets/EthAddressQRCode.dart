import 'package:ether_wallet_flutter_app/Screens/CreateEthAccount.dart';
import 'package:ether_wallet_flutter_app/Screens/ImportEthAccount.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

EthAddressQRCode(BuildContext context, String ethAddress){
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
          ),
          child: Column(
            children: [
                Spacer(),
                Text(
                  "Scan this QR code to share your eth address.", style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20
                ), textAlign: TextAlign.center),
                Spacer(),
                QrImage(
                  data: "0x" + ethAddress,
                  version: QrVersions.auto,
                  size: 150.0,
              ),
              Spacer(),
            ],
          ),
        );
      });
}