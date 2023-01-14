import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/Library/Expanded/ExpandedDetailRatting.dart';
import 'package:hotelbooking/Library/Expanded/ExpandedDetailReviews.dart';
import 'package:hotelbooking/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:hotelbooking/models/info_room_model.dart';

import '../../../../Library/Ratting_Bar/ratting.dart';

class reviewDetail1 extends StatefulWidget {
  reviewDetail1({Key? key, required this.feedbacks}) : super(key: key);
  final List<Feedbacks>? feedbacks;
  @override
  _reviewDetail1State createState() => _reviewDetail1State();
}

class _reviewDetail1State extends State<reviewDetail1> {
  @override
  double rating = 3.5;
  int starCount = 5;

  /// Custom Text for Detail title
  static var _detailText = const TextStyle(
      fontFamily: "Gotik",
      color: Colors.black54,
      letterSpacing: 0.3,
      wordSpacing: 0.5);

  Widget build(BuildContext context) {
    var _appBar = AppBar(
      title:  Text("reviews".tr),
      centerTitle: true,
      leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          )),
      elevation: 0.0,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.feedbacks?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return _buildRating(
                    widget.feedbacks?[index].date ?? '123',
                    widget.feedbacks?[index].review ?? 'rev',
                    widget.feedbacks?[index].rating?.toDouble() ?? 5,
                    'assets/image/profile/profile1.jpg');
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRating(
      String date, String details, double rating, String image) {
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
        style:
        const TextStyle(fontFamily: "Sofia", fontWeight: FontWeight.w300),
      ),
    );
  }
}
