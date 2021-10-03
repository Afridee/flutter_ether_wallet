import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ether_wallet_flutter_app/widgets/TextField1.dart';

class SendTokens extends StatefulWidget {
  @override
  _SendTokensState createState() => _SendTokensState();
}

class _SendTokensState extends State<SendTokens> {
  TextEditingController toContractAddress = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Container(
        //       width: MediaQuery.of(context).size.width,
        //       color: kPrimaryColor.withOpacity(0.2),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           SizedBox(
        //             height: 30,
        //           ),
        //           IconButton(
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //               iconSize: 40,
        //               icon: Icon(Icons.arrow_back_rounded),
        //               color: Colors.black),
        //           SizedBox(
        //             height: 30,
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.only(left: 15.0),
        //             child: Text(
        //               "Send ERC20 Tokens",
        //               style: TextStyle(fontSize: 25),
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(15.0),
        //             child: Text(
        //               "This functionality uses Uniswap's 'swapExactTokensForTokens' function to swap tokens",
        //               style: TextStyle(fontSize: 15),
        //             ),
        //           ),
        //           SizedBox(
        //             height: 30,
        //           ),
        //         ],
        //       ),
        //     ),
        //     SizedBox(
        //       height: 30,
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       height: 70,
        //       child: Center(
        //         child: Center(
        //           child: Text(
        //             "Contract Address of the token you want to swap with :",
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //                 fontSize: 16,
        //                 color: Colors.grey
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       child: TextField1(
        //         hint: "E.g. 0xc7..Ab",
        //         label: "",
        //         controller: toContractAddress,
        //         inputType: TextInputType.text,
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       height: 70,
        //       child: Center(
        //         child: Text(
        //           "Private key of active account: ",
        //           style: TextStyle(
        //               fontSize: 16,
        //               color: Colors.grey
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       child: TextField1(
        //         hint: "E.g. c7..Ab",
        //         label: "",
        //         controller: toContractAddress,
        //         inputType: TextInputType.text,
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       height: 70,
        //       child: Center(
        //         child: Text(
        //           "The amount of input tokens to send :",
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //               fontSize: 16,
        //               color: Colors.grey
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       child: TextField1(
        //         hint: "E.g. 0xc7..Ab",
        //         label: "",
        //         controller: toContractAddress,
        //         inputType: TextInputType.text,
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       height: 70,
        //       child: Center(
        //         child: Text(
        //           "Gas :",
        //           style: TextStyle(
        //               fontSize: 16,
        //               color: Colors.grey
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       child: TextField1(
        //         hint: "E.g. 0xc7..Ab",
        //         label: "",
        //         controller: toContractAddress,
        //         inputType: TextInputType.text,
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       height: 70,
        //       child: Center(
        //         child: Text(
        //           "Gas Price:",
        //           style: TextStyle(
        //               fontSize: 16,
        //               color: Colors.grey
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       child: TextField1(
        //         hint: "E.g. 0xc7..Ab",
        //         label: "",
        //         controller: toContractAddress,
        //         inputType: TextInputType.text,
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       height: 70,
        //       child: Center(
        //         child: Text(
        //           "The minimum amount of output tokens that must be received for the transaction not to revert :",
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //               fontSize: 16,
        //               color: Colors.grey
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(15),
        //       width: MediaQuery.of(context).size.width,
        //       child: TextField1(
        //         hint: "E.g. 0xc7..Ab",
        //         label: "",
        //         controller: toContractAddress,
        //         inputType: TextInputType.text,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}


