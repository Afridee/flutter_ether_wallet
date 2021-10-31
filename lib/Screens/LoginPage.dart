import 'package:ether_wallet_flutter_app/controllers/loginController.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:ether_wallet_flutter_app/widgets/TextField1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:simple_icons/simple_icons.dart';
import 'AuthenticationPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = Get.put(LoginController());
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: GetBuilder<LoginController>(builder: (lc) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kPrimaryColor2],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/bgimg1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: lc.isLoggedIn
                  ? AuthenticationPage(userObj: lc.userObj)
                  : Center(
                      child: Column(
                        children: [
                          Spacer(),
                          Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: 300,
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GetBuilder<LoginController>(
                              builder: (lc){
                                return lc.allowButtonPress ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField1(
                                      obsucureText: false,
                                        controller: email,
                                        inputType: TextInputType.emailAddress,
                                        hint: "jonathan@gmail.com",
                                        label: "Email",
                                        validator: true,
                                        errorText: ''),
                                    TextField1(
                                      obsucureText: true,
                                        controller: password,
                                        inputType: TextInputType.visiblePassword,
                                        hint: "*****",
                                        label: "Password",
                                        validator: true,
                                        errorText: ''),
                                    InkWell(
                                      onTap: (){
                                        loginController.loginWithEmail(email: email.text, password: password.text, context: context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          gradient: LinearGradient(
                                            colors: [kPrimaryColor, kPrimaryColor2],
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                        !lc.registerring ? "Log in" : "Register",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if(!lc.registerring) TextButton(
                                      onPressed: () {
                                       loginController.resetPassword(email: email.text, context: context);
                                      },
                                      child: Text(
                                        "Forgot your password?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    if(!lc.registerring) Divider(
                                      height: 40,
                                      thickness: 2,
                                    ),
                                    if(!lc.registerring) Text("Or Sign in with",
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    if(!lc.registerring) IconButton(onPressed: (){
                                      loginController.loginWithFb(context: context);
                                    }, icon: Icon(SimpleIcons.facebook), color: kPrimaryColor2, iconSize: 40)
                                  ],
                                ) : SpinKitThreeBounce(
                                  itemBuilder: (BuildContext context, int index) {
                                    return DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor2,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                    ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: (){
                              loginController.regi();
                            },
                            child: Container(
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(!lc.registerring ? Icons.app_registration_rounded: Icons.arrow_back, color: kPrimaryColor2),
                                    SizedBox(width: 10),
                                    Text(
                                      !lc.registerring ? "Register" : "Go back",
                                      style: TextStyle(
                                        color: kPrimaryColor2,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      )));
        }),
      ),
    );
  }
}
