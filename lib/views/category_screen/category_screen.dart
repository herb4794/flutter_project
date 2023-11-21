import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';
import 'package:flutter_application_1/controllers/readTime_controller.dart';
import 'package:flutter_application_1/views/category_screen/category_details.dart';
import 'package:flutter_application_1/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});


  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var database = RealtimeDatebaseController();
  List<Map<String, dynamic>> productResult = [];

  Future<Map<String, dynamic>> categoryFuture() async {

    final res =
        await http.get(Uri.parse('https://dummyjson.com/products?limit=10'));
    final result = res.body;
    if (result.isNotEmpty) {
      return json.decode(result);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: categories.text.fontFamily(bold).white.make(),
              automaticallyImplyLeading: false,
            ),
            body: FutureBuilder(
              future: database.setProduct(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                }
                if (snapshot.hasData) {
                  final product = snapshot.data as List<Map<String, dynamic>>;
                  final householdAppliances = product.where((element) => element['product_type'] == "household appliances");
                  final smartPhone = product.where((element) => element['product_type'] ==  "smart phone");
                  final PcGamingEquipment = product.where((element) => element['product_type'] == "PC gaming equipment");
                  final gifs = product.where((element) => element['product_type'] == "gifts");
                  List<Map<String,dynamic>> categories = [];
                  categories.add({
                    'householdAppliances': householdAppliances.toList(),
                    'smartPhone' : smartPhone.toList(),
                    'PcGamingEquipment' : PcGamingEquipment.toList(),
                    'gifs' : gifs.toList()
                  });
                  print(categories[0]['smartPhone']);
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 180),
                          itemBuilder: (context, index) {
                            String itemText;
                            String imageUrl;
                            List<Map<String,dynamic>> product;
                            switch (index) {
                              case 0:
                                itemText = categories[0]['householdAppliances'][0]['product_type'].toString();
                                imageUrl = categories[0]['householdAppliances'][0]['product_image'].toString();
                                product = categories[0]['householdAppliances'];
                                break;
                              case 1:
                                itemText = categories[0]['smartPhone'][0]['product_type'].toString();
                                imageUrl = categories[0]['smartPhone'][0]['product_image'].toString();
                                product = categories[0]['smartPhone'];
                                break;
                              case 2:
                                itemText = categories[0]['PcGamingEquipment'][0]['product_type'].toString();
                                imageUrl = categories[0]['PcGamingEquipment'][0]['product_image'].toString();
                                product = categories[0]['PcGamingEquipment'];
                                break;
                              case 3:
                                itemText = categories[0]['gifs'][0]['product_type'].toString();
                                imageUrl = categories[0]['gifs'][0]['product_image'].toString();
                                product = categories[0]['gifs'];
                                break;
                              default:
                                itemText = '';
                                imageUrl = '';
                                product = [];
                            } return Column(
                              children: [
                                  Image.network(
                                    imageUrl,
                                    height: 120,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                10.heightBox,
                                "${itemText}"
                                    .text
                                    .color(darkFontGrey)
                                    .align(TextAlign.center)
                                    .make(),
                              ],) .box
                                .white
                                .rounded
                                .clip(Clip.antiAlias)
                                .shadowSm
                                .make().onTap(() =>
                                Get.to(() => CategoryDetails(product: product, title: itemText))
                            );
                          },),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )));
  }
}
