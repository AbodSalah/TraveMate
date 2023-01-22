import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/valid.dart';
import 'package:hotelbooking/UI/B2_Message/Chatting/chatting.dart';
import 'package:hotelbooking/components/customtextfild.dart';
import 'package:http/http.dart';
import 'package:quickalert/quickalert.dart';

class callCenter extends StatefulWidget {
  @override
  _callCenterState createState() => _callCenterState();
}

class _callCenterState extends State<callCenter> {
  String? emailController, subjectController, msgController;

  final GlobalKey<FormState> formkeysigin = GlobalKey();
  void Send() async {
    try {
      var url = "https://hotel-booking-8qw1.onrender.com/api/users/sendEmail";
      var response = await post(
        Uri.parse(url),
        body: jsonEncode(<String, String>{
          "email": emailController!,
          "subject": subjectController!,
          "message": msgController!,
        }),
        headers: <String, String>{'Content-Type': 'application/json'},
      ).then((value) {
        var data = jsonDecode(value.body.toString());
        if (value.statusCode == 200) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'تم ارسال الرساله بنجاح',
          );
          emailController = '';
          subjectController = '';
          msgController = '';
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'لم يتم ارسال الرساله',
          );
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
        title:  Text(
          "call_center".tr,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF6991C7)),
        elevation: 0.0,
      ),
      body: Container(
          color: Colors.white,
          child: Center(
              child: Form(
                key: formkeysigin,
                child: ListView(
                  children: <Widget>[
                    Image.asset(
                      "assets/image/illustration/girlcallcenter.png",
                      height: 80.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child:  Padding(
                        padding: EdgeInsets.only(top: 14.0),
                        child: Text(
                          "hel".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 12),
                            child: Text(""),
                          ),
                          const SizedBox(height: 6),
                          CustomTextfeild(
                            icon: Icons.mail,
                            valid: (p0) {
                              return validInput(p0.toString(), 4, 100, 'email');
                            },
                            onsaved: (p0) {
                              return emailController = p0!;
                            },
                            titel: 'email'.tr,
                          )
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
                            child: Text(""),
                          ),
                          const SizedBox(height: 6),
                          CustomTextfeild(
                            icon: Icons.subject,
                            valid: (p0) {
                              return validInput(p0.toString(), 4, 100, 'massge');
                            },
                            onsaved: (p0) {
                              return subjectController = p0!;
                            },
                            titel: 'subject'.tr,
                          )
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
                            child: Text(""),
                          ),
                          const SizedBox(height: 6),
                          CustomTextfeild(
                            icon: Icons.message,
                            valid: (p0) {
                              return validInput(p0.toString(), 4, 100, 'massge');
                            },
                            onsaved: (p0) {
                              return msgController = p0!;
                            },
                            titel: 'message'.tr,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: InkWell(
                        onTap: () async {
                          if (formkeysigin.currentState!.validate()) {
                            formkeysigin.currentState!.save();
                            Send();
                          }
                        },
                        child: Center(
                          child: Container(
                            height: 50.0,
                            width: 280.0,
                            decoration: const BoxDecoration(
                                color: Color(0xFF8DA2BF),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                            child:  Center(
                                child: Text(
                                  "send".tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0),
                                )),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
