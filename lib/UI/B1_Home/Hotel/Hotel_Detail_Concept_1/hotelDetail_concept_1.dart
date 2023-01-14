import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotelbooking/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/maped.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/payment_webview.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/reviewDetail1.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/maps.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/controller/edit_profile_controller.dart';
import 'package:hotelbooking/controller/getInfoRoom_controller.dart';
import 'package:hotelbooking/langs/languge_varible.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/info_room_model.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';
import '../../../../Library/Ratting_Bar/ratting.dart';
import 'gallery.dart';

class HotelDetail extends StatefulWidget {
  HotelDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  double rating = 3.5;
  final Set<Marker> _markers = {};
  final LatLng _currentPosition = const LatLng(40.7078523, -74.008981);

  @override
  void initState() {
    _markers.add(
      Marker(
        markerId: const MarkerId("40.7078523, -74.008981"),
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }

  final GetInfoRoomController getInfoRoomController =
  Get.put(GetInfoRoomController());
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<GetInfoRoomController>(
          builder: (controller) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  SliverPersistentHeader(
                    /// Create Appbar
                    delegate: MySliverAppBar(
                      controller: controller,
                      expandedHeight: _height - 30.0,
                    ),
                    pinned: true,
                  ),

                  /// Create body
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// For icon row
                        IconsAllWidget(controller: controller),

                        /// Desc
                        DescrptionWidget(controller: controller),

                        /// Location
                        LocationHomeWidget(
                            markers: _markers, controller: controller),

                        /// Gallery
                        GalleryWidget(width: _width, controller: controller),

                        /// Ratting
                        ReatingRomWidget(controller: getInfoRoomController),

                        ///Related Post
                        RelatedRoomsWidget(controller: controller),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ReatingRomWidget extends StatefulWidget {
  const ReatingRomWidget({super.key, required this.controller});
  final GetInfoRoomController controller;
  @override
  State<ReatingRomWidget> createState() => _ReatingRomWidgetState();
}

class _ReatingRomWidgetState extends State<ReatingRomWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            width: 600.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 1.0,
                  spreadRadius: 0.2,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "reviews".tr,
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 15.0, bottom: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              child:  Padding(
                                  padding: EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    "vi".tr,
                                    style: TextStyle(
                                        color: Colors.indigoAccent,
                                        fontSize: 14.0),
                                  )),
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => reviewDetail1(
                                        feedbacks: widget.controller
                                            .infoRoomModel?.room?.feedbacks!),
                                  ),
                                );
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0, top: 2.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 18.0,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // StarRating(
                            //   size: 25.0,
                            //   starCount: 5,
                            //   rating: 5,
                            //   color: Colors.yellow,
                            //   borderColor: Colors.yellow,
                            //   onRatingChanged: (double rating) {},
                            // ),
                            const SizedBox(width: 5.0),
                            Text(
                              "العدد: ${widget.controller.infoRoomModel?.room!.feedbacks!.length} ",
                            ),
                          ]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 20.0, top: 15.0, bottom: 7.0),
                    child: _line(),
                  ),
                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget
                          .controller.infoRoomModel!.room!.feedbacks!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildRating(
                            widget.controller.infoRoomModel!.room!
                                .feedbacks![index].date
                                .toString(),
                            widget.controller.infoRoomModel!.room!
                                .feedbacks![index].review
                                .toString(),
                            widget.controller.infoRoomModel?.room!
                                .feedbacks![index].rating!
                                .toDouble() ??
                                5,
                            "assets/image/profile/profile1.jpg");
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RelatedRoomsWidget extends StatelessWidget {
  const RelatedRoomsWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final GetInfoRoomController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "related_rooms".tr,
                style: TextStyle(
                    fontFamily: "Sofia",
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          height: 225.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.infoRoomModel?.relatedRooms!.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  print('object');
                  sharedPreferences.setString(
                      'keyroom',
                      controller.infoRoomModel?.relatedRooms?[index].sId
                          .toString() ??
                          '');
                  Get.delete<GetInfoRoomController>();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HotelDetail(),
                    ),
                  );
                },
                child: _relatedPost(
                  controller.infoRoomModel?.relatedRooms![index].imgs,
                  controller.infoRoomModel?.relatedRooms![index].title,
                  controller.infoRoomModel?.relatedRooms![index].city,
                  controller.infoRoomModel?.relatedRooms![index].averageRating
                      .toString(),
                  controller.infoRoomModel?.relatedRooms![index].price,
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: InkWell(
            onTap: () {
              print('object');

              Get.bottomSheet(
                SizedBox(
                  height: 400,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "يرجي اختيار تاريخ الحجز",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(

                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'تاريخ البداية',
                              style: TextStyle(
                                  color: Colors.grey[200],
                                  fontFamily: "Sofia",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              dateMask: 'd MMM, yyyy',
                              initialValue: DateTime.now().toString(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2100),
                              icon: Icon(Icons.event),
                              dateLabelText: '',
                              timeLabelText: "",
                              selectableDayPredicate: (date) {
                                // Disable weekend days to select from the calendar
                                if (date.weekday == 6 || date.weekday == 7) {
                                  return false;
                                }

                                return true;
                              },
                              onChanged: (val) {
                                print('onchan');
                                controller.startData = DateTime.parse(val);
                                ;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'تاريخ النهاية',
                              style: TextStyle(
                                  color: Colors.grey[200],
                                  fontFamily: "Sofia",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              dateMask: 'd MMM, yyyy',
                              initialValue: DateTime.now().toString(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2100),
                              icon: Icon(Icons.event),
                              dateLabelText: '',
                              timeLabelText: "",
                              selectableDayPredicate: (date) {
                                // Disable weekend days to select from the calendar
                                if (date.weekday == 6 || date.weekday == 7) {
                                  return false;
                                }

                                return true;
                              },
                              onChanged: (val) {
                                print('onchan');
                                controller.endData = DateTime.parse(val);
                              },
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            InkWell(
                              onTap: () {
                                if (controller.infoRoomModel?.room!.type
                                    .toString() ==
                                    'منزل') {
                                  if (controller.startData == null ||
                                      controller.endData == null) {
                                    showsnackBar(
                                      'يرجي تحديد تاريخ البدايه والنهايه',
                                    );
                                    return;
                                  } else {
                                    if (controller.infoRoomModel!.room!
                                        .unavailableDates!.isNotEmpty) {
                                      for (int i = 0;
                                      i <
                                          controller.infoRoomModel!.room!
                                              .unavailableDates!.length;
                                      i++) {
                                        List<String> x = controller
                                            .infoRoomModel!
                                            .room!
                                            .unavailableDates![i]
                                            .split(',');
                                        if ((controller.startData!.isBefore(
                                            DateTime.parse(x[0])) &&
                                            controller.endData!.isBefore(
                                                DateTime.parse(x[1]))) ||
                                            (controller.startData!.isAfter(
                                                DateTime.parse(x[0])) &&
                                                controller.endData!.isAfter(
                                                    DateTime.parse(x[1])))) {
                                        } else {
                                          controller.isDatatime == false;
                                          showsnackBar(
                                            'معاد الحجز غير متوفر يرجي اخيار تاريخ اخر',
                                          );
                                          return;
                                        }
                                      }
                                    } else {
                                      print('GOOOOOOOO PaymentWebView');
                                      sharedPreferences.setString(
                                          'price',
                                          controller.infoRoomModel!.room!.price
                                              .toString());
                                      sharedPreferences.setString('data',
                                          '${controller.startData},${controller.endData}');
                                      sharedPreferences.setString(
                                        'roomId',
                                        controller.infoRoomModel!.room!.sId
                                            .toString(),
                                      );
                                      Get.to(PaymentWebView());
                                      Get.delete<GetInfoRoomController>();
                                    }
                                  }

                                  if (controller.isDatatime) {
                                    print('GOOOOOOOO PaymentWebView  22222 ');
                                    sharedPreferences.setString(
                                        'price',
                                        controller.infoRoomModel!.room!.price
                                            .toString());
                                    sharedPreferences.setString('data',
                                        '${controller.startData},${controller.endData}');
                                    sharedPreferences.setString(
                                        'roomId',
                                        controller.infoRoomModel!.room!.sId
                                            .toString());
                                    Get.to(PaymentWebView());
                                    Get.delete<GetInfoRoomController>();
                                  } else {
                                    showsnackBar(
                                      'معاد الحجز غير متوفر يرجي اخيار تاريخ اخر',
                                    );
                                    return;
                                  }
                                } else {
                                  Get.bottomSheet(
                                    Container(
                                      height: 5000,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                'اختر الغرف',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InfoWidget(
                                              controller: controller,
                                              text1:
                                              'Averge Rating : ${controller.infoRoomModel?.room!.averageRating.toString() ?? '3'}',
                                              text2:
                                              'Max people : ${controller.infoRoomModel?.room!.maxPeople.toString() ?? '3'}',
                                              text3:
                                              'Price : ${controller.infoRoomModel?.room!.price.toString() ?? ''}',
                                              text4: controller.infoRoomModel
                                                  ?.room!.title
                                                  .toString() ??
                                                  '',
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            // InfoWidget(
                                            //   controller: controller,
                                            //   text1:
                                            //   'Averge Rating : ${controller.infoRoomModel?.room!.averageRating.toString() ?? '3'}',
                                            //   text2:
                                            //   'Max people : ${controller.infoRoomModel?.room!.maxPeople.toString() ?? '3'}',
                                            //   text3:
                                            //   'Price : ${controller.infoRoomModel?.room!.price.toString() ?? ''}',
                                            //   text4: controller.infoRoomModel
                                            //       ?.room!.title
                                            //       .toString() ??
                                            //       '',
                                            // ),
                                            // SizedBox(
                                            //   height: 20,
                                            // ),
                                            // InfoWidget(
                                            //   controller: controller,
                                            //   text1:
                                            //   'Averge Rating : ${controller.infoRoomModel?.room!.averageRating.toString() ?? '3'}',
                                            //   text2:
                                            //   'Max people : ${controller.infoRoomModel?.room!.maxPeople.toString() ?? '3'}',
                                            //   text3:
                                            //   'Price : ${controller.infoRoomModel?.room!.price.toString() ?? ''}',
                                            //   text4: controller.infoRoomModel
                                            //       ?.room!.title
                                            //       .toString() ??
                                            //       '',
                                            // ),
                                            // SizedBox(
                                            //   height: 20,
                                            // ),
                                            InkWell(
                                              onTap: () {
                                                if (controller.startData ==
                                                    null ||
                                                    controller.endData ==
                                                        null) {
                                                  showsnackBar(
                                                    'يرجي تحديد تاريخ البدايه والنهايه',
                                                  );
                                                  return;
                                                } else {
                                                  if (controller
                                                      .infoRoomModel!
                                                      .room!
                                                      .unavailableDates!
                                                      .isNotEmpty) {
                                                    for (int i = 0;
                                                    i <
                                                        controller
                                                            .infoRoomModel!
                                                            .room!
                                                            .unavailableDates!
                                                            .length;
                                                    i++) {
                                                      List<String> x = controller
                                                          .infoRoomModel!
                                                          .room!
                                                          .unavailableDates![i]
                                                          .split(',');
                                                      if ((controller.startData!.isBefore(
                                                          DateTime.parse(
                                                              x[0])) &&
                                                          controller
                                                              .endData!
                                                              .isBefore(DateTime.parse(
                                                              x[1]))) ||
                                                          (controller.startData!.isAfter(
                                                              DateTime.parse(
                                                                  x[0])) &&
                                                              controller
                                                                  .endData!
                                                                  .isAfter(
                                                                  DateTime.parse(
                                                                      x[1])))) {
                                                      } else {
                                                        controller.isDatatime ==
                                                            false;
                                                        showsnackBar(
                                                          'معاد الحجز غير متوفر يرجي اخيار تاريخ اخر',
                                                        );
                                                        return;
                                                      }
                                                    }
                                                  } else {
                                                    print(
                                                        'GOOOOOOOO PaymentWebView');
                                                    sharedPreferences.setString(
                                                        'price',
                                                        controller
                                                            .infoRoomModel!
                                                            .room!
                                                            .price
                                                            .toString());
                                                    sharedPreferences.setString(
                                                        'data',
                                                        '${controller.startData},${controller.endData}');
                                                    sharedPreferences.setString(
                                                      'roomId',
                                                      controller.infoRoomModel!
                                                          .room!.sId
                                                          .toString(),
                                                    );
                                                    Get.to(PaymentWebView());
                                                    Get.delete<
                                                        GetInfoRoomController>();
                                                  }
                                                }

                                                if (controller.isDatatime) {
                                                  print(
                                                      'GOOOOOOOO PaymentWebView  22222 ');
                                                  sharedPreferences.setString(
                                                      'price',
                                                      controller.infoRoomModel!
                                                          .room!.price
                                                          .toString());
                                                  sharedPreferences.setString(
                                                      'data',
                                                      '${controller.startData},${controller.endData}');
                                                  sharedPreferences.setString(
                                                      'roomId',
                                                      controller.infoRoomModel!
                                                          .room!.sId
                                                          .toString());
                                                  Get.to(PaymentWebView());
                                                  Get.delete<
                                                      GetInfoRoomController>();
                                                } else {
                                                  showsnackBar(
                                                    'معاد الحجز غير متوفر يرجي اخيار تاريخ اخر',
                                                  );
                                                  return;
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 400,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                ),
                                                child: Text(
                                                  'تأكبد الحجز',
                                                  // style:
                                                  //     TextStyle(fontSize: 23),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                    backgroundColor: Colors.white,
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(35),
                                    //   side: BorderSide(
                                    //     width: 5,
                                    //     color: Colors.black
                                    //   )
                                    // ),
                                    enableDrag: false,
                                  );
                                }
                              },
                              child: Container(
                                height: 55.0,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF8F73F2),
                                      Colors.deepPurpleAccent,
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    ("next").tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19.0,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                    side: BorderSide(width: 5, color: Colors.white10)),
                enableDrag: false,
              );
            },
            child: Container(
              height: 55.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF8F73F2),
                    Colors.deepPurpleAccent,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Center(
                child: Text(
                  LangVarible.Bookings.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
    required this.controller,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
  }) : super(key: key);

  final GetInfoRoomController controller;
  final String text1, text2, text3, text4;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text4,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                text1,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                text2,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 5),
              Text(
                text3,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(),
          ),
          for (int i = 0;
          i < controller.infoRoomModel!.room!.roomNumbers!.length;
          i++)
            CheckCustom(
                text: controller.infoRoomModel!.room!.roomNumbers![i].number),
        ],
      ),
    );
  }
}

class CheckCustom extends StatefulWidget {
  CheckCustom({
    Key? key,
    this.text,
  }) : super(key: key);
  final text;
  @override
  State<CheckCustom> createState() => _CheckCustomState();
}

class _CheckCustomState extends State<CheckCustom> {
  bool x = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.text.toString()),
        GetBuilder<GetInfoRoomController>(
          builder: (controller) {
            return SizedBox(
              height: 40,
              width: 40,
              child: Checkbox(
                value: x,
                onChanged: (value) {
                  setState(() {
                    x = x == true ? false : true;
                  });
                  controller.up();
                  print(value);
                  print(x);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({
    Key? key,
    required double width,
    required this.controller,
  })  : _width = width,
        super(key: key);

  final double _width;
  final GetInfoRoomController controller;
  @override
  Widget build(BuildContext context) {
    List<String> images =
        controller.infoRoomModel?.room!.imgs!.split(',') ?? ''.split(',');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
          EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: Text(
            "gallery".tr,
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(
          height: 400,
          width: double.infinity,
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: "hero-flashsale-${index}",
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return new Material(
                                color: Colors.black54,
                                child: Container(
                                  padding: const EdgeInsets.all(30.0),
                                  child: InkWell(
                                    child: Hero(
                                        tag: "hero-flashsale-${index}",
                                        child: Image.network(
                                          '${MangeAPi.baseurl}/${images[index]}',
                                          width: 300.0,
                                          height: 400.0,
                                          alignment: Alignment.center,
                                          fit: BoxFit.contain,
                                        )),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                            transitionDuration:
                            const Duration(milliseconds: 500)));
                      },
                      child: SizedBox(
                        child: Image.network(
                          '${MangeAPi.baseurl}/${images[index]}',
                          fit: BoxFit.cover,
                          height: 140.0,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class LocationHomeWidget extends StatelessWidget {
  const LocationHomeWidget({
    Key? key,
    required Set<Marker> markers,
    required this.controller,
  })  : _markers = markers,
        super(key: key);

  final Set<Marker> _markers;
  final GetInfoRoomController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
          EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0, bottom: 20.0),
          child: Text(
            "location".tr,
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.justify,
          ),
        ),
        Stack(
          children: <Widget>[
            Container(
              height: 190.0,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    controller.infoRoomModel!.room!.address!.latitude!,
                    controller.infoRoomModel!.room!.address!.longitude!,
                  ),
                  zoom: 13.0,
                ),
                markers: _markers,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 135.0, right: 60.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () async {
                    // await sharedPreferences.setString(
                    //           'searcc',
                    //           modde?.predictions![index].placeId ??
                    //               'ChIJl1ZCUPbgHBURhD0VvTCpC38');
                    //       // await getLocationFromPlaceId(
                    //       //     modde?.predictions![index].placeId ??
                    //       //         'ChIJl1ZCUPbgHBURhD0VvTCpC38');
                    sharedPreferences.setDouble('lan',
                        controller.infoRoomModel!.room!.address!.longitude!);
                    sharedPreferences.setDouble('lat',
                        controller.infoRoomModel!.room!.address!.latitude!);
                    Get.to(MapEdit());
                  },
                  child: Container(
                    height: 35.0,
                    width: 95.0,
                    decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.5),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30.0))),
                    child: const Center(
                      child: Text("See Map",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Sofia")),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class DescrptionWidget extends StatelessWidget {
  const DescrptionWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final GetInfoRoomController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ExpansionTile(
          title: Text(
            'see_contact_info'.tr,
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
          children: [
            ListTile(
              leading: Image.network(
                controller.infoRoomModel?.userContactInfo?.img == null ||
                    controller.infoRoomModel?.userContactInfo?.img == ""
                    ? 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80'
                    : "${MangeAPi.baseurl}/${controller.infoRoomModel?.userContactInfo?.img!.split(',').first}",
              ),
              title: Text(
                controller.infoRoomModel?.userContactInfo?.username ??
                    'username',
                style: TextStyle(
                    fontFamily: "Sofia",
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                  controller.infoRoomModel?.userContactInfo?.email ?? 'email'),
              trailing: Text(
                  controller.infoRoomModel?.userContactInfo?.phone ?? 'ph'),
            ),
          ],
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: Text(
            "about".tr,
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0, bottom: 50.0),
          child: Text(
            controller.infoRoomModel!.room!.desc.toString(),
            style: TextStyle(
                fontFamily: "Sofia",
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}

class IconsAllWidget extends StatelessWidget {
  const IconsAllWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final GetInfoRoomController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Container(
        height: 105.0,
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            children: <Widget>[
              if (controller.infoRoomModel!.room!.features!
                  .contains('Free Wifi'))
                Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: _infoCircle(
                          "assets/image/icon/wifi.png", "Free Wifi"),
                    )),
              if (controller.infoRoomModel!.room!.features!.contains('Buffet'))
                Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: _infoCircle("assets/image/icon/food.png", "Buffet")),
              if (controller.infoRoomModel!.room!.features!
                  .contains('Room Service'))
                Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: _infoCircle(
                        "assets/image/icon/clean.png", "Room Service")),
              if (controller.infoRoomModel!.room!.features!
                  .contains('Smart System'))
                Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: _infoCircle(
                        "assets/image/icon/monitor.png", "Smart System")),
              if (controller.infoRoomModel!.room!.features!.contains('Pool'))
                Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child:
                    _infoCircle("assets/image/icon/swimming.png", "Pool")),
            ],
          ),
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final GetInfoRoomController controller;
  MySliverAppBar({
    required this.expandedHeight,
    required this.controller,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool isDis = controller.infoRoomModel?.room?.discount != null &&
        controller.infoRoomModel?.room?.discount != 0
        ? true
        : false;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: Colors.white,
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Hero(
            tag: controller.infoRoomModel!.room!.sId.toString(),
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '${MangeAPi.baseurl}/${controller.infoRoomModel!.room!.imgs!.split(',').first.toString()}',
                  ),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 130.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    colors: <Color>[
                      Color(0x00FFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Text(
                        controller.infoRoomModel!.room!.title.toString(),
                        style: TextStyle(
                            color: Colors.black87.withOpacity(0.65),
                            fontSize: 30.5,
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w700),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.location_on,
                          size: 14.0,
                          color: Colors.black26,
                        ),
                        Text(
                          controller.infoRoomModel!.room!.city.toString(),
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 14.5,
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Container(
                      child: isDis
                          ? Row(
                        children: [
                          Text(
                            controller.infoRoomModel!.room!.price!
                                .toString(),
                            style: TextStyle(
                              color: Color(0xFF8F73F2),
                              fontSize: 20.5,
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.lineThrough,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            ((controller.infoRoomModel!.room!.price! -
                                ((controller.infoRoomModel!.room!
                                    .discount! /
                                    100) *
                                    controller.infoRoomModel!.room!
                                        .price!)))
                                .toDouble()
                                .toString(),
                            style: const TextStyle(
                              color: Color(0xFF8F73F2),
                              fontSize: 25.5,
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                          : Text(
                        controller.infoRoomModel!.room!.price!.toString(),
                        style: const TextStyle(
                          color: Color(0xFF8F73F2),
                          fontSize: 25.5,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Get.delete<GetInfoRoomController>();
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Container(
                    height: 35.0,
                    width: 35.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                      color: Colors.white70,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 36.0,
            )
          ],
        ),
        if (isDis)
          Positioned(
            right: 30,
            top: -50,
            child: Transform.rotate(
              angle: -35 * (3.14 / 180),
              child: Container(
                alignment: Alignment.center,
                width: 35,
                height: 230,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.teal, Colors.blue],
                  ),

                  //  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Transform.rotate(
                  angle: 80 * (3.14 / 180),
                  child: Row(
                    children: [
                      Text(
                        controller.infoRoomModel!.room!.discount.toString(),
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '%',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

Widget _photo(String image) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 110.0,
          width: 140.0,
          decoration: BoxDecoration(
              image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              color: Colors.black12,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 2.0)
              ]),
        ),
        const SizedBox(
          height: 5.0,
        ),
      ],
    ),
  );
}

Widget _relatedPost(
    String? image, String? title, String? location, String? ratting, price) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 110.0,
          width: 180.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image == null || image == ""
                    ? 'https://akm-img-a-in.tosshub.com/businesstoday/images/story/202204/ezgif-sixteen_nine_161.jpg?size=948:533'
                    : "${MangeAPi.baseurl}/${image.split(',').first}"),
                fit: BoxFit.cover,
              ),
              color: Colors.black12,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 2.0)
              ]),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          title ?? 'titel',
          style: const TextStyle(
              fontFamily: "Sofia",
              fontWeight: FontWeight.w600,
              fontSize: 17.0,
              color: Colors.black87),
        ),
        const SizedBox(
          height: 2.0,
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 0.0),
              child: Text(
                '${price!.toString()}',
                style: const TextStyle(
                    color: Colors.black54,
                    fontFamily: "Gotik",
                    fontWeight: FontWeight.w800,
                    fontSize: 14.0),
              ),
            ),
            const Text(
              "/night",
              style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "Gotik",
                  fontWeight: FontWeight.w400,
                  fontSize: 10.0),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(
              Icons.location_on,
              size: 18.0,
              color: Colors.black12,
            ),
            Text(
              location ?? 'Loction',
              style: const TextStyle(
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: Colors.black26),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            ratingbar(
              starRating: double.parse(ratting!),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                ratting.toString(),
                style: const TextStyle(
                    fontFamily: "Sans",
                    color: Colors.black26,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0),
              ),
            )
          ],
        ),
      ],
    ),
  );
}

Widget _infoCircle(String image, title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
          alignment: Alignment.center,
          height: 45.0,
          width: 45.0,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              color: Color(0xFFF0E5FB)),
          child: Center(
            child: Image.asset(
              image,
              height: 22.0,
              color: Colors.deepPurple,
            ),
          )),
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  fontSize: 11.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
    ],
  );
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}

Widget _buildRating(String date, String details, double rating, String image) {
  return ListTile(
    leading: Container(
      height: 45.0,
      width: 45.0,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(50.0))),
    ),
    title: Row(
      children: <Widget>[
        StarRating(
          size: 20.0,
          rating: rating,
          starCount: 5,
          color: Colors.yellow,
          onRatingChanged: (rating) {},
          borderColor: Colors.yellow,
        ),
        const SizedBox(width: 8.0),
        Text(
          date,
          style: const TextStyle(fontSize: 12.0),
        )
      ],
    ),
    subtitle: Text(
      details,
      style: const TextStyle(fontFamily: "Sofia", fontWeight: FontWeight.w300),
    ),
  );
}
