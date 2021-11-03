import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard/clipboard.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';

import 'Home/Home.dart';
import 'Home/HomePage.dart';
import 'package:ether_wallet_flutter_app/controllers/localAuthenticationController.dart';
import 'package:ether_wallet_flutter_app/controllers/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AuthenticationPage extends StatelessWidget {
  final userObj;

  const AuthenticationPage({
    Key? key,
    @required this.userObj,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int timeincreaser = 1;
    final WalletController walletController = Get.put(WalletController());

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
      FlutterClipboard.copy(event.notification.body.toString())
          .then((value) => {
                AwesomeDialog(
                    padding: EdgeInsets.all(20),
                    context: context,
                    dialogType: DialogType.INFO,
                    animType: AnimType.BOTTOMSLIDE,
                    title: event.notification.title,
                    desc: event.notification.body.toString() +
                        " has been copied to clipboard. You can paste it to etherscan.io to know more about your transaction.")
                  ..show()
              });
      Timer(Duration(seconds: 5 * timeincreaser), () {
        walletController.setUpEthAccount(
            ethAccount: walletController.activeAccount); //refreshes
        walletController.getTokenTransactions(
            walletController.lastTransactionScreen); //refreshes
        timeincreaser++;
      });
    });

    final authController = Get.put(LocalAuthController());
    final loginController = Get.put(LoginController());

    return GetBuilder<LocalAuthController>(
      builder: (lac) {
        return Center(
          child: !lac.didAuthenticate
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hello, " + userObj!["name"],
                      style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,borderRadius: BorderRadius.circular(68)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60.0,
                          child: ClipRRect(
                            child:
                                Image.network(userObj!["picture"]["data"]["url"]),
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                        ),
                      ),
                    ),
                    //Text(apc.userObj!["id"]),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      userObj!["name"],
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontSize: 15),
                    ),
                    //Text(apc.userObj!["email"]),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.verified_user_outlined, color: kPrimaryColor2),
                              TextButton(
                                onPressed: () {
                                  authController.authenticate();
                                },
                                child: Text(
                                  "Verify me",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.logout_rounded, color: kPrimaryColor2),
                              TextButton(
                                onPressed: () {
                                  loginController.logOut();
                                },
                                child: Text(
                                  "Log out",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Home(),
        );
      },
    );
  }
}
