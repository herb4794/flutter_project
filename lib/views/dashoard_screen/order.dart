import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/views/category_screen/item_details.dart';
import 'package:flutter_application_1/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class Order extends StatelessWidget {
  final List<dynamic> product;
  final String? title;
  final String? orderId;
  const Order({Key? key, required this.product, required this.title, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arr = product.map((item) {
      return item[title];
    }).toList();
    return bgWidget(
        child: Scaffold(
          appBar: AppBar(
            title: orderId!.text.fontFamily(bold).white.make(),
          ),
          body: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: arr[0].length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 210,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                arr[0][index]['image'].toString(),
                                height: 130,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              arr[0][index]['title'].toString()
                                  .text
                                  .maxLines(1)
                                  .size(14)
                                  .softWrap(false)
                                  .overflow(TextOverflow.ellipsis)
                                  .align(TextAlign.start)
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "\$${arr[0][index]['price'].toString()}".toString()
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make(),
                              10.heightBox,
                            ],
                          )
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .outerShadowSm
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                              final arr = product.map((item) {
                                  return item[title];
                               }).toList();
                              print(arr[0][index]['image']);
                          });
                        }))
              ],
            ),
          ),
        ));
  }
}
