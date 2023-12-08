import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';
import 'package:flutter_application_1/controllers/home_controller.dart';
import 'package:flutter_application_1/views/cart_screen/cart_screen.dart';
import 'package:flutter_application_1/widgets_common/our_button.dart';
import 'package:flutter_application_1/controllers/cartController.dart';
import 'package:get/get.dart';

class ItemDetails extends StatefulWidget {
  String? title;
  String? price;
  String? image;
  String? description;

  ItemDetails({Key? key, required this.title, required this.price, required this.image, required this.description}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  var title;
  var price;
  var image;
  int quantity = 1;
  var cartControllerGetx = Get.put(CartController());


  @override
  void initState() {
    setState(() {
      title = widget.title;
      price = widget.price;
      image = widget.image;
      quantity;
    });
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: widget.title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  swiper section
                        VxSwiper.builder(
                            autoPlay: true,
                            height: 350,
                            itemCount: 0,
                            aspectRatio: 16 / 9,
                            itemBuilder: (context, index) {
                              return Image.network(image,
                                  width: double.infinity, fit: BoxFit.cover);
                            }),

                        10.heightBox,
                        //  title and details section
                        widget.title!.text
                            .size(16)
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        // rating
                        VxRating(
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          size: 25,
                          stepInt: true,
                        ),
                        10.heightBox,
                        Text(
                          "\$${widget.price?.toString()}",
                          style: TextStyle(
                              color: redColor,
                              fontFamily: bold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            //quantity row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity: ".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if(quantity > 1){
                                            setState(() {
                                              quantity --;
                                              price = double.parse(widget.price.toString()) * quantity;
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.remove)),
                                    quantity.toString().text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            quantity ++;
                                            price = double.parse(widget.price.toString()) * quantity;
                                          });
                                        }, icon: const Icon(Icons.add)),
                                    10.heightBox,
                                    "(0 available)".text.color(textfieldGrey).make(),
                                  ],
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            //  total row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total: ".text.color(textfieldGrey).make(),
                                ),
                                "\$${price.toString()}"
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make()
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),
                        //  description section
                        10.heightBox,
                        "Description"
                            .text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        "${widget.description}"
                            .text
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              subjectiveIdealism.length,
                                  (index) => ListTile(
                                title: subjectiveIdealism[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                        ),
                      ]))),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
                color: redColor,
                onPress: () async {
                  double price = double.parse(widget.price!) * quantity;
                  List<Map<String, dynamic>> toJson = [{
                    "title": title,
                    "price": price,
                    "image": image,
                    "quantity": quantity,
                    "status": false
                  }];
                  cartControllerGetx.getCartItemResult.addAll(toJson);
                },
                textColor: whiteColor,
                title: "Add to cart"),
          )
        ],
      ),
    );
  }
}