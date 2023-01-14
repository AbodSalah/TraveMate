import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/UI/B1_Home/Destination/destinationDetail.dart';
import 'package:hotelbooking/controller/get_from_data_City_controller.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/cities_model.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

class CardCity extends StatelessWidget {
  const CardCity({
    Key? key,
    required this.message,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.delete<GetDataCityController>();
        sharedPreferences.setString('keycity', message.sId.toString());
        Get.to(
          () => destination(
            name: message.name,
            desc: message.desc,
          ),
          duration: const Duration(milliseconds: 600),
          transition: Transition.fadeIn,
          curve: Curves.easeIn,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 400.0,
          width: 140.0,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              image: DecorationImage(
                image: NetworkImage(
                    "${MangeAPi.baseurl}/${message.imgs!.split(',').first}"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.darken),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 2.0,
                    spreadRadius: 1.0)
              ]),
          child: Center(
            child: Text(
              message.name!,
              style: const TextStyle(
                  fontFamily: 'Amira',
                  color: Colors.white,
                  fontSize: 40.0,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 2.0,
                    )
                  ]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
