import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;




FirebaseFirestore firestore = FirebaseFirestore.instance;


User? currentUser = auth.currentUser;

    //collections
const usersCollection = "users";

class apiInterface {
  final Map category;

  apiInterface({
    required this.category,
  });

  factory apiInterface.fromjson(Map<String, dynamic> json) {
    return apiInterface(
      category: json,
    );
  }
}

