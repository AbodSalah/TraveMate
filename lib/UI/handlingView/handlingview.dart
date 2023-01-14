import 'package:flutter/material.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:lottie/lottie.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: SizedBox(
              child: Lottie.asset(
                'assets/images/loding.json',
                width: 250,
                height: 250,
              ),
            ),
          )
        : statusRequest == StatusRequest.offlinefailure
            ? Center(
                child: SizedBox(
                  child: Lottie.asset(
                    'assets/images/120346-empty-box-orange-theme.json',
                    width: 250,
                    height: 250,
                  ),
                ),
              )
            : statusRequest == StatusRequest.serverfailure
                ? Center(
                    child: SizedBox(
                      child: Lottie.asset(
                        'assets/images/93120-erorr-404.json',
                        width: 250,
                        height: 250,
                      ),
                    ),
                  )
                : statusRequest == StatusRequest.failure
                    ? Center(
                        child: SizedBox(
                          child: Lottie.asset(
                            'assets/images/120346-empty-box-orange-theme.json',
                            width: 250,
                            height: 250,
                          ),
                        ),
                      )
                    : widget;
  }
}
