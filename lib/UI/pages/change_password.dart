import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/langs/languge_varible.dart';
import 'package:hotelbooking/main.dart';
import 'package:http/http.dart';
import 'package:quickalert/quickalert.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  void Reset(String oldPass, Pass, Confpassword) async {
    try {
      var url =
          "https://hotel-booking-8qw1.onrender.com/api/users/changePassword";
      var rep = await put(Uri.parse(url));

      var response = await put(
        Uri.parse(url),
        body: jsonEncode(<String, String>{
          "userId": sharedPreferences.getString('id')!,
          "oldPassword": oldPass,
          "newPassword": Pass,
          "rePassword": Confpassword,
        }),
        headers: <String, String>{'Content-Type': 'application/json'},
      ).then((value) {
        var data = jsonDecode(value.body.toString());
        if (value.statusCode == 200) {
          if (data['message'] == 'Reset Password successfully') {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'تم تغير كلمة السر بنجاح');
          } else {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'لم يتم تغير كلمة السر');
          }

          print(data['error'] ?? data['message']);
        } else {
          print('failed');
        }
      });
      ;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        title: const Text(""),
        leading: IconButton(
          onPressed: () async {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.grey[800],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 12),
                    child: Text(LangVarible.old_password.tr),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: oldPassController,
                    obscureText: true,
                    decoration:
                    InputDecoration(hintText: LangVarible.old_password.tr),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 12),
                    child: Text(LangVarible.new_password.tr),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    obscureText: true,
                    controller: passController,
                    decoration:
                    InputDecoration(hintText: LangVarible.new_password.tr),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 12),
                    child: Text(LangVarible.confirm_password.tr),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    obscureText: true,
                    controller: confirmPassController,
                    // decoration: InputDecoration(
                    //     hintText: "enter new password ..."
                    // ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 33),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: Get.width,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
                onPressed: () async {
                  Reset(
                      oldPassController.text.toString(),
                      passController.text.toString(),
                      confirmPassController.text.toString());
                },
                child:  Text("apply".tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
