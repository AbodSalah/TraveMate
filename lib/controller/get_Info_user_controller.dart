import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/data/functions_response/get_Info_user.dart';
import 'package:hotelbooking/models/get_info_user_model.dart';

class GetInfoUserController extends GetxController {
  late StatusRequest statusRequest;
  GetInfoUserModel? infocityModel;
  getdataFromCity() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await getProfileRespon();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      infocityModel = await GetInfoUserModel.fromJson(response);
      print(
          '--------------------------------------------------------------------------');
    } else {
      print('erorr');
    }
    update();
  }

  @override
  void onInit() {
    getdataFromCity();
    super.onInit();
  }
}
