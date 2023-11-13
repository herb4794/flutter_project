import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:get/get.dart';

//  storing data method

class FireCloud extends GetxController {

  storingUserData({name, password, email, imageUrl}) async {

    if(currentUser != null){
      DocumentReference store =
      firestore.collection(usersCollection).doc(currentUser!.uid);
      store.set(
      {'name': name, 'password': password, 'email': email, 'imageUrl': imageUrl, "orders" : []});
    }
  }

  // cart get data method
}

