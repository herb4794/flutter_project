import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

//  storing data method

class FireCloud extends GetxController {
  UploadTask? uploadTask;
  var storage;

  FireCloud(){
    storage = FirebaseStorage.instance.ref();
  }

  Future uploadImage({email, imageName,file}) async {
    final ref = storage.child('${email}/${imageName}');
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete((){});
    final urlDownload = await snapshot.ref.getDownloadURL();
    auth.authStateChanges().listen((user) async {
      if(user != null){
        final docRef = await firestore.collection(usersCollection).doc(user.uid);
        docRef.update({"imageUrl" : urlDownload.toString()}).then(
              (value) => print("upData successful"),
        onError: (e) => print("Error updating document $e"));
      }
    });
  }

  Future getStroageImage ({email , uid}) async {
    final ref = FirebaseStorage.instance.ref();
    final data = ref.child('${email}/scaled_hey_icon.jpg');
    final imageList = await data.getDownloadURL();
  }

  storingUserData({name, method, email, imageUrl}) async {

    if(currentUser != null){
      DocumentReference store =
      firestore.collection(usersCollection).doc(currentUser!.uid);
      store.set(
      {'name': name, 'method': method, 'email': email, 'imageUrl': imageUrl, "orders" : []});
    }
  }

  // cart get data method
}

