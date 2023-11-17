import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// initialise authentication
FirebaseAuth auth = FirebaseAuth.instance;

// initialise fireStore database
FirebaseFirestore firestore = FirebaseFirestore.instance;

// initialise readTime database
FirebaseDatabase database = FirebaseDatabase.instance;

// get user information
User? currentUser = auth.currentUser;

// collections
const usersCollection = "users";

const productCollection = "product";

// Have all database json object convert to List<Map<String, dynamic>> type
class ProductInterface {
  final List<Map<String, dynamic>> productList;

  ProductInterface({required this.productList});

  factory ProductInterface.fromJson(List<dynamic> json) {
    List<Map<String, dynamic>> products = json
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();

    return ProductInterface(productList: products);
  }

}