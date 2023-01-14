import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/data/functions_response/get_data_by_cities.dart';
import 'package:quickalert/quickalert.dart';

class NotfyController extends GetxController {
  NotfyModel? notfyModel;
  late StatusRequest statusRequest7;

  getNotfy() async {
    statusRequest7 = StatusRequest.loading;
    update();
    var response = await getNotfyRespon();
    statusRequest7 = handlingData(response);
    if (StatusRequest.success == statusRequest7) {
      notfyModel = await NotfyModel.fromJson(response);
      print('Notfy');
    } else {
      print('erorr');
    }
    update();
  }

  late StatusRequest statusRequest1 = StatusRequest.none;
  addFeedback(String idRoomFeed, BuildContext context, int reating,
      String review) async {
    statusRequest1 = StatusRequest.none;
    update();
    var response = await addFeedbackRespon(
      idRoomFeed: idRoomFeed,
      reating: reating,
      review: review,
    );

    statusRequest1 = handlingData(response);
    if (StatusRequest.success == statusRequest1) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'تم اضافة التقيم بنجاح',
      );
    } else {
      QuickAlert.show(
          context: context, type: QuickAlertType.error, title: 'يوجد مشكله ما');
    }
    update();
  }

  @override
  void onInit() {
    getNotfy();
    super.onInit();
  }
}

class NotfyModel {
  List<MessageNotfyModel>? message;

  NotfyModel({this.message});

  NotfyModel.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <MessageNotfyModel>[];
      json['message'].forEach((v) {
        message!.add(new MessageNotfyModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageNotfyModel {
  String? sId;
  String? title;
  String? type;
  String? imgs;
  int? price;
  int? maxPeople;
  String? city;
  double? averageRating;

  MessageNotfyModel(
      {this.sId,
      this.title,
      this.imgs,
      this.type,
      this.price,
      this.maxPeople,
      this.city,
      this.averageRating});

  MessageNotfyModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    type = json['type'];
    type = json['imgs'];
    price = json['price'];
    maxPeople = json['maxPeople'];
    city = json['city'];
    averageRating = double.parse(json['averageRating'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['imgs'] = this.type;
    data['price'] = this.price;
    data['maxPeople'] = this.maxPeople;
    data['city'] = this.city;
    data['averageRating'] = this.averageRating;
    return data;
  }
}
