import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/cartController.dart';
import 'package:flutter_application_1/controllers/readTime_controller.dart';
import 'package:flutter_application_1/views/cart_screen/componets/cartColor.dart';
import 'package:flutter_application_1/views/cart_screen/componets/cartItemContainer.dart';
import 'package:flutter_application_1/widgets_common/our_button.dart';
import 'package:flutter_application_1/controllers/fireCloud.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/rng.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final controller = CartController();
  // final cartController = Get.find();
  final cartControllerGetx = Get.put(CartController());
  final productController = RealtimeDatebaseController();
  final orderController = FireCloud();
  final uuid = Uuid().v1();
  List<Map<String, dynamic>>? productMapList;
  List<Map<String, dynamic>> orderMapList = [];
  var total;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      productMapList = cartControllerGetx.getCartItemResult;
      orderMapList.add({
        uuid: productMapList
      });
       total = productMapList!.fold(0.0, (pre, product) {
        var price = double.parse(product['price'].toString());
        return pre+ price;
      });
      print("================================================");
      print(total);
    });

  }

  // final uploadOrber = 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.maxFinite,
        color: CartColor.myCartBackgroundColor,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: CartColor.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            padding: EdgeInsets.all(10),
            width: 400,
            height: 600,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                // row of text and icon
                Row(
                  children: const [
                    Expanded(
                      child: Center(
                        child: Text(
                          'My Cart',
                          style: TextStyle(
                              color: CartColor.darkText,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.close,
                      color: CartColor.lightBlue,
                      size: 30,
                    ),
                  ],
                ),
                // column of image, text and button
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: productMapList!.map((productList) => CartItemContainer(
                      image: productList['image'],
                      itemName: productList['title'].toString(),
                      itemPrice: productList['price'].toString(),
                      itemQuantity: productList['quantity'].toString()),).toList()
                ),
                SizedBox(
                  height: 50,
                ),
                // row of text and button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // column of text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 16,
                              color: CartColor.lightBlue),
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          "\$${total}",
                          style: TextStyle(
                              color: CartColor.darkText,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    // button
                    Container(
                      padding: EdgeInsets.all(15),
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: CartColor.lightBlue,
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                            color: CartColor.backgroundColor,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
