import 'package:ether_wallet_flutter_app/functions/getAllWebhooks.dart';
import 'package:ether_wallet_flutter_app/functions/updateWebhookAddresses.dart';
import 'package:ether_wallet_flutter_app/models/EncryptedEthAccountModel.dart';
import 'package:ether_wallet_flutter_app/models/WebhooksModel.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../functions/createEthAccountAPI.dart';

class WalletController extends GetxController {
  createAEthAccount() async {
    ///TODO: It should ask for a password
    Map<String, dynamic> account = await createEthAccountAPI();

    if (account['error'] == null) {
      final currentUser = fba.FirebaseAuth.instance.currentUser;
      String currentUserUid = "...";

      if (currentUser != null) {
        currentUserUid = currentUser.uid;
      }

      final CollectionReference ethAccounts = FirebaseFirestore.instance
          .collection('Users/' + currentUserUid + '/EthAccounts');

      ethAccounts.doc().set({"data": account});

      EncryptedEthAccountModel accountModel =
          EncryptedEthAccountModel.fromJson(account);

      List<Datum> webhooks = await getAllWebhooks();

      if (webhooks.length > 0) {
        webhooks.forEach((webhook) {
          List<String> addresses = webhook.addresses;
          addresses.add(accountModel.address);
          updateWebhookAddresses(webhook.id, addresses);
        });
      } else {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Users/' +
                fba.FirebaseAuth.instance.currentUser!.uid +
                '/OneSignalIds')
            .get();

        List<String> oneSignalIds = [];

        for (int i = 0; i < querySnapshot.docs.length; i++) {

        }
        ///TODO: more work to go
      }
    } else {
      print(
          "error while creating eth account : " + account['error'].toString());
    }
  }
}
