import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/data/functions_response/get_cities.dart';
import 'package:hotelbooking/data/functions_response/search_res.dart';
import 'package:hotelbooking/models/cities_model.dart';
import 'package:hotelbooking/models/models_type.dart';

class FiltterController extends GetxController {
  int v1 = 0, v2 = 0;
  HouseTypeModels? helpModel;
  String? future;
  int datalen = 0;
  int count = 0;
  String? city;
  int maxprice = 400;
  int minprice = 1;
  List<String> x = [];
  List<String> type = [];
  int distance = 6;
  int futurer = 0;
  StatusRequest statusRequest = StatusRequest.none;
  getdataFromFiltter() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await getFiltterRespon(
      city: city,
      distance: distance,
      maxprice: maxprice,
      minprice: minprice,
      type: type.join(',').toString(),
      x: x,
    );
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      helpModel = await HouseTypeModels.fromJson(response);
      count = helpModel?.message!.length ?? 0;
    } else {
      print('erorr');
    }
    update();
  }

  late StatusRequest statusRequest2;
  CitisModel? getCitesModel;
  getCiteisdata() async {
    try {
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
    } catch (e) {
      print(e);
    }
  }

  late StatusRequest statusRequest3;
  DataforFiltterModel? dataforFiltterModel;
  getDatadata() async {
    try {
      statusRequest3 = StatusRequest.loading;
      update();
      var response = await getDataForfiltterRespon();
      statusRequest3 = handlingData(response);
      if (StatusRequest.success == statusRequest3) {
        dataforFiltterModel = await DataforFiltterModel.fromJson(response);
        futurer = dataforFiltterModel!.features!.length;
        datalen = dataforFiltterModel!.typeOfAccommodation!.length;
        v1 = dataforFiltterModel!.prices![0];
        v2 = dataforFiltterModel!.prices![1];
        ;
      } else {
        print('erorr');
      }
      update();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getDatadata();
    getCiteisdata();
    super.onInit();
  }
}
