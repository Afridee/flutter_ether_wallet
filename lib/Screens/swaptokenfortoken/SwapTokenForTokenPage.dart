import 'package:ether_wallet_flutter_app/controllers/SwapTokenForTokenController.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasPriceAPI.dart';
import 'package:ether_wallet_flutter_app/functions/getAmountsOutForTokenSwapAPI.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:ether_wallet_flutter_app/widgets/TextField1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:numberpicker/numberpicker.dart';

class SwapTokenForToken extends StatefulWidget {
  final int tokenIndex;

  const SwapTokenForToken({Key? key, required this.tokenIndex})
      : super(key: key);

  @override
  _SwapTokenForTokenState createState() => _SwapTokenForTokenState();
}

class _SwapTokenForTokenState extends State<SwapTokenForToken> {
  final WalletController walletController = Get.put(WalletController());
  final SwapTokenForTokenController swapTokenForTokenController =
      Get.put(SwapTokenForTokenController());
  Box<String> eRC20TokenBox = Hive.box<String>('ERC20Tokens');
  TextEditingController toContractAddress = new TextEditingController();
  TextEditingController amountIn = new TextEditingController();
  TextEditingController gas = new TextEditingController();
  TextEditingController privateKey = new TextEditingController();
  TextEditingController gasPrice = new TextEditingController();

  @override
  void initState() {
    toContractAddress.addListener(() {
      swapTokenForTokenController.estimateAmountsOut(
        network: walletController.network,
        amountIn: amountIn.text,
        fromContractAddress:
            walletController.eRC20TokenBox.getAt(widget.tokenIndex - 1) ?? '',
        toContractAddress: toContractAddress.text,
      );
    });
    amountIn.addListener(() {
      swapTokenForTokenController.estimateAmountsOut(
        network: walletController.network,
        amountIn: amountIn.text,
        fromContractAddress:
            walletController.eRC20TokenBox.getAt(widget.tokenIndex - 1) ?? '',
        toContractAddress: toContractAddress.text,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    toContractAddress.dispose();
    amountIn.dispose();
    gas.dispose();
    privateKey.dispose();
    gasPrice.dispose();
    super.dispose();
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
                      "Swap exact tokens for tokens.",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "This functionality uses Uniswap's 'swapExactTokensForTokens' function to swap tokens",
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
                    "Contract Address of the token you want to swap with :",
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
                controller: toContractAddress,
                inputType: TextInputType.text,
                validator: toContractAddress.text.length == 42,
                errorText: "Contract Address should be 42 characters long",
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
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Center(
                child: Text(
                  "The amount of input tokens to send :",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: TextField1(
                hint: "E.g. 0.2",
                label: "",
                controller: amountIn,
                inputType: TextInputType.text,
                validator: true,
                errorText: "",
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Center(
                child: Text(
                  "Gas :",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: TextField1(
                hint: "E.g. 120000",
                label: "",
                controller: gas,
                inputType: TextInputType.number,
                validator: true,
                errorText: "",
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Center(
                child: Text(
                  "Gas Price:",
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
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Center(
                child: Text(
                  "The minimum amount of output tokens that must be received for the transaction not to revert :",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GetBuilder<SwapTokenForTokenController>(
                      builder: (STC) {
                        return NumberPicker(
                            textStyle: TextStyle(color: Colors.grey),
                            selectedTextStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: kPrimaryColor.withOpacity(0.1)),
                            value: STC.minOutPercentage,
                            minValue: 0,
                            maxValue: 100,
                            onChanged: (val) {
                              swapTokenForTokenController
                                  .changeMinOutPercentage(val);
                            });
                      },
                    ),
                    Text(
                      "% of",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: 160,
                        child: GetBuilder<SwapTokenForTokenController>(
                          builder: (STC) {
                            return Text(
                              STC.estimatedamountsOut + STC.amountsOutToken,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                        ))
                  ],
                ),
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: InkWell(
                onTap: (){
                  swapTokenForTokenController.estimateGasForSwappingToken(network: walletController.network, fromContractAddress: walletController.eRC20TokenBox.getAt(widget.tokenIndex - 1) ?? '', toContractAddress: toContractAddress.text, from: "0x"+walletController.activeAccount, amountIn: amountIn.text, context: context);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kPrimaryColor
                  ),
                  child: Center(
                    child: Text(
                        "Swap",
                         style: TextStyle(
                           color: Colors.white
                         ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
