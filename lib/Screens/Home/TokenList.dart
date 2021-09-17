import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TokenList extends StatelessWidget {
  const TokenList({
    Key? key,
    required TextTheme textTheme,
  }) : _textTheme = textTheme, super(key: key);

  final TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(builder: (wC) {
      return ListView.builder(
        itemCount: wC.tokenList.length,
        itemBuilder: (context, index) {
          return ListTile(
            subtitle: Text(""),
            tileColor: Colors.white,
            title: Text(
              wC.tokenList[index].tokenSymbol,
              style: _textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black54,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                CupertinoIcons.money_euro_circle,
                size: 35,
              ),
            ),
            trailing: Column(
              children: [
                Text(
                  double.parse(wC.tokenList[index].balance).toStringAsFixed(3), // set the price
                  style: _textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Text(wC.tokenList[index].tokenSymbol)
              ],
            ),
          );
        },
      );
    });
  }
}