import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/cartController.dart';
import 'package:flutter_application_1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final controller = CartController();
  List<Map<String, dynamic>>? productMapList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addCart().then((value){
      setState(() {
        for(int i = 0; i < controller.cartValue.length; i += 2){
          productMapList?.add({
            'title': controller.cartValue[i],
            'price': controller.cartValue[i+1],
          });
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar :AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text('Cart',style: TextStyle(color: Colors.black),),
          actions: [
            Badge(
              isLabelVisible: false,

              child: IconButton(
                onPressed: (){
                },
                icon: Icon(Icons.shopping_cart),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            shrinkWrap: true,
            itemCount: productMapList!.length,
            itemBuilder: (context, index) {
              final item = productMapList![index];
              final title = item['title'];
              final price = item['price'];
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
                        "https://i.dummyjson.com/data/products/8/thumbnail.jpg",
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
                      }),
                    ],
                  ),
                ),
              );
            }),
    );}
}