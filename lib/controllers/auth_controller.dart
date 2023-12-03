import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/fireCloud.dart';
import 'package:flutter_application_1/views/auth_screen/login_screen.dart';
import 'package:flutter_application_1/views/home_screen/home.dart';
import 'package:flutter_application_1/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  User? currentUser;
//   login method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//  signup method

  Future<UserCredential?> signUpMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      currentUser = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //  google sign in method
  GoogleLoginMethod({product}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential);
      var userResult = await auth.signInWithCredential(credential);
        FireCloud().storingUserData(
            name: userResult.user!.displayName,
            email: userResult.user!.email,
            method: "google",
            imageUrl: userResult.user!.photoURL);
      print("---------------------Google User--------------------------------");
      print(userResult.user!.uid);
      Get.to(() =>  Home(product: product));
    } catch (e) {
      print("Error Google is False" + e.toString());
    }
  }


  void updateLocalUserEmailAndPassword ({context }) {
    auth.authStateChanges().listen((user) async {
      if(user != null){
        final docRef = await firestore.collection(usersCollection).doc(user.uid);
        if(passwordController.text != ""){
          user?.updatePassword(passwordController.text);
        }
        docRef.update({"name" : userNameController.text}).then(
                (value) => print("update successful"),
            onError: (e) => print("Error updating document $e"));
        Get.to(() => ProfileScreen());
        VxToast.show(context, msg: "Change is successful");
      }else{
        VxToast.show(context, msg: "Something Error");
        Get.to(() => LoginScreen());
      }
    });
  }

  void signoutMethod(context) async {
    try {
      await auth.signOut();
      print("=================================SignOut!!!=======================================");
      print("signOut Done");
    } catch (e) {
      VxToast.show(context, msg: e.toString() + "----------Error!!!!!");
    }
  }
}
