import 'package:ether_wallet_flutter_app/controllers/localAuthenticationController.dart';
import 'package:ether_wallet_flutter_app/controllers/loginController.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationPage extends StatelessWidget {

  final userObj;

  const AuthenticationPage({
    Key? key,@required this.userObj,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authController = Get.put(LocalAuthController());
    final loginController = Get.put(LoginController());
    final walletController = Get.put(WalletController());

    return GetBuilder<LocalAuthController>(
      builder: (lac){
        return Center(
          child: !lac.didAuthenticate ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello, " + userObj!["name"],
                style: GoogleFonts.poppins(fontStyle: FontStyle.normal, fontSize: 20),),
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 60.0,
                child: ClipRRect(
                  child: Image.network(userObj!["picture"]["data"]["url"]),
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
              //Text(apc.userObj!["id"]),
              SizedBox(
                height: 15,
              ),
              Text(userObj!["name"], style: GoogleFonts.poppins(fontStyle: FontStyle.normal, fontSize: 15),),
              //Text(apc.userObj!["email"]),
              SizedBox(
                height: 40,
              ),
              TextButton(onPressed: () {
                authController.authenticate();
              }, child: Text("verify me")),
              TextButton(onPressed: () {
                loginController.logOut();
              }, child: Text("Log out")),
            ],
          ) : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.green,
            child: Center(
              child: TextButton(onPressed: () {
                walletController.createAEthAccount();
              }, child: Text("check Api"))
            ),
          ),
        );
      },
    );
  }
}