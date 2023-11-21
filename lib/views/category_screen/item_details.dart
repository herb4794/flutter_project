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

  ItemDetails({Key? key, required this.title, required this.price, required this.image}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  var title;
  var price;
  var image;
  var cartControllerGetx = Get.put(CartController());


  @override
  void initState() {
    setState(() {
      title = widget.title;
      price = widget.price;
      image = widget.image;
    });
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    int quantity = 0;
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

                  10.heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "In House Brands"
                            .text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .size(16)
                            .make()
                          ],
                        )),
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.message_rounded,
                          color: darkFontGrey,
                        ),
                      )
                    ],
                  )
                  .box
                  .height(60)
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .color(textfieldGrey)
                  .make(),

                  //  color section
                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Color: ".text.color(textfieldGrey).make(),
                          ),
                          Row(
                            children: List.generate(
                              3,
                            (index) => VxBox()
                                .size(40, 40)
                                .roundedFull
                                .color(Vx.randomPrimaryColor)
                                .margin(
                                  const EdgeInsets.symmetric(horizontal: 4))
                                .make(),
                            ),
                          )
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make(),

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
                                onPressed: () {},
                                icon: const Icon(Icons.remove)),
                              "0"
                              .text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(bold)
                              .make(),
                              IconButton(
                                onPressed: () {}, icon: const Icon(Icons.add)),
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
                          "\$0.00"
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
                  "Who are you? Who slips into my robot body and whispers to my ghost"
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
                  20.heightBox,

                  //products may like sectin
                  productYouMayLike.text
                  .fontFamily(bold)
                  .size(16)
                  .color(darkFontGrey)
                  .make(),

                  10.heightBox,
                  //i copied this widget from home screen featured products
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        6,
                      (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              imgP1,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            10.heightBox,
                            "Laptop 4GB/64GB"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                            10.heightBox,
                            "\$600"
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(16)
                            .make(),
                          ],
                        )
                          .box .white .margin(
                            const EdgeInsets.symmetric(horizontal: 4))
                          .roundedSM
                          .padding(const EdgeInsets.all(8))
                          .make()),
                    ),
                  )
                ]))),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
              color: redColor,
              onPress: () async {
                List<Map<String, dynamic>> toJson = [{
                  "title": title,
                  "price": price,
                  "image": image,
                }];
                cartControllerGetx.getCartItemResult.addAll(toJson);
                print("=========================================================");
                print(cartControllerGetx.getCartItemResult);
              },
              textColor: whiteColor,
              title: "Add to cart"),
          )
        ],
      ),
    );
  }
}
