import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:hotelbooking/UI/IntroApps/search_map.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/controller/main_slection_controller.dart';
import 'package:hotelbooking/langs/languge_varible.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:quickalert/quickalert.dart';

bool button1 = true;
bool button2 = true;
bool button3 = true;
bool button4 = true;
bool button5 = true;
bool button6 = true;

class MainSelection extends StatefulWidget {
  MainSelection({Key? key}) : super(key: key);

  @override
  State<MainSelection> createState() => _MainSelectionState();
}

class _MainSelectionState extends State<MainSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: GetBuilder<MainSlecController>(
        init: MainSlecController(),
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      LangVarible.choose_your_favourite_distination.tr,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Sofia",
                      ),
                    ),
                  ),
                  for (int i = 0; i < controller.count; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: itemCard(
                        mainSlecController: controller,
                        image: controller.helpModel!.message![i].imgs,
                        title: controller.helpModel!.message![i].name,
                      ),
                    ),
                  // SizedBox(
                  //   height: 400,
                  //   child: Wrap(
                  //     alignment: WrapAlignment.center,
                  //     children: [
                  //       for (int i = 0; i < controller.count; i++)
                  //         Padding(
                  //           padding: const EdgeInsets.only(right: 15, left: 15),
                  //           child: itemCard(
                  //             mainSlecController: controller,
                  //             image: controller.helpModel!.message![i].imgs,
                  //             title: controller.helpModel!.message![i].name,
                  //           ),
                  //         ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  GetBuilder<MainSlecController>(
                    builder: (controller) {
                      return HandlingDataView(
                        statusRequest: controller.statusRequest1,
                        widget: InkWell(
                          onTap: () {
                            if (controller.caogerySlected.isNotEmpty) {
                              controller.addCatogeryaUser();
                            } else {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.warning,
                                title: 'يرجي اختيار قسم',
                              );
                            }
                          },
                          child: Container(
                            height: 55.0,
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 0.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color(0xFF647DEE),
                                  Color(0xFF7F53AC)
                                ])),
                            child: Center(
                              child: Text(
                                LangVarible.next.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19.5,
                                    letterSpacing: 1.2),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class itemCard extends StatefulWidget {
  String? image, title;
  final MainSlecController mainSlecController;

  itemCard({
    this.image,
    this.title,
    required this.mainSlecController,
  });

  @override
  State<itemCard> createState() => _itemCardState();
}

class _itemCardState extends State<itemCard> {
  bool isSlected = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSlected = !isSlected;
          isSlected
              ? widget.mainSlecController.caogerySlected
                  .removeWhere((element) => element == widget.title)
              : widget.mainSlecController.caogerySlected.add(widget.title!);
          print(isSlected);
          print(widget.mainSlecController.caogerySlected);
        });
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
                      '${MangeAPi.baseurl}/${widget.image!.split(',').first}'),
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
                    isSlected ? widget.title! : 'Selected',
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
