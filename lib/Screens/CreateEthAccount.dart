import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateEthAccountScreen extends StatefulWidget {
  @override
  _CreateEthAccountScreenState createState() => _CreateEthAccountScreenState();
}

class _CreateEthAccountScreenState extends State<CreateEthAccountScreen> {


  TextEditingController password = new TextEditingController();
  TextEditingController reEnteredpassword = new TextEditingController();
  final WalletController walletController = Get.put(WalletController());


  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(builder: (wC){
      return ModalProgressHUD(
        inAsyncCall: wC.loading,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: kPrimaryColor.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              iconSize: 40,
                              icon: Icon(Icons.arrow_back_rounded),
                              color: Colors.black),
                          Spacer(),
                          Text(
                            "Create a new eth account.",
                            style: TextStyle(fontSize: 25),
                          ),
                          Spacer(),
                          Text(
                            "Please note that the account will be encrypted and saved in our database, So that you can retrieve the private key with your given password whenever you like.",
                            style: TextStyle(fontSize: 15),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            controller: password,
                            decoration: InputDecoration(
                              hintText: 'Enter your password.',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: kPrimaryColor, width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: kPrimaryColor, width: 2.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            controller: reEnteredpassword,
                            decoration: InputDecoration(
                              hintText: 'Re-enter your password.',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: kPrimaryColor, width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: kPrimaryColor, width: 2.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        child: Text('Create\nAccount'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(35),
                          primary: kPrimaryColor,
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          // print("password : " + password.text);
                          // print("reEnteredpassword : " + reEnteredpassword.text);
                          if(password.text.isNotEmpty && password.text==reEnteredpassword.text){
                            walletController.createAEthAccount(password: password.text, context: context);
                          }
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
