import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class WalletController extends GetxController{

    final String baseUrl = dotenv.env['BASE_URL'].toString();

    createAEthAccount() async {
      var url = Uri.parse(baseUrl + '/accounts/create');
      var response = await http.post(
          url, headers: {"Content-Type": "application/json"},
          body: jsonEncode({"password": "doodle"}));
      Map account = jsonDecode(response.body);


      final currentUser = fba.FirebaseAuth.instance.currentUser;
      String currentUserUid = "...";
      if(currentUser!=null){
        currentUserUid = currentUser.uid;
      }

      final CollectionReference ethAccounts = FirebaseFirestore.instance.collection('Users/'+ currentUserUid +'/EthAccounts');

      ethAccounts.doc().set(account);
    }

}