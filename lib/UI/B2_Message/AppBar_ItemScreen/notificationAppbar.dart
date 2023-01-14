import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/Library/Ratting_Bar/Ratting_bar.dart';
import 'package:hotelbooking/Library/Ratting_Bar/Ratting_bar_widget.dart';
import 'package:hotelbooking/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:hotelbooking/UI/B2_Message/AppBar_ItemScreen/Notfy_controller.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/components/custombutten.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

class notificationAppbar extends StatefulWidget {
  notificationAppbar({Key? key}) : super(key: key);

  @override
  _notificationAppbarState createState() => _notificationAppbarState();
}

class _notificationAppbarState extends State<notificationAppbar> {
  bool x = false;

  @override
  Widget build(BuildContext context) {
    final NotfyController controller = Get.put(NotfyController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text(
          "notification".tr,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22.0,
              letterSpacing: 2.0,
              color: Colors.black54,
              fontFamily: "Berlin"),
        ),
        iconTheme: const IconThemeData(
          color: Colors.deepPurpleAccent,
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: controller.notfyModel?.message!.length != 0
          ? GetBuilder<NotfyController>(
        init: NotfyController(),
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest7,
            widget: Padding(
              padding: const EdgeInsets.only(top: 95.0),
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) => cardList(
                      controller.notfyModel!.message![index],
                    ),
                    itemCount: controller.notfyModel?.message!.length,
                  ),
                ),
              ),
            ),
          );
        },
      )
          : Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 120.0)),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Image.asset(
                "assets/image/illustration/message.png",
                height: 250.0,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20.0)),
            Text(
              "noo".tr,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 21.5,
                  color: Colors.black54,
                  fontFamily: "Sofia"),
            ),
          ],
        ),
      ),
    );
  }
}

class cardList extends StatelessWidget {
  @override
  var _txtStyleTitle = const TextStyle(
    color: Colors.black87,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  var _txtStyleSub = const TextStyle(
    color: Colors.black26,
    fontFamily: "Gotik",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  MessageNotfyModel hotelData;

  cardList(this.hotelData);
  Widget build(BuildContext context) {
    final NotfyController controller = Get.put(NotfyController());
    return InkWell(
      onTap: () {
        String sea = '';
        double rat = 3.0;
        Get.bottomSheet(
          Container(
              height: 400,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ما رايك في هذ الفندق',
                    style: TextStyle(fontSize: 21),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RatingBar.builder(
                    initialRating: rat,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      rat = rating;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: 400,
                      child: TextField(
                        onChanged: (value) {
                          sea = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'اخبرنا برايك في هذا المنزل'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    width: 400,
                    haigh: 60,
                    color: Colors.teal,
                    text: 'apply Rating',
                    press: () {
                      controller.addFeedback(
                          hotelData.sId.toString(), context, rat.toInt(), sea);
                    },
                  ),
                ],
              )),
          enableDrag: false,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
        child: Container(
          height: 250.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 3.0,
                    spreadRadius: 1.0)
              ]),
          child: Column(children: [
            Container(
              height: 165.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                image: DecorationImage(
                    image: NetworkImage(
                      hotelData.imgs == null || hotelData.imgs == ""
                          ? 'https://akm-img-a-in.tosshub.com/businesstoday/images/story/202204/ezgif-sixteen_nine_161.jpg?size=948:533'
                          : "${MangeAPi.baseurl}/${hotelData.imgs!.split(',').first}",
                    ),
                    fit: BoxFit.cover),
              ),
              alignment: Alignment.topRight,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 220.0,
                            child: Text(
                              hotelData.title ?? ' Hotel name',
                              style: _txtStyleTitle,
                              overflow: TextOverflow.ellipsis,
                            )),
                        const Padding(padding: EdgeInsets.only(top: 5.0)),
                        Row(
                          children: <Widget>[
                            ratingbar(
                              starRating: double.parse(
                                  hotelData.averageRating.toString()),
                              color: Colors.blueAccent,
                            ),
                            const Padding(padding: EdgeInsets.only(left: 5.0)),
                            Text(
                              "(" + hotelData.averageRating.toString() + ")",
                              style: _txtStyleSub,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.9),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.location_on,
                                size: 16.0,
                                color: Colors.black26,
                              ),
                              const Padding(padding: EdgeInsets.only(top: 3.0)),
                              Text(hotelData.city ?? 'نابلس',
                                  style: _txtStyleSub)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "\$" + hotelData.price.toString(),
                          style: const TextStyle(
                              fontSize: 25.0,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Gotik"),
                        ),
                        Text("per night",
                            style: _txtStyleSub.copyWith(fontSize: 11.0))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
