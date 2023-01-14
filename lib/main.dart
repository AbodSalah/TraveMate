import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/editProfile.dart';
import 'package:hotelbooking/UI/IntroApps/Login.dart';
import 'package:hotelbooking/UI/IntroApps/search/Pages/map/map_page.dart';
import 'package:hotelbooking/UI/IntroApps/search_map.dart';
import 'package:hotelbooking/UI/IntroApps/travelSelection.dart';
import 'package:hotelbooking/UI/languege_screen/languege_screen.dart';
import 'package:hotelbooking/langs/ar.dart';
import 'package:hotelbooking/langs/en.dart';
import 'package:hotelbooking/splash_screen.dart';
import 'package:hotelbooking/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'funs.dart' as f;

import 'classes.dart';

late SharedPreferences sharedPreferences;
FirebaseMessaging messaging = FirebaseMessaging.instance;
Stream<RemoteMessage> _stream = FirebaseMessaging.onMessageOpenedApp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  // await Firebase.initializeApp();
  await GetStorage.init();

  f.getFCMToken();
  print('object');
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    //   statusBarColor: Colors.transparent,
    // ));

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff424242), // navigation bar color
      // statusBarColor: Colors.grey, // status bar color
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      home: SplashScreen(), //MapPage(), //SplashScreen(),
      // home: BottomNavBar(),
      debugShowCheckedModeBanner: false, translations: MyTranslation(),
      locale: controller.language,
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColorLight: Colors.white,
        primaryColor: Colors.white,
        sliderTheme: SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(55),
            gapPadding: 0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(55),
            gapPadding: 0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.pink,
            ),
            borderRadius: BorderRadius.circular(55),
            gapPadding: 0,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(55),
            gapPadding: 0,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(55),
            gapPadding: 0,
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(55),
            borderSide: BorderSide(
              color: Colors.red,
            ),
            gapPadding: 0,
          ),
          labelStyle: TextStyle(
            height: 1,
          ),
          hintStyle: TextStyle(
            height: 1.5,
            color: Colors.grey[400],
          ), // height: 2.5
          helperStyle: TextStyle(
            height: 1.4,
          ),
          helperMaxLines: 3,
          fillColor: Colors.white,
          filled: true,
          errorStyle: TextStyle(height: 1.4),
        ),
      ),

      // lang _________________________________________________

      // locale: Locale("en"),
      fallbackLocale: Locale("ar"),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // DefaultWidgetsLocalizations.delegate,
        // DefaultCupertinoLocalizations.delegate,
        // DefaultMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar'),
        const Locale('en'),
      ],
      // end lang _________________________________________________
    );
  }
}

class MyTranslation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {"ar": ar, "en": en};
}
