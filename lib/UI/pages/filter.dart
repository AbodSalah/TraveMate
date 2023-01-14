// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hotelbooking/UI/fliter_screen/fliter_screen.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/controller/edit_profile_controller.dart';
import 'package:hotelbooking/controller/filtter_controller.dart';
import 'package:hotelbooking/langs/languge_varible.dart';
import 'package:hotelbooking/models/cities_model.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var sliderValue = 1.0;

  bool u = false, i = false, o = false;
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu

  SfRangeValues _values = const SfRangeValues(1, 400);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            Get.back();
          },
          icon: Icon(
            Icons.clear,
            color: Colors.grey[800],
          ),
        ),
        title: const Text(""),
      ),
      body: GetBuilder<FiltterController>(
        init: FiltterController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: HandlingDataView(
                statusRequest: controller.statusRequest3,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LangVarible.filter.tr,
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsetsDirectional.only(start: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("price (for 1 night)",
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 40),
                          SfRangeSliderTheme(
                            data: SfRangeSliderThemeData(
                              tooltipBackgroundColor: Colors.transparent,
                              tooltipTextStyle: const TextStyle(
                                color: Colors.black,
                                height: 0,
                              ),
                            ),
                            child: SfRangeSlider(
                              min: 1,
                              max: 400,
                              labelPlacement: LabelPlacement.betweenTicks,
                              edgeLabelPlacement: EdgeLabelPlacement.auto,
                              shouldAlwaysShowTooltip: true,
                              tooltipShape: const SfPaddleTooltipShape(),
                              tooltipTextFormatterCallback:
                                  (dynamic actualValue, String formattedText) {
                                return "${double.parse(actualValue.toString()).round()}\$";
                              },
                              values: _values,
                              interval: 20.0,
                              // showTicks: true,
                              // showLabels: true,
                              stepSize: 1,
                              minorTicksPerInterval: 1,
                              onChanged: (SfRangeValues values) {
                                setState(() {
                                  _values = values;
                                  controller.maxprice = int.parse(
                                      values.end.toString().substring(0, 1));

                                  controller.minprice = int.parse(
                                      values.start.toString().substring(0, 1));
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<FiltterController>(
                      builder: (controller) {
                        return HandlingDataView(
                          statusRequest: controller.statusRequest2,
                          widget: SizedBox(
                            width: 450,
                            height: 55,
                            child: DropdownButton<String>(
                              hint: Text('يرجي اختيار مدينه'),
                              value: controller.city,
                              items: controller.getCitesModel?.message!
                                  .map((Message value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name ?? 'name'),
                                );
                              }).toList(),
                              onChanged: (vlue) {
                                setState(() {
                                  controller.city = vlue!;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsetsDirectional.only(start: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "popular",
                            style: TextStyle(fontSize: 16),
                          ),
                          if (controller.futurer != 0)
                            Wrap(
                              children: [
                                for (int i = 0; i < controller.futurer; i++)
                                  CheckCustom(
                                    tit: controller
                                        .dataforFiltterModel!.features![i],
                                  ),
                              ],
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsetsDirectional.only(start: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(LangVarible.distance_from_city_center.tr,
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 40),
                          SfSliderTheme(
                            data: SfSliderThemeData(
                              tooltipBackgroundColor: Colors.transparent,
                              tooltipTextStyle: const TextStyle(
                                color: Colors.black,
                                height: 0,
                              ),
                            ),
                            child: SfSlider(
                              min: controller.dataforFiltterModel
                                      ?.destanceFromCityCenter![1] ??
                                  1,
                              max: controller.dataforFiltterModel
                                      ?.destanceFromCityCenter![0] ??
                                  5,
                              labelPlacement: LabelPlacement.betweenTicks,
                              edgeLabelPlacement: EdgeLabelPlacement.auto,
                              shouldAlwaysShowTooltip: true,
                              tooltipShape: const SfPaddleTooltipShape(),
                              tooltipTextFormatterCallback:
                                  (dynamic actualValue, String formattedText) {
                                return "less than ${double.parse(actualValue.toString()).round()} km";
                              },
                              value: sliderValue,
                              interval: 20.0,
                              // showTicks: true,
                              // showLabels: true,
                              stepSize: 1,
                              minorTicksPerInterval: 1,
                              onChanged: (dynamic values) {
                                setState(() {
                                  print(values);
                                  sliderValue = values;
                                  controller.distance = int.parse(
                                      values.toString().substring(0, 1));
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsetsDirectional.only(start: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 8),
                            child: Text(LangVarible.type_of_accommodation.tr,
                                style: TextStyle(fontSize: 16)),
                          ),
                          for (int i = 0; i < controller.datalen; i++)
                            CustomList(
                              controller: controller,
                              text: controller
                                  .dataforFiltterModel!.typeOfAccommodation![i],
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Get.width,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                        onPressed: () async {
                          Get.to(FilterScreen());
                          controller.getdataFromFiltter();
                        },
                        child: Text(LangVarible.search.tr),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomList extends StatefulWidget {
  const CustomList({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);
  final String text;
  final FiltterController controller;
  @override
  State<CustomList> createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  bool x = false;
  @override
  Widget build(BuildContext context) {
    return ListTileSwitch(
      contentPadding: const EdgeInsetsDirectional.only(
          start: 2, end: 16, top: 8, bottom: 8),
      value: x,
      // leading: Icon(CupertinoIcons.battery_empty, size: 0,),
      onChanged: (value) async {
        setState(() {
          x = x == true ? false : true;
          x == true
              ? widget.controller.type.add(widget.text)
              : widget.controller.type.removeWhere(
                  (element) => element == widget.text,
                );
          print(widget.controller.type);
        });
      },
      visualDensity: VisualDensity.comfortable,
      switchType: SwitchType.cupertino,
      switchActiveColor: Colors.blue,
      title: Padding(
        padding: EdgeInsetsDirectional.only(start: 16, end: 0),
        child: Text(widget.text.toString()),
      ),
    );
  }
}

// ListTileSwitch(
//                         contentPadding: const EdgeInsetsDirectional.only(
//                             start: 2, end: 16, top: 8, bottom: 8),
//                         value: o,
//                         // leading: Icon(CupertinoIcons.battery_empty, size: 0,),
//                         onChanged: (value) async {
//                           setState(() {
//                             o = value;
// o == true
//     ? controller.type = 'فندق'
//     : controller.type = '';
//                             print(controller.type);
//                           });
//                         },
//                         visualDensity: VisualDensity.comfortable,
//                         switchType: SwitchType.cupertino,
//                         switchActiveColor: Colors.blue,
//                         title: Padding(
//                           padding:
//                               EdgeInsetsDirectional.only(start: 16, end: 0),
//                           child: Text(controller.dataforFiltterModel
//                                   ?.typeOfAccommodation![1] ??
//                               'فندق'),
//                         ),
//                       ),
//                       ListTileSwitch(
//                         contentPadding: const EdgeInsetsDirectional.only(
//                             start: 2, end: 16, top: 8, bottom: 8),
//                         value: u,
//                         // leading: Icon(CupertinoIcons.battery_empty, size: 0,),
//                         onChanged: (value) async {
//                           setState(() {
//                             u = value;
//                             u == true
//                                 ? controller.type = 'منزل'
//                                 : controller.type = '';
//                             print(controller.type);
//                           });
//                         },
//                         visualDensity: VisualDensity.comfortable,
//                         switchType: SwitchType.cupertino,
//                         switchActiveColor: Colors.blue,
//                         title: Padding(
//                           padding:
//                               EdgeInsetsDirectional.only(start: 16, end: 0),
//                           child: Text(controller.dataforFiltterModel
//                                   ?.typeOfAccommodation![0] ??
//                               'منزل'),
//                         ),
//                       ),
class CheckCustom extends StatefulWidget {
  const CheckCustom({
    Key? key,
    required this.tit,
  }) : super(key: key);
  final String tit;
  @override
  State<CheckCustom> createState() => _CheckCustomState();
}

class _CheckCustomState extends State<CheckCustom> {
  bool x = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FiltterController>(
      builder: (controller) {
        return SizedBox(
          height: 50,
          child: CheckboxListTile(
            title: Text(widget.tit),
            value: x,
            onChanged: (value) {
              setState(() {
                x = value!;
                x == true
                    ? controller.x.add(widget.tit)
                    : controller.x.removeWhere(
                        (element) => element == widget.tit,
                      );
                print(controller.x);
              });
            },
          ),
        );
      },
    );
  }
}
