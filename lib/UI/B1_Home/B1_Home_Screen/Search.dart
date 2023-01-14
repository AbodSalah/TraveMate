import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/valid.dart';
import 'package:hotelbooking/UI/search_screen/search_screen.dart';
import 'package:hotelbooking/controller/edit_profile_controller.dart';
import 'package:hotelbooking/data/functions_response/get_by_type.dart';
import 'package:hotelbooking/langs/languge_varible.dart';
import 'package:hotelbooking/main.dart';

String? searchText;
final GlobalKey<FormState> formkeysigin = GlobalKey();

class search extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  var _appBar = AppBar(
    iconTheme: const IconThemeData(
      color: Colors.deepPurpleAccent,
    ),
    title: Text(
      LangVarible.search.tr,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
          color: Colors.black,
          fontFamily: "Gotik"),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: CircleAvatar(
          backgroundColor: Colors.black54,
          radius: 15.0,
          child: Image.asset("assets/image/images/GirlProfile.png"),
        ),
      )
    ],
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0.0,
  );

  var _textHello = Padding(
    padding: EdgeInsets.only(right: 50.0, left: 20.0),
    child: Text(
      //  "Hello, ${sharedPreferences.getString('username') ?? 'ahmed'}. \nWhat would you like to search ?",
      "مرحبا ${sharedPreferences.getString('username') ?? 'ahmed'}\n ماذا تود البحث؟",

      style: TextStyle(
          letterSpacing: 0.1,
          fontWeight: FontWeight.w600,
          fontSize: 27.0,
          color: Colors.black54,
          fontFamily: "Gotik"),
    ),
  );

  static final txtButton = const TextStyle(
      color: Colors.black54, fontFamily: "Gotik", fontWeight: FontWeight.w500);

  /// Item TextFromField Search
  var _search = Padding(
      padding: const EdgeInsets.only(top: 65.0, right: 20.0, left: 20.0),
      child: Column(
        children: <Widget>[
          Container(
              height: 50.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5.0,
                        spreadRadius: 0.0)
                  ]),
              child: Center(
                child: Form(
                  key: formkeysigin,
                  child: TextFormField(

                    validator: (value) {
                      validInput(value.toString(), 1, 100, 'text');
                      return null;
                    },
                    onSaved: (newValue) {
                      searchText = newValue!;
                    },
                    decoration: InputDecoration(
                      hintText: "search".tr,
                      prefixIcon:
                      InkWell(onTap: () {}, child: Icon(Icons.search)),
                    ),
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 120.0,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2.0,
                        spreadRadius: 0.0)
                  ]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: InkWell(
              onTap: () {
                if (formkeysigin.currentState!.validate()) {
                  formkeysigin.currentState!.save();
                  if (searchText == null) {
                    showsnackBar('يرجي ادخال قيمه');
                  } else {
                    print(
                        '----------------------------ooooooooooooooooooooooooooooooooooo---------------------------------------');
                    Get.to(SearchScreen());
                  }
                }
              },
              child: Container(
                height: 50.0,
                decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                ),
                child: Center(
                  child: Text(
                    LangVarible.search.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontFamily: "Gotik",
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          )
        ],
      ));

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// Caliing a variable
                _textHello,
                _search,

                const Padding(padding: EdgeInsets.only(bottom: 30.0, top: 2.0))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///Favorite Item Card
class cardLastActivity extends StatelessWidget {
  String? image, Rating, Salary, title, sale;

  cardLastActivity(
      {this.image, this.Rating, this.Salary, this.title, this.sale});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 5.0, bottom: 10.0),
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
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 110.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(7.0),
                          topRight: Radius.circular(7.0)),
                      image: DecorationImage(
                          image: AssetImage(image!), fit: BoxFit.cover)),
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    width: 110.0,
                    child: Text(
                      title!,
                      style: const TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.black54,
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 1.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    Salary!,
                    style: const TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            Rating!,
                            style: const TextStyle(
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
                      Text(
                        sale!,
                        style: const TextStyle(
                            fontFamily: "Sans",
                            color: Colors.black26,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
