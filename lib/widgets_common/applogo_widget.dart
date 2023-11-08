import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:get/route_manager.dart';

Widget applogoWidget() {
  //using velcoity X here
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
