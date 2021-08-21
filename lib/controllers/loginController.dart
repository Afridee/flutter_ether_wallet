import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ether_wallet_flutter_app/models/EncryptedEthAccountModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LoginController extends GetxController{

  bool isLoggedIn = fba.FirebaseAuth.instance.currentUser != null;
  Box<Map> userObjBox = Hive.box<Map>("userObj");
  Map<dynamic, dynamic>? userObj = Hive.box<Map>("userObj").get("userObj") ?? {};

  loginWithFb() async{

    await FacebookAuth.instance.login(
        permissions: ["public_profile", "email"]
    ).then((value) => {
      FacebookAuth.instance.getUserData().then((userData){
          userObj = userData;
          update();
      })
    });

    final AccessToken? accessToken = await FacebookAuth.instance.accessToken;


    if(accessToken!=null){

      final authResult;

      authResult = await  fba.FirebaseAuth.instance.signInWithCredential(
        fba.FacebookAuthProvider.credential(accessToken.token),
      );

      isLoggedIn = fba.FirebaseAuth.instance.currentUser != null;
      update();

      final CollectionReference users = FirebaseFirestore.instance.collection('Users');
      users.doc(authResult.user.uid).set(userObj);

      Map<dynamic, dynamic>? userObjTemp = userObj;

      userObjBox.put("userObj", userObjTemp ?? {});

      final status = await OneSignal.shared.getDeviceState();
      final String? osUserID = status?.userId;

      final CollectionReference oneSignalIds = FirebaseFirestore.instance.collection('Users/'+ authResult.user.uid +'/OneSignalIds');

      await oneSignalIds.doc(osUserID).get().then((doc) async{
        if(doc.exists){

          oneSignalIds.doc(osUserID).set({
            "data" :  osUserID
          });

          QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users/'+ authResult.user.uid +'/EthAccounts').get();

          if(querySnapshot.docs.length>0){
            for (int i = 0; i < querySnapshot.docs.length; i++) {
              EncryptedEthAccountModel model =
              EncryptedEthAccountModel.fromJson(querySnapshot.docs[i].get('data'));
              print(model.address);
              ///TODO: ADD the webhooks
            }
          }
        }
      });
    }
  }

  logOut() async{
    await fba.FirebaseAuth.instance.signOut();
    isLoggedIn = fba.FirebaseAuth.instance.currentUser != null;
    update();
  }
}