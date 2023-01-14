import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/Search.dart';
import 'package:hotelbooking/data/functions_response/get_types.dart';
import 'package:hotelbooking/data/functions_response/search_res.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/dataofcatogery_models.dart';
import 'package:hotelbooking/models/search_models.dart';

class DataOfCatogeryController extends GetxController {
  DataofCatogeryModels? helpModel;
  late StatusRequest statusRequest;

  getdataSearch(String searchtext) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await getDataOfcatoRespon(searchtext);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      helpModel = await DataofCatogeryModels.fromJson(response);
    } else {
      print('erorr');
    }
    update();
  }

  @override
  void onInit() {
    getdataSearch(sharedPreferences.getString('dataofcato') ?? '');
    super.onInit();
  }
}
