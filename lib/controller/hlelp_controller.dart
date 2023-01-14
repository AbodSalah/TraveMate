import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/data/functions_response/get_help_and_fav.dart';
import 'package:hotelbooking/models/help_models.dart';

class HelpController extends GetxController {
  HelpModel? helpModel;
  late StatusRequest statusRequest;
  getdataHelp() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await getHelpRespon();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      helpModel = await HelpModel.fromJson(response);
    } else {
      print('erorr');
    }
    update();
  }

  @override
  void onInit() {
    getdataHelp();
    super.onInit();
  }
}
