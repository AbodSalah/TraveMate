import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/controller/edit_profile_controller.dart';
import 'package:hotelbooking/data/functions_response/get_help_and_fav.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/fav_models.dart';

class GetFavoriteController extends GetxController {
  late StatusRequest statusRequest;
  FavoriteModel? infocityModel;
  getdatagetFavorit(String id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await getFavoritRespon(id);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      infocityModel = await FavoriteModel.fromJson(response);
      print(
          '--------------------------------------------------------------------------');
    } else {
      print('erorr');
    }
    update();
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
        infocityModel?.favouritePlaces!
            .removeWhere((element) => element.sId == placeId);
        update();
        showsnackBar('تم الحذف من قائمة المفضلات بنجاح');
      }
    } else {
      showsnackBar('يوجد مشكله ما');
    }
    update();
  }

  @override
  void onInit() {
    print(sharedPreferences.getString('id'));
    getdatagetFavorit(
        sharedPreferences.getString('id') ?? '63a121b56cc98ab64c281828');
    super.onInit();
  }
}
