import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/controller/hlelp_controller.dart';
import 'package:hotelbooking/models/help_models.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:quickalert/quickalert.dart';

import '../../my_widgets.dart';

class Helps extends StatefulWidget {
  const Helps({Key? key}) : super(key: key);

  @override
  State<Helps> createState() => _HelpsState();
}

class _HelpsState extends State<Helps> {
  TextEditingController _txtsearch = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HelpController controller = Get.put(HelpController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(""),
        titleSpacing: -5,
      ),
      body: GetBuilder<HelpController>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Container(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.blue,
                    child: Container(
                      width: Get.width,
                      padding:
                      const EdgeInsetsDirectional.only(start: 20, end: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "how_can_we_help".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: CustomSearchHintDelegate(
                                  xc: controller.helpModel!.topics!,
                                  hintText: 'ادخل محتوي البحث',
                                ),
                              );
                            },
                            controller: _txtsearch,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              hintText: "search".tr,
                              prefixIcon: IconButton(
                                onPressed: () async {
                                  showSearch(
                                    context: context,
                                    delegate: CustomSearchHintDelegate(
                                      xc: controller.helpModel!.topics!,
                                      hintText: 'ادخل محتوي البحث',
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.search_outlined),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      itemBuilder: (context, int i) {
                        return Align(
                          alignment: Alignment.topRight,
                          child: ExpansionTile(
                            title: Text(
                              controller.helpModel?.topics?[i].topic ?? 'topic',
                              style:
                              TextStyle(fontSize: 21, color: Colors.black),
                            ),
                            children: List.generate(
                              controller.helpModel?.topics?[i].helpQuestions!
                                  .length ??
                                  0,
                                  (index) => Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 6,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.info,
                                          title: controller
                                              .helpModel
                                              ?.topics?[i]
                                              .helpQuestions![index]
                                              .question,
                                          text: controller.helpModel?.topics?[i]
                                              .helpQuestions![index].answer,
                                        );
                                      },
                                      child: Text(
                                        controller
                                            .helpModel
                                            ?.topics?[i]
                                            .helpQuestions![index]
                                            .question ??
                                            'Question',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, int i) {
                        return Divider(
                            color: Colors.grey[300],
                            height: 1,
                            thickness: 1,
                            endIndent: 0,
                            indent: 0);
                      },
                      itemCount: controller.helpModel?.topics?.length ?? 0,
                    ),
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

class CustomSearchHintDelegate extends SearchDelegate<String> {
  CustomSearchHintDelegate({
    required this.xc,
    required String hintText,
  }) : super(
    searchFieldLabel: hintText,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.search,
  );
  final List<Topics> xc;
  @override
  Widget buildLeading(BuildContext context) => IconButton(
    onPressed: () {
      Get.back();
    },
    icon: Icon(Icons.close),
  );

  // @override
  // PreferredSizeWidget buildBottom(BuildContext context) {
  //   return const PreferredSize(
  //       preferredSize: Size.fromHeight(56.0), child: Text('bottom'));
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Topics> xsug =
    xc.where((element) => element.topic!.contains(query)).toList();
    return Align(
      alignment: Alignment.topRight,
      child: ListView.builder(
        itemCount: query == '' ? xc.length : xsug.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              dialog(helpQuestions: xc[index].helpQuestions);
            },
            title: Text(query == ''
                ? xc[index].topic ?? 'nodata'
                : xsug[index].topic ?? 'nodata'),
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('النتائج');
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return List.generate(
        xc.length, (index) => Text(xc[index].topic ?? 'nodata'));
  }
}

void dialog({List<HelpQuestions>? helpQuestions}) {
  Get.defaultDialog(
    title: "الاسئله",
    middleText: "",
    content: Container(
      height: 250,
      width: 400,
      child: ListView.builder(
        itemCount: helpQuestions?.length,
        itemBuilder: (BuildContext context, int index) {
          return Align(
            alignment: Alignment.topRight,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 6,
                ),
                TextButton(
                  onPressed: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.info,
                      title: helpQuestions![index].question,
                      text: helpQuestions[index].answer,
                    );
                  },
                  child: Text(
                    helpQuestions![index].question ?? 'Question',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
    backgroundColor: Colors.teal,
    titleStyle: TextStyle(color: Colors.white),
    middleTextStyle: TextStyle(color: Colors.white),
    radius: 30,
  );
}
