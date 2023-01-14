// ignore_for_file: file_names

import 'package:hotelbooking/data/database/connectdatabase.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

getCitesRespon() async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    MangeAPi.getCities,
  );
  print(respons);
  return respons;
}

getUsersRespon() async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    'https://hotel-booking-8qw1.onrender.com/api/users/getUsers',
  );
  print(respons);
  return respons;
}

getDataForfiltterRespon() async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    'https://hotel-booking-8qw1.onrender.com/api/rooms/getDataForFilter',
  );
  print(respons);
  return respons;
}

class DataforFiltterModel {
  List<int>? prices;
  List<String>? features;
  List<int>? destanceFromCityCenter;
  List<String>? typeOfAccommodation;

  DataforFiltterModel(
      {this.prices,
      this.features,
      this.destanceFromCityCenter,
      this.typeOfAccommodation});

  DataforFiltterModel.fromJson(Map<String, dynamic> json) {
    prices = json['prices'].cast<int>();
    features = json['features'].cast<String>();
    destanceFromCityCenter = json['destanceFromCityCenter'].cast<int>();
    typeOfAccommodation = json['typeOfAccommodation'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prices'] = this.prices;
    data['features'] = this.features;
    data['destanceFromCityCenter'] = this.destanceFromCityCenter;
    data['typeOfAccommodation'] = this.typeOfAccommodation;
    return data;
  }
}

class UsersModels {
  List<MessageUser>? message;

  UsersModels({this.message});

  UsersModels.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <MessageUser>[];
      json['message'].forEach((v) {
        message!.add(new MessageUser.fromJson(v));
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

class MessageUser {
  String? sId;
  String? username;

  MessageUser({this.sId, this.username});

  MessageUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    return data;
  }
}
