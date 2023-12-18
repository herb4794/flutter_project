import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/cartController.dart';
import 'package:flutter_application_1/controllers/readTime_controller.dart';
import 'package:flutter_application_1/views/cart_screen/componets/cartColor.dart';
import 'package:flutter_application_1/views/cart_screen/componets/cartItemContainer.dart';
import 'package:flutter_application_1/widgets_common/bg_widget.dart';
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
  final uuid = const Uuid().v1();
  List<Map<String, dynamic>>? productMapList;
  List<Map<String, dynamic>> orderMapList = [];
  RxDouble total = 0.0.obs;
  void updateTotal() {
    setState(() {
      total.value = productMapList!.fold(0.0, (pre, product) {
        var price = double.parse(product['price'].toString());
        var quantity = int.parse(product['quantity'].toString());
        return pre + (price * quantity);
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

      productMapList = cartControllerGetx.getCartItemResult;
      double totals = productMapList!.fold(0.0, (pre, product) {
        var price = double.parse(product['price'].toString());
        var quantity = int.parse(product['quantity'].toString());
        return pre + (price * quantity);
      });
      print(totals);
      orderMapList.add({
        uuid: productMapList,
      });
    });
    updateTotal();
  }

  @override
  Widget build(BuildContext context) {
    productMapList = cartControllerGetx.getCartItemResult;
    total.value = productMapList!.fold(0.0, (pre, product) {
      var price = double.parse(product['price'].toString());
      var quantity = int.parse(product['quantity'].toString());
      return pre + (price * quantity);
    });
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body:Center(
          child: Container(
            decoration: BoxDecoration(
              color: CartColor.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25))),
            padding: EdgeInsets.all(10),
            width: 400,
            height: 600,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child:  total > 1 ?  Column(
                children: [
                  Text("My Cart"),
                  const SizedBox(
                    height: 20,
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
                      itemQuantity: productList['quantity'].toString(),
                      decreaseQuantity: (){
                        setState(() {
                          int currentQuantity = int.parse(productList['quantity'].toString());
                          if (currentQuantity >= 1) {
                            currentQuantity--;
                            productList['quantity'] = currentQuantity.toString();
                            updateTotal();
                          }
                          if (currentQuantity == 0){
                              productMapList!.remove(productList);
                            }
                        });
                      },
                      increaseQuantity:(){
                        setState(() {
                          int currentQuantity = int.parse(productList['quantity'].toString());
                          currentQuantity++;
                          productList['quantity'] = currentQuantity.toString();
                          updateTotal();
                        });
                      }
                    ),).toList()
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
                            "\$${total}".toString(),
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
                        width: 100,
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
                        ).onTap(() {
                          VxToast.show(context, msg: "Order Successfully",textSize: 12,showTime: 2000);
                          orderController.addCart(product: orderMapList, total: total.value);
                          Future.delayed(Duration(seconds: 2)).then((value) {
                            productMapList!.clear();
                            updateTotal();
                          });

                        }),
                      )
                    ],
                  )
                ],
              ) : const Center(
                child: Text(
                    "Your cart is empty",
                    style: TextStyle(color: Colors.black),),
              ),
            ),
          ),
        ) ,
      ),
    );
  }
}
