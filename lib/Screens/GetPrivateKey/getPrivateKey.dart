import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard/clipboard.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:ether_wallet_flutter_app/widgets/TextField1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class GetPrivateKey extends StatefulWidget {
  const GetPrivateKey({Key? key}) : super(key: key);

  @override
  _GetPrivateKeyState createState() => _GetPrivateKeyState();
}

class _GetPrivateKeyState extends State<GetPrivateKey> {
  late TextEditingController password;
  final WalletController walletController = Get.put(WalletController());

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
    return Scaffold(
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
        )));
  }
}
