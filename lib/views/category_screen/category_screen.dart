import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';
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
  Future<Map<String, dynamic>> categoryFuture() async {
    final res =
        await http.get(Uri.parse('https://dummyjson.com/products?limit=10'));
    final result = await res.body;
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
              future: categoryFuture(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                }
                if (snapshot.hasData) {
                  final aptResult = snapshot.data as Map<String, dynamic>;
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: 9,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 180),
                            itemBuilder: (context, index) {
                              if (aptResult.containsKey('products')) {
                                final products =
                                    aptResult['products'] as List<dynamic>;
                                if (products.isNotEmpty) {
                                  final productsList =
                                      products[index] as Map<String, dynamic>;
                                  if (productsList.containsKey('category') &&
                                      productsList.containsKey('thumbnail')) {
                                    var images =
                                        productsList['thumbnail'] as String;
                                    var category =
                                        productsList['category'] as String;
                                    if (images != null && category != null) {
                                      return Column(
                                        children: [
                                          Image.network(
                                            images,
                                            height: 120,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "${category}"
                                              .text
                                              .color(darkFontGrey)
                                              .align(TextAlign.center)
                                              .make(),
                                        ],
                                      )
                                          .box
                                          .white
                                          .rounded
                                          .clip(Clip.antiAlias)
                                          .shadowSm
                                          .make()
                                          .onTap(() {
                                        Get.to(() =>
                                            CategoryDetails(title: category));
                                      });
                                    }
                                  }
                                }
                              }
                            }),
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
