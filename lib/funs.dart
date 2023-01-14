
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'vars.dart' as v;

String appLang() {
  if (v.box.read("lang") == null) {
    if (Get.deviceLocale?.languageCode == "en") {
      v.lang = "en";
    } else if (Get.deviceLocale?.languageCode == "ar") {
      v.lang = "ar";
    } else {
      v.lang = "en";
    }
    GetStorage().write("lang", v.lang);
  } else {
    v.lang = GetStorage().read("lang");
  }
  print("v.lang: ${v.lang}");
  return "ar";
}

Future getFCMToken() async {
  try {
    FirebaseMessaging.instance.getToken().then((value) {
      print("============================= token ============================");
      print("${value}");
      print("============================= token ============================");
      print("FirebaseMessaging.onMessage.listen(onArriveForegroundfbm)");
    }).catchError((err) {
      print("err get token fbm: ${err}");
      Fluttertoast.showToast(
          msg: "لا يمكنك تلقي الاشعارات تحقق من اتصال الانترنت");
    });
  }catch(err){
    print("err messaging: ${err}");
  }

}

Future<String> getExternalStorage() async {
  Directory? dir = await getExternalStorageDirectory();
  return dir!.path;
}
