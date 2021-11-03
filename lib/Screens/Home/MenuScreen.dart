import 'package:auto_size_text/auto_size_text.dart';
import 'package:ether_wallet_flutter_app/Screens/ApproveERC20token/ApproveERC20token.dart';
import 'package:ether_wallet_flutter_app/Screens/GetPrivateKey/getPrivateKey.dart';
import 'package:ether_wallet_flutter_app/controllers/loginController.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../webview.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [kPrimaryColor, kPrimaryColor2])),
        child: Container(
          width: MediaQuery.of(context).size.width - 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    //   gradient: LinearGradient(
                    // colors: [kPrimaryColor.withOpacity(0.5), kPrimaryColor2.withOpacity(0.5)]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70))),
                child: Column(
                  children: [
                    GetBuilder<LoginController>(
                      builder: (lc) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(45)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  lc.userObj!["picture"]["data"]["url"]),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetBuilder<LoginController>(builder: (lc) {
                      return Container(
                          width: 150,
                          height: 30,
                          child: AutoSizeText(
                            lc.userObj!["name"],
                            style: GoogleFonts.poppins(
                                fontStyle: FontStyle.normal,
                                fontSize: 20,
                                color: Colors.white),
                          ));
                    })
                  ],
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => new ApproveERC20token(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 30),
                        Icon(Icons.approval, color: Colors.white, size: 30),
                        SizedBox(width: 20),
                        Text(
                          'Approove ERC20 Token',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              new Webview(link: "https://etherscan.io"),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 30),
                        Icon(Icons.web, color: Colors.white, size: 30),
                        SizedBox(width: 20),
                        Text(
                          'Visit etherscan.io',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => new Webview(
                              link: "https://ethereum.org/en/get-eth/"),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 30),
                        Icon(Ionicons.bag_add, color: Colors.white, size: 30),
                        SizedBox(width: 20),
                        Text(
                          'Buy Ether',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => new GetPrivateKey(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 30),
                        Icon(Icons.vpn_key, color: Colors.white, size: 30),
                        SizedBox(width: 20),
                        Text(
                          'Get Private Key',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      loginController.logOut();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 30),
                        Icon(Icons.logout, color: Colors.white, size: 30),
                        SizedBox(width: 20),
                        Text(
                          'Log Out',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
