import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/get_top_reating_model.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hotelbooking/DataSample/HotelListData.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/Search.dart';

class houseList extends StatefulWidget {
  String? nameAppbar;
  houseList({Key? key, this.nameAppbar}) : super(key: key);
  @override
  _houseListState createState() => _houseListState();
}

/// Component widget houseList
class _houseListState extends State<houseList> {
  ///
  /// Get image data dummy from firebase server
  ///
  var imageNetwork = const NetworkImage(
      "https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/a.jpg?alt=media&token=e36bbee2-4bfb-4a94-bd53-4055d29358e2");

  ///
  /// check the condition is right or wrong for image loaded or no
  ///
  bool loadImage = true;

  /// Custom text
  static var _customTextStyleBlack = const TextStyle(
      fontFamily: "Sofia",
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 15.0);

  /// Custom Text Blue Color
  static var _customTextStyleBlue = const TextStyle(
      fontFamily: "Sofia",
      color: Colors.black45,
      fontWeight: FontWeight.w700,
      fontSize: 15.0);

  ///
  /// SetState after imageNetwork loaded to change list card
  ///
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      setState(() {
        loadImage = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// SubCategory item
    var _subCategory = Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Category",
                  style: _customTextStyleBlack,
                ),
                InkWell(
                  onTap: null,
                  child: Text("See More", style: _customTextStyleBlue),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 15.0),
              height: 110.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  /// Get keyword item class in Search.dart
                  const Padding(padding: EdgeInsets.only(left: 20.0)),
                  KeywordItem(
                    title: "Modern",
                    title2: "Traditional",
                  ),
                  const Padding(padding: EdgeInsets.only(left: 15.0)),
                  KeywordItem(
                    title: "Minimalist",
                    title2: "Industrial",
                  ),
                  const Padding(padding: EdgeInsets.only(left: 15.0)),
                  KeywordItem(
                    title: "Rusitic",
                    title2: "Scandivian",
                  ),
                  const Padding(padding: EdgeInsets.only(left: 15.0)),
                  KeywordItem(
                    title: "Contempor",
                    title2: "Boheiman",
                  ),
                  const Padding(padding: EdgeInsets.only(right: 20.0)),
                ],
              ),
            ),
          )
        ],
      ),
    );

    /// Item Discount
    var _itemDiscount = Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Recommended For You",
                  style: _customTextStyleBlack,
                ),
                InkWell(
                  onTap: () {},
                  child: Text("See More ", style: _customTextStyleBlue),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: 300.0,

              ///
              ///
              /// check the condition if image data from server firebase loaded or no
              /// if image true (image still downloading from server)
              /// Card to set card loading animation
              ///
              ///
              child: loadImage
                  ? _loadingImageAnimation(context)
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) =>
                          menuItemCard(hotelDataDummy[index]),
                      itemCount: hotelDataDummy.length,
                    ),
            ),
          )
        ],
      ),
    );

    /// Item Popular
    var _itemPopular = Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "House Popular",
                    style: _customTextStyleBlack,
                  ),
                  InkWell(
                    onTap: null,
                    child: Text("See More", style: _customTextStyleBlue),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 300.0,
                child: loadImage
                    ? _loadingImageAnimation(context)
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) =>
                            menuItemCard(hotelDataDummy[index]),
                        itemCount: hotelDataDummy.length,
                      ),
              ),
            )
          ],
        ),
      ),
    );

    /// Item New
    var _itemNew = Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "New House",
                    style: _customTextStyleBlack,
                  ),
                  InkWell(
                    onTap: null,
                    child: Text("See More", style: _customTextStyleBlue),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(bottom: 15.0),
                height: 300.0,

                ///
                ///
                /// check the condition if image data from server firebase loaded or no
                /// if image true (image still downloading from server)
                /// Card to set card loading animation
                ///
                ///
                child: loadImage
                    ? _loadingImageAnimation(context)
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) =>
                            menuItemCard(hotelDataDummy[index]),
                        itemCount: hotelDataDummy.length,
                      ),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  PageRouteBuilder(pageBuilder: (_, __, ___) => new search()));
            },
            child: IconButton(
              onPressed: null,
              icon: Icon(Icons.search,
                  color: Colors.deepPurpleAccent.withOpacity(0.9)),
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          widget.nameAppbar!,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              /// Get a variable

              _subCategory,
              _itemDiscount,
              _itemPopular,
              _itemNew
            ],
          ),
        ),
      ),
    );
  }
}

///Item Popular component class
class itemPopular extends StatelessWidget {
  RoomsWithOffers? roomsWithOffers;

  itemPopular({this.roomsWithOffers});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        sharedPreferences.setString('keyroom', roomsWithOffers!.sId.toString());
        Get.to(HotelDetail());
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                child: Container(
                  height: 100.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(7.0),
                        topRight: Radius.circular(7.0)),
                    image: DecorationImage(
                      image: NetworkImage(roomsWithOffers!.imgs == null ||
                              roomsWithOffers!.imgs == ""
                          ? 'https://akm-img-a-in.tosshub.com/businesstoday/images/story/202204/ezgif-sixteen_nine_161.jpg?size=948:533'
                          : "${MangeAPi.baseurl}/${roomsWithOffers!.imgs!.split(',').first}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  width: 110.0,
                  child: Text(
                    roomsWithOffers?.title ?? 'titel',
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
                      roomsWithOffers?.price.toString() ?? '0.0',
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
                padding:
                    const EdgeInsets.only(left: 10.0, right: 15.0, top: 3.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ratingbar(
                          starRating: double.parse(
                              roomsWithOffers?.averageRating.toString() ?? '2'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            roomsWithOffers?.averageRating.toString() ?? '0',
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
          Positioned(
            right: 10,
            top: -40,
            child: Transform.rotate(
              angle: -35 * (3.14 / 180),
              child: Container(
                alignment: Alignment.center,
                width: 30,
                height: 180,
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
                        roomsWithOffers?.discount.toString() ?? '0',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '%',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Container(
//       alignment: Alignment.topRight,
//       width: 130.0,
// decoration: BoxDecoration(
//   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//   image: DecorationImage(
//       image:
//           NetworkImage('${MangeAPi.baseurl}/${image!.split(',').first}'),
//       fit: BoxFit.cover),
// ),
//       child: Transform.rotate(
//         angle: -35 * (3.14 / 180),
//         child: Container(
//           alignment: Alignment.center,
//           width: 35,
//           height: 150,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: <Color>[Colors.teal, Colors.blue],
//             ),

//             //  color: Colors.amber,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Transform.rotate(
//             angle: 80 * (3.14 / 180),
//             child: Row(
//               children: [
//                 Text(
//                   '10',
//                   style: TextStyle(fontSize: 15, color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//                 Text(
//                   '%',
//                   style: TextStyle(fontSize: 15, color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
// Positioned(
//         right: 30,
//         top: -50,
//         child: Transform.rotate(
//           angle: -35 * (3.14 / 180),
//           child: Container(
//             alignment: Alignment.center,
//             width: 35,
//             height: 230,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: <Color>[Colors.teal, Colors.blue],
//               ),

//               //  color: Colors.amber,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Transform.rotate(
//               angle: 80 * (3.14 / 180),
//               child: Row(
//                 children: [
//                   Text(
//                     '10',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     '%',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
class menuItemCard extends StatelessWidget {
  hotelListData item;

  menuItemCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Container(
                width: 160.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 185.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(7.0),
                              topRight: Radius.circular(7.0)),
                          image: DecorationImage(
                              image: AssetImage(item.img!), fit: BoxFit.cover)),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 7.0)),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        item.name!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 1.0)),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        "\$ " + item.price!,
                        style: const TextStyle(
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14.0,
                              ),
                              const SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                item.rating.toString(),
                                style: const TextStyle(
                                    fontFamily: "Sans",
                                    color: Colors.black26,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
///
///
/// Loading Item Card Animation Constructor
///
///
///
class loadingMenuItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.black38,
                highlightColor: Colors.white,
                child: Container(
                  width: 160.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 185.0,
                            width: 160.0,
                            color: Colors.black12,
                          ),
                          Container(
                            height: 25.5,
                            width: 65.0,
                            decoration: const BoxDecoration(
                                color: Color(0xFFD7124A),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(5.0))),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 5.0, top: 12.0),
                          child: Container(
                            height: 9.5,
                            width: 130.0,
                            color: Colors.black12,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 5.0, top: 10.0),
                          child: Container(
                            height: 9.5,
                            width: 80.0,
                            color: Colors.black12,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const Text(
                                  "",
                                  style: TextStyle(
                                      fontFamily: "Sans",
                                      color: Colors.black26,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0),
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14.0,
                                )
                              ],
                            ),
                            Container(
                              height: 8.0,
                              width: 30.0,
                              color: Colors.black12,
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
        ),
      ),
    );
  }
}

///
///
/// Calling imageLoading animation for set a grid layout
///
///
Widget _loadingImageAnimation(BuildContext context) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) => loadingMenuItemCard(),
    itemCount: hotelDataDummy.length,
  );
}

/// Popular Keyword Item class
class KeywordItem extends StatelessWidget {
  @override
  String? title, title2;

  KeywordItem({this.title, this.title2});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 3.0),
          child: Container(
            height: 29.5,
            width: 90.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.5,
                  spreadRadius: 1.0,
                )
              ],
            ),
            child: Center(
              child: Text(
                title!,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(color: Colors.black54, fontFamily: "Sans"),
              ),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 15.0)),
        Container(
          height: 29.5,
          width: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.5,
                spreadRadius: 1.0,
              )
            ],
          ),
          child: Center(
            child: Text(
              title2!,
              style: const TextStyle(
                color: Colors.black54,
                fontFamily: "Sans",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
