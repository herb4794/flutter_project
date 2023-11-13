import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/controllers/fireCloud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/views/home_screen/home.dart';
import 'package:flutter_application_1/widgets_common/applogo_widget.dart';
import 'package:flutter_application_1/widgets_common/bg_widget.dart';
import 'package:flutter_application_1/widgets_common/custom_textfield.dart';
import 'package:flutter_application_1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;

  var controller = Get.put(AuthController());
  var fireCloud = Get.put(FireCloud());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
            (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Sign Up to $appname"
              .text
              .fontFamily(bold)
              .white
              .size(18)
              .make(),
              15.heightBox,
              Column(
                children: [
                  customTextField(
                    hint: nameHint,
                    title: name,
                    controller: nameController,
                    isPass: false),
                  customTextField(
                    hint: emailHint,
                    title: email,
                    controller: emailController,
                    isPass: false),
                  customTextField(
                    hint: passwordHint,
                    title: password,
                    controller: passwordController,
                    isPass: true),
                  customTextField(
                    hint: passwordHint,
                    title: retypePassword,
                    controller: passwordRetypeController,
                    isPass: true),
                  15.heightBox,
                  Row(
                    children: [
                      Checkbox(
                        activeColor: redColor,
                        checkColor: whiteColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        }),
                      10.heightBox,
                      Expanded(
                        child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                fontFamily: regular, color: fontGrey)),
                            TextSpan(
                              text: termAndCond,
                              style: TextStyle(
                                fontFamily: regular, color: redColor)),
                            TextSpan(
                              text: " & ",
                              style: TextStyle(
                                fontFamily: regular, color: fontGrey)),
                            TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                fontFamily: bold, color: redColor)),
                          ]),
                        ),
                      )
                    ],
                  ),
                  5.heightBox,
                  ourButton(
                    color: isCheck == true ? redColor : lightGrey,
                    title: signup,
                    textColor: whiteColor,
                    onPress: () async {
                      if (isCheck != false) {
                        try {
                          await controller
                          .signUpMethod(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text)
                          .then((value) {
                            return fireCloud.storingUserData(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              imageUrl: " ",
                            );
                          }).then((value) {
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(() => Home());
                          });
                        } catch (e) {
                          auth.signOut();
                          VxToast.show(context, msg: e.toString());
                        }
                      }
                    }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: alreadyHaveAccount,
                        style:
                        TextStyle(fontFamily: bold, color: fontGrey)),
                      TextSpan(
                        text: login,
                        style:
                        TextStyle(fontFamily: bold, color: redColor)),
                    ])).onTap(() {
                    Get.back();
                  }),
                ],
              )
              .box
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .width(context.screenWidth - 70)
              .shadowSm
              .make()
            ],
          ),
        )));
  }
}
