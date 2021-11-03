import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ether_wallet_flutter_app/Screens/GetPrivateKey/getPrivateKey.dart';
import 'package:ether_wallet_flutter_app/controllers/ApproveERC20tokenController.dart';
import 'package:ether_wallet_flutter_app/controllers/walletController.dart';
import 'package:ether_wallet_flutter_app/functions/estimateGasPriceAPI.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ether_wallet_flutter_app/widgets/TextField1.dart';
import 'package:get/get.dart';

class ApproveERC20token extends StatefulWidget {
  @override
  _ApproveERC20tokenState createState() => _ApproveERC20tokenState();
}

class _ApproveERC20tokenState extends State<ApproveERC20token> {
  TextEditingController tokenAddress = new TextEditingController();
  TextEditingController amountIn = new TextEditingController();
  TextEditingController gasPrice = new TextEditingController();
  TextEditingController privateKey = new TextEditingController();
  final WalletController walletController = Get.put(WalletController());
  final ApproveERC20tokenController approveERC20tokenController =
      Get.put(ApproveERC20tokenController());

  estimate() {
    approveERC20tokenController.estimateGasForApprovingToken(
        network: walletController.network,
        tokenAddress: tokenAddress.text,
        from: "0x" + walletController.activeAccount,
        amountIn: double.parse(amountIn.text.trim()));
  }

  @override
  void dispose() {
    tokenAddress.dispose();
    amountIn.dispose();
    gasPrice.dispose();
    privateKey.dispose();
    approveERC20tokenController.reset();
    super.dispose();
  }

  @override
  void initState() {
    tokenAddress.addListener(() {
      if (tokenAddress.text.isNotEmpty && amountIn.text.isNotEmpty) {
        estimate();
      }
    });
    amountIn.addListener(() {
      if (tokenAddress.text.isNotEmpty && amountIn.text.isNotEmpty) {
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
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      "Approve ERC20 Token.",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      "Approve an erc20 token for Uniswap before swapping.",
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
                    "Token Address : ",
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
                hint: "E.g. 0xc7..Ab",
                label: "",
                controller: tokenAddress,
                inputType: TextInputType.text,
                errorText: "Contract Address should be 42 characters long",
                validator: tokenAddress.text.length == 42,
                obsucureText: false,
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Center(
                child: Text(
                  "Amount to approve:",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25),
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
              child: GetBuilder<ApproveERC20tokenController>(
                builder: (aerc20tc) {
                  return Center(
                    child: Text(
                      "${aerc20tc.estimatedGasNeeded}",
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
                    ),
                  ),
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
              padding: EdgeInsets.only(right: 25, left: 25, top: 15),
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
                      errorText: "private key length should be\n64 characters",
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
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: InkWell(
                onTap: () {
                  try {
                    approveERC20tokenController.approve(
                        network: walletController.network,
                        tokenAddress: tokenAddress.text.trim(),
                        privateKey: privateKey.text.trim(),
                        gasPrice: double.parse(gasPrice.text.trim()),
                        from: "0x" + walletController.activeAccount,
                        amountIn: double.parse(amountIn.text.trim()),
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
                child: GetBuilder<ApproveERC20tokenController>(
                  builder: (aerc20tc) {
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [kPrimaryColor, kPrimaryColor2],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          aerc20tc.allowButtonPress
                              ? "Approve"
                              : "Processing...",
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
