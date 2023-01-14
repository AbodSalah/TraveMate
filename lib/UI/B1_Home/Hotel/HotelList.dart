import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/DataSample/HotelListData.dart';
import 'package:hotelbooking/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/controller/getInfoRoom_controller.dart';
import 'package:hotelbooking/controller/hotel_bt_type_controller.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/models_type.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';
import 'package:shimmer/shimmer.dart';

class HotelList extends StatefulWidget {
  final String name;
  const HotelList({Key? key, required this.name}) : super(key: key);

  @override
  State<HotelList> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  @override
  static hotelListData? hotelData;
  bool loadImage = true;
  bool colorIconCard = false;
  bool chosseCard = false;
  bool colorIconCard2 = true;

  var loadImageAnimation = Container(
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: (ctx, index) => cardLoading(hotelDataDummy[index]),
        itemCount: hotelDataDummy.length,
      ));

  var imageNetwork = const NetworkImage(
      "https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg?raw=true");

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          loadImage = false;
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HotelBytypeController>(
        init: HotelBytypeController(),
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Stack(
              children: <Widget>[
                chosseCard
                    ? Padding(
                        padding: const EdgeInsets.only(top: 95.0),
                        child: Container(
                          color: Colors.white,
                          child: cardGrid(
                            message: controller.helpModel1?.message!,
                            typ: widget.name,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 95.0),
                        child: Container(
                          color: Colors.white,
                          child: Container(
                            color: Colors.white,
                            child: ListView.builder(
                              itemBuilder: (ctx, index) => cardList(
                                controller.helpModel1?.message![index],
                                controller,
                                widget.name,
                              ),
                              itemCount: controller.helpModel1?.message!.length,
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    color: Colors.white,
                    height: 130.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 35.0, left: 15.0),
                            child: Icon(
                              Icons.clear,
                              size: 30.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 13.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "${widget.name}",
                                style: const TextStyle(
                                    fontFamily: "Sofia",
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w800),
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (colorIconCard == true) {
                                            colorIconCard = false;
                                            colorIconCard2 = true;
                                            chosseCard = false;
                                          } else {
                                            colorIconCard = true;
                                            colorIconCard2 = false;
                                            chosseCard = true;
                                          }
                                        });
                                      },
                                      child: Icon(
                                        Icons.calendar_view_day,
                                        color: colorIconCard
                                            ? Colors.black12
                                            : Colors.deepPurpleAccent,
                                      )),
                                  const SizedBox(
                                    width: 14.0,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (colorIconCard2 == true) {
                                            colorIconCard2 = false;
                                            colorIconCard = true;
                                            chosseCard = true;
                                          } else {
                                            colorIconCard2 = true;
                                            colorIconCard = false;
                                            chosseCard = false;
                                          }
                                        });
                                      },
                                      child: Icon(
                                        Icons.dashboard,
                                        color: colorIconCard2
                                            ? Colors.black12
                                            : Colors.deepPurpleAccent,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class cardGrid extends StatelessWidget {
  const cardGrid({Key? key, this.message, required this.typ}) : super(key: key);
  final List<MessageTowHouse>? message;
  final String typ;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 5.0, bottom: 0.0),
      childAspectRatio: mediaQueryData.size.height / 1300,
      crossAxisSpacing: 0.0,
      mainAxisSpacing: 0.0,
      primary: false,
      children: List.generate(
        /// Get data in flashSaleItem.dart (ListItem folder)
        message?.length ?? 0,
        (index) => itemGrid(message![index], typ),
      ),
    );
  }
}

/// Component Card item in gridView after done loading image
class itemGrid extends StatelessWidget {
  final MessageTowHouse? hotelData;
  final String typ;
  itemGrid(this.hotelData, this.typ);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                if (typ == 'فندق') {
                  print(hotelData!.sId);
                  sharedPreferences.setString(
                      'keyhot', hotelData!.sId.toString());
                  Get.to(hotelDetail2());
                } else {
                  Get.delete<GetInfoRoomController>();
                  sharedPreferences.setString(
                      'keyroom', hotelData!.sId.toString());
                  Get.to(HotelDetail());
                }
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      spreadRadius: 0.2,
                      blurRadius: 0.5)
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: "hero-flashsale-${hotelData?.sId}",
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
                                            tag:
                                                "hero-flashsale-${hotelData?.sId}",
                                            child: Image.network(
                                              hotelData?.imgs == null ||
                                                      hotelData?.imgs == "" ||
                                                      hotelData?.imgs == 'null'
                                                  ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5dEwOb8aCwl457d-k9xo2cwlAbz2zwH8tXA&usqp=CAU'
                                                  : '${MangeAPi.baseurl}/${hotelData?.imgs!.split(',').first}',
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
                              hotelData?.imgs == null ||
                                      hotelData?.imgs == "" ||
                                      hotelData?.imgs == 'null'
                                  ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5dEwOb8aCwl457d-k9xo2cwlAbz2zwH8tXA&usqp=CAU'
                                  : '${MangeAPi.baseurl}/${hotelData?.imgs!.split(',').first ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5dEwOb8aCwl457d-k9xo2cwlAbz2zwH8tXA&usqp=CAU'}',
                              fit: BoxFit.cover,
                              height: 140.0,
                              width: mediaQueryData.size.width / 2.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 3.0, top: 15.0),
                      child: Container(
                        width: mediaQueryData.size.width / 2.7,
                        child: Text(
                          hotelData?.title ?? 'titel',
                          style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Sofia"),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    typ == 'فندق'
                        ? SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 5.0),
                                child: Text("\$ ${hotelData?.price ?? '0'}",
                                    style: const TextStyle(
                                        fontSize: 15.5,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "Sans")),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              SizedBox(
                                child: GetBuilder<HotelBytypeController>(
                                  init: HotelBytypeController(),
                                  builder: (controller) {
                                    return HandlingDataView(
                                      statusRequest: controller.statusRequest1,
                                      widget: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, right: 10.0),
                                        child: CircleAvatar(
                                          radius: 20.0,
                                          backgroundColor: Colors.black12,
                                          child: IconButton(
                                            onPressed: () {
                                              controller.updateFavorit(
                                                hotelData?.sId.toString() ??
                                                    '638e12d4387bd697991743a6',
                                              );
                                            },
                                            icon: Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Row(
                        children: <Widget>[
                          ratingbar(
                            starRating: hotelData?.averageRating != null &&
                                    hotelData?.averageRating != "null"
                                ? double.parse('${hotelData?.averageRating}')
                                : double.parse('${hotelData?.Rating}'),
                            color: Colors.deepPurpleAccent,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 5.0)),
                          Text(
                            hotelData?.averageRating != null &&
                                    hotelData?.averageRating != "null"
                                ? '(${hotelData?.averageRating})'
                                : '(${hotelData?.Rating})',
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 5.0, bottom: 15.0),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.location_on,
                            size: 11.0,
                            color: Colors.black38,
                          ),
                          Text(
                            hotelData?.city ?? 'sdfdsfdsfsdf',
                            style: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Sans",
                                color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class cardList extends StatefulWidget {
  final HotelBytypeController controller;
  final MessageTowHouse? hotelData;
  final String typ;
  cardList(this.hotelData, this.controller, this.typ);

  @override
  State<cardList> createState() => _cardListState();
}

class _cardListState extends State<cardList> {
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
  bool isfav = false;
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.typ == 'فندق') {
          print(widget.hotelData!.sId);
          sharedPreferences.setString(
              'keyhot', widget.hotelData!.sId.toString());
          Get.to(hotelDetail2());
        } else {
          Get.delete<GetInfoRoomController>();
          sharedPreferences.setString(
              'keyroom', widget.hotelData!.sId.toString());
          Get.to(HotelDetail());
        }
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
                image: widget.hotelData?.imgs == null ||
                        widget.hotelData?.imgs == "" ||
                        widget.hotelData?.imgs == 'null'
                    ? DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5dEwOb8aCwl457d-k9xo2cwlAbz2zwH8tXA&usqp=CAU'))
                    : DecorationImage(
                        image: NetworkImage(
                          '${MangeAPi.baseurl}/${widget.hotelData?.imgs!.split(',').first ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5dEwOb8aCwl457d-k9xo2cwlAbz2zwH8tXA&usqp=CAU'}',
                        ),
                        fit: BoxFit.cover),
              ),
              child: GetBuilder<HotelBytypeController>(
                builder: (controller) {
                  return HandlingDataView(
                    statusRequest: controller.statusRequest1,
                    widget: Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                      child: widget.typ == 'فندق'
                          ? SizedBox()
                          : CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.black12,
                              child: IconButton(
                                onPressed: () async {
                                  await controller.updateFavorit(
                                    widget.hotelData?.sId.toString() ??
                                        '638e12d4387bd697991743a6',
                                  );
                                  isfav = !isfav;
                                  controller.upda();
                                },
                                icon: Icon(
                                  isfav
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: isfav ? Colors.red : Colors.white,
                                ),
                              ),
                            ),
                    ),
                  );
                },
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
                              widget.hotelData?.title ?? 'titel',
                              style: _txtStyleTitle,
                              overflow: TextOverflow.ellipsis,
                            )),
                        const Padding(padding: EdgeInsets.only(top: 5.0)),
                        Row(
                          children: <Widget>[
                            ratingbar(
                              starRating: widget.hotelData?.averageRating !=
                                          null &&
                                      widget.hotelData?.averageRating != "null"
                                  ? double.parse(
                                      '${widget.hotelData?.averageRating}')
                                  : double.parse('${widget.hotelData?.Rating}'),
                              color: Colors.deepPurpleAccent,
                            ),
                            const Padding(padding: EdgeInsets.only(left: 5.0)),
                            Text(
                              widget.hotelData?.averageRating != null &&
                                      widget.hotelData?.averageRating != "null"
                                  ? '(${widget.hotelData?.averageRating})'
                                  : '(${widget.hotelData?.Rating})',
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
                              Text(widget.hotelData?.city ?? '',
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
                          widget.hotelData?.price == null ||
                                  widget.hotelData?.price == "null"
                              ? ''
                              : '\$${widget.hotelData?.price ?? ''}',
                          style: const TextStyle(
                              fontSize: 25.0,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Gotik"),
                        ),
                        Text(
                            widget.hotelData?.price == null ||
                                    widget.hotelData?.price == "null"
                                ? ''
                                : "per night",
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

class cardLoading extends StatelessWidget {
  @override
  hotelListData data;
  cardLoading(this.data);
  final color = Colors.black38;
  Widget build(BuildContext context) {
    return Padding(
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
        child: Shimmer.fromColors(
          baseColor: color,
          highlightColor: Colors.white,
          child: Column(children: [
            Container(
              height: 165.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 10.0, right: 10.0),
                child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.black12,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    )),
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
                          height: 25.0,
                          color: Colors.black12,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 5.0)),
                        Container(
                          height: 15.0,
                          width: 100.0,
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.9),
                          child: Container(
                            height: 12.0,
                            width: 140.0,
                            color: Colors.black12,
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
                        Container(
                          height: 35.0,
                          width: 55.0,
                          color: Colors.black12,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8.0)),
                        Container(
                          height: 10.0,
                          width: 55.0,
                          color: Colors.black12,
                        ),
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
