import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

//  storing data method

class FireCloud extends GetxController {
  UploadTask? uploadTask;
  var storage;

  FireCloud() {
    storage = FirebaseStorage.instance.ref();
  }


  // Have image url synchronize to fireStorage
  Future uploadImage({email, imageName, file}) async {
    final ref = storage.child('${email}/${imageName}');
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    auth.authStateChanges().listen((user) async {
      if (user != null) {
        final docRef = await firestore.collection(usersCollection).doc(
            user.uid);
        docRef.update({"imageUrl": urlDownload.toString()}).then(
                (value) => print("upData successful"),
            onError: (e) => print("Error updating document $e"));
      }
    });
  }


  storingUserData({name, method, email, imageUrl}) async {
    firestore.collection(usersCollection).doc(currentUser!.uid).get().then((
        doc) {
      final data = doc.data() as Map<String, dynamic>;
      if (data != null) {
        print(data);
      } else {
        DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
        store.set(
            {
              'name': name,
              'method': method,
              'email': email,
              'imageUrl': imageUrl,
              "orders": []
            });
      }
    });
  }
  // TODO upload product array to firestore
  addCart({product, total}) {
    List<Map<String, dynamic>> result = [];
    result.add({
      "products": product,
      "totalPrice": total
    });
    auth.authStateChanges().listen((user) async {
      if (user != null) {
        final docRef = await firestore.collection(usersCollection).doc(
            user.uid);
        docRef.update({"orders": FieldValue.arrayUnion(result)}).then(
                (value) => print("Add Cart"),
            onError: (e) => print("Add Cart Error $e"));
      }
    });
  }

  Future<List<Map<String, dynamic>>> getOrder() async {
    List<Map<String, dynamic>> order = [];
    final user = auth.currentUser;
    if (user != null) {
      final docRef = firestore.collection(usersCollection).doc(user.uid);
      final item = await docRef.get();
      final data = item.data() as Map<String, dynamic>;
      List orderReList = data['orders'].toList();
      order.add(
          {'product': orderReList}
      );
    }
    return order;
  }

  removeOrder({index}) {
    auth.authStateChanges().listen((user) async {
      if (user != null) {
        final docRef = await firestore.collection(usersCollection).doc(
            user.uid);
        final item = await docRef.get();
        Map<String, dynamic> data = item.data() as Map<String, dynamic>;
        List<dynamic> orders = data['orders'];
        if (orders != null && orders.isNotEmpty) {
          orders.removeAt(index);
        }
        await docRef.update({"orders" : orders});
      }
    });
  }
}

