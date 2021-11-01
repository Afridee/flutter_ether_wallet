import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ether_wallet_flutter_app/Screens/GetPrivateKey/getPrivateKey.dart';
import 'package:ether_wallet_flutter_app/controllers/swapetherwithtokesController.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasPriceAPI.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ether_wallet_flutter_app/widgets/TextField1.dart';
import 'package:get/get.dart';

class SwapEthersWithTokens extends StatefulWidget {
  @override
  _SwapEthersWithTokensState createState() => _SwapEthersWithTokensState();
}

class _SwapEthersWithTokensState extends State<SwapEthersWithTokens> {
  TextEditingController tokenAddress = new TextEditingController();
  TextEditingController value = new TextEditingController();
  TextEditingController amountOutMin = new TextEditingController();
  TextEditingController gasPrice = new TextEditingController();
  TextEditingController privateKey = new TextEditingController();
  final WalletController walletController = Get.put(WalletController());
  final SwapetherwithtokesController swapetherwithtokesController =
      Get.put(SwapetherwithtokesController());

  estmateGas() async {
    swapetherwithtokesController.estimateGas(
        network: walletController.network,
        amountOutMin: amountOutMin.text,
        tokenAddress: tokenAddress.text,
        value: value.text,
        admin: "0x" + walletController.activeAccount,
        context: context);
  }

  estimateOutput() async {
    amountOutMin.text = "Loading...";
    try {
      amountOutMin.text = await swapetherwithtokesController.estimateAmountsOut(
          network: walletController.network,
          toContractAddress: tokenAddress.text,
          amountIn: double.parse(value.text),
          context: context);
    } catch (e) {}
  }

  @override
  void initState() {
    tokenAddress.addListener(() {
      estmateGas();
      estimateOutput();
    });
    value.addListener(() {
      estmateGas();
      estimateOutput();
    });
    amountOutMin.addListener(() {
      estmateGas();
    });
    super.initState();
  }

  @override
  void dispose() {
    tokenAddress.dispose();
    value.dispose();
    amountOutMin.dispose();
    gasPrice.dispose();
    privateKey.dispose();
    swapetherwithtokesController.reset();
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
                      "Swap Ether with ERC20 token.",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Swap ether with an erc20 token using Uniswap's 'swapExactETHForTokens'.",
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
                    "Contract Address of the token : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              width: MediaQuery.of(context).size.width,
              child: TextField1(
                obsucureText: false,
                hint: "E.g. 0x...ff",
                label: "",
                controller: tokenAddress,
                inputType: TextInputType.text,
                validator: tokenAddress.text.length == 42,
                errorText: 'Contract address length should be 42 characters',
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Center(
                child: Text(
                  "Amount to send (in Ether) :",
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
                controller: value,
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
                  "Minimum amount of token you want in return:\n",
                  textAlign: TextAlign.center,
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
                    child: GetBuilder<SwapetherwithtokesController>(
                      builder: (sewtc) {
                        return TextField1(
                          obsucureText: false,
                          hint: "E.g. 1",
                          label: "",
                          controller: amountOutMin,
                          inputType: TextInputType.number,
                          validator: sewtc.errortextForAmountsOut.isEmpty,
                          errorText: sewtc.errortextForAmountsOut,
                        );
                      },
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 20.0),
                    child: GetBuilder<SwapetherwithtokesController>(
                      builder: (sewtc) {
                        return Text(
                          sewtc.tokenName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        );
                      },
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
                  "Estimated Gas Needed for transaction:",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: GetBuilder<SwapetherwithtokesController>(
                builder: (sewtc) {
                  return Center(
                    child: Text(
                      "${sewtc.estimatedGasNeeded}",
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
                      errorText: "private key length should\nbe 64 characters",
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
                    //print(privateKey.text);
                    swapetherwithtokesController.swap(
                        network: walletController.network,
                        privateKey: privateKey.text.trim(),
                        tokenAddress: tokenAddress.text.trim(),
                        amountOutMin: double.parse(amountOutMin.text.trim()),
                        value: double.parse(value.text.trim()),
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
                child: GetBuilder<SwapetherwithtokesController>(
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
                          stftc.allowButtonPress ? "Swap" : "Processing...",
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
