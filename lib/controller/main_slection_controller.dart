import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/UI/IntroApps/search_map.dart';
import 'package:hotelbooking/data/functions_response/main_selectiom_res.dart';
import 'package:hotelbooking/models/minslection_models.dart';

class MainSlecController extends GetxController {
  GetCatogerys? helpModel;
  int count = 0;
  List<String> caogerySlected = [];
  late StatusRequest statusRequest;
  getCatogerySearch() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await getCatogeryRespon();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      helpModel = await GetCatogerys.fromJson(response);
      count = helpModel?.message!.length ?? 0;
    } else {
      print('erorr');
    }
    update();
  }

  void Isslected(bool x) {
    //  x = !x;
    update();
  }

  StatusRequest statusRequest1 = StatusRequest.none;
  addCatogeryaUser() async {
    statusRequest1 = StatusRequest.loading;
    update();
    var response = await aDDCatogeryRespon(
      caogerySlected.join(','),
    );
    statusRequest1 = handlingData(response);
    if (StatusRequest.success == statusRequest1) {
      update();
      Get.offAll(() => SearchInMap());
      Get.delete<MainSlecController>();
    } else {
      Get.offAll(() => SearchInMap());
      Get.delete<MainSlecController>();
    }
    update();
  }

  @override
  void onInit() {
    getCatogerySearch();
    super.onInit();
  }
}
