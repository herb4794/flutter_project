import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/controllers/fireCloud.dart';
import 'package:flutter_application_1/controllers/profile_controller.dart';
import 'package:flutter_application_1/widgets_common/bg_widget.dart';
import 'package:flutter_application_1/widgets_common/custom_textfield.dart';
import 'package:flutter_application_1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen ({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();

}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  var authController = Get.put(AuthController());
  Map? existObj = {
    "name" : "",
    "email" : "",
    "ImageUrl" : " "
  };


  @override
  void initState() {
    // TODO: implement initState
    auth.authStateChanges().listen((User? user)async {
      if (user != null)  {
        var existUser = await firestore.collection(usersCollection).doc(user.uid).get();
        var existUserData = existUser.data();
        setState(() {
          existObj?['name'] = existUserData!['name'].toString();
          existObj?['email'] = existUserData!['email'].toString();
          existObj?['ImageUrl'] = existUserData!['imageUrl'].toString();
          print("=============================================existObj==============================================");
          print(existObj);
        });
      }
    });

    }
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
               existObj?["ImageUrl"] != null || existObj?["ImageUrl"].toString().contains("googleusercontent") == true &&
                   existObj?['imageUrl'].toString().contains("googleapis") == true
                      ? Image.network(existObj!['ImageUrl'].toString(),
                        width: 52, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make() :
                       Image.asset(avatar, width: 52, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make(),
              10.heightBox,
              ourButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context,existObj!['email']);
                },
                textColor: whiteColor,
                title: "Change Picture",
              ),
              Divider(),
              20.heightBox,
              customTextField(
                hint: existObj!['name'].toString(),
                title: name,
                isPass: false,
                controller: authController.userNameController
              ),
              customTextField(
                hint: password,
                title: password,
                isPass: true,
                controller: authController.passwordController
              ),
              20.heightBox,
              SizedBox(
                width: context.screenWidth - 60,
                  child: ourButton(color: redColor,onPress: (){
                    authController.updateLocalUserEmailAndPassword(context: context);
                  }, textColor: whiteColor, title: "Edit"))
            ],
          ).box.white.shadowSm.
          padding(const EdgeInsets.all(16)).
          margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded.make(),
        ),
      ),
    );
  }
}
