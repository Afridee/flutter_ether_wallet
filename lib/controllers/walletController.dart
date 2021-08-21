import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../functions/createEthAccountAPI.dart';

class WalletController extends GetxController{


    createAEthAccount() async {

      ///TODO: It should ask for a password
      Map account = await createEthAccountAPI();

      if(account['error']==null){
        final currentUser = fba.FirebaseAuth.instance.currentUser;
        String currentUserUid = "...";

        if(currentUser!=null){
          currentUserUid = currentUser.uid;
        }

        final CollectionReference ethAccounts = FirebaseFirestore.instance.collection('Users/'+ currentUserUid +'/EthAccounts');

        ethAccounts.doc().set({
          "data" : account
        });
      }else{
        print("error while creating eth account : "  + account['error'].toString());
      }
    }

}