import 'package:ether_wallet_flutter_app/controllers/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AuthenticationPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LoginController>(
      builder: (lc) {
        return Container(
            child: lc.isLoggedIn?
            AuthenticationPage(userObj: lc.userObj) : Center(child: ElevatedButton(
              child: Text("Login with facebook"),
              onPressed: (){
                loginController.loginWithFb();
              },
            ))
        );
      }),
    );
  }
}


