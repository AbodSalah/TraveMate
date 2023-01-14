import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/controller/home_controller.dart';
import 'package:hotelbooking/langs/languge_varible.dart';

class TopReatingWidget extends StatelessWidget {
  const TopReatingWidget({
    Key? key,
    required TextStyle txtStyle,
  })  : _txtStyle = txtStyle,
        super(key: key);

  final TextStyle _txtStyle;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.only(right: 5.0, top: 10.0),
            height: 230.0,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12.0),
                  child: Text(
                    LangVarible.top_rating.tr,
                    style: _txtStyle,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 12, right: 12),
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (ctx, index) {
                      return cardLastActivity(
                        searchesModel: controller
                            .getTopReatingModel?.topRatingRooms![index],
                      );
                    },
                    itemCount:
                        controller.getTopReatingModel?.topRatingRooms!.length ??
                            1,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 12);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
