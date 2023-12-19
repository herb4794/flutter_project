import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/controllers/cartController.dart';
import 'package:flutter_application_1/controllers/fireCloud.dart';
import 'package:flutter_application_1/controllers/profile_controller.dart';
import 'package:flutter_application_1/views/auth_screen/login_screen.dart';
import 'package:flutter_application_1/views/dashoard_screen/order_screen.dart';
import 'package:flutter_application_1/views/profile_screen/components/details_card.dart';
import 'package:flutter_application_1/views/profile_screen/edit_profile_screen.dart';
import 'package:flutter_application_1/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final cartControllerGetx = Get.put(CartController());
  final fireCloud = FireCloud();
  List<Map<String, dynamic>>? productMapList;
  List<Map<String, dynamic>>? orderList;
  List<Map<String, dynamic>>? getOrderList;

  void orderRemove(index){
    setState(() {
      fireCloud.removeOrder(index: index);
      // updateMethod();
      // updateMethod(index);
    });
  }
  // void updateMethod(index){
  //   setState(() {
  //     getOrderList![0]['product'][index].clear();
  //   });
  //   print(getOrderList![0]['product'][index]);
  // }
  void fetchData() async {
    getOrderList = await fireCloud.getOrder();
    print(getOrderList);
  }
  var controller;
  Map? existObj = {
    "name" : "",
    "email" : "",
    "method" : "",
    "ImageUrl" : " "
  };
  List productArr = [];
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    productMapList = cartControllerGetx.getCartItemResult;
    fetchData();
    auth.authStateChanges().listen((User? user)async {
      if (user != null)  {
        var existUser = await firestore.collection(usersCollection).doc(user.uid).get();
        var existUserData = existUser.data();
        setState(() {
          existObj?['name'] = existUserData!['name'].toString();
          existObj?['email'] = existUserData!['email'].toString();
          existObj?['method'] = existUserData!['method'].toString();
          existObj?['ImageUrl'] = existUserData!['imageUrl'].toString();
          productArr =  existUserData!['orders'];
          print(productArr.length);
          controller = Get.put(ProfileController());
        });
      }
    });
    print(productMapList);
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                //edit profile button
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    existObj!['method'].toString() == "local" ?
                    Align(
                        alignment: Alignment.topRight,
                        child: const Icon(
                          Icons.edit,
                          color: whiteColor,
                        ).onTap(() {
                          Get.to(() => const EditProfileScreen());
                        })
                    ) : Align(
                        alignment: Alignment.topRight,
                        child: const Icon(
                            Icons.edit_off,
                            color: whiteColor
                        ).onTap(() { })
                    )
                ),

                //user details section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      existObj?["ImageUrl"] != null ||
                          existObj?["ImageUrl"].toString().contains("googleusercontent") == true &&
                          existObj?['imageUrl'].toString().contains(" https://firebasestorage.googleapis.com") == true
                          ? Image.network(existObj!['ImageUrl'].toString(),
                          width: 52, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                          : Image.asset(avatar, width: 52, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
                      10.heightBox,
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              existObj?['name'] != null
                                  ? existObj!['name'].toString()
                                  .text
                                  .fontFamily('semibold')
                                  .white
                                  .make()
                                  : 'Anonymous'.text.make(),
                              5.heightBox,
                              existObj?['email']!= null
                                  ? existObj!['email'].toString().text.color(Colors.white).make()
                                  : "".text.make(),
                            ],
                          )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: whiteColor,
                              )),
                          onPressed: () async {
                            // AuthController().signoutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: "Logout".text.fontFamily(semibold).white.make())
                    ],
                  ),
                ),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailsCard(
                        count: productMapList!.length,
                        title: "in your cart",
                        width: context.screenWidth / 3.4),
                    detailsCard(
                        count:  productArr!.length,
                        title: "your orders",
                        width: context.screenWidth / 3.4)
                  ],
                ),

                //  buttons section

                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: lightGrey,
                    );
                  },
                  itemCount: profileButtonsList.length,
                  itemBuilder: (BuildContext context, index) {
                    String itemText;
                    String itemIcon;
                    Function orderPage;
                    switch (index){
                      case 0:
                        itemText = profileButtonsList[0];
                        itemIcon =   profileButtonsicon[0];
                        orderPage = () => Get.to(() => OrderScreen(orderList: getOrderList,removeOrder: orderRemove,));
                        break;
                      case 1:
                        itemText = profileButtonsList[1];
                        itemIcon =   profileButtonsicon[1];
                        orderPage = () => {};
                        break;
                      default:
                        itemText = '';
                        itemIcon = '';
                        orderPage = () => {};
                    } return ListTile(
                      leading: Image.asset(
                        itemIcon,
                        width: 22,
                      ),
                      title: itemText
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make().onTap(() => orderPage()),
                    );
                  },
                )
                    .box
                    .white
                    .rounded
                    .margin(const EdgeInsets.all(12))
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .shadowSm
                    .make()
                    .box
                    .color(Colors.black12)
                    .make(),
              ],
            ),
          ),
        ));
  }
}
