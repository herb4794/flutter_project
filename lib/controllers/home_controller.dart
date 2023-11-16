import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  RxList<Map<String, dynamic>> getCartItemResult = <Map<String,dynamic>>[].obs;

  RxList<Map<String,dynamic>> getData(){
    print(getCartItemResult);
    return getCartItemResult;
  }
}