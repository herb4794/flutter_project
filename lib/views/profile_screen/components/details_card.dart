import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/consts/consts.dart';

Widget detailsCard({width, int? count, String? title}){
  return
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
        5.heightBox,
        title!.text.color(darkFontGrey).make(),
      ],
    ).box.white.rounded.width(width).height(65).padding(const EdgeInsets.all(4)).make();
}
