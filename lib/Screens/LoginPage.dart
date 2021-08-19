import 'package:ether_wallet_flutter_app/controllers/loginController.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final loginController = Get.put(LoginController());
  bool canCheckBiometrics = false;

  check() async{
    var localAuth = LocalAuthentication();
    canCheckBiometrics  = await localAuth.canCheckBiometrics;
    print("does it have it:" + canCheckBiometrics.toString());
    bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        biometricOnly: true);
    print("does it authenticate:" + didAuthenticate.toString());
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: Text("Codesundar"),
      ),
      body: GetBuilder<LoginController>(
      builder: (apc) {
        return Container(
            child: apc.isLoggedIn?
            Column(
              children: [
                Image.network(apc.userObj!["picture"]["data"]["url"]),
                Text(apc.userObj!["id"]),
                Text(apc.userObj!["name"]),
                Text(apc.userObj!["email"]),
                TextButton(onPressed: () async{
                }, child: Text("LogOut"))
              ],
            ) : Center(child: ElevatedButton(
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
