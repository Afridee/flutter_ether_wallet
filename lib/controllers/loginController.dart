import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ether_wallet_flutter_app/functions/createWebhookForAddressActivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LoginController extends GetxController {
  bool isLoggedIn = fba.FirebaseAuth.instance.currentUser != null;
  Box<Map> userObjBox = Hive.box<Map>("userObj");
  Map<dynamic, dynamic>? userObj = Hive.box<Map>("userObj").get("userObj") ?? {};
  bool registerring = false;
  bool allowButtonPress  = true;

  regi(){
    registerring = ! registerring;
    update();
  }

  resetPassword({required String email, required BuildContext context}) async{

    if(email.contains("@") && email.contains(".com")){
      await fba.FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Email Sent',
        desc: "A mail has been sent to ${email} for resetting password.",
      )..show();
    }else{
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Oops!',
        desc: "Make Sure You have typed the email properly before pressing 'forgot your password'",
      )..show();
    }
  }

  loginWithFb({required BuildContext context}) async {
    if(allowButtonPress){

      allowButtonPress = false;
      update();
      Timer(Duration(seconds: 5),() async{
        allowButtonPress = true;
        update();
      });

      try {
        await FacebookAuth.instance
                  .login(permissions: ["public_profile", "email"]).then((value) => {
                FacebookAuth.instance.getUserData().then((userData) {
                  userObj = userData;
                  update();
                })
              });

        final AccessToken? accessToken = await FacebookAuth.instance.accessToken;

        if (accessToken != null) {
                final authResult;

                authResult = await fba.FirebaseAuth.instance.signInWithCredential(
                  fba.FacebookAuthProvider.credential(accessToken.token),
                );

                isLoggedIn = fba.FirebaseAuth.instance.currentUser != null;
                update();

                final CollectionReference users =
                FirebaseFirestore.instance.collection('Users');
                users.doc(authResult.user.uid).set(userObj);

                Map<dynamic, dynamic>? userObjTemp = userObj;

                userObjBox.put("userObj", userObjTemp ?? {});

                afterLogin(authResult);
              }
      } catch (e) {
        allowButtonPress = true;
        update();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Oops!',
          desc: e.toString(),
        )..show();
      }
    }
  }

  loginWithEmail({required String email, required String password, required BuildContext context}) async {
    if(allowButtonPress){
      allowButtonPress = false;
      update();
      Timer(Duration(seconds: 5),() async{
        allowButtonPress = true;
        update();
      });

      final fba.UserCredential authResult;

      try {

        if(registerring){
          authResult = await fba.FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        }else{
          authResult = await fba.FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        }

        isLoggedIn = fba.FirebaseAuth.instance.currentUser != null;
        update();

        if(isLoggedIn){
          userObj = {
            "name" : authResult.user!.email,
            "picture" : {
              "data" : {
                "url" : "https://firebasestorage.googleapis.com/v0/b/ether-wallet-56723.appspot.com/o/profile.png?alt=media&token=8d98c998-6949-476d-ba7f-5ff00a8f8343"
              }
            }
          };

          final CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
          users.doc(authResult.user!.uid).set({
            "name" : authResult.user!.email,
            "picture" : {
              "data" : {
                "url" : "https://firebasestorage.googleapis.com/v0/b/ether-wallet-56723.appspot.com/o/profile.png?alt=media&token=8d98c998-6949-476d-ba7f-5ff00a8f8343"
              }
            }
          });

          Map<dynamic, dynamic>? userObjTemp = userObj;

          userObjBox.put("userObj", userObjTemp ?? {});

          afterLogin(authResult);
        }
      } catch (e) {
        allowButtonPress = true;
        update();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Oops!',
          desc: e.toString(),
        )..show();
      }
    }
  }

  afterLogin(fba.UserCredential authResult) async{

    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;

    final CollectionReference oneSignalIds = FirebaseFirestore.instance
        .collection('Users/' + authResult.user!.uid + '/OneSignalIds');

    await oneSignalIds.doc(osUserID).get().then((doc) async {
      if (!doc.exists) {
        oneSignalIds.doc(osUserID).set({"data": osUserID});

        var response =
        await create_Webhook_ForMinedTransactionNotifications(
            appId: dotenv.env['ALCHEMY_MAINNET_APP_ID'].toString(),
            playerId: osUserID.toString(),
            userId : authResult.user!.uid
            );
        var response2 =
        await create_Webhook_ForMinedTransactionNotifications(
            appId: dotenv.env['ALCHEMY_RINKEBY_APP_ID'].toString(),
            playerId: osUserID.toString(),
            userId : authResult.user!.uid
            );
      }
    });
  }

  logOut() async {
    await fba.FirebaseAuth.instance.signOut();
    isLoggedIn = fba.FirebaseAuth.instance.currentUser != null;
    update();
  }
}
