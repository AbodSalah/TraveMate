import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/Search.dart';
import 'package:hotelbooking/data/functions_response/search_res.dart';
import 'package:hotelbooking/models/search_models.dart';

class SearchController extends GetxController {
  SearchModel? helpModel;
  late StatusRequest statusRequest;
  getdataSearch(String searchtext) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await getSearchRespon(searchtext);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      helpModel = await SearchModel.fromJson(response);
    } else {
      print('erorr');
    }
    update();
  }

  @override
  void onInit() {
    getdataSearch(searchText!);
    super.onInit();
  }
}
