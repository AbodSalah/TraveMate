import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/data/functions_response/get_data_by_cities.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/models/get_data_from_city.dart';

class GetDataCityController extends GetxController {
  late StatusRequest statusRequest;
  GetDataFromCityModel? infocityModel;
  getdataFromCity(String id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await getdataFromCitesRespon(id);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      infocityModel = await GetDataFromCityModel.fromJson(response);
      print(
          '--------------------------------------------------------------------------');
    } else {
      print('erorr');
    }
    update();
  }

  @override
  void onInit() {
    getdataFromCity(
        sharedPreferences.getString('keycity') ?? '637cf50c33762baba63f1832');
    super.onInit();
  }
}
