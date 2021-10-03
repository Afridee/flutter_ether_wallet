import 'dart:convert';
import 'dart:math';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/functions/DecodeInputDataAPI.dart';
import 'package:ether_wallet_flutter_app/functions/TimestampToDateTime.dart';
import 'package:ether_wallet_flutter_app/functions/getABI.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class Erc20Transactionlist extends StatelessWidget {
  const Erc20Transactionlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      builder: (wC) {
        return ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: wC.erc20transfers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () async {},
                trailing: Icon(
                  Ionicons.arrow_forward,
                  color:
                      wC.erc20transfers[index].from == "0x" + wC.activeAccount
                          ? Colors.redAccent
                          : Color(0xff3cad89),
                ),
                title: Text(
                  wC.erc20transfers[index].from == "0x" + wC.activeAccount
                      ? (double.parse(wC.erc20transfers[index].value) /
                                  double.parse(
                                    (pow(10, 18)).toString(),
                                  ))
                              .toStringAsFixed(3) +
                          " " +
                          wC.erc20transfers[index].tokenSymbol +
                          "\nsent"
                      : (double.parse(wC.erc20transfers[index].value) /
                                  double.parse(
                                    (pow(10, 18)).toString(),
                                  ))
                              .toStringAsFixed(3) +
                          " " +
                          wC.erc20transfers[index].tokenSymbol +
                          "\nreceived",
                  style: TextStyle(
                      color: wC.erc20transfers[index].from ==
                              "0x" + wC.activeAccount
                          ? Colors.redAccent
                          : Color(0xff3cad89),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                subtitle: Text(TimeStampToDate(
                    int.parse(wC.erc20transfers[index].timeStamp) * 1000)),
                leading: CircleAvatar(
                  backgroundColor:
                      wC.erc20transfers[index].from == "0x" + wC.activeAccount
                          ? Color(0xffffeaef)
                          : Color(0xffc6fae0),
                  radius: 30,
                  child: Column(
                    children: [
                      Spacer(),
                      Icon(
                        wC.erc20transfers[index].from == "0x" + wC.activeAccount
                            ? Ionicons.arrow_up
                            : Ionicons.arrow_down,
                        color: wC.erc20transfers[index].from ==
                                "0x" + wC.activeAccount
                            ? Colors.redAccent
                            : Color(0xff3cad89),
                        size: 10,
                      ),
                      Icon(
                        Ionicons.wallet,
                        color: wC.erc20transfers[index].from ==
                                "0x" + wC.activeAccount
                            ? Colors.redAccent
                            : Color(0xff3cad89),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
