// ignore_for_file: must_be_immutable

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/DataSample/HomeGridRooms.dart';
import 'package:hotelbooking/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/widget/RecomendedTrevatelWidget.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/widget/TopBokingWidget.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/widget/citesWidget.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/widget/topReatingWidget.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:hotelbooking/UI/B1_Home/House/HouseList.dart';
import 'package:hotelbooking/UI/B2_Message/AppBar_ItemScreen/notificationAppbar.dart';
import 'package:hotelbooking/UI/data_of_cato/data_of_cato.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/UI/pages/filter.dart';
import 'package:hotelbooking/controller/getInfoRoom_controller.dart';
import 'package:hotelbooking/controller/home_controller.dart';
import 'package:hotelbooking/langs/languge_varible.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/get_top_reating_model.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';
import 'Search.dart';
import 'editProfile.dart';

Stream<RemoteMessage> _stream = FirebaseMessaging.onMessageOpenedApp;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static final _txtStyle = const TextStyle(
      fontSize: 15.5,
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontFamily: 'Gotik');
  @override
  void initState() {
    _stream.listen((RemoteMessage event) async {
      if (event.data != null) {
        Get.to(notificationAppbar());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _stream.listen((RemoteMessage event) async {
      if (event.data != null) {
        Get.to(notificationAppbar());
      }
    });
    Get.put(HomeController());
    var _appBar = AppBar(
      backgroundColor: Colors.white,
      title: Text("Home".tr,
          style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: "Gotik",
              fontSize: 28.0,
              color: Colors.black)),
      centerTitle: false,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            onTap: () {
              Get.to(EditProfile());
            },
            child: Container(
              height: 45.0,
              width: 45.0,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/image/images/GirlProfile.png",
                    ),
                  )),
            ),
          ),
        )
      ],
      brightness: Brightness.light,
      elevation: 0.0,
    );

    var _searchBox = Padding(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () => Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new search(),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        )),
        child: Container(
          height: 43.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(9.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                spreadRadius: 1.0,
                blurRadius: 3.0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.search,
                  color: Colors.deepPurple,
                  size: 25.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("ser".tr,
                      style: TextStyle(
                          color: Colors.black26,
                          fontFamily: "Gotik",
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    ///  Grid item in bottom of Category

    return Scaffold(
      appBar: _appBar,
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: Get.width,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 12),
                      child: Row(
                        children: [
                          Expanded(child: _searchBox),
                          IconButton(
                            onPressed: () async {
                              Get.to(() => const Filter());
                            },
                            icon: Icon(
                              Icons.filter_alt,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    GetBuilder<HomeController>(
                      init: HomeController(),
                      initState: (_) {},
                      builder: (_) {
                        return HandlingDataView(
                          statusRequest: _.statusRequest5,
                          widget:
                          OffersHouseWidget(roomsWithOffers: _.roomoffers),
                        );
                      },
                    ),
                    GetBuilder<HomeController>(
                      builder: (controller) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.only(start: 12.0),
                              child: Text(
                                'destinations'.tr,
                                style: _txtStyle,
                              ),
                            ),
                            HandlingDataView(
                              statusRequest: controller.statusRequest4,
                              widget: Container(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller
                                      .getusercatogerys?.userCategories!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CUstomitemCard(
                                      image: controller.getusercatogerys
                                          ?.userCategories![index].imgs ??
                                          '',
                                      title: controller.getusercatogerys
                                          ?.userCategories![index].name ??
                                          'name',
                                      id: controller.getusercatogerys
                                          ?.userCategories![index].sId
                                          .toString() ??
                                          '123',
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    TopReatingWidget(txtStyle: _txtStyle),
                    const SizedBox(height: 8),
                    TopBokingWidget(txtStyle: _txtStyle),
                    RecomendedTrevatelWidget(txtStyle: _txtStyle),
                    CitesWidget(txtStyle: _txtStyle),
                    RecommendedAi(txtStyle: _txtStyle),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedAi extends StatelessWidget {
  const RecommendedAi({
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
          statusRequest: controller.statusRequest7,
          widget: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 40.0, right: 20.0),
                    child: Text("Recommended_Rooms".tr, style: _txtStyle),
                  ),

                  /// To set GridView item
                  GridView.count(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                    childAspectRatio: 0.795,
                    crossAxisCount: 2,
                    primary: false,
                    children: List.generate(
                      controller.getRecommendAi?.rooms?.length ?? 0,
                          (index) =>
                          ItemGrid(controller.getRecommendAi?.rooms![index]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class OffersHouseWidget extends StatelessWidget {
  const OffersHouseWidget({
    Key? key,
    this.roomsWithOffers,
  }) : super(key: key);
  final OffersHouseModels? roomsWithOffers;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 250.0,
      padding: const EdgeInsets.only(bottom: 20.0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 10.0, bottom: 3.0, right: 20.0),
            child: Text(
              LangVarible.offers.tr,
              style: const TextStyle(
                fontFamily: "Sofia",
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 15.0,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10.0, left: 12, right: 12),
              scrollDirection: Axis.horizontal,
              itemCount: roomsWithOffers?.roomsWithOffers?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: itemPopular(
                    roomsWithOffers: roomsWithOffers?.roomsWithOffers![index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class cardLastActivity extends StatelessWidget {
  TopRatingRooms? searchesModel;

  cardLastActivity({this.searchesModel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10.0, bottom: 8.0),
      child: InkWell(
        onTap: () {
          Get.delete<GetInfoRoomController>();
          sharedPreferences.setString('keyroom', searchesModel!.sId.toString());
          Get.to(HotelDetail());
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                )
              ]),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Material(
                    child: Container(
                      height: 100.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7.0),
                            topRight: Radius.circular(7.0)),
                        image: DecorationImage(
                          image: NetworkImage(searchesModel!.imgs == null ||
                              searchesModel!.imgs == ""
                              ? 'https://akm-img-a-in.tosshub.com/businesstoday/images/story/202204/ezgif-sixteen_nine_161.jpg?size=948:533'
                              : "${MangeAPi.baseurl}/${searchesModel!.imgs!.split(',').first}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      width: 110.0,
                      child: Text(
                        searchesModel!.title!,
                        style: const TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2.0)),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 0.0),
                        child: Text(
                          searchesModel!.price!.toString(),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 15.0, top: 3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ratingbar(
                              starRating:
                              double.parse(searchesModel!.averageRating!),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                searchesModel!.averageRating.toString(),
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
                  ),
                ],
              ),
              // Container(
              //   child: Text('data'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardType extends StatelessWidget {
  final String? txtTitle, txtHeader, txtDesc;
  final double? txtSize;
  final GestureTapCallback? navigatorOntap;
  String? img;
  CardType({
    Key? key,
    this.img,
    this.txtTitle,
    this.txtHeader,
    this.txtDesc,
    this.txtSize,
    this.navigatorOntap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 4.0, right: 12.0, top: 8.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: navigatorOntap,
            child: Container(
              width: 285.0,
              height: 135.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  onError: (exception, stackTrace) {
                    img =
                    'https://economictimes.indiatimes.com/thumb/msid-93232118,width-1254,height-836,resizemode-4,imgsize-28786/oriental-hotels-reports-standalone-q1-pat-at-rs-11-09-cr.jpg?from=mdr';
                  },
                  image: NetworkImage(
                    img!.split(',').first,
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.darken),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF656565).withOpacity(0.15),
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  txtTitle!,
                  style: TextStyle(
                      fontFamily: 'Amira',
                      color: Colors.white,
                      fontSize: txtSize,
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 2.0,
                        )
                      ]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10.0),
            child: Text(
              txtHeader!,
              style: const TextStyle(
                fontFamily: "Sans",
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Colors.black54,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 5.0),
            child: Container(
                width: 270.0,
                child: Text(
                  txtDesc!,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                  style: const TextStyle(
                    fontFamily: "Sans",
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black26,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

/// ItemGrid in bottom item "Recomended" item
class ItemGrid extends StatelessWidget {
  /// Get data from HomeGridItem.....dart class
  Rooms? gridItem;
  ItemGrid(this.gridItem);

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.delete<GetInfoRoomController>();
          sharedPreferences.setString('keyroom', gridItem!.sId.toString());
          Get.to(HotelDetail());
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF656565).withOpacity(0.15),
                blurRadius: 4.0,
                spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
              ),
            ],
          ),
          child: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Material(
                    child: Container(
                      height: mediaQueryData.size.height / 5.8,
                      width: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7.0),
                            topRight: Radius.circular(7.0)),
                        image: DecorationImage(
                          image: NetworkImage(
                              '${MangeAPi.baseurl}/${gridItem!.imgs!.split(',').first}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 5.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Container(
                      width: 130.0,
                      child: Text(
                        gridItem?.title ?? 'tit',
                        style: const TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2.0)),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 0.0),
                        child: Text(
                          gridItem?.price.toString() ?? 'price',
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 15.0, top: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ratingbar(
                              starRating:
                              gridItem?.averageRating!.toDouble() ?? 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                gridItem?.averageRating?.toString() ?? '5.0',
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CUstomitemCard extends StatefulWidget {
  final String image, title, id;

  CUstomitemCard({
    required this.image,
    required this.title,
    required this.id,
  });

  @override
  State<CUstomitemCard> createState() => _CUstomitemCardState();
}

class _CUstomitemCardState extends State<CUstomitemCard> {
  bool isSlected = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        sharedPreferences.setString('dataofcato', widget.title.toString());
        Get.to(DataOfCato());
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 5.0, bottom: 10.0),
        child: Container(
          height: 85.0,
          width: 165.0,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Material(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                image: DecorationImage(
                  image: NetworkImage(
                      '${MangeAPi.baseurl}/${widget.image.split(',').first}'),
                  fit: BoxFit.cover,
                  opacity: isSlected ? 1 : 0.7,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFABABAB).withOpacity(0.2),
                    blurRadius: 4.0,
                    spreadRadius: 3.0,
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.black12.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    isSlected ? widget.title : 'Slected',
                    style: TextStyle(
                      shadows: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 10.0,
                            spreadRadius: 2.0)
                      ],
                      color: Colors.white,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w800,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
