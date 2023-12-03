import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/controllers/readTime_controller.dart';
import 'package:flutter_application_1/views/auth_screen/signup_screen.dart';
import 'package:flutter_application_1/views/home_screen/home.dart';
import 'package:flutter_application_1/widgets_common/applogo_widget.dart';
import 'package:flutter_application_1/widgets_common/bg_widget.dart';
import 'package:flutter_application_1/widgets_common/custom_textfield.dart';
import 'package:flutter_application_1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Map<String, dynamic>> product = [];
  var database = RealtimeDatebaseController().setProduct();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      database.then((value) {
        product.addAll(value);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
            (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Log in to Hvar".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  customTextField(
                    hint: emailHint,
                    title: email,
                    isPass: false,
                    controller: controller.emailController),
                  customTextField(
                    hint: passwordHint,
                    title: password,
                    isPass: true,
                    controller: controller.passwordController),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPassword.text.make())),
                  5.heightBox,
                  ourButton(
                    title: login,
                    color: redColor,
                    textColor: whiteColor,
                    onPress: () async {
                      await controller
                      .loginMethod(context: context)
                      .then((value) {
                        if (value != null) {
                          VxToast.show(context, msg: loggedin);
                          Get.offAll(() =>  Home(product: product,));
                        }
                      });
                    }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createnewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(
                    title: signup,
                    color: lightGolden,
                    textColor: redColor,
                    onPress: () {
                      Get.to(() => const SignupScreen());
                    }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                    (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 25,
                          child: Image.asset(
                            socialIconList[index],
                            width: 30,
                          ).onTap(() {
                            AuthController().GoogleLoginMethod(product: product);
                          }),
                        ),
                      )),
                  )
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
