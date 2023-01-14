import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({Key? key}) : super(key: key);

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/invite.png",
              height: 400,
              width: 400,
            ),
            Text(
              "invite_your_friend".tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text(
              "",
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: 33),
            SizedBox(
              height: 50,
              width: Get.width * 0.4,
              child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final box = context.findRenderObject() as RenderBox?;

                    await Share.share(
                      'please share this link with your friends to rate us : https://PlayStore/TravelMate',
                      sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                    );
                    //  Share.share('check out my website https://example.com');
                  } catch (e) {
                    print('erorrrr  :  $e');
                  }
                },
                icon: const Icon(Icons.share),
                label:  Text("share".tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
