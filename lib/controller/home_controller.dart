import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/data/functions_response/get_cities.dart';
import 'package:hotelbooking/data/functions_response/get_top_boking.dart';
import 'package:hotelbooking/data/functions_response/get_top_reating.dart';
import 'package:hotelbooking/data/functions_response/get_types.dart';
import 'package:hotelbooking/data/functions_response/main_selectiom_res.dart';
import 'package:hotelbooking/models/cities_model.dart';
import 'package:hotelbooking/models/get_top_reating_model.dart';
import 'package:hotelbooking/models/minslection_models.dart';
import 'package:hotelbooking/models/types_model.dart';

class HomeController extends GetxController {
  GetTopReatingModel? getTopReatingModel;
  GetTopReatingModel? getTopBokingModel;
  CitisModel? getCitesModel;
  RecommendAi? getRecommendAi;
  TypesModel? getTypesModel;
  late StatusRequest statusRequest;
  late StatusRequest statusRequest1;
  late StatusRequest statusRequest2;
  late StatusRequest statusRequest3;
  GetUserCatogerys? getusercatogerys;
  late StatusRequest statusRequest4;
  late StatusRequest statusRequest7;

  getRecommedai() async {
    statusRequest7 = StatusRequest.loading;
    update();
    var response = await getRecommendAiRespon();
    statusRequest7 = handlingData(response);
    if (StatusRequest.success == statusRequest7) {
      getRecommendAi = await RecommendAi.fromJson(response);
      print('RecommendAi');
    } else {
      print('erorr');
    }
    update();
  }

  getUserCatogerys() async {
    statusRequest4 = StatusRequest.loading;
    update();
    var response = await getUserCatogeryRespon();
    statusRequest4 = handlingData(response);
    if (StatusRequest.success == statusRequest4) {
      getusercatogerys = await GetUserCatogerys.fromJson(response);
      print('getTopReatingModel');
    } else {
      print('erorr');
    }
    update();
  }

  getdataTopreating() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await getTopReating();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      getTopReatingModel = await GetTopReatingModel.fromJson(response);
      print('getTopReatingModel');
    } else {
      print('erorr');
    }
    update();
  }

  getdataBoking() async {
    statusRequest1 = StatusRequest.loading;
    update();
    var response = await getTopBoking();
    statusRequest1 = handlingData(response);
    if (StatusRequest.success == statusRequest1) {
      getTopBokingModel = await GetTopReatingModel.fromJson(response);
    } else {
      print('erorr');
    }
    update();
  }

  getCiteisdata() async {
    statusRequest2 = StatusRequest.loading;
    update();
    var response = await getCitesRespon();
    statusRequest2 = handlingData(response);
    if (StatusRequest.success == statusRequest2) {
      getCitesModel = await CitisModel.fromJson(response);
    } else {
      print('erorr');
    }
    update();
  }

  getTypesdata() async {
    statusRequest3 = StatusRequest.loading;
    update();
    var response = await getTypesRespon();
    statusRequest3 = handlingData(response);
    if (StatusRequest.success == statusRequest3) {
      getTypesModel = await TypesModel.fromJson(response);
    } else {
      print('erorr');
    }
    update();
  }

  late StatusRequest statusRequest5;
  OffersHouseModels? roomoffers;
  getOffers() async {
    statusRequest5 = StatusRequest.loading;
    update();
    var response = await getOffersRooms();
    statusRequest5 = handlingData(response);
    if (StatusRequest.success == statusRequest5) {
      roomoffers = await OffersHouseModels.fromJson(response);
    } else {
      print('erorr');
    }
    update();
  }

  @override
  void onInit() {
    getOffers();
    getdataTopreating();
    getdataBoking();
    getCiteisdata();
    getTypesdata();
    getUserCatogerys();
    getRecommedai();
    super.onInit();
  }
}

class RecommendAi {
  List<Rooms>? rooms;

  RecommendAi({this.rooms});

  RecommendAi.fromJson(Map<String, dynamic> json) {
    if (json['Rooms'] != null) {
      rooms = <Rooms>[];
      json['Rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rooms != null) {
      data['Rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  String? sId;
  String? title;
  String? type;
  int? price;
  String? city;
  double? averageRating;
  String? imgs;

  Rooms(
      {this.sId,
      this.title,
      this.type,
      this.price,
      this.city,
      this.averageRating,
      this.imgs});

  Rooms.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    type = json['type'];
    price = json['price'];
    city = json['city'];
    averageRating = double.parse(json['averageRating'].toString());
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['price'] = this.price;
    data['city'] = this.city;
    data['averageRating'] = this.averageRating;
    data['imgs'] = this.imgs;
    return data;
  }
}
