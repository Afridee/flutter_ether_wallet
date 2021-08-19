import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:get/get.dart';
import 'package:hive/hive.dart';

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

    final authResult;

    if(accessToken!=null){
      authResult = await  fba.FirebaseAuth.instance.signInWithCredential(
        fba.FacebookAuthProvider.credential(accessToken.token),
      );

      isLoggedIn = true;
      update();

      final CollectionReference users = FirebaseFirestore.instance.collection('Users');
      users.doc(authResult.user.uid).set(userObj);

      Map<dynamic, dynamic>? userObj_temp = userObj;

      userObjBox.put("userObj", userObj_temp ?? {});
    }
  }
}