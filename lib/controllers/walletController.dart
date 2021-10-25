import 'dart:convert';
import 'dart:math';
import 'package:ether_wallet_flutter_app/functions/DecodeInputDataAPI.dart';
import 'package:ether_wallet_flutter_app/functions/createWebhookForAddressActivity.dart';
import 'package:ether_wallet_flutter_app/functions/getABI.dart';
import 'package:ether_wallet_flutter_app/functions/getAllWebhooks.dart';
import 'package:ether_wallet_flutter_app/functions/getERC20txList.dart';
import 'package:ether_wallet_flutter_app/functions/getETHBalanceAPI.dart';
import 'package:ether_wallet_flutter_app/functions/getEthPrice.dart';
import 'package:ether_wallet_flutter_app/functions/getTokenBalanceAPI.dart';
import 'package:ether_wallet_flutter_app/functions/gettxList.dart';
import 'package:ether_wallet_flutter_app/functions/importAccount.dart';
import 'package:ether_wallet_flutter_app/functions/updateWebhookAddresses.dart';
import 'package:ether_wallet_flutter_app/models/ERC20tokenTransferModel.dart';
import 'package:ether_wallet_flutter_app/models/EncryptedEthAccountModel.dart';
import 'package:ether_wallet_flutter_app/models/WebhooksModel.dart';
import 'package:ether_wallet_flutter_app/models/getTokenBalanceModel.dart';
import 'package:ether_wallet_flutter_app/models/transactionListtransactionmodel.dart';
import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:ether_wallet_flutter_app/widgets/ethAccountCreatedDialogue.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../functions/createEthAccountAPI.dart';

class WalletController extends GetxController {
  bool loading = false;
  int lastTransactionScreen = -1;

  Box<String> eRC20TokenBox = Hive.box<String>('ERC20Tokens');

  List<EncryptedEthAccountModel> ethAccounts = [];
  String network = "rinkeby";

  String activeAccount = 'Not Available';
  String activeAccountEthBalance = '0';
  String activeAccountUSDBalance = '0';

  List<GetTokenBalanceModel> tokenList = [];

  List<Erc20TokenTransferModel> erc20transfers = [];

  List<TransactionListtransactionmodel> ethTransfers = [];

  changeExplorer(String network) {
    this.network = network;
    update();
    setUpEthAccount(ethAccount: activeAccount);
  }

  Future<String> decodeInputData(
      {required String address, required String input}) async {
    try {
      var response = await getABI(network: "-$network", address: address);
      var decoded = await decodeInputDataAPI(
        inputdata: input,
        abi: jsonDecode(
          response['result'],
        ),
      );

      return decoded['name'];
    } catch (e) {
      return "Smart Contract interaction";
    }
  }

  getTokenTransactions(int contractIndex) async {
    lastTransactionScreen = contractIndex;
    erc20transfers = [];
    update();

    if (contractIndex >= 0) {
      var response = await getERC20transactions(
          network: network=="rinkeby" ? "-$network" : "",
          address: "0x" + activeAccount,
          contractaddress: eRC20TokenBox.getAt(contractIndex).toString(),
          page: 1,
          offset: 100);

      if (response['error'] == null) {
        List transactions = response['result'];
        transactions.forEach((element) {
          Erc20TokenTransferModel transferDetails =
              Erc20TokenTransferModel.fromJson(element);
          erc20transfers.add(transferDetails);
        });
      }
      update();
    } else {
      var response = await getTransactions(
          network: network=="rinkeby" ? "-$network" : "",
          address: "0x" + activeAccount,
          page: 1,
          offset: 100);

      if (response['error'] == null) {
        List transactions = response['result'];
        transactions.forEach((element) {
          TransactionListtransactionmodel transferDetails =
              TransactionListtransactionmodel.fromJson(element);
          ethTransfers.add(transferDetails);
        });
      }

      update();
    }
  }

  getTokens() async {
    loading = true;
    update();

    tokenList = [];

    tokenList.add(new GetTokenBalanceModel(
        tokenSymbol: 'ETH',
        tokenName: 'ETH',
        balance: activeAccountEthBalance.toString(),
        tokenDecimal: '18'));

    for (int i = 0; i < eRC20TokenBox.length; i++) {
      if (eRC20TokenBox.getAt(i) != null) {
        String tknAddress = eRC20TokenBox.getAt(i).toString();
        var response = await getTokenBalanceAPI(
            network: network,
            tokenAddress: tknAddress,
            walletAddress: '0x' + activeAccount);
        GetTokenBalanceModel token = GetTokenBalanceModel.fromJson(response);
        tokenList.add(token);
      }
    }

    loading = false;
    update();
  }

  AddToken({required String tknAddress}) async {
    var response = await getTokenBalanceAPI(
        network: network,
        tokenAddress: tknAddress,
        walletAddress: '0x' + activeAccount);

    if (response["error"] == null) {
      GetTokenBalanceModel token = GetTokenBalanceModel.fromJson(response);
      eRC20TokenBox.put(token.tokenSymbol, tknAddress);
    } else {
      print("Error while adding token: ");
      print(response["error"]);
    }

    getTokens();
  }

  getEthAccounts() async {
    ethAccounts = [];

    final currentUser = fba.FirebaseAuth.instance.currentUser;
    String currentUserUid = "...";

    if (currentUser != null) {
      currentUserUid = currentUser.uid;
    }

    final CollectionReference ethAccountsCollection = FirebaseFirestore.instance
        .collection('Users/' + currentUserUid + '/EthAccounts');
    QuerySnapshot querySnapshot = await ethAccountsCollection.get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      EncryptedEthAccountModel model =
          EncryptedEthAccountModel.fromJson(querySnapshot.docs[i].get('data'));
      ethAccounts.add(model);
    }

    update();

    if (activeAccount == "Not Available" && ethAccounts.length > 0) {
      setUpEthAccount(ethAccount: ethAccounts[0].address);
    }
  }

  setUpEthAccount({required ethAccount}) async {
    loading = true;
    update();

    activeAccount = ethAccount;

    Map<String, dynamic> response =
        await getETHBalanceAPI(address: "0x" + activeAccount, network: network);
    if (response["error"] == null) {
      activeAccountEthBalance =
          double.parse(response["balance"]).toStringAsFixed(3);
    }

    response = await getEthPrice();

    if (response["error"] == null) {
      activeAccountUSDBalance =
          (double.parse((response['result']['ethusd']).toString()) *
                  double.parse(activeAccountEthBalance))
              .toStringAsFixed(3);
    }

    update();

    getTokens();
  }

  createAEthAccount(
      {required BuildContext context, required String password}) async {
    loading = true;
    update();

    Map<String, dynamic> account =
        await createEthAccountAPI(password: password);

    if (account['error'] == null) {
      final currentUser = fba.FirebaseAuth.instance.currentUser;
      String currentUserUid = "...";

      if (currentUser != null) {
        currentUserUid = currentUser.uid;
      }

      final CollectionReference ethAccounts = FirebaseFirestore.instance
          .collection('Users/' + currentUserUid + '/EthAccounts');

      ethAccounts.doc("0x" + account['address']).set({"data": account});

      EncryptedEthAccountModel accountModel =
          EncryptedEthAccountModel.fromJson(account);

      loading = false;
      update();

      Navigator.of(context).pop();
      ethAccountCreatedDialog(
          context: context,
          ethAddress: accountModel.address,
          color: kPrimaryColor,
          title: "Eth account created");

      getEthAccounts();
    } else {
      loading = false;
      update();
      print(
          "error while creating eth account : " + account['error'].toString());
    }
  }

  importAEthAccount(
      {required String password,
      required String privateKey,
      required BuildContext context}) async {
    loading = true;
    update();

    Map<String, dynamic> account =
        await importEthAccountAPI(password: password, privateKey: privateKey);

    if (account['error'] == null) {
      final currentUser = fba.FirebaseAuth.instance.currentUser;
      String currentUserUid = "...";

      if (currentUser != null) {
        currentUserUid = currentUser.uid;
      }

      final CollectionReference ethAccounts = FirebaseFirestore.instance
          .collection('Users/' + currentUserUid + '/EthAccounts');

      ethAccounts.doc("0x" + account['address']).set({"data": account});

      EncryptedEthAccountModel accountModel =
          EncryptedEthAccountModel.fromJson(account);

      loading = false;
      update();

      Navigator.of(context).pop();
      ethAccountCreatedDialog(
          context: context,
          ethAddress: accountModel.address,
          color: kPrimaryColor,
          title: "Eth account imported");

      getEthAccounts();
    } else {
      loading = false;
      update();
      print(
          "error while importing eth account : " + account['error'].toString());
    }
  }
}
