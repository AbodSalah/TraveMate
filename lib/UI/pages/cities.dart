import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/UI/B1_Home/Destination/destinationDetail.dart';
import 'package:hotelbooking/controller/get_from_data_City_controller.dart';
import 'package:hotelbooking/langs/languge_varible.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/cities_model.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

class Cities extends StatefulWidget {
  const Cities({Key? key, this.message}) : super(key: key);
  final List<Message>? message;
  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            Get.back();
          },
          icon: Icon(
            Icons.clear,
            color: Colors.grey[800],
          ),
        ),
        title: Text(LangVarible.Cities.tr,
            style: TextStyle(color: Colors.grey[800])),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        itemBuilder: (context, int i) {
          return GestureDetector(
            onTap: () {
              Get.delete<GetDataCityController>();
              sharedPreferences.setString(
                  'keycity', widget.message![i].sId.toString());
              Get.to(
                () => destination(
                  name: widget.message![i].name,
                  desc: widget.message![i].desc,
                ),
                duration: const Duration(milliseconds: 600),
                transition: Transition.fadeIn,
                curve: Curves.easeIn,
              );
            },
            child: Container(
              height: Get.width * 0.6,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: Get.width * 0.95,
                    height: Get.width * 0.6,
                    child: Image.network(
                        "${MangeAPi.baseurl}/${widget.message?[i].imgs!.split(',').first}",
                        fit: BoxFit.cover),
                  ),
                  Container(
                    width: Get.width * 0.95,
                    height: Get.width * 0.6,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  Text(
                    "${widget.message?[i].name}",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, int i) {
          return SizedBox(height: 14);
        },
        itemCount: widget.message?.length ?? 0,
      ),
    );
  }
}
