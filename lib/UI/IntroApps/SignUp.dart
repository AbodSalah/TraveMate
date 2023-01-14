import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/valid.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/components/customtextfild.dart';
import 'package:hotelbooking/controller/auth_controller/signup_controller.dart';
import 'package:hotelbooking/langs/languge_varible.dart';
import 'package:http/http.dart';
import 'package:hotelbooking/Library/SupportingLibrary/Animation/LoginAnimation.dart';
import 'package:hotelbooking/Library/intro_views_flutter-2.4.0/lib/UI/page.dart';
import 'package:hotelbooking/Library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';
import 'package:hotelbooking/UI/IntroApps/Login.dart';
import 'package:http/http.dart' as http;
import 'package:hotelbooking/UI/IntroApps/travelSelection.dart';
import 'SignUp.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  @override

  //Animation Declaration
  late AnimationController sanimationController;

  var tap = 0;

  @override

  /// set state animation controller
  void initState() {
    sanimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..addStatusListener((statuss) {
        if (statuss == AnimationStatus.dismissed) {
          setState(() {
            tap = 0;
          });
        }
      });
    // TODO: implement initState
    super.initState();
  }

  /// Dispose animation controller
  @override
  void dispose() {
    sanimationController.dispose();
    super.dispose();
  }

  /// Playanimation set forward reverse
  Future _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<SiginUpController>(
        init: SiginUpController(),
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Form(
                      key: controller.formkeysigin,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /// Image Top
                          Container(
                            height: 220,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  height: 270,
                                  width: width + 20,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/image/destinationPopuler/tripBackground.png'),
                                            fit: BoxFit.fill)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20.0,
                            ),
                            child: Column(
                              //luyiiul
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "sign_up".tr,
                                  style: TextStyle(
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 37.5,
                                      wordSpacing: 0.1),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        const BoxShadow(
                                          color:
                                          Color.fromRGBO(196, 135, 198, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10),
                                        )
                                      ]),
                                  child: Column(
                                    //dhthdtgh
                                    children: <Widget>[
                                      CustomTextfeild(
                                        valid: (p0) {
                                          return validInput(p0.toString(), 2,
                                              100, 'username');
                                        },
                                        onsaved: (p0) {
                                          return controller.name = p0!;
                                        },
                                        titel: 'user_name'.tr,
                                      ),
                                      CustomTextfeild(
                                        valid: (p0) {
                                          return validInput(
                                              p0.toString(), 2, 100, 'email');
                                        },
                                        onsaved: (p0) {
                                          return controller.email = p0!;
                                        },
                                        titel: LangVarible.email.tr,
                                      ),
                                      CustomTextfeild(
                                        obsecuer: true,
                                        valid: (p0) {
                                          return validInput(p0.toString(), 8,
                                              100, 'password');
                                        },
                                        onsaved: (p0) {
                                          return controller.password = p0!;
                                        },
                                        titel: 'password'.tr,
                                      ),
                                      CustomTextfeild(
                                        obsecuer: true,
                                        valid: (p0) {
                                          return validInput(p0.toString(), 8,
                                              100, 'password');
                                        },
                                        onsaved: (p0) {
                                          return controller.repass = p0!;
                                        },
                                        titel: 'confirm_password'.tr,
                                      ),
                                      CustomTextfeild(
                                        valid: (p0) {
                                          return validInput(
                                              p0.toString(), 2, 100, 'city');
                                        },
                                        onsaved: (p0) {
                                          return controller.country = p0!;
                                        },
                                        titel: LangVarible.country.tr,
                                      ),
                                      CustomTextfeild(
                                        valid: (p0) {
                                          return validInput(
                                              p0.toString(), 2, 100, 'city');
                                        },
                                        onsaved: (p0) {
                                          return controller.city = p0!;
                                        },
                                        titel: 'city'.tr,
                                      ),
                                      CustomTextfeild(
                                        valid: (p0) {
                                          return validInput(
                                              p0.toString(), 5, 100, 'Phone');
                                        },
                                        onsaved: (p0) {
                                          return controller.phone = p0!;
                                        },
                                        titel: LangVarible.phone.tr,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                              const Login(),
                                              transitionDuration:
                                              const Duration(
                                                  milliseconds: 2000),
                                              transitionsBuilder: (_,
                                                  Animation<double> animation,
                                                  __,
                                                  Widget child) {
                                                return Opacity(
                                                  opacity: animation.value,
                                                  child: child,
                                                );
                                              }));
                                    },
                                    child:  Text(
                                      "Have_Account_Login".tr,
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontFamily: "Sofia",
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 1.3),
                                    )),
                                const SizedBox(
                                  height: 90,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    /// Set Animaion after user click buttonSignup
                    tap == 0
                        ? InkWell(
                      splashColor: Colors.yellow,
                      onTap: () {
                        setState(() {
                          tap = 1;
                        });
                        LoginAnimation(
                          animationController: sanimationController.view
                          as AnimationController,
                        );
                        _PlayAnimation();
                      },
                      child: GestureDetector(
                        onTap: () {
                          controller.SiginUp(
                            context: context,
                          );
                        },
                        child: Container(
                          height: 55.0,
                          margin: const EdgeInsets.only(
                              left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFF8DA2BF),
                          ),
                          child: Center(
                            child: Text(
                              LangVarible.sign_up.tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Sofia",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.5,
                                  letterSpacing: 1.2),
                            ),
                          ),
                        ),
                      ),
                    )
                        : LoginAnimation(
                      animationController: sanimationController.view
                      as AnimationController,
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
