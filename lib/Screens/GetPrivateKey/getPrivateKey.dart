import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard/clipboard.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:ether_wallet_flutter_app/widgets/TextField1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class GetPrivateKey extends StatefulWidget {
  const GetPrivateKey({Key? key}) : super(key: key);

  @override
  _GetPrivateKeyState createState() => _GetPrivateKeyState();
}

class _GetPrivateKeyState extends State<GetPrivateKey> {
  late TextEditingController password;
  final WalletController walletController = Get.put(WalletController());
  bool press = true;

  @override
  void initState() {
    password = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      inAsyncCall: !press,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
          ),
          body: Container(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "The currently active account is",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<WalletController>(builder: (wc) {
                  return Text(
                    "0x" + wc.activeAccount,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: TextField1(
                      controller: password,
                      inputType: TextInputType.text,
                      hint: "password",
                      label: "password",
                      validator: true,
                      errorText: "",
                      obsucureText: true),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async{
                    if(press){
                      setState(() {
                        press = false;
                      });
                      String privateKey = await walletController.getPrivateKey(password: password.text);
                      FlutterClipboard.copy(privateKey.substring(2,privateKey.length))
                          .then((value) => {
                        AwesomeDialog(
                            padding: EdgeInsets.all(15),
                            context: context,
                            dialogType: privateKey!="******" ? DialogType.SUCCES : DialogType.ERROR,
                            animType: AnimType.BOTTOMSLIDE,
                            title: privateKey!="******" ? 'Private key has been copied to clipboard!':"Wrong password!",
                            desc: "Private Key: "+ privateKey.substring(2,privateKey.length),
                            btnOkOnPress: () {},
                            btnOkColor: kPrimaryColor)
                          ..show()
                      });
                      setState(() {
                        press = true;
                      });
                    }
                  },
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Show Private Key",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          kPrimaryColor,
                          kPrimaryColor2
                        ]
                      )
                    ),
                  ),
                )
              ],
            ),
          ))),
    );
  }
}
