import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/views/dashoard_screen/order.dart';
import 'package:flutter_application_1/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? orderList;
  const OrderScreen({Key? key, required this.orderList}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String limitStringLength(String input, int maxLength){
    if(input.length <= maxLength){
      return input;
    }else{
      return input.substring(0, maxLength) + "...";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: "Order".text.color(Colors.white).make(),
        ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: widget.orderList![0]['product'].length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 200),
                    itemBuilder: (context, index){
                      String? id;
                      String? total;
                      String? fullId;
                      List<Map<String, dynamic>> order = [];
                      id = limitStringLength(widget.orderList![0]['product'][index]['products'][0].keys.first, 15);
                      fullId = widget.orderList![0]['product'][index]['products'][0].keys.first;
                      total = widget.orderList![0]['product'][index]['totalPrice'].toString();
                      final orderResult = widget.orderList![0]['product'][index]['products'].map((value) {
                        return value;
                      }).toList();
                      order.add({
                        "order": widget.orderList![0]['product'][index]
                      });
                      String? imageUrl;
                      imageUrl = widget.orderList![0]['product'][index]['products'].map<String>((item)
                        => item[widget.orderList![0]['product'][index]['products'][0].keys.first][0]['image'].toString()).join();
                      return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                       child: Column(
                         children: [
                           Image.network(
                             imageUrl!,
                             height: 120,
                             width: 100,
                             fit: BoxFit.cover,
                           ),
                           10.heightBox,
                           "id: ${id}"
                           .text
                           .color(darkFontGrey)
                           .align(TextAlign.center)
                           .make(),
                           10.heightBox,
                           "total \$${total}"
                               .text
                               .color(darkFontGrey)
                               .align(TextAlign.center)
                               .make(),
                         ],
                       ) .box
                           .white
                           .rounded
                           .clip(Clip.antiAlias)
                           .shadowSm.make()
                           .onTap(() {
                          Get.to(() => Order(product: orderResult, title: fullId, orderId: id));
                       }),
                      ),
                    );
                  },),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
