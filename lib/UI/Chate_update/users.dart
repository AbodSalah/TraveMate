import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/UI/Chate_update/Chat_room.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/UI/pages/helps.dart';
import 'package:hotelbooking/data/functions_response/get_cities.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UsersModels? helpModel;
  late StatusRequest statusRequest;
  getdataUser() async {
    statusRequest = StatusRequest.loading;
    setState(() {});
    var response = await getUsersRespon();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      helpModel = await UsersModels.fromJson(response);
    } else {
      print('erorr');
    }
    setState(() {});
  }

  @override
  void initState() {
    getdataUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  title: Text('UserScreen'),
        actions: [
          InkWell(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchHintDelegate(
                    xc: helpModel!.message!,
                    hintText: '',
                  ),
                );
              },
              child: Icon(Icons.search)),
        ],
      ),
      body: HandlingDataView(
        statusRequest: statusRequest,
        widget: ListView.builder(
          itemCount: helpModel?.message!.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: ListTile(
                  onTap: () {
                    Get.to(ChatPage(
                      peerId: helpModel!.message![index].sId!,
                      username: helpModel!.message![index].username!,
                    ));
                  },
                  shape: RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xff6ae792),
                    child: Image.asset(
                      'assets/images/imagenot.jpg',
                    ),
                  ),
                  title: Text(
                    helpModel?.message![index].username ?? 'username',
                  ),
                  subtitle: Text('0128896454'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
            );
          },
        ),
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
  final List<MessageUser> xc;
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
    List<MessageUser> xsug =
        xc.where((element) => element.username!.contains(query)).toList();
    return Align(
      alignment: Alignment.topRight,
      child: ListView.builder(
        itemCount: query == '' ? xc.length : xsug.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              Get.to(ChatPage(
                peerId: xc[index].sId!,
                username: xc[index].username!,
              ));
            },
            title: Text(query == ''
                ? xc[index].username ?? 'nodata'
                : xsug[index].username ?? 'nodata'),
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
    return [];
  }
}
