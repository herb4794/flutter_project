import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/cartController.dart';
import 'package:flutter_application_1/controllers/readTime_controller.dart';
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
  List<Map<String, dynamic>>? productMapList = [];
  List<Map<String, dynamic>> orderMapList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      productMapList = cartControllerGetx.getCartItemResult;
      orderMapList.add({
        uuid: productMapList
      });
    });
  }

  // final uploadOrber = 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar :AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Cart',style: TextStyle(color: Colors.black),),
        actions: [
          Badge(
            isLabelVisible: false,
            child: IconButton(
              onPressed: () async {
                var json = productController.product;
                print(json);
              },
              icon: Icon(Icons.shopping_cart),

            ),
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: cartControllerGetx.getCartItemResult != [] ? ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        shrinkWrap: true,
        itemCount: productMapList!.length,
        itemBuilder: (context, index) {
          final item = productMapList![index];
          final title = item['title'];
          final price = item['price'];
          final image = item['image'];
          return Card(
            color: Colors.orange.shade300,
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.network(
                    image,
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(
                    width: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5.0,
                        ),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                            text: 'Name: ',
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 16.0),
                            children: [
                              TextSpan(
                                text:
                                '${title}\n',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                            ]),
                        ),
                        RichText(
                          maxLines: 1,
                          text: TextSpan(
                            text: 'Price: ' r"$",
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 16.0),
                            children: [
                              TextSpan(
                                text:
                                '${price.toString()}\n',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                            ]),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ).onTap(() {
                    setState(() {
                      cartControllerGetx.getCartItemResult.removeAt(index);
                    });
                  }),
                  TextButton(onPressed: (){
                    orderController.addCart(product: orderMapList);
                  }, child: Text("Order"))
                ],
              ),
            ),
          );
        }) : Center(child: CircularProgressIndicator(),),
    );}
}
