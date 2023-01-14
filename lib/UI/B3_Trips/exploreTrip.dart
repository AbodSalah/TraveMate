import 'package:flutter/material.dart';
import 'package:hotelbooking/DataSample/HotelListData.dart';
import 'package:hotelbooking/DataSample/travelModelData.dart';
import 'package:hotelbooking/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:hotelbooking/UI/B1_Home/Destination/destinationDetail.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:hotelbooking/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';

import '../../Library/Carousel/CarouselPro.dart';

class exploreTrip extends StatefulWidget {
  exploreTrip({Key? key}) : super(key: key);

  @override
  _exploreTripState createState() => _exploreTripState();
}

class _exploreTripState extends State<exploreTrip> {
  var _recommended = Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Container(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (ctx, index) {
          return cardList(travelDataDummy[index]);
        },
        itemCount: travelDataDummy.length,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 292.0,
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
                      images: const [
                        AssetImage("assets/image/banner/banner4.jpg"),
                        AssetImage("assets/image/banner/banner6.jpg"),
                        AssetImage("assets/image/banner/banner10.jpg"),
                        AssetImage("assets/image/banner/banner12.jpg"),
                      ],
                      onImageChange: (int, s) {},
                      onImageTap: (int) {},
                      radius: const Radius.circular(1.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 15.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 45.0,
                        width: 45.0,
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Discover New Places",
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 5.0),
              Container(
                height: 320.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    const SizedBox(
                      width: 10.0,
                    ),
                    _card("assets/image/banner/banner7.jpg", "Ama Dablam ",
                        "Tanzania", "4,3", "dsadsa2", context),
                    _card("assets/image/banner/banner8.jpg", "Table Mountain",
                        "Africa", "4,1", "gew321", context),
                    _card("assets/image/banner/banner13.jpg",
                        "Mount Kilimanjaro", "Nepal", "4,2", "213asd", context),
                    _card("assets/image/banner/banner9.jpg", "Gangtok Mount",
                        "Nepal", "4,7", "gfd23", context),
                    _card("assets/image/banner/banner11.jpg", "Mount Papua",
                        "Indonesia", "4,5", "cds321", context),
                    const SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Top Destination",
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        "See all",
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Container(
                  height: 140.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      const SizedBox(
                        width: 20.0,
                      ),
                      cardCountry(
                        colorTop: const Color(0xFFF07DA4),
                        colorBottom: const Color(0xFFF5AE87),
                        image: "assets/image/icon/amerika.png",
                        title: "America",
                      ),
                      cardCountry(
                          colorTop: const Color(0xFF63CCD1),
                          colorBottom: const Color(0xFF75E3AC),
                          image: "assets/image/icon/thailand.png",
                          title: "Thailand"),
                      cardCountry(
                          colorTop: const Color(0xFF9183FC),
                          colorBottom: const Color(0xFFDB8EF6),
                          image: "assets/image/icon/england.png",
                          title: "England"),
                      cardCountry(
                          colorTop: const Color(0xFF56B4EE),
                          colorBottom: const Color(0xFF59CCE1),
                          image: "assets/image/icon/italia.png",
                          title: "Italia"),
                      cardCountry(
                          colorTop: const Color(0xFF56AB2F),
                          colorBottom: const Color(0xFFA8E063),
                          image: "assets/image/icon/spanyol.png",
                          title: "Spanyol"),
                      InkWell(
                        onTap: () {},
                        child: cardCountry(
                            colorTop: const Color(0xFF74EBD5),
                            colorBottom: const Color(0xFFACB6E5),
                            image: "assets/image/icon/paris.png",
                            title: "France"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 22.0),
                child: Text(
                  "Recommended",
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              _recommended,
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
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

  travelListData hotelData;

  cardList(this.hotelData);
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new hotelDetail2(),
              transitionDuration: const Duration(milliseconds: 600),
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              }));
        },
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
            Hero(
              tag: 'hero-tag-${hotelData.id}',
              child: Material(
                child: Container(
                  height: 165.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    image: DecorationImage(
                        image: AssetImage(hotelData.img!), fit: BoxFit.cover),
                  ),
                  alignment: Alignment.topRight,
                ),
              ),
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
                              hotelData.name!,
                              style: _txtStyleTitle,
                              overflow: TextOverflow.ellipsis,
                            )),
                        const Padding(padding: EdgeInsets.only(top: 5.0)),
                        Row(
                          children: <Widget>[
                            ratingbar(
                              starRating: hotelData.rating,
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
                              Text(hotelData.location!, style: _txtStyleSub)
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
                          "\$" + hotelData.price!,
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

Widget _card(String image, title, location, ratting, id, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => HotelDetail(),
                transitionDuration: const Duration(milliseconds: 600),
                transitionsBuilder:
                    (_, Animation<double> animation, __, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                }));
          },
          child: Hero(
            tag: 'hero-tag-${id}',
            child: Material(
              child: Container(
                height: 220.0,
                width: 160.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.cover),
                    color: Colors.black12,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12.withOpacity(0.1),
                          spreadRadius: 2.0)
                    ]),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          title,
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
              location,
              style: const TextStyle(
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: Colors.black26),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.star,
              size: 18.0,
              color: Colors.yellow,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                ratting,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sofia",
                    fontSize: 13.0),
              ),
            ),
            const SizedBox(
              width: 35.0,
            ),
            Container(
              height: 27.0,
              width: 82.0,
              decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: const Center(
                child: Text("Discount 15%",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0)),
              ),
            )
          ],
        ),
      ],
    ),
  );
}

class cardCountry extends StatelessWidget {
  Color? colorTop, colorBottom;
  String? image, title;
  cardCountry({this.colorTop, this.colorBottom, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new destination(
                    name: this.title,
                  ),
              transitionDuration: const Duration(milliseconds: 600),
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              }));
        },
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
      ),
    );
  }
}
