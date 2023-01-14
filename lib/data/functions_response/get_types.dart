// ignore_for_file: file_names

import 'package:hotelbooking/data/database/connectdatabase.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

getTypesRespon() async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    MangeAPi.getHotelTypes,
  );
  print(respons);
  return respons;
}

getDataOfcatoRespon(String cato) async {
  Curd curd = Curd();
  print(
      '${MangeAPi.nearestPlaces}?userId=${sharedPreferences.getString('id')}&category=$cato');
  var respons = await curd.getrequest(
    '${MangeAPi.nearestPlaces}?userId=${sharedPreferences.getString('id')}&category=$cato',
  );
  print(respons);
  return respons;
}

getSearchCityRespon(String inpout) async {
  Curd curd = Curd();

  var respons = await curd.getrequest(
    'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inpout&types=geocode&key=AIzaSyANd3nsdL7bmOR-8UkZDrTNtjaX63JbjZs',
  );
  print(respons);
  return respons;
}
