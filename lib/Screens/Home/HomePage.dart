import 'package:ether_wallet_flutter_app/Screens/Home/TokenList.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import '../../widgets/AddTokenDialogue.dart';
import 'package:get/get.dart';
import '../../custom_widgets.dart/custom_appbar.dart';
import '../../utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homePageTopPart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = List<String>.generate(10000, (i) => "ETH $i");
  final WalletController walletController = Get.put(WalletController());

  @override
  void initState() {
    walletController.getEthAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        textTheme: _textTheme,
        title: '',
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            hmPageTopPart(textTheme: _textTheme),
            Container(
              height: 260,
              child: TokenList(textTheme: _textTheme),
            ),
            Container(
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: kPrimaryColor,
                  ),
                  iconSize: 70,
                  color: Colors.white,
                  onPressed: () {
                    addTokenDialog(context: context, title: "Enter ERC20 token address", color: kPrimaryColor);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




