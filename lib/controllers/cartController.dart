import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  List<String> newArr =  [];
  List<String> cartValue = [];

  RxList<Map<String, dynamic>> getCartItemResult = <Map<String, dynamic>>[].obs;

  void setNewArr (List<String>Value){
    newArr.addAll(Value);
    setCart(newArr);
  }

  // TODO LocalStorage init
  void setCart (newArr) async {
    SharedPreferences setCart = await SharedPreferences.getInstance();
    setCart.setStringList("product",newArr);
  }

  List<String> getCartItem ()  {
    return cartValue;
  }

  // TODO LocalStorage setter
  Future addCart () async {
    SharedPreferences getCart = await SharedPreferences.getInstance();
    try{
      List<String>? itemResult = getCart.getStringList("product");
      if(itemResult == null){
        itemResult = [];
      }
      cartValue.addAll(itemResult);
      print(itemResult);
      return  itemResult;
    }catch (e){
      print("getCart Error to $e");
    }
  }
}

// final toJson = getCart.getString(id!);
// if(toJson != null){
//   final itemJson = jsonDecode(toJson) as List<dynamic>;
//   for (dynamic item in itemJson){
//     if(item is Map<String,dynamic>){
//       getCartItemResult.value.add(Map<String,dynamic>.from(item));
//     }
