// ignore_for_file: file_names

import 'package:hotelbooking/data/database/connectdatabase.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

getHotelByTypeRespon(String type) async {
  Curd curd = Curd();
  print('${MangeAPi.getRoomsByType}=$type');
  var respons = await curd.getrequest(
    '${MangeAPi.getRoomsByType}=$type',
  );
  return respons;
}
