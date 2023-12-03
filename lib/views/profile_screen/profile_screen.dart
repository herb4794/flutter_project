import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/controllers/profile_controller.dart';
import 'package:flutter_application_1/views/auth_screen/login_screen.dart';
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
  var controller;
  Map? existObj = {
    "name" : "",
    "email" : "",
    "method" : "",
    "ImageUrl" : " "
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.authStateChanges().listen((User? user)async {
      if (user != null)  {
        var existUser = await firestore.collection(usersCollection).doc(user.uid).get();
        var existUserData = existUser.data();
        setState(() {
          existObj?['name'] = existUserData!['name'].toString();
          existObj?['email'] = existUserData!['email'].toString();
          existObj?['method'] = existUserData!['method'].toString();
          existObj?['ImageUrl'] = existUserData!['imageUrl'].toString();
          controller = Get.put(ProfileController());
        });
      }
    });
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
                        count: 0,
                        title: "in your cart",
                        width: context.screenWidth / 3.4),
                    detailsCard(
                        count: 0,
                        title: "in your wishlist",
                        width: context.screenWidth / 3.4),
                    detailsCard(
                        count: 0,
                        title: "your orders",
                        width: context.screenWidth / 3.4),
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
                    return ListTile(
                      leading: Image.asset(
                        profileButtonsicon[index],
                        width: 22,
                      ),
                      title: profileButtonsList[index]
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
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
                    .color(redColor)
                    .make(),
              ],
            ),
          ),
        ));
  }
}
