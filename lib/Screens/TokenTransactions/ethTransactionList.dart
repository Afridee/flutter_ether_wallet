import 'dart:convert';
import 'dart:math';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/functions/DecodeInputDataAPI.dart';
import 'package:ether_wallet_flutter_app/functions/TimestampToDateTime.dart';
import 'package:ether_wallet_flutter_app/functions/getABI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class EthTransactionlist extends StatelessWidget {

  const EthTransactionlist({
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
          itemCount: wC.ethTransfers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: wC.ethTransfers[index].input == "0x"
                  ? ListTile(
                      onTap: () async {
                         
                      },
                      trailing: Icon(
                        Ionicons.arrow_forward,
                        color: wC.ethTransfers[index].from ==
                                "0x" + wC.activeAccount
                            ? Colors.redAccent
                            : Color(0xff3cad89),
                      ),
                      title: Text(
                        wC.ethTransfers[index].from == "0x" + wC.activeAccount
                            ? (double.parse(wC.ethTransfers[index].value) /
                                        double.parse((pow(10, 18)).toString()))
                                    .toStringAsFixed(3) +
                                " " +
                                "ETH " +
                                "\nsent"
                            : (double.parse(wC.ethTransfers[index].value) /
                                        double.parse((pow(10, 18)).toString()))
                                    .toStringAsFixed(3) +
                                " " +
                                "ETH " +
                                "\nreceived",
                        style: TextStyle(
                            color: wC.ethTransfers[index].from ==
                                    "0x" + wC.activeAccount
                                ? Colors.redAccent
                                : Color(0xff3cad89),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      subtitle: Text(TimeStampToDate(
                          int.parse(wC.ethTransfers[index].timeStamp) * 1000)),
                      leading: CircleAvatar(
                        backgroundColor: wC.ethTransfers[index].from ==
                                "0x" + wC.activeAccount
                            ? Color(0xffffeaef)
                            : Color(0xffc6fae0),
                        radius: 30,
                        child: Column(
                          children: [
                            Spacer(),
                            Icon(
                              wC.ethTransfers[index].from ==
                                      "0x" + wC.activeAccount
                                  ? Ionicons.arrow_up
                                  : Ionicons.arrow_down,
                              color: wC.ethTransfers[index].from ==
                                      "0x" + wC.activeAccount
                                  ? Colors.redAccent
                                  : Color(0xff3cad89),
                              size: 10,
                            ),
                            Icon(
                              Ionicons.wallet,
                              color: wC.ethTransfers[index].from ==
                                      "0x" + wC.activeAccount
                                  ? Colors.redAccent
                                  : Color(0xff3cad89),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                    onTap: () async{
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blueAccent.withOpacity(0.1),
                              radius: 30,
                              child: Column(
                                children: [
                                  Spacer(),
                                  Icon(
                                    Ionicons.contract,
                                    color: Colors.blueAccent,
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder<String>(
                                  initialData: "...",
                                  future: wC.decodeInputData(address: wC.ethTransfers[index].to, input: wC.ethTransfers[index].input),
                                  builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                                      if(snapshot.connectionState==ConnectionState.done){
                                        return Container(
                                          width: 150,
                                          child: Text(
                                            snapshot.data ?? "...", //TODO: this will be dynamic
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }else{
                                        return Center(child: CircularProgressIndicator());
                                      }
                                  },
                                ),
                                Text("Value: " +
                                    (double.parse(wC.ethTransfers[index].value) /
                                            double.parse(
                                                (pow(10, 18)).toString()))
                                        .toStringAsFixed(3) +
                                    " " +
                                    "ETH"),
                                Text(
                                  wC.ethTransfers[index].isError == '1'
                                      ? "Failed"
                                      : "Confirmed",
                                  style: TextStyle(
                                      color: wC.ethTransfers[index].isError == '1'
                                          ? Colors.redAccent
                                          : Colors.greenAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  TimeStampToDate(int.parse(
                                          wC.ethTransfers[index].timeStamp) *
                                      1000),
                                  style:
                                      TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(
                              Ionicons.arrow_forward,
                              color: Colors.blueAccent,
                            )
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
