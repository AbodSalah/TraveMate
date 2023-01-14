import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/UI/B2_Message/AppBar_ItemScreen/notificationAppbar.dart';
import 'package:hotelbooking/UI/IntroApps/Login.dart';
import 'package:hotelbooking/UI/pages/change_password.dart';
import 'package:hotelbooking/UI/pages/helps.dart';
import 'package:hotelbooking/UI/pages/invite_friend.dart';
import 'package:hotelbooking/langs/languge_varible.dart';
import 'package:hotelbooking/main.dart';
import 'ListProfile/CallCenter.dart';

class profile extends StatefulWidget {
  profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 352.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/image/images/bannerProfile.png",
                      ),
                      fit: BoxFit.cover)),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 67.0, left: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 90.0,
                          width: 90.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0)
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: sharedPreferences.getString('img') != null
                                ? Image.network(
                                    sharedPreferences.getString('img')!,
                                    errorBuilder: (context, error, stackTrace) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          'assets/images/imagenot.jpg',
                                        ),
                                      );
                                    },
                                  )
                                : Image.asset(
                                    'assets/images/imagenot.jpg',
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  sharedPreferences.getString('username') ?? '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0),
                                ),
                                Text(
                                  sharedPreferences.getString('email') ?? '',
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.0),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                              ]),
                        ),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 230.0),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              new notificationAppbar()));
                    },
                    child: category(
                      txt: LangVarible.notification.tr,
                      image: "assets/image/icon/notification.png",
                      padding: 20.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const Helps());
                    },
                    child: category(
                      txt: LangVarible.FAQs.tr,
                      image: "assets/image/icon/coupon.png",
                      padding: 20.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const InviteFriend());
                    },
                    child: category(
                      txt: LangVarible.invite_friends.tr,
                      image: "assets/image/icon/card.png",
                      padding: 20.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new callCenter()));
                    },
                    child: category(
                      txt: LangVarible.call_center.tr,
                      image: "assets/image/icon/callCenter.png",
                      padding: 20.0,
                    ),
                  ),
                  ListTile(
                    contentPadding:
                        const EdgeInsetsDirectional.only(start: 30, end: 22),
                    leading: const Icon(Icons.change_circle_outlined),
                    title: Padding(
                      padding: EdgeInsetsDirectional.only(start: 20),
                      child: Text(
                        LangVarible.change_password.tr,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Sofia",
                        ),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black26,
                      size: 15.0,
                    ),
                    onTap: () async {
                      Get.to(() => const ChangePassword());
                    },
                  ),
                  ListTile(
                    contentPadding:
                        const EdgeInsetsDirectional.only(start: 32, end: 22),
                    leading: const Icon(Icons.logout),
                    title: Padding(
                      padding: EdgeInsetsDirectional.only(start: 18),
                      child: Text(
                        LangVarible.logout.tr,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Sofia",
                        ),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black26,
                      size: 15.0,
                    ),
                    onTap: () async {
                      Get.to(() => const Login());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String? txt, image;
  GestureTapCallback? tap;
  double? padding;

  category({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: padding!),
                      child: Image.asset(
                        image!,
                        height: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        txt!,
                        style: const TextStyle(
                          fontSize: 14.5,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Sofia",
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 15.0,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
