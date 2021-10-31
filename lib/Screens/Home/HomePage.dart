import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ether_wallet_flutter_app/Screens/Home/TokenList.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../widgets/AddTokenDialogue.dart';
import 'package:get/get.dart';
import '../../custom_widgets.dart/custom_appbar.dart';
import '../../utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'MenuScreen.dart';
import 'homePageTopPart.dart';

class HomeScreen extends StatefulWidget {

  final drawerController;

  const HomeScreen({Key? key,@required this.drawerController}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = List<String>.generate(10000, (i) => "ETH $i");
  final WalletController walletController = Get.put(WalletController());

  @override
  void initState() {
    walletController.getEthAccounts();
    Timer(Duration(seconds: 5), (){
      if(walletController.ethAccounts.isEmpty){
        AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO_REVERSED,
            animType: AnimType.BOTTOMSLIDE,
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Press"),
                SizedBox(width: 5),
                Icon(CupertinoIcons.profile_circled),
                SizedBox(width: 5),
                Text("to create/import eth accounts")
              ],
            ),
            btnOkOnPress: () {},
            btnOkColor: kPrimaryColor2)
          ..show();
      }
    });
    final _drawerController = ZoomDrawerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          textTheme: _textTheme,
          title: '',
          drawerController: widget.drawerController,
        ),
        body: GetBuilder<WalletController>(
          builder: (wC){
            return ModalProgressHUD(
              color: Colors.white,
              opacity: 1,
              progressIndicator: SpinKitThreeBounce(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: kPrimaryColor2,
                    ),
                  );
                },
              ),
              inAsyncCall: wC.loading,
              child: SingleChildScrollView(
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
                            Icons.add_circle_rounded,
                            color: kPrimaryColor2,
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
          },
        ),
      ),
    );
  }
}




