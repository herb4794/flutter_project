
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:get/get.dart';

class RealtimeDatebaseController extends GetxController {
  List<Map<String, dynamic>> product = [];

  // getter method of the Realtime database product item
  List<Map<String, dynamic>> get getProduct => product;

  // Initialise method
  RealtimeDatebaseController(){
     setProduct().then((value) {
    return product.addAll(value);
  }); }

  // Monitor changes
  synchronicity ()  {
    DatabaseReference synchronization =  database.ref(productCollection);
    synchronization.onValue.listen((DatabaseEvent  event) {
      final jsonListAsync = event.snapshot.value as List<dynamic>;
      final result = ProductInterface.fromJson(jsonListAsync);
      product = result.productList;
    });
  }

  // Only read once
  Future setProduct() async {
    final ref = database.ref();
    final snapshot = await ref.child(productCollection).get();

    if (snapshot.exists) {
      final jsonList = snapshot.value as List<dynamic>;
      final products = ProductInterface.fromJson(jsonList);
      return products.productList;
    }
  }
}