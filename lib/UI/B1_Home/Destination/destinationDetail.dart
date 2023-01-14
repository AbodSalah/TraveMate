import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/DataSample/travelModelData.dart';
import 'package:hotelbooking/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/controller/get_from_data_City_controller.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/get_data_from_city.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

import '../../../Library/Carousel/CarouselPro.dart';

class destination extends StatefulWidget {
  final String? name;
  final String? desc;
  destination({
    Key? key,
    this.name,
    this.desc,
  }) : super(key: key);

  @override
  _destinationState createState() => _destinationState();
}

class _destinationState extends State<destination> {
  @override
  Widget build(BuildContext context) {
    var onClickMenuIcon = () {
      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new Home(),
          transitionDuration: const Duration(milliseconds: 750),

          /// Set animation with opacity
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          }));
    };

    var _appBar = PreferredSize(
      preferredSize: const Size.fromHeight(45.0),
      child: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.name!, style: const TextStyle(fontFamily: "Sofia")),
      ),
    );

    var _description = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Text(
            widget.name!,
            style: const TextStyle(
                fontFamily: "Sofia",
                fontWeight: FontWeight.w700,
                fontSize: 20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0, bottom: 30.0),
          child: Container(
              width: MediaQuery.of(context).size.width - 10.0,
              child: Text(
                "${widget.desc}",
                style: const TextStyle(
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w300,
                    fontSize: 14.5,
                    color: Colors.black45),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.start,
              )),
        ),
      ],
    );

    return Scaffold(
      appBar: _appBar,
      backgroundColor: Colors.white,
      body: GetBuilder<GetDataCityController>(
        init: GetDataCityController(),
        builder: (controller) {
          List<String> phot =
              controller.infocityModel?.city?.imgs!.split(',') ?? [''];

          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ///Slider image in top
                  Container(
                    height: 222.0,
                    child: new Carousel(
                      boxFit: BoxFit.cover,
                      dotColor: Colors.white.withOpacity(0.8),
                      dotSize: 5.5,
                      dotSpacing: 16.0,
                      dotBgColor: Colors.transparent,
                      showIndicator: true,
                      overlayShadow: true,
                      overlayShadowColors: Colors.white.withOpacity(0.1),
                      overlayShadowSize: 0.9,
                      images: List.generate(
                        phot.length,
                            (index) => Image.network(
                          "${MangeAPi.baseurl}/${phot[index]}",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      onImageChange: (int, s) {},
                      onImageTap: (int) {},
                      radius: const Radius.circular(1.0),
                    ),
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),

                  /// Description
                  _description,

                  /// Category
                  FutureWidget(
                    catogery:
                    controller.infocityModel?.city!.categories ?? ['تراث'],
                  ),
                  if (controller.infocityModel?.topDestination!.length != 0)
                    TopDestinationWidget(controller: controller),

                  if (controller.infocityModel?.places!.length != 0)
                    RecomendedWidget(controller: controller),
                  SizedBox(
                    height: 10,
                  ),
                  if (controller.infocityModel?.hotels!.length != 0)
                    RecomendedHotelsWidget(controller: controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecomendedHotelsWidget extends StatelessWidget {
  const RecomendedHotelsWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final GetDataCityController controller;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 22.0,right: 20.0),
            child: Text(
              "recommended_places".tr,
              style: TextStyle(
                  fontFamily: "Sofia",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: controller.infocityModel?.hotels!.length,
                itemBuilder: (ctx, index) {
                  return cardListHotel(
                      controller.infocityModel!.hotels![index]);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

class RecomendedWidget extends StatelessWidget {
  const RecomendedWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final GetDataCityController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         Padding(
          padding: EdgeInsets.only(left: 22.0,right: 20),
          child: Text(
            "recommended_rooms".tr,
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Container(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: controller.infocityModel?.places!.length,
              itemBuilder: (ctx, index) {
                return cardList(controller.infocityModel!.places![index]);
              },
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}

class TopDestinationWidget extends StatelessWidget {
  const TopDestinationWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final GetDataCityController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 30.0,right: 20.0),
          child: Text(
            "top_destination".tr,
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          height: 330.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: controller.infocityModel?.topDestination!.length,
            itemBuilder: (BuildContext context, int index) {
              return TopDestinationCard(
                topDestination:
                controller.infocityModel!.topDestination![index],
              );
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
      ],
    );
  }
}

class FutureWidget extends StatelessWidget {
  const FutureWidget({
    Key? key,
    required this.catogery,
  }) : super(key: key);
  final List<String> catogery;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child:  Padding(
            padding: EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
            child: Text(
              "fea".tr,
              style: TextStyle(
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: [
            for (int var_name = 0; var_name < catogery.length; var_name++)
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 170,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  catogery[var_name],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
          ],
        ),
        Container(
          height: 30.0,
          width: double.infinity,
          color: Colors.black12.withOpacity(0.03),
        ),
      ],
    );
  }
}

class cardListHotel extends StatelessWidget {
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

  Hotels hotelData;

  cardListHotel(this.hotelData);
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(hotelData.sId);
        sharedPreferences.setString('keyhot', hotelData.sId.toString());
        Get.to(hotelDetail2());
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
                              hotelData.name ?? ' Hotel name',
                              style: _txtStyleTitle,
                              overflow: TextOverflow.ellipsis,
                            )),
                        const Padding(padding: EdgeInsets.only(top: 5.0)),
                        Row(
                          children: <Widget>[
                            ratingbar(
                              starRating:
                              double.parse(hotelData.rating.toString()),
                              color: Colors.blueAccent,
                            ),
                            const Padding(padding: EdgeInsets.only(left: 5.0)),
                            Text(
                              "(" + hotelData.rating.toString() + ")",
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
                ],
              ),
            )
          ]),
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

  Places hotelData;

  cardList(this.hotelData);
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        sharedPreferences.setString('keyroom', hotelData.sId.toString());
        Get.to(HotelDetail());
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

class TopDestinationCard extends StatelessWidget {
  const TopDestinationCard({super.key, required this.topDestination});
  final TopDestination topDestination;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 220.0,
            width: 160.0,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 2.0)
              ],
              image: DecorationImage(
                  image: NetworkImage(
                      '${MangeAPi.baseurl}/${topDestination.imgs!.split(',').first}'),
                  fit: BoxFit.cover),
            ),
          ),

          // Image.network(
          //   '${MangeAPi.baseurl}/${topDestination.imgs}',
          //   fit: BoxFit.cover,
          //   errorBuilder: (context, error, stackTrace) {
          //     return Text('data');
          //   },
          // ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            topDestination.name.toString(),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.location_on,
                size: 18.0,
                color: Colors.black12,
              ),
              Text(
                topDestination.city.toString(),
                style: const TextStyle(
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.black26),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class cardCountry extends StatelessWidget {
  Color? colorTop, colorBottom;
  String? image, title;
  cardCountry({this.colorTop, this.colorBottom, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 105.0,
            width: 105.0,
            decoration: BoxDecoration(
              boxShadow: [
                const BoxShadow(blurRadius: 8.0, color: Colors.black12)
              ],
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              gradient: LinearGradient(
                  colors: [colorTop!, colorBottom!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    image!,
                    height: 60,
                    color: Colors.white,
                  )),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              title!,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Sofia",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}

/// Component item Menu icon bellow a Description
class CategoryIconValue extends StatelessWidget {
  String? icon1, icon2, icon3, icon4, title1, title2, title3, title4;
  GestureTapCallback? tap1, tap2, tap3, tap4;

  CategoryIconValue(
      {this.icon1,
        this.tap1,
        this.icon2,
        this.tap2,
        this.icon3,
        this.tap3,
        this.icon4,
        this.tap4,
        this.title1,
        this.title2,
        this.title3,
        this.title4});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: tap1,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon1!,
                height: 30.2,
                fit: BoxFit.cover,
              ),
              const Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                title1!,
                style: const TextStyle(
                  fontFamily: "Sans",
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap2,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon2!,
                height: 32.2,
              ),
              const Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                title2!,
                style: const TextStyle(
                  fontFamily: "Sans",
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap3,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon3!,
                height: 32.2,
              ),
              const Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                title3!,
                style: const TextStyle(
                  fontFamily: "Sans",
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap4,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon4!,
                height: 32.2,
              ),
              const Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                title4!,
                style: const TextStyle(
                  fontFamily: "Sans",
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
