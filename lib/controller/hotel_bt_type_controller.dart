import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/controller/edit_profile_controller.dart';
import 'package:hotelbooking/data/functions_response/get_by_type.dart';
import 'package:hotelbooking/data/functions_response/get_help_and_fav.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/models_type.dart';

class HotelBytypeController extends GetxController {
  HouseTypeModels? helpModel1;
  late StatusRequest statusRequest;
  getdataSearch(String type) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      var response = await getHotelByTypeRespon(type);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        helpModel1 = await HouseTypeModels.fromJson(response);
      } else {
        print('erorr');
      }
      update();
    } catch (e) {
      print(e);
    }
  }

  late StatusRequest statusRequest1 = StatusRequest.none;
  updateFavorit(String placeId) async {
    statusRequest1 = StatusRequest.none;
    update();
    var response = await addFavoritRespon(
      placeId: placeId,
      userId: sharedPreferences.getString('id'),
    );

    statusRequest1 = handlingData(response);
    if (StatusRequest.success == statusRequest1) {
      if (response == 'sucssfully added') {
        showsnackBar('تم الاضافه الي قائمة المفضلات بنجاح');
      } else {
        showsnackBar('تم الحذف من قائمة المفضلات بنجاح');
      }
    } else {
      showsnackBar('يوجد مشكله ما');
    }
    update();
  }

  upda() {
    update();
  }

  @override
  void onInit() {
    getdataSearch(sharedPreferences.getString('type') ?? 'فندق');
    super.onInit();
  }
}
