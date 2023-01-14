import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/controller/search_controller.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/search_models.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Column(
              children: [
                if (controller.helpModel?.rooms!.length != 0)
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              top: 50.0,
                              right: 20.0,
                            ),
                            child: Text(
                              'Ro'.tr,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount:
                              controller.helpModel?.rooms?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return CardLastActivity(
                                  rommsdata:
                                  controller.helpModel?.rooms![index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (controller.helpModel?.hotels!.length != 0)
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              top: 40.0,
                              right: 20.0,
                            ),
                            child: Text(
                              'hotels'.tr,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Expanded(
                            child: CardGrid(searchModel: controller.helpModel),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (controller.helpModel?.hotels!.length == 0 &&
                    controller.helpModel?.rooms!.length == 0)
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: 350,
                      height: 450,
                      child: Lottie.asset(
                          'assets/images/106964-shake-a-empty-box.json'),
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

//---------------------------------------------------------------------
class CardLastActivity extends StatelessWidget {
  Rooms? rommsdata;

  CardLastActivity({this.rommsdata});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10.0, bottom: 8.0),
      child: InkWell(
        onTap: () {
          Get.delete<SearchController>();
          sharedPreferences.setString('keyroom', rommsdata!.sId.toString());
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => HotelDetail(),
              transitionDuration: const Duration(milliseconds: 600),
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              },
            ),
          );
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
          child: Wrap(
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
                          image: NetworkImage(rommsdata!.imgs == null ||
                              rommsdata!.imgs == ""
                              ? 'https://akm-img-a-in.tosshub.com/businesstoday/images/story/202204/ezgif-sixteen_nine_161.jpg?size=948:533'
                              : "${MangeAPi.baseurl}/${rommsdata!.imgs!.split(',').first}"),
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
                        rommsdata!.title!,
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
                          rommsdata!.price!.toString(),
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
                              starRating: double.parse(
                                  rommsdata!.averageRating!.toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                rommsdata!.averageRating.toString(),
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
//--------------------------------------------------------------------------------------------------

class CardGrid extends StatelessWidget {
  const CardGrid({Key? key, required this.searchModel}) : super(key: key);
  final SearchModel? searchModel;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
      childAspectRatio: mediaQueryData.size.height / 1100,
      crossAxisSpacing: 0.0,
      mainAxisSpacing: 0.0,
      primary: false,
      children: List.generate(
        searchModel?.hotels?.length ?? 0,
            (index) => itemGrid(searchModel?.hotels?[index]),
      ),
    );
  }
}

/// Component Card item in gridView after done loading image
class itemGrid extends StatelessWidget {
  Hotels? hotelData;
  itemGrid(this.hotelData);

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
                sharedPreferences.setString(
                    'keyhot', hotelData!.sId.toString());
                Get.to(hotelDetail2());
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
                      tag: "hero-flashsale-${hotelData?.sId ?? '1'}",
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
                                            "hero-flashsale-${hotelData?.sId ?? 1}",
                                            child: Image.network(
                                              hotelData?.imgs != null ||
                                                  hotelData?.imgs != ""
                                                  ? '${MangeAPi.baseurl}/${hotelData?.imgs!.split(',').first ?? 'https://media.timeout.com/images/105892648/750/422/image.jpg'}'
                                                  : 'https://media.timeout.com/images/105892648/750/422/image.jpg',
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
                              hotelData?.imgs != null || hotelData?.imgs != ""
                                  ? '${MangeAPi.baseurl}/${hotelData?.imgs!.split(',').first ?? 'https://media.timeout.com/images/105892648/750/422/image.jpg'}'
                                  : 'https://media.timeout.com/images/105892648/750/422/image.jpg',
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
                          hotelData?.name ?? 'name',
                          style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Sofia"),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Text("",
                          style: const TextStyle(
                              fontSize: 15.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Sans")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Row(
                        children: <Widget>[
                          ratingbar(
                            starRating:
                            double.parse(hotelData?.rating! ?? '5.0'),
                            color: Colors.deepPurpleAccent,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 5.0)),
                          Text(
                            "(" + hotelData!.rating.toString() + ")",
                            style: const TextStyle(
                              color: Colors.black26,
                              fontFamily: "Gotik",
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
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
                            hotelData?.city ?? 'city',
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
