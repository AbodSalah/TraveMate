import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/controller/fav_controller.dart';
import 'package:hotelbooking/langs/languge_varible.dart';
import 'package:hotelbooking/my_widgets.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

import '../../Library/Ratting_Bar/Ratting_bar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    print("initState favorite");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        title: Text(
          LangVarible.favourites.tr,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GetBuilder<GetFavoriteController>(
        init: GetFavoriteController(),
        builder: (controller) {
          return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              itemBuilder: (context, int i) {
                double rating = 0.0;
                double radius = 16.0;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                        const Offset(2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(radius),
                        onTap: () async {},
                        child: Container(
                          width: Get.width,
                          height: 150,
                          child: Row(
                            children: [
                              Container(
                                width: Get.width * 0.35,
                                child: Image.network(
                                  '${MangeAPi.baseurl}/${controller.infocityModel?.favouritePlaces![i].imgs!.split(',').first}',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Text(error.toString());
                                  },
                                  fit: BoxFit.cover,
                                  height: Get.height,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.infocityModel
                                            ?.favouritePlaces![i].title
                                            .toString() ??
                                            'name',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        controller.infocityModel
                                            ?.favouritePlaces![i].desc ??
                                            'very good',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              size: 20, color: Colors.blue),
                                          Text(
                                              controller
                                                  .infocityModel
                                                  ?.favouritePlaces![i]
                                                  .city ??
                                                  'city',
                                              style: const TextStyle(
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      RatingBar.builder(
                                        initialRating: rating,
                                        itemSize: 18,
                                        minRating: 0.5,
                                        ignoreGestures: true,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        itemBuilder: (context, int i) =>
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(""),
                                  IconButton(
                                    onPressed: () async {
                                      controller.updateFavorit(
                                        controller.infocityModel
                                            ?.favouritePlaces![i].sId ??
                                            '638e12d4387bd697991743a6',
                                      );
                                    },
                                    icon: const Icon(Icons.favorite,
                                        color: Colors.pink),
                                  ),
                                  Container(
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 12, bottom: 12),
                                    child: Text(
                                      "\$${controller.infocityModel?.favouritePlaces![i].price}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, int i) {
                return const SizedBox(height: 22);
              },
              itemCount:
              controller.infocityModel?.favouritePlaces!.length ?? 0);
        },
      ),
    );
  }
}
