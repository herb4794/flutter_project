import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/fireCloud.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;

  // Upload  user profile images to the storage
  changeImage(context,email) async {
    try {
      final img = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 70);
      if (img == null){ return;}
      else{
        var imageFile = File(img.path);
        profileImgPath.value = img.path;
        FireCloud().uploadImage(email: email,imageName: img.name ,file: imageFile);
      }
    } on PlatformException catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }
}