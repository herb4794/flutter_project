import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/cartController.dart';
import 'package:flutter_application_1/controllers/home_controller.dart';
import 'package:flutter_application_1/controllers/readTime_controller.dart';
import 'package:flutter_application_1/views/cart_screen/cart_screen.dart';
import 'package:flutter_application_1/views/category_screen/category_screen.dart';
import 'package:flutter_application_1/views/home_screen/home_screen.dart';
import 'package:flutter_application_1/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  List<Map<String, dynamic>> product = [];
  Home({Key? key, required this.product}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // init home controller
    var controller  = Get.put(HomeController());
    final cartControllerGetx = Get.put(CartController());
    var navbarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26), label: home ),
      BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26), label: categories ),
      BottomNavigationBarItem(icon: Image.asset(icCart, width: 26), label: cart ),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26), label: account )
    ];
    var navBody = [
      HomeScreen(result: widget.product),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx(() =>
        BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle:  TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: navbarItem,
          onTap: (value){
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
