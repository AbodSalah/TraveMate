import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/HotelList.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/controller/home_controller.dart';
import 'package:hotelbooking/langs/languge_varible.dart';
import 'package:hotelbooking/main.dart';
import '../../../../vars.dart' as v;
import '../B1_Home_Screen.dart';

class RecomendedTrevatelWidget extends StatelessWidget {
  const RecomendedTrevatelWidget({
    Key? key,
    required TextStyle txtStyle,
  })  : _txtStyle = txtStyle,
        super(key: key);

  final TextStyle _txtStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40.0),
      height: 325.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            child: Text(
              LangVarible.Types.tr,
              style: _txtStyle,
            ),
          ),
          Expanded(
            child: GetBuilder<HomeController>(builder: (controller) {
              return HandlingDataView(
                statusRequest: controller.statusRequest3,
                widget: ListView.separated(
                  itemCount: controller.getTypesModel?.message!.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, int i) {
                    return CardType(
                      img:
                          "${v.imagLink}/${controller.getTypesModel?.message![i].imgs!.split(',').first}",

                      txtTitle: controller.getTypesModel?.message![i].title,
                      txtSize: 48.0,
                      txtHeader: controller.getTypesModel?.message![i].type,
                      txtDesc: controller.getTypesModel?.message![i].desc,
                      navigatorOntap: () {
                        sharedPreferences.setString(
                          'type',
                          controller.getTypesModel?.message![i].type ?? 'فندق',
                        );

                        Get.to(
                          HotelList(
                            name: controller.getTypesModel?.message![i].type ??
                                'hotelName',
                          ),
                        );
                      }, //
                    );
                  },
                  separatorBuilder: (context, int i) {
                    return const SizedBox(
                      width: 4,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
