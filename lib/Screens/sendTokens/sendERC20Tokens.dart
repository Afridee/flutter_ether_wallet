import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ether_wallet_flutter_app/controllers/sendERC20TokenController.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasPriceAPI.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ether_wallet_flutter_app/widgets/TextField1.dart';
import 'package:get/get.dart';

class SendERC20Tokens extends StatefulWidget {

  final int tokenIndex;
  final String tokenSymbol;

  const SendERC20Tokens({Key? key, required this.tokenIndex, required this.tokenSymbol}) : super(key: key);

  @override
  _SendERC20TokensState createState() => _SendERC20TokensState();
}

class _SendERC20TokensState extends State<SendERC20Tokens> {
  final WalletController walletController = Get.put(WalletController());
  final SendERC20TokenController sendERC20TokenController = Get.put(SendERC20TokenController());
  TextEditingController toAddress = new TextEditingController();
  TextEditingController amountIn = new TextEditingController();
  TextEditingController gasPrice = new TextEditingController();
  TextEditingController privateKey = new TextEditingController();

  @override
  void dispose() {
    toAddress.dispose();
    amountIn.dispose();
    gasPrice.dispose();
    privateKey.dispose();
    sendERC20TokenController.reset();
    super.dispose();
  }

  estimate() {
    sendERC20TokenController.estimateGas(
        network: walletController.network,
        fromAddress: "0x" + walletController.activeAccount,
        toAddress: toAddress.text,
        amountIn: double.parse(amountIn.text),
        context: context,
        contractAddress: walletController.eRC20TokenBox.getAt(widget.tokenIndex - 1) ?? '');
  }

  @override
  void initState() {
    toAddress.addListener(() {
      if (toAddress.text.isNotEmpty && amountIn.text.isNotEmpty) {
        estimate();
      }
    });
    amountIn.addListener(() {
      if (toAddress.text.isNotEmpty && amountIn.text.isNotEmpty) {
        estimate();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: kPrimaryColor.withOpacity(0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconSize: 40,
                      icon: Icon(Icons.arrow_back_rounded),
                      color: Colors.black),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Send Ether.",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Send ether to another account from currently active account.",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Center(
                child: Center(
                  child: Text(
                    "Contract Address of the Receiver : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: TextField1(
                hint: "E.g. 0xc7..Ab",
                label: "",
                controller: toAddress,
                inputType: TextInputType.text,
                errorText: "Contract Address should be 42 characters long",
                validator: toAddress.text.length == 42,
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Center(
                child: Text(
                  "Amount to send (in ${widget.tokenSymbol}) :",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: TextField1(
                hint: "E.g. 1.5",
                label: "",
                controller: amountIn,
                inputType: TextInputType.number,
                validator: true,
                errorText: '',
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Center(
                child: Text(
                  "Estimated Gas Needed for transaction:",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: GetBuilder<SendERC20TokenController>(
                builder: (sec) {
                  return Center(
                    child: Text(
                      "${sec.estimatedGasNeeded}",
                      style: TextStyle(fontSize: 16, color: kPrimaryColor),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Center(
                child: Text(
                  "Gas Price (in gwei):",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField1(
                      hint: "E.g. 1.000000009(in gwei)",
                      label: "",
                      controller: gasPrice,
                      inputType: TextInputType.number,
                      validator: true,
                      errorText: "",
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () async {
                            gasPrice.text = ".........";
                            Map<String, dynamic> m = await estimateGasPriceAPI(
                                network: walletController.network);
                            gasPrice.text = (m["GasPrice"] ?? "").toString();
                          },
                          child: Text(
                            "Estimate",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Center(
                child: Text(
                  "Private key of active account: ",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: TextField1(
                hint: "E.g. c7..Ab",
                label: "",
                controller: privateKey,
                inputType: TextInputType.text,
                validator: privateKey.text.length == 64,
                errorText: "private key length should be 64 characters",
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: InkWell(
                onTap: () {
                  try {
                     sendERC20TokenController.sendERC20(network: walletController.network, fromAddress:"0x"+walletController.activeAccount, toAddress: toAddress.text, contractAddress: walletController.eRC20TokenBox.getAt(widget.tokenIndex - 1) ?? '', amountIn: double.parse(amountIn.text), fromAddressPrivateKey: privateKey.text, gasPrice: double.parse(gasPrice.text), context: context);

                  } catch (e) {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Oops!',
                        desc: e.toString(),
                        btnOkOnPress: () {},
                        btnOkColor: kPrimaryColor
                    )..show();
                  }
                },
                child: GetBuilder<SendERC20TokenController>(
                  builder: (stftc) {
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kPrimaryColor),
                      child: Center(
                        child: Text(
                          stftc.allowButtonPress ? "Send" : "Processing...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


