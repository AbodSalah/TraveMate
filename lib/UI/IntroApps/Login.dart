import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/valid.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/components/customtextfild.dart';
import 'package:hotelbooking/controller/auth_controller/login_controler.dart';
import 'package:hotelbooking/Library/SupportingLibrary/Animation/LoginAnimation.dart';
import 'package:hotelbooking/UI/IntroApps/forgetPass.dart';
import '../../langs/languge_varible.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late AnimationController sanimationController;
  var tap = 0;

  @override
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LoginController>(
        init: LoginController(context),
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Form(
              key: controller.formkeysigin,
              child: ListView(
                children: <Widget>[
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: 270,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  height: 300,
                                  width: width + 20,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/image/destinationPopuler/tripBackground.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                /// Fade Animation for transtition animaniton

                                Text(
                                  "login".tr,
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
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      CustomTextfeild(
                                        valid: (p0) {
                                          return validInput(
                                              p0.toString(), 5, 100, 'email');
                                        },
                                        onsaved: (p0) {
                                          return controller.emaillog = p0!;
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
                                          return controller.passwordlog = p0!;
                                        },
                                        titel: 'password'.tr,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    Signup(),
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
                                      child: Text(
                                        LangVarible.sign_up.tr,
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontFamily: "Sofia",
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 1.3),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                forgetPass(),
                                            transitionDuration: const Duration(
                                                milliseconds: 2000),
                                            transitionsBuilder: (_,
                                                Animation<double> animation,
                                                __,
                                                Widget child) {
                                              return Opacity(
                                                opacity: animation.value,
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child:  Text(
                                        "forget_password".tr,
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontFamily: "Sofia",
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 1.3),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 110)
                              ],
                            ),
                          ),
                        ],
                      ),

                      /// Set Animaion after user click buttonLogin
                      tap == 0
                          ? InkWell(
                        splashColor: Colors.yellow,
                        onTap: () {
                          setState(() {
                            tap = 1;
                          });
                          new LoginAnimation(
                            animationController: sanimationController.view
                            as AnimationController,
                          );
                          _PlayAnimation();
                        },
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              controller.login();
                              print('object');
                            },
                            child: Container(
                              height: 55.0,
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xFF8DA2BF),
                              ),
                              child: Center(
                                child: Text(
                                  LangVarible.login.tr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19.5,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                          : new LoginAnimation(
                        animationController: sanimationController.view
                        as AnimationController,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
