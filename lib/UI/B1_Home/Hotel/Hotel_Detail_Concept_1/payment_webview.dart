import 'package:flutter/material.dart';
import 'package:hotelbooking/data/functions_response/get_info_room.dart';
import 'package:hotelbooking/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({
    super.key,
  });

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          print(
              '-------------------------------------------------------------------');
        },
        onPageStarted: (String url) {
          print(
              '##############################################################');
        },
        onPageFinished: (String url) async {
          print(
              '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
          await addDataRespon(
            data: sharedPreferences.getString('data'),
            placeid: sharedPreferences.getString('roomId'),
          );
          print(
              '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
        },
        onWebResourceError: (WebResourceError error) {
          print(
              '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        },
        onNavigationRequest: (NavigationRequest request) {
          print(
              '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
          if (request.url.startsWith('https://www.youtube.com')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(
        'https://hotel-booking-8qw1.onrender.com/api/users/placePay?price=${sharedPreferences.getString('price')}&userId=${sharedPreferences.getString('id')}&roomId=${sharedPreferences.getString('roomId')}'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
