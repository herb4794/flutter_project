import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';
import 'package:flutter_application_1/controllers/readTime_controller.dart';
import 'package:flutter_application_1/views/home_screen/components/featured_button.dart';
import 'package:flutter_application_1/widgets_common/home_buttons.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  List<Map<String, dynamic>> result;
  HomeScreen({Key? key, required this.result}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> product = [];
  var database = RealtimeDatebaseController().setProduct();
  List<Map<String, dynamic>> products = RealtimeDatebaseController().getProduct;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      });
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                color: lightGrey,
                child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: whiteColor,
                      hintText: searchanything,
                      hintStyle: TextStyle(color: textfieldGrey),
                    )
                ),
              ),

              10.heightBox,

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // swipers brands
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: slidersList.length,
                          itemBuilder: (context,index){
                            return Image.asset(
                              slidersList[index],
                              fit: BoxFit.fill,
                            ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                          }),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            2,
                                (index) => homeButtons(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 2.5,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title: index == 0 ? todayDeal : flashsale,
                            )),
                      ),
                      10.heightBox,
                      //  swipes brands
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: secondSlidersList.length,
                          itemBuilder: (context,index){
                            return Image.asset(
                              secondSlidersList[index],
                              fit: BoxFit.fill,
                            ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                          }),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(3, (index) => homeButtons(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 3.5,
                          icon: index == 0 ? icTopCategories : index == 1 ? icBrands : icTopSeller,
                          title: index == 0 ? topCategories : index == 1 ? brand : topSellers,
                        )),
                      ),

                      //featured cateogories
                      20.heightBox,
                      Align(
                          alignment: Alignment.centerLeft,
                          child: featuredCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
                      20.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            3,
                                (index) => Column(
                              children: [
                                featuredButton(
                                  icon: featuredImages1[index],
                                  title: featuredTitles1[index],
                                ),
                                10.heightBox,
                                featuredButton(
                                  icon: featuredImages2[index],
                                  title: featuredTitles2[index],
                                ),
                              ],
                            ),
                          ).toList(),
                        ),
                      ),

                      //  featured product

                      20.heightBox,
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: redColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text.white.fontFamily(bold).size(18).make(),
                            10.heightBox,
                            widget.result != [] ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(6, (int index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(widget.result[index]['product_image'],width: 150, fit: BoxFit.cover,),
                                    10.heightBox,
                                    widget.result[index]['product_en_name'].toString().text.fontFamily(semibold).color(darkFontGrey).make(),
                                    10.heightBox,
                                    "\$${widget.result[index]['product_price']}".toString().text.color(redColor).fontFamily(bold).size(16).make(),
                                  ],
                                ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(8)).make()),
                              ),
                            ) : Center(child: CircularProgressIndicator())
                          ],
                        ),
                      ),
                      20.heightBox,
                      //  third swiper
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: secondSlidersList.length,
                          itemBuilder: (context,int index){
                            return Image.asset(
                              secondSlidersList[index],
                              fit: BoxFit.fill,
                            ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                          }),
                      //  all products section
                      20.heightBox,
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 300),
                          itemBuilder: (context,index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  widget.result[index]['product_image'],
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                "${widget.result[index]['product_en_name']}".toString().text.size(12).fontFamily(semibold).color(darkFontGrey).make(),
                                10.heightBox,
                                "\$${widget.result[index]['product_price']}".toString().text.color(redColor).fontFamily(bold).size(16).make(),
                                10.heightBox,
                              ],
                            ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make();
                          }),
                    ],
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }
}
