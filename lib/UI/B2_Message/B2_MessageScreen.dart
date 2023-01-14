import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/UI/Chate_update/users.dart';
import 'AppBar_ItemScreen/inboxAppbar.dart';
import 'AppBar_ItemScreen/notificationAppbar.dart';
import 'message.dart';

class noMessage extends StatefulWidget {
  noMessage({Key? key}) : super(key: key);

  @override
  _noMessageState createState() => _noMessageState();
}

class _noMessageState extends State<noMessage> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title:  Text(
          "",
          style: TextStyle(
              fontFamily: "Sofia",
              fontWeight: FontWeight.w800,
              fontSize: 29.5,
              wordSpacing: 0.1),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/image/destinationPopuler/destination1.png",
            height: _height,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 210.0,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 20.0, color: Colors.black12.withOpacity(0.08))
                ]),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(
                        "Chat",
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 21.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        "When you find a place you love, share it with others. Tell them a bit about yourself and the purpose of your trip",
                        style: TextStyle(
                            color: Colors.black26, fontFamily: "Sofia"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(UserScreen());
                      },
                      child: Container(
                        height: 45.0,
                        width: 180.0,
                        color: Colors.deepPurpleAccent,
                        child: const Center(
                          child: Text(
                            "Start Exploring",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Sofia"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
