import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/UI/IntroApps/Login.dart';
import 'package:hotelbooking/data/functions_response/LoginFunc.dart';
import 'package:quickalert/quickalert.dart';

class SiginUpController extends GetxController {
  late String email, password, name, city, country, phone, repass;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _user = Rxn<User>();
  String? get user => _user.value?.email;
  final GlobalKey<FormState> formkeysigin = GlobalKey();

  StatusRequest statusRequest = StatusRequest.none;
  SiginUp({required BuildContext context}) async {
    if (formkeysigin.currentState!.validate()) {
      formkeysigin.currentState!.save();
      statusRequest = StatusRequest.loading;
      update();
      var respon = await SignUpRespons(
        city: city,
        country: country,
        email: email,
        password: password,
        phone: phone,
        repassword: repass,
        username: name,
      );
      statusRequest = handlingData(respon);
      try {
        if (StatusRequest.success == statusRequest) {
          if (respon['message'].toString() ==
              'Verification email is sent to your gmail account') {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'تم انشاء الحساب بنجاح يرجي تاكيد الاميل الخاص بك');
            Get.to(Login());
            print('Sucss $respon');
          } else {
            statusRequest = StatusRequest.none;
            print('erorr $respon');
            showToast(respon['message']);
          }
        }
      } catch (e) {
        print('catch $e');
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'لم يتم انشاء الحساب');
      }
      update();
    }
  }

  late FToast fToast;
  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
    fToast = FToast();
    super.onInit();
  }

  showToast(String masge) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(
            masge,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
  }
}
