import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:hotelbooking/data/functions_response/get_Info_user.dart';
import 'package:hotelbooking/data/functions_response/updet_user.dart';
import 'package:hotelbooking/models/get_info_user_model.dart';

class EditProfileController extends GetxController {
  int y = 0;
  StatusRequest statusRequest = StatusRequest.none;
  final GlobalKey<FormState> formkeyedit = GlobalKey();
  String? email, image, countery, phone, username, city;
  late StatusRequest statusRequest1;
  GetInfoUserModel? infousetModel;
  getInfoProfile() async {
    statusRequest1 = StatusRequest.loading;
    update();
    var response = await getProfileRespon();
    statusRequest1 = handlingData(response);
    if (StatusRequest.success == statusRequest1) {
      infousetModel = await GetInfoUserModel.fromJson(response);
      print(
          '--------------------------------------------------------------------------');
    } else {
      print('erorr');
    }
    update();
  }

  @override
  void onInit() {
    getInfoProfile();
    super.onInit();
  }

  updateUser(File? isfile) async {
    if (formkeyedit.currentState!.validate()) {
      formkeyedit.currentState!.save();
      statusRequest = StatusRequest.loading;
      update();
      var response = await updetUserRespons(
        country: countery,
        email: email,
        phone: phone,
        username: username,
        isfile: isfile,
      );
      print('file : $isfile');
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        Get.to(() => Home());

        showsnackBar('تم تحديث المعلومات بنجاح');
        Get.delete<EditProfileController>();
      } else {
        Get.to(() => Home());

        showsnackBar('لم يتم تحديث المعلومات');
        Get.delete<EditProfileController>();
      }
      update();
    } else {
      print('erorr');
    }
  }

  @override
  void dispose() {
    Get.delete<EditProfileController>();
    super.dispose();
  }
}

void showsnackBar(String masg) {
  Get.snackbar(
    "Status",
    masg,
    titleText: Align(
      alignment: Alignment.center,
      child: Text(
        'الحاله',
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey[300],
        ),
      ),
    ),
    borderRadius: 20,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    duration: Duration(seconds: 4),
    forwardAnimationCurve: Curves.easeOutBack,
    messageText: Align(
      alignment: Alignment.center,
      child: Text(
        masg,
        style: TextStyle(fontSize: 18, color: Colors.grey[300]),
      ),
    ),
    snackPosition: SnackPosition.TOP,
    colorText: Colors.white,
    backgroundColor: Colors.teal,
  );
}
