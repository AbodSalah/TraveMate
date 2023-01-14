import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/UI/IntroApps/OnBoarding.dart';
import 'package:hotelbooking/components/custombutten.dart';
import 'package:hotelbooking/main.dart';

class Language extends GetView<LocaleController> {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        child: ButtonWithtext(
          controller: controller,
          width1: 400,
          width2: 400,
        ),
      ),
    );
  }
}

class ButtonWithtext extends StatelessWidget {
  const ButtonWithtext({
    Key? key,
    required this.controller,
    required this.width1,
    required this.width2,
  }) : super(key: key);

  final LocaleController controller;
  final double width1;
  final double width2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("choose_the_language".tr,
            style: Theme.of(context).textTheme.headline3),
        const SizedBox(height: 20),
        CustomButton(
          color: Colors.teal,
          haigh: 75,
          text: "Arabic",
          press: () {
            controller.changeLang("ar");
            Get.to(onBoarding());
          },
          width: width1,
        ),
        CustomButton(
          haigh: 75,
          text: "English",
          press: () {
            controller.changeLang("en");
            Get.to(onBoarding());
          },
          color: Colors.blue,
          width: width2,
        ),
      ],
    );
  }
}

class LocaleController extends GetxController {
  Locale? language;

  // MyServices myServices = Get.find();
  //ThemeData appTheme = themeEnglish;
  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    //  appTheme = langcode == "ar" ? themeArabic : themeEnglish;
    sharedPreferences.setString("lang", langcode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = sharedPreferences.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      // appTheme = themeArabic;
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      //appTheme = themeEnglish;
    } else {
      //  appTheme = themeEnglish;
      language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
