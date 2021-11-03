import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ether_wallet_flutter_app/Screens/GetPrivateKey/getPrivateKey.dart';
import 'package:ether_wallet_flutter_app/Screens/ScanQRcode/ScanQrcode.dart';
import 'package:ether_wallet_flutter_app/controllers/sendERC20TokenController.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasPriceAPI.dart';
import 'package:ether_wallet_flutter_app/models/getTokenBalanceModel.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ether_wallet_flutter_app/widgets/TextField1.dart';
import 'package:get/get.dart';

class SendERC20Tokens extends StatefulWidget {

  final GetTokenBalanceModel token;

  const SendERC20Tokens({Key? key, required this.token}) : super(key: key);

  @override
  _SendERC20TokensState createState() => _SendERC20TokensState();
}

class _SendERC20TokensState extends State<SendERC20Tokens> {
  final WalletController walletController = Get.put(WalletController());
  final SendERC20TokenController sendERC20TokenController =
      Get.put(SendERC20TokenController());
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
        contractAddress: widget.token.tokenAddress);
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kPrimaryColor2],
                ),
              ),
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
                      color: Colors.white),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Send ERC20 tokens.",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Send erc20 token to another account from currently active account.",
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                    "Address of the Receiver : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  width: MediaQuery.of(context).size.width - 50,
                  child: TextField1(
                    obsucureText: false,
                    hint: "E.g. 0xc7..Ab",
                    label: "",
                    controller: toAddress,
                    inputType: TextInputType.text,
                    errorText: "Contract Address should be\n42 characters long",
                    validator: toAddress.text.length == 42,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => QRViewExample(text: toAddress),
                        ));
                      },
                      child: Icon(Icons.qr_code_scanner,
                          size: 30, color: kPrimaryColor2)),
                )
              ],
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Center(
                child: Text(
                  "Amount to send (in ${widget.token.tokenSymbol}) :",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25, top: 15),
              width: MediaQuery.of(context).size.width,
              child: TextField1(
                obsucureText: false,
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
              padding: EdgeInsets.only(left: 25, right: 25, top: 15),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField1(
                      obsucureText: false,
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
                    padding: const EdgeInsets.only(left: 8.0, bottom: 30.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor2,
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
              padding: EdgeInsets.only(left: 25, right: 25, top: 15),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField1(
                      obsucureText: false,
                      hint: "E.g. c7..Ab",
                      label: "",
                      controller: privateKey,
                      inputType: TextInputType.text,
                      validator: privateKey.text.length == 64,
                      errorText: "private key length\nshould be 64 characters",
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 30.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor2,
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new GetPrivateKey(),
                            ),
                          );
                        },
                        child: Text(
                          "get",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: InkWell(
                onTap: () {
                  try {
                    sendERC20TokenController.sendERC20(
                        network: walletController.network,
                        fromAddress: "0x" + walletController.activeAccount,
                        toAddress: toAddress.text.trim(),
                        contractAddress: widget.token.tokenAddress,
                        amountIn: double.parse(amountIn.text.trim()),
                        fromAddressPrivateKey: privateKey.text.trim(),
                        gasPrice: double.parse(gasPrice.text.trim()),
                        context: context);
                  } catch (e) {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Oops!',
                        desc: e.toString(),
                        btnOkOnPress: () {},
                        btnOkColor: kPrimaryColor)
                      ..show();
                  }
                },
                child: GetBuilder<SendERC20TokenController>(
                  builder: (stftc) {
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [kPrimaryColor, kPrimaryColor2],
                          ),
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
