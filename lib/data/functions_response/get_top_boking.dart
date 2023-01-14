// ignore_for_file: file_names

import 'package:hotelbooking/data/database/connectdatabase.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

getTopBoking() async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    MangeAPi.topBookingRooms,
  );
  print(respons);
  return respons;
}

getOffersRooms() async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    MangeAPi.offers,
  );

  return respons;
}
