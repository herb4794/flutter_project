import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/widgets_common/bg_widget.dart';
import 'package:flutter_application_1/widgets_common/custom_textfield.dart';
import 'package:flutter_application_1/widgets_common/our_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen ({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();

}

class _EditProfileScreenState extends State<EditProfileScreen> {
 Map? existObj = {
  "name" : "",
  "password" : "",
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
          existObj?['password'] = existUserData!['email'].toString();
          existObj?['ImageUrl'] = existUserData!['imageUrl'].toString();
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
               existObj?["ImageUrl"] != null && existObj?["ImageUrl"].toString().contains("googleusercontent") == true 
                      ? Image.network(existObj!['ImageUrl'].toString(),
                        width: 52, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                      : (existObj?["ImageUrl"].toString().contains(" ") == false) ?
                      Image.asset(existObj!['ImageUrl'].toString(),
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
              ourButton(
                color: redColor,
                onPress: () {},
                textColor: whiteColor,
                title: "Change Picture",
              ),
              Divider(),
              20.heightBox,
              customTextField(
                hint: existObj!['name'].toString(),
                title: name,
                isPass: false
              ),
              customTextField(
                hint: password,
                title: password,
                isPass: true
              )
            ],
          ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50)).make(),
        ),
      ),
    );
  }
}
