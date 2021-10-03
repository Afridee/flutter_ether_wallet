import 'package:ether_wallet_flutter_app/Screens/TokenTransactions/ethTransactionList.dart';
import 'package:ether_wallet_flutter_app/Screens/sendEthers/sendEthers.dart';
import 'package:ether_wallet_flutter_app/Screens/sendTokens/sendTokens.dart';
import 'package:ether_wallet_flutter_app/Screens/swapetherwithtokens/swapetherwithtokes.dart';
import 'package:ether_wallet_flutter_app/Screens/swaptokenfortoken/SwapTokenForTokenPage.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/models/getTokenBalanceModel.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:ether_wallet_flutter_app/widgets/EthAddressQRCode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'erc20TransactionList.dart';

class TransactionScreen extends StatefulWidget {
  final int tokenIndex;
  final GetTokenBalanceModel token;

  const TransactionScreen(
      {Key? key,
      required this.tokenIndex,
      required this.token,
      })
      : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: kPrimaryColor,
                child: Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Ionicons.ticket,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),
                    Spacer(),
                    Text(
                      double.parse(widget.token.balance).toStringAsFixed(3) +
                          " " +
                          widget.token.tokenSymbol,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  if(widget.tokenIndex>0){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => new SendTokens(),
                                      ),
                                    );
                                  }else{//token is ether then...
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => new SendEthers(),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(Ionicons.send, color: kPrimaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Send",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                        if (widget.tokenIndex == 0)
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 30.0,
                                backgroundColor: Colors.white,
                                child: GetBuilder<WalletController>(
                                  builder: (wC){
                                    return IconButton(
                                      onPressed: () {
                                        EthAddressQRCode(context, wC.activeAccount);
                                      },
                                      icon: Icon(Ionicons.download,
                                          color: kPrimaryColor),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Receive",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                   if(widget.tokenIndex>0){
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                         builder: (context) => new SwapTokenForToken(tokenIndex: widget.tokenIndex),
                                       ),
                                     );
                                   }else{//token is ether then...
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                         builder: (context) => new SwapEthersWithTokens(),
                                       ),
                                     );
                                   }
                                },
                                icon: Icon(Ionicons.swap_vertical,
                                    color: kPrimaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Swap",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: widget.tokenIndex==0? EthTransactionlist() : Erc20Transactionlist(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




